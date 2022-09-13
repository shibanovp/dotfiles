FROM node:16.17.0@sha256:a5d9200d3b8c17f0f3d7717034a9c215015b7aae70cb2a9d5e5dae7ff8aa6ca8 AS builder
WORKDIR /srv

COPY ./package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine@sha256:082f8c10bd47b6acc8ef15ae61ae45dd8fde0e9f389a8b5cb23c37408642bf5d
RUN rm -rf /usr/share/nginx/html
COPY --from=builder /srv/build /usr/share/nginx/html
ENTRYPOINT ["nginx", "-g", "daemon off;"]
