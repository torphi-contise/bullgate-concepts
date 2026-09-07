# deploy-bullgate.ps1 — monta o site e, com confirmação explícita, publica no Cloudflare Pages legado
#
# Uso:      .\deploy-bullgate.ps1
# Requer:   Node.js (usa npx wrangler) + token da Cloudflare (ver DEPLOY.md)
#
# Credenciais (nunca vão para o git — estão no .gitignore):
#   .cloudflare-token    -> o API token (uma linha)
#   .cloudflare-account  -> o Account ID da Cloudflare (uma linha)
#   (alternativa: variáveis de ambiente CLOUDFLARE_API_TOKEN / CLOUDFLARE_ACCOUNT_ID)

param(
    [string]$ProjectName = "bullgate",
    [switch]$BuildOnly,
    [switch]$PublishCloudflarePages
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$dist = Join-Path $root "deploy-dist"

# ---------- monta o site com a mesma rotina usada pela imagem Docker ----------
node (Join-Path $root "scripts\build-site.mjs")
if ($LASTEXITCODE -ne 0) { Write-Error "Build do site falhou (node saiu com código $LASTEXITCODE)." }

if ($BuildOnly -or -not $PublishCloudflarePages) {
    Write-Host "Build local concluído. A produção de bullgate.dev é publicada por imagem Docker + Argo CD." -ForegroundColor Green
    return
}

# ---------- credenciais de publicação ----------
if (-not $env:CLOUDFLARE_API_TOKEN) {
    $f = Join-Path $root ".cloudflare-token"
    if (Test-Path $f) { $env:CLOUDFLARE_API_TOKEN = (Get-Content $f -Raw).Trim() }
}
if (-not $env:CLOUDFLARE_ACCOUNT_ID) {
    $f = Join-Path $root ".cloudflare-account"
    if (Test-Path $f) { $env:CLOUDFLARE_ACCOUNT_ID = (Get-Content $f -Raw).Trim() }
}
if (-not $env:CLOUDFLARE_API_TOKEN) {
    Write-Error "Token ausente. Crie o arquivo .cloudflare-token (ver DEPLOY.md) ou defina CLOUDFLARE_API_TOKEN."
}
if (-not $env:CLOUDFLARE_ACCOUNT_ID) {
    Write-Error "Account ID ausente. Crie o arquivo .cloudflare-account (ver DEPLOY.md) ou defina CLOUDFLARE_ACCOUNT_ID."
}

# ---------- deploy ----------
npx --yes wrangler@4 pages deploy $dist --project-name $ProjectName --branch main --commit-dirty=true
if ($LASTEXITCODE -ne 0) { Write-Error "Deploy falhou (wrangler saiu com código $LASTEXITCODE)." }

Write-Host ""
Write-Host "Publicado no projeto Cloudflare Pages legado. A produção de bullgate.dev continua no Kubernetes — ver DEPLOY.md." -ForegroundColor Green
