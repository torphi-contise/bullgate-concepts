# Bullgate

**English: [README.md](README.md)**

O Bullgate é uma plataforma open source, mobile-first, para identidade, acesso,
assinaturas, ofertas dirigidas, entitlements e operação de aplicativos.

Este repositório reúne o site público, os conceitos do produto e a documentação
técnica destinada a pessoas que querem entender ou integrar o Bullgate.

- [Conheça o Bullgate](https://bullgate.dev/)
- [Escolha a documentação técnica](https://bullgate.dev/docs/)
- [Integre o Bullgate Access](https://bullgate.dev/docs/access/)

## Estado atual

O **Bullgate Access** está implementado e integrado ao laboratório BAYBO. Ele
cobre cadastro e login, sessões opacas, integração server-to-server, adapter
ASP.NET Core, SDK React Native, jornada de verificação de telefone e resolução
do conflito de telefone da fase 1. O fluxo integrado foi validado em aparelho
Android em 04/09/2026.

O bootstrap usa um único manifesto v2 por environment para policies,
providers, segredos e configuração pública. Cada build se identifica por uma
`applicationClientKey` pública e estável; UUIDs de `ApplicationClient` são
detalhes internos do banco. O aplicativo continua falando apenas com o BFF e
nunca recebe a credencial de integração nem segredos dos providers.

As páginas distinguem explicitamente três situações:

- comportamento implementado e disponível na fase atual;
- contrato já decidido, mas ainda não implementado;
- possibilidade futura ainda sujeita a desenho e validação.

O núcleo de compra avulsa do Bullgate Billing começou em 2026-09-05 e já possui
persistência PostgreSQL, migrations, API server-to-server, autenticação própria,
bootstrap por manifesto e testes concorrentes no banco e por HTTP. O catálogo
pode receber novos produtos/SKUs, e credenciais possuem rotação explícita.
Em 2026-09-06 também estão implementados SDK .NET, transporte HTTP de benefícios,
política de recompra, verificadores Google Play/App Store e preparação com
vínculo de conta. Os testes usam HTTP externo simulado; o fluxo de compra ainda
não está conectado ao BFF/mobile, nem validado com compra real nas lojas.
Finalização/recuperação e resolução de compras pagas bloqueadas estão pendentes.
Billing, ofertas, entitlements e outras frentes aparecem como construção
inicial, visão de produto ou experiência comprovada no laboratório BAYBO
enquanto não existem como módulos públicos do Bullgate. A documentação não
apresenta roadmap como funcionalidade disponível.

## Documentação publicada

| Página                                                                               | Conteúdo                                                                                     |
| ------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------- |
| [Visão geral](https://bullgate.dev/)                                                 | Problemas que o Bullgate resolve, princípios do produto e estado de cada frente.             |
| [Política de Privacidade do Bullgate Lab](https://bullgate.dev/privacy/)             | Dados tratados pelo aplicativo móvel, finalidades, provedores e contato.                     |
| [Índice técnico](https://bullgate.dev/docs/)                                         | Entrada para escolher o documento adequado à integração.                                     |
| [Integração do Access](https://bullgate.dev/docs/access/)                            | Arquitetura, configuração, contratos, endpoints, adapter backend e SDK frontend.             |
| [Políticas](https://bullgate.dev/docs/access/politicas/)                             | Manifesto, authenticators, identifiers, verificação, permissões e invariantes.               |
| [Resolução de identidade](https://bullgate.dev/docs/access/resolucao-de-identidade/) | Detecção de conflito, provas, ações, concorrência, transferência e limites da fase 1.        |
| [Erros e mensagens](https://bullgate.dev/docs/access/erros/)                         | Códigos estáveis, status HTTP, copy recomendada, ação da interface e tratamento operacional. |

## Conteúdo do repositório

| Caminho                                                | Finalidade                                                                     |
| ------------------------------------------------------ | ------------------------------------------------------------------------------ |
| [`html/`](html/)                                       | Fontes HTML do site e da documentação publicada.                               |
| [`apresentacao-bullgate.md`](apresentacao-bullgate.md) | Documento mestre de visão, capacidades e placar do produto.                    |
| [`deploy-bullgate.ps1`](deploy-bullgate.ps1)           | Montagem local das rotas; publicação antiga no Pages exige flag explícita.     |
| [`DEPLOY.md`](DEPLOY.md)                               | Procedimento operacional de publicação mantido para os responsáveis pelo site. |

## Princípios da documentação

- **Comportamento antes de promessa:** toda capacidade informa se está
  implementada, decidida ou apenas prevista.
- **Contrato antes de exemplo:** parâmetros, estados, erros e efeitos precisam
  ser explicados antes de uma integração copiar código.
- **Backend e frontend separados:** cada lado da integração tem responsabilidade
  explícita; segredo de servidor nunca é configuração do aplicativo.
- **Texto para humanos, estrutura para ferramentas:** o conteúdo deve ser legível
  hoje e suficientemente estável para alimentar ferramentas e MCPs no futuro.

## Como contribuir

Correções, exemplos, melhorias de acessibilidade e propostas de documentação são
bem-vindos. Leia o [guia de contribuição](CONTRIBUTING.md) antes de abrir um pull
request. A participação no projeto segue nosso
[Código de Conduta](CODE_OF_CONDUCT.md).

## Segurança

Não publique vulnerabilidades ou dados sensíveis em issues. Consulte a
[política de segurança](SECURITY.md) para conhecer o escopo e o canal de relato
privado.

## Licença

O código e o conteúdo deste repositório são licenciados sob a
[Apache License 2.0](LICENSE).

Conforme a seção 6 da Apache-2.0, a licença não concede permissão para usar nomes
comerciais, marcas de serviço, marcas registradas, nomes de produtos ou a
identidade visual Bullgate, exceto no uso descritivo razoável necessário para
indicar a origem do trabalho.
