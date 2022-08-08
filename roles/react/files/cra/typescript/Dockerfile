FROM node:16.16.0@sha256:1ed1e17ccabb09038cfb8a965337ebcda51ef9e9d32082164c502d44d9731a02 AS builder
WORKDIR /srv

COPY ./package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html
COPY --from=builder /srv/build /usr/share/nginx/html
ENTRYPOINT ["nginx", "-g", "daemon off;"]
