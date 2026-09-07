# Bullgate — Apresentação do produto

> **Rascunho vivo** · iniciado em 2026-09-01 · material de apresentação, não documentação técnica
> canônica. Para integrar, consulte as páginas técnicas publicadas no site.
>
> Este documento apresenta o Bullgate como produto: o que ele é, de onde vem cada capacidade, o que
> já está provado com dinheiro real e o que ainda é decisão ou construção. Ele é escrito no padrão
> de três documentos de referência citados ao final: **placar honesto**, sem inflar o que não existe.

**Legenda de estado, usada no documento inteiro:**

| Selo | Significado |
|---|---|
| 🟢 **No ar (laboratório)** | construído e em produção no BAYBO, com usuário e dinheiro reais |
| 🟡 **Prova pendente** | construído de ponta a ponta no laboratório; falta validação em aparelho/loja |
| 🔵 **No ar (plataforma)** | já reexpresso como código Bullgate e validado com o primeiro consumidor |
| 🔷 **Em construção (plataforma)** | parcialmente implementado no Bullgate |
| ⚪ **Decidido** | decisão e contrato registrados; implementação não começou |
| ⬜ **Em aberto** | decisão pendente |

---

## 1. O que é o Bullgate

Bullgate é uma **plataforma open source, mobile-first**, para donos de aplicativos operarem a
fundação que todo app com receita precisa e nenhum quer reescrever:

- **identidade e acesso** — cadastro, login, sessão, verificação, recuperação e resolução de
  conflitos de conta;
- **billing e assinaturas** — compras e assinaturas via App Store, Google Play e provedores web,
  com o backend como fonte de verdade;
- **ofertas dirigidas** — desconto para uma pessoa específica, sem cupom, no canal onde ela já
  paga;
- **entitlements** — entrega idempotente de benefícios, seja crédito, plano Pro, minutos ou
  qualquer moeda do app;
- **admin e operação** — painel de mesa e app de operação de bolso, com ações auditáveis;
- **portal do cliente** — autoatendimento de plano e pagamento.

O modo **self-hosted é gratuito para sempre** — isso é promessa de produto, não detalhe de deploy.
A receita pode vir de **Bullgate Cloud** (hospedagem gerenciada), suporte, operação e recursos
comerciais ao redor da plataforma. O Bullgate **não processa pagamento**: Apple, Google, Mercado
Pago e afins cobram e liquidam; o Bullgate orquestra, normaliza, audita e entrega o benefício.

**Licença (decidida em 2026-09-01):** AGPL-3.0 nos serviços, Apache-2.0 nos SDKs e na infra, CLA
para contribuições externas.

---

## 2. A tese: a fundação que todo app refaz

Todo aplicativo que vende plano dentro de app tropeça nos mesmos lugares, na mesma ordem:

1. o **cadastro** cobra fricção antes de a pessoa ter motivo para confiar — e ela fecha o app;
2. a **assinatura vaza** — quem queria pagar menos cancela, o app não sabe o que houve na loja,
   quem se arrepende não consegue voltar;
3. a **retenção** vira cupom genérico circulando por aí, em vez de uma proposta para a pessoa
   certa no momento certo;
4. a **operação** vira SQL na mão, planilha e "quem mandou isso?" seis meses depois.

Cada uma dessas dores tem solução conhecida — mas ela é pouco óbvia, cheia de armadilha de loja, e
cara de descobrir. O Bullgate existe para que ninguém precise pagar esse aprendizado de novo:
**tudo que a plataforma promete foi construído, quebrado e corrigido primeiro num produto real**,
com assinante pagando. Esse produto é o laboratório.

---

## 3. O laboratório: BAYBO

### 3.1 O produto e o usuário

O BAYBO é um painel de patrimônio para **leigo total** — a pessoa que tem dinheiro em algum lugar
(poupança, corretora, cripto, conta no exterior) e quer uma tela só que responda: quanto coloquei,
quanto tenho, e estou ganhando mais ou menos que Bitcoin, CDI e dólar. Não é trader, não é
contador. É "a vovó".

Esse usuário importa para a apresentação por um motivo: **ele é o teste mais duro possível para
fluxos de conta e cobrança.** Um fluxo de cadastro que a vovó completa, uma tela de assinatura que
ela entende ("nada é cobrado agora"), uma oferta que ela aceita sem digitar código — funcionam
para qualquer público.

### 3.2 A monetização do laboratório

O BAYBO vende **créditos de IA** em duas modalidades, publicadas nas duas lojas, com assinante
real pagando:

| Nível | Plano mensal | Por mês | Créditos/mês | Avulso (consumível) | Créditos avulso |
|---|---|---:|---:|---:|---:|
| 1 | Sardinha | R$ 19,90 | 40 | R$ 19,90 | 30 |
| 2 | Golfinho | R$ 29,90 | 60 | R$ 29,90 | 45 |
| 3 | Tubarão | R$ 39,90 | 80 | R$ 39,90 | 60 |
| 4 | Tubarão Baleia | R$ 49,90 | 100 | R$ 49,90 | 75 |
| 5 | Baleia | R$ 99,90 | 200 | R$ 99,90 | 150 |

