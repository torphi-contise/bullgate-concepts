# Valida a estrutura pública do repositório sem publicar ou usar credenciais.

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

function Assert-True {
    param(
        [Parameter(Mandatory)]
        [bool]$Condition,

        [Parameter(Mandatory)]
        [string]$Message
    )

    if (-not $Condition) {
        throw $Message
    }
}

function Get-PublishedTarget {
    param(
        [Parameter(Mandatory)]
        [string]$DistRoot,

        [Parameter(Mandatory)]
        [string]$Route
    )

    $routeWithoutQuery = ($Route -split "[?#]", 2)[0]
    $relativeRoute = $routeWithoutQuery.TrimStart("/")

    if ([string]::IsNullOrWhiteSpace($relativeRoute)) {
        return Join-Path $DistRoot "index.html"
    }

    $relativePath = $relativeRoute.Replace("/", [IO.Path]::DirectorySeparatorChar)
    if ([IO.Path]::HasExtension($relativePath)) {
        return Join-Path $DistRoot $relativePath
    }

    return Join-Path (Join-Path $DistRoot $relativePath) "index.html"
}

Push-Location $repoRoot
try {
    $requiredFiles = @(
        "README.md",
        "LICENSE",
        "CONTRIBUTING.md",
        "CODE_OF_CONDUCT.md",
        "SECURITY.md",
        ".editorconfig",
        ".gitattributes",
        ".github/ISSUE_TEMPLATE/config.yml",
        ".github/ISSUE_TEMPLATE/documentation.yml",
        ".github/ISSUE_TEMPLATE/proposal.yml",
        ".github/pull_request_template.md"
    )

    foreach ($requiredFile in $requiredFiles) {
        Assert-True (Test-Path -LiteralPath $requiredFile -PathType Leaf) "Arquivo obrigatório ausente: $requiredFile"
    }

    $trackedFiles = @(git ls-files)
    Assert-True ($LASTEXITCODE -eq 0) "Não foi possível listar os arquivos rastreados pelo Git."

    foreach ($forbiddenFile in @(".cloudflare-token", ".cloudflare-account")) {
        Assert-True ($trackedFiles -notcontains $forbiddenFile) "Arquivo secreto rastreado pelo Git: $forbiddenFile"
    }

    $generatedFiles = @($trackedFiles | Where-Object { $_ -like "deploy-dist/*" })
    Assert-True ($generatedFiles.Count -eq 0) "deploy-dist contém arquivos rastreados pelo Git."

    & (Join-Path $repoRoot "deploy-bullgate.ps1") -BuildOnly

    $distRoot = Join-Path $repoRoot "deploy-dist"
    $expectedRoutes = @(
        "/",
        "/privacy/",
        "/docs/",
        "/docs/access/",
        "/docs/access/politicas/",
        "/docs/access/resolucao-de-identidade/",
        "/docs/access/erros/"
    )

    foreach ($route in $expectedRoutes) {
        $target = Get-PublishedTarget -DistRoot $distRoot -Route $route
        Assert-True (Test-Path -LiteralPath $target -PathType Leaf) "Rota sem arquivo publicado: $route"
    }

    $pages = @(Get-ChildItem -LiteralPath $distRoot -Filter "*.html" -File -Recurse)
    Assert-True ($pages.Count -eq $expectedRoutes.Count) "Quantidade inesperada de páginas HTML em deploy-dist."

    foreach ($page in $pages) {
        $content = Get-Content -LiteralPath $page.FullName -Raw -Encoding UTF8
        Assert-True ($content -match "(?i)<!doctype html>") "DOCTYPE ausente em $($page.FullName)"
        Assert-True ($content -match "(?i)<title>.+?</title>") "Título ausente em $($page.FullName)"
        Assert-True ($content -match "(?i)<meta\s+name=[`"']viewport[`"']") "Viewport ausente em $($page.FullName)"

        $ids = @([regex]::Matches($content, "(?i)\bid\s*=\s*[`"']([^`"']+)[`"']") | ForEach-Object { $_.Groups[1].Value })
        $duplicateIds = @($ids | Group-Object | Where-Object Count -gt 1)
        Assert-True ($duplicateIds.Count -eq 0) "IDs duplicados em $($page.FullName): $($duplicateIds.Name -join ', ')"

        $hrefs = @([regex]::Matches($content, "(?i)\bhref\s*=\s*[`"']([^`"']*)[`"']") | ForEach-Object { $_.Groups[1].Value })
        foreach ($href in $hrefs) {
            if ([string]::IsNullOrWhiteSpace($href) -or $href -eq "#") { continue }
            if ($href -match "^(?i:https?:|mailto:|tel:|data:|javascript:)") { continue }

            $parts = $href -split "#", 2
            $routePart = $parts[0]
            $fragment = if ($parts.Count -gt 1) { [Uri]::UnescapeDataString($parts[1]) } else { "" }

            if ([string]::IsNullOrWhiteSpace($routePart)) {
                $targetPage = $page.FullName
            }
            elseif ($routePart.StartsWith("/")) {
                $targetPage = Get-PublishedTarget -DistRoot $distRoot -Route $routePart
            }
            else {
                $targetPage = [IO.Path]::GetFullPath((Join-Path $page.DirectoryName $routePart))
            }

            Assert-True (Test-Path -LiteralPath $targetPage -PathType Leaf) "Link interno quebrado em $($page.FullName): $href"

            if (-not [string]::IsNullOrWhiteSpace($fragment)) {
                $targetContent = Get-Content -LiteralPath $targetPage -Raw -Encoding UTF8
                $escapedFragment = [regex]::Escape($fragment)
                Assert-True ($targetContent -match "(?i)\bid\s*=\s*[`"']$escapedFragment[`"']") "Âncora ausente em $($page.FullName): $href"
            }
        }
    }

    $diffCheck = @(git diff --check 2>&1)
    Assert-True ($LASTEXITCODE -eq 0) "git diff --check encontrou problemas:`n$($diffCheck -join "`n")"

    Write-Host "Validação concluída: $($pages.Count) páginas, $($expectedRoutes.Count) rotas e arquivos comunitários presentes." -ForegroundColor Green
}
finally {
    Pop-Location
}
