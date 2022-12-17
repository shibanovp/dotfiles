FROM alpine:3.16.2@sha256:65a2763f593ae85fab3b5406dc9e80f744ec5b449f269b699b5efd37a07ad32e as builder
# renovate: datasource=github-releases depName=dagger lookupName=dagger/dagger versioning=npm
ARG DAGGER_RELEASE_VERSION=v0.2.36
WORKDIR /usr/local
RUN apk add --no-cache curl bash
# ${DAGGER_RELEASE_VERSION:1} drops v from the version
RUN bash -c "export DAGGER_VERSION=${DAGGER_RELEASE_VERSION:1} && curl -L https://dl.dagger.io/dagger/install.sh | sh"
FROM alpine:3.16.2@sha256:65a2763f593ae85fab3b5406dc9e80f744ec5b449f269b699b5efd37a07ad32e
COPY --from=builder /usr/local/bin/dagger /usr/local/bin/dagger
COPY verify_version.sh .
ENTRYPOINT [ "/usr/local/bin/dagger" ]