O preço mora **na loja** (o app exibe o que a loja retorna, por país); o benefício mora em
configuração do backend. Para a plataforma, o que interessa é a mecânica — em outro app o
benefício seria acesso Pro, telas, minutos ou armazenamento. O Bullgate **não conhece "créditos de
IA"**: conhece entitlements.

### 3.3 Por que "laboratório" não é marketing

- Está em **produção** na Google Play e na App Store, com renovação, troca de plano, cancelamento,
  reembolso e notificação em tempo real operando desde agosto de 2026.
- Cada regra descrita aqui tem **incidente de origem** documentado: a cadeia de certificados da
  Apple que não existia no container (5 dias, 30+ builds), o R8 que renomeava a API de Billing só
  no release, a transação não finalizada que travava o SKU, a exclusão de conta que reabria replay
  de compra.
- O comportamento foi **conferido no código**, não só na documentação das lojas.

---

## 4. Os pilares do produto

### 4.1 Bullgate Access — identidade, sessão e continuidade da pessoa

**Estado geral: 🔵 integrado ao primeiro consumidor** — o Bullgate Access já existe como serviço
standalone (.NET 10, PostgreSQL 18, sessões opacas, migrations e deploy próprios). A integração
com o BAYBO foi **validada em aparelho Android real em 2026-09-04**: cadastro por e-mail/senha,
provisionamento do perfil, login, sessão persistente, verificação de telefone, resolução de
conflito e logout com revogação.

#### 4.1.1 O que o Access entrega

| Capacidade | Estado |
|---|---|
| Cadastro/login por e-mail e senha, server-to-server, sessão opaca | 🔵 No ar (plataforma) |
| Sessão: token opaco 256-bit, só hash persistido, revogação monotônica por `SessionVersion` | 🔵 No ar (plataforma) |
| Fail-closed sem fail-logout: loja de identidade fora do ar = `503` preservando cookie; sessão inválida = `401` | 🔵 No ar (plataforma) |
| Protocolo `AccessFlow` (jornada stateful multi-etapas, retry idempotente, snapshots por revisão) | 🔵 No ar (plataforma) |
| Verificação de telefone (SMS via Twilio Verify com código gerado pelo Bullgate, SMS Retriever Android, OTP iOS) | 🔵 No ar na plataforma — fluxo integrado validado no Android |
| Conflito de telefone: transferir o número provando posse + conhecimento do e-mail anterior | 🔵 No ar na plataforma — integrado ao BAYBO |
| Consolidação de conta provisória na conta anterior (recuperar a conta antiga) | ⚪ Decidido — contrato completo registrado |
| CPF como identificador de login de primeira classe (`br:cpf`) | ⚪ Decidido |
| Recuperação integral por titularidade de CPF (`CpfOwnership`) com provedores plugáveis (ICP-Brasil, Datavalid, GOV.BR) | ⚪ Decidido — port definido, adapters futuros |
| Login social Google/Apple na plataforma | 🔵 Implementado e habilitado por environment; e-mail coincidente não faz auto-link entre identities |

#### 4.1.2 O diferencial: identity resolution

Login isolado o mercado inteiro tem. O que o Access resolve de específico é a **continuidade da
pessoa quando o caminho simples quebra**: conta duplicada porque ela perdeu o acesso, telefone que
já pertence à conta antiga, e-mail que não existe mais, CPF que prova quem é a dona de verdade.

O modelo é um só para todos os casos: **caso → provas → política versionada → grant de uso único →
execução idempotente**. Sem pontuação oculta, sem decisão subjetiva de suporte — se as provas
satisfazem a política, o grant sai; se não satisfazem, nenhum operador pode "aprovar na mão". Cada
passo é auditável, e a titular recuperada consulta a própria trilha de segurança sem depender de
atendimento.

#### 4.1.3 A jornada do usuário: cadastro sem fricção (provado no laboratório)

O desenho vem do documento de referência **"Fluxo de Cadastro"** e está 🟢 no ar no BAYBO:

- **entrar sem conta** — modo visitante com dados de demonstração; cadastro é decisão informada;
- **três portas** — Google e Apple na frente (o provedor prova a credencial), formulário atrás de
  um toque; e-mail já usado por outra identity produz conflito explícito, e outro provider só é
  vinculado a partir de uma sessão autenticada;
- **nada de "confirme seu e-mail" barrando a entrada** — o custo é adiado para a recuperação, e as
  saídas de conflito existem exatamente por isso;
- **telefone como passo próprio, depois da conta**, com "Agora não" de verdade e a etapa inteira
  ligável por configuração de servidor;
- **conflito como escolha, não erro** — o único losango do fluxo: número provado que já pertence a
  outra conta oferece três saídas (mover o número, recuperar a conta antiga, seguir sem telefone),
  com identificador mascarado para reconhecer e completo como prova, e a guarda que impede apagar
  conta estabelecida.

