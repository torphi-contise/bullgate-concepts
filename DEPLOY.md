# Deploy — bullgate.dev

A produção é uma imagem ARM64 servida por nginx no Kubernetes da Oracle. O
estado do cluster é declarado no repositório privado `baybo-infra` e reconciliado
pelo Argo CD. O código e o conteúdo públicos permanecem neste repositório.

## Como o site é montado

O comando abaixo gera `deploy-dist/` com as sete rotas públicas:

```powershell
node .\scripts\build-site.mjs
```

O mesmo script é usado pelo `Dockerfile`; não há uma segunda implementação do
build para produção. A validação completa é:

```powershell
.\scripts\validate-repository.ps1
```

## Publicação de produção

1. Faça commit e push das mudanças neste repositório.
2. Use o hash curto do commit como tag imutável da imagem.
3. Em `baybo-infra`, execute:

   ```powershell
   .\k8s\scripts\build_bullgate_site.ps1 -Tag HASH_DO_COMMIT
   ```

4. Atualize `images.newTag` em
   `k8s/overlays/bullgate-prod/site/kustomization.yaml`.
5. Faça commit e push no branch `develop` do `baybo-infra`.
6. O Argo CD reconcilia `bullgate-prod-site` e `bullgate-prod-shared`.

O Ingress publica `bullgate.dev` e redireciona `www.bullgate.dev` para a raiz.
O cert-manager emite os certificados pelo ClusterIssuer `letsencrypt-prod`.

## Cloudflare

Na zona `bullgate.dev`, os registros DNS-only devem apontar para o IP público do
ingress-nginx da Oracle:

| Tipo | Nome | Destino |
|---|---|---|
| `A` | `bullgate.dev` | IP do ingress-nginx |
| `A` | `www.bullgate.dev` | IP do ingress-nginx |

Manter DNS-only durante a emissão HTTP-01 evita colocar o proxy da Cloudflare no
meio do primeiro certificado. O token usado pelo Terraform precisa ter acesso
explícito à zona `bullgate.dev`; acesso somente a `baybo.app` não é suficiente.

## Cloudflare Pages antigo

O site anterior continua recuperável no projeto Pages `bullgate`, mas deixou de
ser a produção. Uma publicação manual nesse destino exige intenção explícita:

```powershell
.\deploy-bullgate.ps1 -PublishCloudflarePages
```

Executar `deploy-bullgate.ps1` sem essa flag apenas monta o site localmente.

## Quando sair do preliminar

Remover o `noindex` das seis páginas e o aviso `versão 1 · preliminar` somente
quando a documentação estiver pronta para indexação pública.
