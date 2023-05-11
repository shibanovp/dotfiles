FROM node:19.8.1@sha256:1fab548e95c779df229e4b50d8d20e222597bda15aeece508098c5ba7723302e AS builder
WORKDIR /srv

COPY ./package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine@sha256:02ffd439b71d9ea9408e449b568f65c0bbbb94bebd8750f1d80231ab6496008e
RUN rm -rf /usr/share/nginx/html
COPY --from=builder /srv/build /usr/share/nginx/html
ENTRYPOINT ["nginx", "-g", "daemon off;"]