Integração **100% nativa**: o Bullgate entrega protocolo, SDK React Native e bridges de
plataforma; o app dono entrega layout, copy e navegação. Nenhuma jornada depende de WebView, HTML
ou página de login hospedada. O SDK nunca fala com o Bullgate direto — só com a API do próprio
app, que instala o adapter server-side.

---

### 4.2 Bullgate Billing — assinatura sem fuga

**Estado geral: 🟢 referência no laboratório, 🔷 plataforma em construção.** A mecânica
abaixo usa a implementação BAYBO como referência, sem usuários ou legado comercial a migrar.
Em 2026-09-05 começou o código do Bullgate Billing pela compra
avulsa: domínio puro, ports de validação/entrega, recibo anônimo, PostgreSQL, migration e testes
concorrentes de idempotência. A API server-to-server, a autenticação própria e o bootstrap por
manifesto já existem, com expansão de catálogo e rotação explícita de credenciais. Em 2026-09-06
também estão implementados SDK .NET, transporte HTTP, política de recompra, verificadores App
Store/Google Play e preparação com vínculo de conta. A verificação local usa HTTP externo
simulado. Finalização/recuperação, conexão do fluxo ao BFF/mobile, resolução de compras pagas
bloqueadas e validação real nas lojas continuam pendentes; não é um fluxo comercial ativado.

#### 4.2.1 Os quatro vazamentos resolvidos

Do documento de referência **"Assinatura Sem Fuga"** — os lugares onde todo app que vende plano
perde dinheiro, e a solução de cada um:

**1. Quem quer pagar menos, cancela** · 🟢 No ar
Todos os planos visíveis o tempo todo, com o atual marcado; troca dentro do app, nunca passando
por cancelamento, nunca virando segunda assinatura paralela. Regra de tempo assimétrica de
propósito: **subir vale agora** (cobrança imediata, benefício na hora), **descer vale na próxima
renovação** (nada cobrado no meio, nada confiscado). A tela diz o timing antes de abrir a loja:
"Nada é cobrado agora".

**2. Quem se arrepende da troca não consegue voltar** · 🟢 No ar
A Play recusa "trocar" para o plano em que a pessoa já está. A solução é o **plano gêmeo**
(`.keep`): um espelho físico de cada plano — mesmo preço, benefício e nome — invisível na tela.
Para a pessoa é o mesmo plano; para a loja é outro produto, e a volta passa. A volta é **sempre
agendada, nunca cobrada** (senão a pessoa pagaria um ciclo para não mudar nada). Só o Android
precisa disso; no iPhone a Apple desfaz o agendamento pela reescolha no subscription group.

**3. O app não sabe o que houve na loja** · 🟢 No ar
Notificação em tempo real das duas lojas: **RTDN** da Play (Pub/Sub push autenticado por OIDC) e
**App Store Server Notifications v2** (payload assinado pela Apple, verificado contra a raiz
embarcada). Disciplina inegociável: **o aviso é gatilho, nunca fonte da verdade** — ao receber,
o backend reconsulta a loja antes de mexer no acesso de alguém. E o ganho maior não é cortar mais
rápido: é **distinguir "cancelou" de "cartão em retentativa"** — e não derrubar quem não queria
sair. Redes de segurança por baixo: scanner periódico, conferência ao abrir a tela, reenvio de
compra que a loja conhece e o servidor não.

**4. Uma pessoa, várias lojas** · 🟢 No ar
O plano é da pessoa, não do aparelho. Quem assinou pela Play e abre no iPhone vê o plano ativo com
a mensagem "assinado em outra loja — gerencie por lá", e **não** recebe botão de assinar de novo.
Cobrança dupla é reembolso, ticket e nota ruim.

#### 4.2.2 A regra que sustenta o dinheiro

**Um período pago, um período de benefício.** O benefício só nasce de **cobrança efetiva
confirmada pela loja** — nunca de estado, promessa ou webhook. A idempotência usa chaves
diferentes por modalidade, e a diferença não é estilo:

- **avulso: por transação** — o identificador externo é guardado só como SHA-256; retry devolve
  "já entregue" sem duplicar;
- **mensal: por ciclo pago** — a chave é `(loja, orderId)`, porque o token da assinatura é
  constante e cada cobrança gera um id novo.

Consequência elegante que dispensa lógica extra: grace period, on-hold, pausa e retentativa de
cartão **não cobram → não geram orderId → não creditam**. Sem regra especial para cada estado.

E a armadilha mais cara do módulo, já paga: **excluir a conta não pode zerar a trava de replay.**
O laboratório mantém um **recibo anônimo** — só loja + tipo + hash da chave, deliberadamente sem
dono, sem FK, sem valor — que sobrevive à exclusão (dado não-pessoal para a LGPD, retenção
antifraude) e impede que o mesmo pagamento vire benefício duas vezes numa conta nova.

#### 4.2.3 Operações de loja que a operação usa

