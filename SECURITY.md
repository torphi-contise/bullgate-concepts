# Política de segurança

A segurança de quem consulta, integra e mantém o Bullgate faz parte do produto.
Esta política explica como relatar uma possível vulnerabilidade sem expor outras
pessoas antes que o problema possa ser compreendido e corrigido.

## Versões cobertas

Recebem correções de segurança:

- a versão atualmente publicada em <https://bullgate.dev/>;
- os arquivos vigentes da branch padrão deste repositório.

Artefatos históricos e cópias mantidas por terceiros não recebem correções
retroativas. Se um problema antigo também afetar a versão vigente, ele permanece
dentro do escopo.

## O que relatar

Relate de forma privada situações como:

- credenciais, tokens, dados pessoais ou outros segredos presentes no
  repositório ou no site publicado;
- execução de script, injeção de conteúdo ou redirecionamento não autorizado no
  site;
- falhas no processo de build ou publicação que permitam alterar o conteúdo sem
  autorização ou revelar credenciais;
- documentação ou exemplos oficiais que orientem o uso inseguro de segredos,
  autenticação, sessões ou dados pessoais;
- qualquer falha reproduzível que possa comprometer confidencialidade,
  integridade ou disponibilidade do projeto.

Se a descoberta afetar um serviço Bullgate que ainda não possua sua própria
política pública, o mesmo canal privado pode ser usado. O relato será encaminhado
ao repositório responsável sem publicação prematura.

## Como relatar

Envie um e-mail para `acp.marco@outlook.com` com o assunto
`Segurança — Bullgate`.

Inclua, quando possível:

1. componente, página, rota ou arquivo afetado;
2. descrição do impacto observado ou potencial;
3. passos mínimos para reproduzir;
4. ambiente, navegador, versão ou commit relacionado;
5. evidências estritamente necessárias, removendo dados pessoais e segredos;
6. uma forma segura de contato para perguntas adicionais.

Não envie tokens válidos, senhas, documentos pessoais ou dados de terceiros. Se
uma evidência sensível for indispensável, descreva primeiro sua existência e
combine um meio adequado de transferência.

## O que esperar

O objetivo inicial é:

- confirmar o recebimento em até cinco dias úteis;
- fazer uma avaliação inicial de impacto e reprodução em até dez dias úteis;
- manter quem relatou informado quando houver mudança relevante de estado;
- coordenar a divulgação depois de existir correção ou mitigação adequada.

Esses prazos são metas de comunicação, não garantia de resolução. Complexidade,
dependências externas e disponibilidade de mantenedores podem alterar o tempo de
correção. Se o relato não estiver no escopo, responderemos indicando o motivo e,
quando conhecido, o canal apropriado.

## Divulgação responsável

Pedimos que detalhes capazes de facilitar exploração não sejam publicados antes
de uma correção, mitigação ou data de divulgação combinada. O crédito pela
descoberta será oferecido quando desejado e quando sua publicação não aumentar o
risco.

O projeto não possui programa de recompensa financeira por vulnerabilidades.
Não prometa pagamento, benefício ou reconhecimento em nome do Bullgate.

## Limites para testes

Uma pesquisa responsável deve:

- usar somente contas, dados e sistemas que pertençam à pessoa pesquisadora ou
  para os quais ela tenha autorização expressa;
- evitar indisponibilidade, degradação, spam, engenharia social e acesso a dados
  de terceiros;
- interromper o teste ao encontrar dados que não deveria acessar;
- coletar apenas a evidência mínima necessária para demonstrar o problema;
- respeitar serviços de terceiros e suas próprias políticas.

Esta política não concede autorização para testar contas, infraestrutura ou
serviços de terceiros, nem para realizar ataques de negação de serviço.

## Fora do canal privado

Erros de texto, links quebrados, problemas de layout e propostas sem impacto de
segurança podem ser tratados por issue ou pull request quando o repositório
público estiver disponível. Questões de conduta seguem o
[Código de Conduta](CODE_OF_CONDUCT.md), não esta política.
