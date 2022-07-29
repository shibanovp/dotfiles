FROM alpine:3.15.5@sha256:0483110c51a764abe175a8cefb941541ca0bc0f628ce418d3a660338abf4622a as builder
ARG DAGGER_VERSION=0.2.27
WORKDIR /usr/local
RUN apk add --no-cache curl
RUN curl -L https://dl.dagger.io/dagger/install.sh | sh

FROM alpine:3.15.5@sha256:0483110c51a764abe175a8cefb941541ca0bc0f628ce418d3a660338abf4622a
COPY --from=builder /usr/local/bin/dagger /usr/local/bin/dagger
ENTRYPOINT [ "/usr/local/bin/dagger" ]