| Operação | Mecânica | Estado |
|---|---|---|
| **Adiar a cobrança** (compensar alguém sem devolver dinheiro) | Google `defer` (1 dia–1 ano, com etag) · Apple `extend` (1–90 dias, 2×/ano-calendário, idempotente por `requestIdentifier`) | 🟢 No ar |
| **Cancelar a renovação** | só Google (`USER_REQUESTED_STOP_RENEWALS`, preservando o direito de restaurar); na Apple quem cancela é a pessoa — e a tela diz "Apple não permite", não "não suportado" | 🟢 No ar |
| **Reembolsar e encerrar** | só Google (`revoke`, integral ou proporcional — modos mutuamente exclusivos, sem default); o estorno de benefício acontece pelo sync idempotente, nunca por escrita direta do painel | 🟢 No ar |
| **Restaurar / reconsultar a loja** | ação inline sem justificativa — não decide nada, só sincroniza | 🟢 No ar |

#### 4.2.4 O que o Billing não faz (fronteira de produto)

Não é adquirente, não armazena cartão, não faz custódia de dinheiro, não faz antifraude próprio
completo, não faz contabilidade fiscal. Pagamento é processado por provedores; o Bullgate
orquestra e entrega.

#### 4.2.5 Próximos passos decididos

- ⚪ **Cobrança própria fora da comissão de loja** (PIX/cartão via Mercado Pago, depois Stripe):
  o desenho já fala em "onde a pessoa paga" de forma genérica desde o começo — entrar com um
  terceiro meio é acrescentar adapter, não reescrever.
- ⚪ **Checkout web e portal do cliente** como contratos de plataforma.

---

### 4.3 Ofertas dirigidas — a joia da coroa

**Estado geral: 🟢 catálogo, envio, canais e aceite Android no ar no laboratório; 🟡 aceite iOS e
troca-com-oferta construídos aguardando validação em loja; ⚪ plataforma não iniciada.**

Este é o pilar de maior retorno para quem vende assinatura, e o mais difícil de construir sozinho
— por isso ganha a seção mais longa.

#### 4.3.1 O que é (e o que não é)

**Não é cupom.** Não tem código para digitar, não tem link que qualquer um repassa, não existe
promoção circulando. É uma oferta **feita para uma pessoa específica** — só ela vê — que chega
como aviso no celular, aparece dentro do app enquanto valer, e é aceita **na tela da própria
loja**, com o preço com desconto e o preço cheio lado a lado. O preço da base inteira não muda.

A loja continua dona do preço, da cobrança e da assinatura. O sistema não inventa desconto: ele
**orquestra o catálogo da loja + a elegibilidade + a comunicação**, e registra a trilha inteira.

#### 4.3.2 Os cinco momentos

Desconto dirigido só funciona se cada oferta souber em que momento da vida do assinante ela fala.
O sistema trabalha com categorias que **também são regra**: o momento não é etiqueta — é o que a
elegibilidade verifica ("voltar" não se oferece a quem está ativo; "subir" não se oferece a quem
já está no topo).

| Momento | Campanha real no laboratório | Condição | Estado |
|---|---|---|---|
| **Introdução** (`acquisition`) | "Comece com 25%" | 25% · 2 meses no Android (a Play recusou desconto recorrente de 1 período — regra de loja vazando para o desenho) | 🟢 catálogo no ar (Google) · Apple exige introductory offer, contrato separado — deliberadamente fora do fluxo de grant |
| **Retenção** (`retention`) | "Ficar no BAYBO" | 50% · 3 meses, para quem cancelou a renovação ou agendou descida | 🟢 catálogo no ar (2 lojas) |
| **Upgrade** (`upgrade`) | "Subir de plano" | 30% · 2 meses, para quem usa muito e caberia no plano de cima | 🟢 catálogo no ar (2 lojas) |
| **Win-back** (`win_back`) | "Voltar para o BAYBO" | 50% · 3 meses, para quem já assinou e saiu | 🟢 catálogo no ar (2 lojas) |
| **Cortesia** (`courtesy`) | gesto de atendimento | caso a caso | ⚪ categoria prevista |

#### 4.3.3 O catálogo: uma campanha, um cadastro por loja

Para a operação, "Ficar no BAYBO — Tubarão" é **uma campanha**. Para a Apple e o Google são
registros distintos com identificadores próprios que pertencem à loja. O modelo guarda **uma linha
por loja** e a tela agrupa as duas como canais do mesmo cartão. Isso não é burocracia:

- permite **ativar uma loja e não a outra** (caso real no ar: Apple inativa, Google ativa);
- absorve **divergências que a loja impõe** (as boas-vindas têm duração diferente por loja);
- deixa o identificador da loja como **contrato imutável** — oferta não se apaga, se **desativa**,
  porque o histórico de quem recebeu aponta para ela.

Mecânica por loja, verificada em produção:

