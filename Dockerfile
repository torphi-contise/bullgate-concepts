FROM node:24-alpine AS build

WORKDIR /src
COPY html/ ./html/
COPY scripts/build-site.mjs ./scripts/build-site.mjs
RUN node scripts/build-site.mjs

FROM nginxinc/nginx-unprivileged:1.29-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build --chown=101:101 /src/deploy-dist/ /usr/share/nginx/html/

EXPOSE 8080
