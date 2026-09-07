import { cpSync, mkdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const root = join(dirname(fileURLToPath(import.meta.url)), "..");
const dist = join(root, "deploy-dist");

rmSync(dist, { recursive: true, force: true });
mkdirSync(dist, { recursive: true });

const source = readFileSync(join(root, "html", "bullgate.html"), "utf8");
const marker = "</style>";
const markerIndex = source.indexOf(marker);

if (markerIndex < 0) {
  throw new Error("html/bullgate.html sem bloco <style>; formato inesperado.");
}

const headEnd = markerIndex + marker.length;
const head = source.slice(0, headEnd);
const body = source.slice(headEnd);
const favicon = '<link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>&#128002;</text></svg>">';

const index = `<!doctype html>
<html lang="pt-BR">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="color-scheme" content="only light">
<meta name="supported-color-schemes" content="light">
<meta name="robots" content="noindex">
${favicon}
${head}
</head>
<body>
${body}
</body>
</html>
`;

writeFileSync(join(dist, "index.html"), index, "utf8");

const pages = [
  ["privacy.html", "privacy/index.html"],
  ["docs-index.html", "docs/index.html"],
  ["docs.html", "docs/access/index.html"],
  ["resolution.html", "docs/access/resolucao-de-identidade/index.html"],
  ["policies.html", "docs/access/politicas/index.html"],
  ["errors.html", "docs/access/erros/index.html"],
];

for (const [sourceName, destination] of pages) {
  const target = join(dist, destination);
  mkdirSync(dirname(target), { recursive: true });
  cpSync(join(root, "html", sourceName), target);
}

console.log(`Site montado em ${dist} (${pages.length + 1} paginas).`);