- **Google Play**: oferta pertence a um base plan; o app cruza o `offerId` autorizado com as
  ofertas retornadas pela Billing Library e compra com o **`offerToken` vigente** (token nunca é
  contrato — o contrato é `productId + basePlanId + offerId`). Quando a pessoa já assina e a
  compra precisa trocar o produto físico (canônico ↔ gêmeo, upgrade), o backend devolve os
  parâmetros de replacement e o app compra com eles.
- **App Store**: promotional offer exige **assinatura criptográfica do servidor** — o backend
  assina (ECDSA, nonce novo, timestamp em milissegundos) com a chave de IAP e o app passa
  `withOffer` ao StoreKit. Promotional é para assinante atual/anterior; win-back tem caminho
  próprio da Apple, inclusive URL de resgate por e-mail.

#### 4.3.4 O grant: ciclo de vida completo, auditável

Cada envio cria um **grant** — o vínculo pessoa↔oferta — com trilha própria:

```
created → sent → opened → redeemed
                        ↘ expired · canceled · not_eligible · store_rejected
```

- **Enviada** não é resgatada. **Aberta** não é resgatada. **Resgatada é quando a loja confirma a
  cobrança com aquela condição** — no iOS, o comprovante assinado pela Apple precisa trazer o
  identificador exato da oferta; no Android, a compra confirmada precisa ser do plano e base plan
  certos.
- **Divergência não pune a pessoa**: compra válida sem a condição esperada vale — ninguém paga e
  fica sem; a trilha registra que o desconto não foi aplicado, para a operação ver.
- **Validade**: todo convite expira (1/3/7/15 dias, padrão 15) — data concreta gravada no envio,
  nunca prazo que se move sozinho. Vencido, some das telas e do formulário; o histórico permanece.
- **Todo envio deixa registro**: quem enviou, para quem, qual oferta, motivo interno, resultado
  por canal. Ação que mexe com dinheiro de cliente sem trilha vira "quem mandou isso?" seis meses
  depois.

#### 4.3.5 Os quatro canais — e a regra que os governa

A mesma oferta viaja por quatro caminhos que não competem:

| Canal | Onde | Papel |
|---|---|---|
| **Pop-up no topo** | dentro do app | a primeira vista garantida — um de cada vez, sai só no X, dispensa por aparelho |
| **Bolha flutuante** | dentro do app | o lembrete que não interrompe — teto de duas, fica enquanto o convite valer |
| **E-mail** | fora do app | o canal de quem foi embora (win-back) — **sem botão que leva à oferta, o envio nem sai**: meio aviso é pior que nenhum |
| **Push** | fora do app | o atalho imediato — abre direto a tela da oferta, no aparelho onde o pagamento já está cadastrado |

**A regra aprendida com incidente: envio é UM fato; canal é técnica.** O grant vira `sent` em
qualquer combinação — inclusive só nas superfícies do app — e cada canal carrega o próprio
resultado de entrega. Antes dessa regra, um e-mail que quicava desfazia o envio e **a oferta sumia
do app inteiro**, embora existisse, válida, no card. Aviso perdido não pode matar a oferta: o
lugar dela é dentro do app, listada enquanto valer.

#### 4.3.6 O envio: parte de uma pessoa, não de uma lista

O envio acontece **na ficha da pessoa** dentro do painel de operação — onde já se vê o plano, o
histórico de cobrança e os aparelhos. E o formulário é travado **pelo estado, não pelo bom senso**:

- só lista as ofertas que o estado real da assinatura permite (a elegibilidade é **uma pergunta do
  domínio**, num lugar só — a lição do laboratório foi achar a mesma regra copiada em duas camadas
  divergindo);
- e-mail e push só ficam marcáveis quando existem de verdade ("sem aparelho registrado" trava a
  caixa e diz por quê);
- a copy é a do catálogo — ver antes de mandar é diferente de reescrever no celular;
- a validade é escolhida em valores fechados; quem resolve a data é o servidor;
- catálogo vazio para aquela pessoa **não é erro**: "nenhuma oferta serve para ela" é fato do
  estado.

#### 4.3.7 O aceite: onde a pessoa já paga

Do lado de quem recebe não existe resgate, código nem formulário. A oferta é um cartão na tela; o
toque abre uma tela dedicada que mostra **o valor real vindo da loja** (R$ 19,95 num plano de
R$ 39,90) com condição, benefício e loja declaradas — **o app nunca calcula o preço**; se a loja
não devolver a oferta, a tela não inventa número. O botão abre a folha de compra da própria loja.

Regras de produto que não regridem:

- **o desconto não mexe no benefício** — quem aceita 50% recebe o benefício cheio; desconto que
  corta benefício é rebaixamento disfarçado;
- **aceitar usa a mecânica de sempre** — ficar com desconto compra o próprio plano, subir com
  desconto é a troca normal; nunca nasce assinatura paralela;
- **benefício continua nascendo só de cobrança confirmada** — oferta enviada não credita nada.

#### 4.3.8 Ofertas de compra avulsa (além da assinatura)

