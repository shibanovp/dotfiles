FROM node:16.16.0@sha256:a9c47f97951cd63e32e67df3bca896598dd73e5199084a59efd6019f0dd007fe AS builder
WORKDIR /srv

COPY ./package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine@sha256:044441a2f81e4cfc98c9d740c1b73ed7313dec240298161ec360e036c3ba218e
RUN rm -rf /usr/share/nginx/html
COPY --from=builder /srv/build /usr/share/nginx/html
ENTRYPOINT ["nginx", "-g", "daemon off;"]
