FROM node:16.19.1@sha256:8ef06c513538040a988ac7731afa8ad8b1135cfe5d8b6ad78489d80c6f6c0137 AS builder
WORKDIR /srv

COPY ./package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine@sha256:207332a7d1d17b884b5a0e94bcf7c0f67f1a518b9bf8da6c2ea72c83eec889b8
RUN rm -rf /usr/share/nginx/html
COPY --from=builder /srv/build /usr/share/nginx/html
ENTRYPOINT ["nginx", "-g", "daemon off;"]