O mesmo desenho vale para produto avulso/consumível: catálogo por loja apontando **sempre para um
produto real** (sem produto fake), grant com as mesmas superfícies e validade, e resgate amarrado
à compra confirmada. As lojas divergem e o modelo absorve: no Google, a oferta usa o token de
desconto da Billing Library; na Apple, o caminho é **offer code / URL de resgate** — o app abre a
URL e, na volta, drena as compras disponíveis para validar. Uma atribuição local com prazo cobre o
retorno tardio da loja. 🟢 Envio, histórico e aceite Android validados em aparelho; 🟡 iOS e
submissão de loja pendentes.

#### 4.3.9 Placar da frente de ofertas

| Peça | Estado |
|---|---|
| Catálogo por loja com ativação independente (4 campanhas reais nas 2 lojas) | 🟢 No ar |
| Envio pela ficha com elegibilidade, canais travados, motivo e trilha | 🟢 No ar |
| Superfícies no app (card persistente, pop-up, bolha) + push + e-mail com CTA obrigatório | 🟢 No ar |
| Aceite Android de ponta a ponta (offerToken, replacement quando precisa) | 🟢 No ar (validado em aparelho) |
| Aceite iOS (assinatura criptográfica de promotional offer, `withOffer`) | 🟡 Prova pendente — construído inteiro, falta TestFlight com oferta cadastrada |
| Troca de plano já aceitando a oferta (Android) | 🟡 Prova pendente |
| Oferta avulsa (Google token / Apple redemption URL) | 🟢 envio+Android · 🟡 iOS/loja |
| Auditoria fina do que a loja aplicou (`offerId`/`offerTags` Google, `offerType` Apple) | ⚪ Decidido |
| Win-back Apple com URL de resgate por e-mail | ⚪ Decidido |
| Generalização como Bullgate Billing (catálogo/grant/entitlement genéricos) | 🔷 Compra avulsa em construção |

---

### 4.4 Bullgate Admin — a operação (mesa e bolso)

**Estado geral: 🟢 no ar no laboratório em duas superfícies complementares; ⚪ como produto
Bullgate, decidido e não iniciado.** O laboratório provou algo raro: **a operação inteira de um
produto com dinheiro real cabendo no bolso do operador.**

#### 4.4.1 As duas superfícies

| | Backoffice web (a mesa) | App de operação (o bolso — "Zap" no laboratório) |
|---|---|---|
| Para quê | trabalho de mesa: catálogos de ofertas, jobs, desenho do que vem | atendimento e operação por pessoa: busca, ficha, ações, conversa |
| Navegação | por módulo (Usuários, Ofertas, Jobs, Suporte) | **a pessoa é o eixo** — duas abas (Conversas, Pessoas), tudo pende da ficha |
| Escreve? | catálogos e suporte | todas as ações operacionais de pessoa |

#### 4.4.2 A ficha da pessoa — o coração da operação

Uma chamada, tudo que vem do banco: identidade, plano vigente com nome operacional, contas,
créditos, compras avulsas, ciclos pagos, ofertas enviadas (com resultado por canal), conversas,
gravações de sessão e erros (PostHog, buscados só no clique). Organizada **por assunto**: Acesso,
Contas, Créditos, Assinatura, Atendimento.

Decisões que valem para qualquer produto:

- **a disponibilidade de cada ação vem do servidor** (`enabled` + motivo escrito): "Apple não
  permite" e "sem assinatura ativa" são fatos do estado, e recalcular no cliente divergiria no
  primeiro ajuste;
- **valor sai cru, como está armazenado** — decimal viaja como string para o JavaScript não
  arredondar (conta em BTC tem 8 decimais que importam); data em UTC marcada, com o relativo ao
  lado e nunca no lugar;
- **"sem registro" onde ninguém mediu, nunca travessão** — travessão se leria como "nunca
  aconteceu", que é afirmar fato não medido;
- **pendência não se sinaliza no app de operação** — tela só entra quando faz o que promete; o que
  aparece é indisponibilidade *daquela pessoa*, com motivo.

#### 4.4.3 As ações operacionais — todas com o mesmo envelope

Cada ação grava seu próprio registro de auditoria com ator (das claims, nunca do corpo), tipo,
alvo, **chave de idempotência** (por intenção, não por toque — toque duplo não executa duas
vezes), carimbos e desfecho. Erros vêm em faixas semânticas que mudam o que o operador faz:
404 "não existe", 409 "o estado recusa — não adianta insistir", 400 "o pedido está errado",
503 "loja/serviço fora — a ação ficou registrada".

| Grupo | Ações no ar | Nota |
|---|---|---|
| **Acesso** | enviar link de redefinição · encerrar sessões · bloquear · desbloquear · desconectar Google/Apple | bloquear barra as portas **e** derruba sessões atomicamente; desbloquear nunca devolve sessão antiga |
| **Assinatura** | ofertar · adiar cobrança · cancelar renovação · reembolsar · restaurar | as guardas de loja/estado vêm do domínio; "restaurar" é a única inline (não decide nada) |
| **Créditos** | ofertar pacote avulso · saldo/extrato/histórico | envio nunca concede benefício — só a compra confirmada |
| **Atendimento** | conversa em tempo real · push avulso com destino fechado | resposta persiste → transmite → notifica, nessa ordem |

