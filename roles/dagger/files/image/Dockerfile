FROM alpine:3.15.5@sha256:26284c09912acfc5497b462c5da8a2cd14e01b4f3ffa876596f5289dd8eab7f2 as builder
ARG DAGGER_VERSION=0.2.27
WORKDIR /usr/local
RUN apk add --no-cache curl
RUN curl -L https://dl.dagger.io/dagger/install.sh | sh

FROM alpine:3.15.5@sha256:26284c09912acfc5497b462c5da8a2cd14e01b4f3ffa876596f5289dd8eab7f2
COPY --from=builder /usr/local/bin/dagger /usr/local/bin/dagger
ENTRYPOINT [ "/usr/local/bin/dagger" ]