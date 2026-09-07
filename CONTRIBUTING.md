# Como contribuir com o Bullgate Concepts

Obrigado por considerar uma contribuição. Este repositório reúne a apresentação
pública e a documentação técnica do Bullgate. Uma mudança aqui pode influenciar
decisões de integração, portanto clareza e precisão são parte do produto.

Ao participar, você concorda em seguir o
[Código de Conduta](CODE_OF_CONDUCT.md) do projeto.

## Antes de começar

Use uma issue para propor mudanças de comportamento, arquitetura, escopo ou
identidade visual antes de investir em uma implementação extensa. Correções
objetivas de texto, links, acessibilidade e pequenos erros podem seguir direto
para um pull request.

Não inclua credenciais, tokens, dados pessoais, segredos de integração ou
informações internas nos exemplos, screenshots, commits ou descrições.

Se a mudança estiver relacionada a uma vulnerabilidade ou puder expor dados,
não abra uma issue ou pull request público. Siga a
[política de segurança](SECURITY.md).

## O que pode ser contribuído

- correções de conteúdo, ortografia e links;
- melhoria de legibilidade, navegação, responsividade e acessibilidade;
- exemplos técnicos completos e verificáveis;
- documentação de parâmetros, estados, erros e decisões de integração;
- propostas de novas páginas ou de uma organização melhor do conteúdo.

Mudanças na marca Bullgate, no posicionamento do produto ou na classificação de
uma funcionalidade como implementada precisam de discussão prévia.

## Regra editorial principal

Não apresente intenção como comportamento existente. Toda afirmação de produto
deve deixar claro se descreve:

1. algo implementado na versão atual;
2. um contrato decidido, mas ainda não implementado;
3. uma hipótese ou capacidade futura.

Ao documentar comportamento técnico, informe a evidência usada na descrição do
pull request. Quando código e documentação divergirem, o comportamento do código
vigente deve ser investigado antes de alterar a documentação.

## Preparar o ambiente

O site não possui dependências de aplicação. Para montar localmente a mesma
estrutura de rotas usada na publicação, é necessário Windows PowerShell ou
PowerShell 7:

Primeiro, clone o repositório usando a URL apresentada pelo botão **Code** na
página do projeto. Dentro do checkout, execute:

```powershell
cd bullgate-concepts
.\deploy-bullgate.ps1 -BuildOnly
```

O resultado será criado em `deploy-dist/`. Para navegar pelas rotas locais, use
qualquer servidor HTTP estático. Com Python instalado, por exemplo:

```powershell
python -m http.server 3000 --directory deploy-dist
```

Abra `http://localhost:3000/`. O modo `-BuildOnly` não acessa a Cloudflare e não
exige credenciais. A publicação é responsabilidade dos mantenedores.

## Fazer a mudança

Crie uma branch curta a partir da branch padrão e mantenha o pull request focado
em um único assunto. Edite os arquivos-fonte em `html/`; não edite
`deploy-dist/`, pois ele é gerado e ignorado pelo Git.

Preserve os contratos de navegação entre estas rotas:

| Fonte                  | Rota publicada                          |
| ---------------------- | --------------------------------------- |
| `html/bullgate.html`   | `/`                                     |
| `html/privacy.html`    | `/privacy/`                             |
| `html/docs-index.html` | `/docs/`                                |
| `html/docs.html`       | `/docs/access/`                         |
| `html/policies.html`   | `/docs/access/politicas/`               |
| `html/resolution.html` | `/docs/access/resolucao-de-identidade/` |
| `html/errors.html`     | `/docs/access/erros/`                   |

## Verificar antes de enviar

1. Execute `.\scripts\validate-repository.ps1`.
2. Se alterou arquivos comunitários ou de configuração do GitHub e possui
   Node.js, execute `npx --yes prettier@3.6.2 --check README.md CONTRIBUTING.md CODE_OF_CONDUCT.md SECURITY.md ".github/**/*.{yml,md}"`.
3. Navegue pela página alterada em largura desktop e mobile.
4. Confirme que não há rolagem horizontal involuntária.
5. Teste links, menu, foco por teclado e conteúdo exibido sem JavaScript.
6. Confira se exemplos não contêm segredos e se recursos futuros estão marcados
   como não implementados.
7. Revise o diff para garantir que o pull request não inclua arquivos gerados ou
   alterações sem relação com o objetivo.

Na descrição do pull request, explique o problema, a solução, como foi verificada
e quais páginas ou contratos foram afetados. Inclua imagens quando a mudança for
visual.

## Licença das contribuições

Ao enviar uma contribuição intencional para inclusão neste repositório, você
concorda que ela seja disponibilizada sob a [Apache License 2.0](LICENSE), nos
termos da seção 5 da própria licença.

A licença do repositório não concede direitos sobre nomes, marcas ou identidade
visual Bullgate além do uso descritivo permitido pela seção 6.