#### 4.4.4 Suporte com WhatsApp

O inbox unifica conversas do app (logado ou visitante) e **conversas vindas do WhatsApp** (webhook
da Meta), rotuladas com o número cru. A resposta do atendente entrega no WhatsApp dentro da janela
de 24h, e as falhas voltam **para a tela do operador** com a causa distinguida (janela fechada ≠
token vencido), porque as ações corretivas são opostas. Push nativo avisa o atendente de mensagem
nova no aparelho.

#### 4.4.5 Como isso vira produto Bullgate

⚪ Decidido: Admin Console e Customer Portal são superfícies da plataforma operando **sobre
contratos** de Access e Billing (nunca escrevendo direto no banco); toda ação sensível gera
auditoria; o admin não contém regra de dinheiro própria. O backoffice do laboratório será o
primeiro cliente da API administrativa do Access (bloquear, desbloquear, revogar sessões) quando
esse contrato entrar.

---

### 4.5 Bullgate Portal — autoatendimento

⚪ **Decidido, não construído.** Ver plano atual, trocar, cancelar, reativar, atualizar pagamento
via provedor, histórico, recuperar compra, corrigir cobrança falha. Opcional para apps que já têm
UI própria — mas os contratos de backend existirão de qualquer forma, para o app implementar a
própria superfície.

---

## 5. As invariantes da plataforma

As regras que valem em todos os pilares — cada uma custou um incidente ou nasceu de decisão
explícita:

1. **O backend é a fonte de verdade** para acesso, assinatura, entitlement e idempotência. O
   cliente exibe; nunca decide.
2. **Webhook é gatilho, não verdade financeira.** Toda notificação dispara reconsulta ao provedor
   antes de mudar estado sensível.
3. **Benefício só nasce de cobrança efetiva confirmada** — nunca de estado, promessa, oferta
   enviada ou produto devolvido antes de pago.
4. **Entrega de benefício é idempotente por chave natural** — replay, retry e evento duplicado não
   duplicam; evento fora de ordem não corrompe.
5. **A loja/provedor é dona do preço.** A tela mostra o que a loja retorna; o app nunca calcula.
6. **Dado de provedor é referência e auditoria** — payload bruto imutável; estado interno
   normalizado.
7. **Nada de cartão no banco da plataforma.** Token/referência do provedor; escopo PCI fora.
8. **Toda ação administrativa sensível gera auditoria** — ator, alvo, chave, desfecho.
9. **Capability curta e explícita para operação sensível** — titularidade comprovada não libera
   nada por efeito colateral.
10. **Falha operacional não vira decisão de domínio** — loja fora do ar é retry, nunca rejeição;
    indisponibilidade não vira logout, cancelamento nem "manual review".

---

## 6. O placar honesto — visão geral

| Capacidade | Laboratório (BAYBO) | Plataforma (Bullgate) |
|---|---|---|
| Cadastro/login e-mail+senha, sessão opaca, introspecção | 🟢 migrado para o Bullgate | 🔵 **no ar, validado em Android real (2026-09-04)** |
| Login social Google/Apple | 🟢 integrado ao Bullgate | 🔵 implementado, sem auto-link por coincidência de e-mail |
| Verificação de telefone + conflito (mover número) | 🟢 migrado para o Bullgate | 🔵 implementado no `AccessFlow` e validado no app |
| Recuperar conta antiga + consolidação | desenho provado | ⚪ decidido, contrato completo |
| CPF login + `CpfOwnership` (recuperação integral) | — | ⚪ decidido, port definido |
| Assinatura nas 2 lojas (troca, gêmeo, RTDN/ASN, redes de segurança) | 🟢 | ⚪ decidido; núcleo avulso compartilhado em construção |
| Adiar / cancelar / reembolsar / restaurar | 🟢 | ⚪ decidido |
| Compra avulsa consumível nas 2 lojas | 🟢 | 🔷 API, SDK, entrega HTTP, política, verificadores e vínculo de conta; sem fluxo BFF/mobile ou compra real validada |
| **Ofertas de assinatura dirigidas** (catálogo, grant, 4 canais, elegibilidade) | 🟢 (aceite iOS 🟡) | ⚪ decidido |
| **Ofertas avulsas dirigidas** | 🟢 envio+Android · 🟡 iOS | ⚪ decidido |
| Operação de mesa (catálogos, jobs) | 🟢 | ⚪ decidido |
| Operação de bolso (ficha, ações auditáveis, suporte, WhatsApp) | 🟢 | ⚪ decidido |
| Portal do cliente | — | ⚪ decidido |
| Cobrança web própria (Mercado Pago, PIX) | — | ⚪ decidido |
| Bullgate Cloud | — | ⬜ em aberto |
| Público inicial | — | ⬜ em aberto |
| Licença | — | ✅ decidida: AGPL-3.0 serviços · Apache-2.0 SDKs · CLA |

---

