FROM node:19.8.1@sha256:2405a991a6d9f6ac1d991feefc0a4539d5187abd2ca532fd18f7185c98b32a45 AS builder
WORKDIR /srv

COPY ./package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine@sha256:207332a7d1d17b884b5a0e94bcf7c0f67f1a518b9bf8da6c2ea72c83eec889b8
RUN rm -rf /usr/share/nginx/html
COPY --from=builder /srv/build /usr/share/nginx/html
ENTRYPOINT ["nginx", "-g", "daemon off;"]
