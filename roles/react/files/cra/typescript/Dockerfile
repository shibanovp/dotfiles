FROM node:16.17.0@sha256:0c672d547405fe64808ea28b49c5772b1026f81b3b716ff44c10c96abf177d6a AS builder
WORKDIR /srv

COPY ./package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine@sha256:b87c350e6c69e0dc7069093dcda226c4430f3836682af4f649f2af9e9b5f1c74
RUN rm -rf /usr/share/nginx/html
COPY --from=builder /srv/build /usr/share/nginx/html
ENTRYPOINT ["nginx", "-g", "daemon off;"]