## 7. Mapa: de onde vem cada peça

| Peça da plataforma | Origem provada no laboratório |
|---|---|
| Bullgate Access — sessões, revogação monotônica, fail-closed | caracterização do auth do BAYBO + as lacunas achadas (bloqueio não-atômico virou contrato atômico na plataforma) |
| Identity resolution — caso/prova/política/grant | fluxo real de conflito de telefone do BAYBO (challenge de 6 dígitos, 10 min, 5 tentativas, cooldown) reexpresso como política |
| SDK mobile nativo (protocolo de etapas, SMS Retriever, OTP iOS) | telas nativas do BAYBO dirigidas por snapshot |
| Billing — idempotência por transação/ciclo | `(loja, orderId)` e SHA-256 de referência externa em produção |
| Plano gêmeo / produto físico vs visível | `.keep` do Android, auditado por ferramenta própria contra o catálogo da Play |
| Recibo anônimo pós-exclusão | incidente real de replay por exclusão de conta, corrigido |
| Ofertas dirigidas | catálogo real de 4 campanhas nas 2 lojas + grant lifecycle + validação em aparelho |
| Verificação criptográfica (JWS Apple, raiz embarcada; OIDC do RTDN) | 5 dias de investigação e a regra "nunca confiar no trust store do container" |
| Admin/operação | backoffice Blazor + app de operação Android em produção |
| Suporte omnicanal | chat do app + WhatsApp via webhook Meta, inbox único |

A regra de migração é explícita nos docs canônicos: **nada é copiado mecanicamente**. Cada regra
trazida do laboratório é classificada — genérica de plataforma, específica do BAYBO, específica de
provedor, ou acidente histórico a descartar.

---

## 8. Modelo de negócio

- **Self-hosted gratuito para sempre** — instalação documentada, bootstrap idempotente por
  manifesto, cada serviço com database e migrations próprias. O core gratuito inclui o modelo
  inteiro de proofs/policies/grants; adapters externos (Datavalid, ICP-Brasil) podem ter custo do
  fornecedor, sem virar requisito da plataforma.
- **Bullgate Cloud** (⬜ em aberto se nasce junto): hospedagem gerenciada, upgrades, backups,
  observabilidade, SLA, adapters comerciais, white-label — cada cliente isolado em workspace.
- **Licença**: AGPL-3.0 nos serviços (protege o Cloud sem quebrar a promessa open source),
  Apache-2.0 nos SDKs e infra (código que roda dentro do app do cliente não pode ter copyleft),
  CLA preservando a capacidade de licença comercial.
- **Público inicial** (⬜ em aberto): candidatos — apps próprios, devs indie, SaaS pequenos,
  agências com entrega recorrente, empresas que exigem self-hosted.

---

## 9. Em progresso agora

1. 🔷 **Lab distribuível**: fechar o Compose que sobe PostgreSQL, `access-init`, Bullgate Access e
   o BFF com um único manifesto local de primeiro environment, sem exigir segredos no Git.
2. ⚪ **Consolidação de identidade** (recuperar a conta anterior de ponta a ponta, com recovery
   session e saga idempotente com o perfil do app).
3. 🟡 **Fechamento das provas de loja das ofertas**: TestFlight com promotional offer real
   cadastrada; troca de plano com oferta no Android; auditoria fina do que a loja aplicou.
4. 🔷 **Bullgate Billing** como código de plataforma — compra avulsa com domínio, PostgreSQL,
   migration, entrega idempotente, API autenticada, bootstrap, SDK .NET, verificadores das duas
   lojas e vínculo de conta. Próximos: finalização/recuperação, integração BFF/mobile e compra
   real validada; ofertas avulsas antes de assinaturas. Avisar o usuário antes de conectar o
   fluxo ao BFF. Resolução de compras pagas bloqueadas segue pendente antes de vendas restritas.

---

## 10. Sobre este documento

- **Fontes**: documentação canônica do Bullgate (`bullgate-docs`, atualizada até 2026-09-04), documentação
  canônica do BAYBO (`baybo-docs` — em especial o doc de IAP, o de backoffice e os documentos de
  trabalho de ofertas e operação), e os três documentos de apresentação já publicados
  ([Fluxo de Cadastro](https://claude.ai/code/artifact/0ec30634-e1c3-40bb-8023-d37bf28746eb) ·
  [Assinatura Sem Fuga](https://claude.ai/code/artifact/5bd48522-a2d5-48b2-bae0-347095dd953c) ·
  [Oferta Sem Cupom](https://claude.ai/code/artifact/57760742-192a-4bb7-a3a9-70178fb10e90)).
- **Regra de confiança**: em fato técnico, o código e os docs canônicos vencem este documento;
  aqui o compromisso é o placar honesto — nenhuma capacidade apresentada acima do seu selo real.
- **Pendências deste documento**: identidade visual/nome público das seções; versão resumida
  (one-pager) e versão visual (artefato) derivadas deste mestre; revisão do dono sobre ênfases e
  o que entra na primeira divulgação pública.
