FROM node:16.18.1@sha256:68fc9f749931453d5c8545521b021dd97267e0692471ce15bdec0814ed1f8fc3 AS builder
WORKDIR /srv

COPY ./package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine@sha256:dd8a054d7ef030e94a6449783605d6c306c1f69c10c2fa06b66a030e0d1db793
RUN rm -rf /usr/share/nginx/html
COPY --from=builder /srv/build /usr/share/nginx/html
ENTRYPOINT ["nginx", "-g", "daemon off;"]
