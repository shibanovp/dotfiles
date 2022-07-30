FROM alpine:3.16.1@sha256:7580ece7963bfa863801466c0a488f11c86f85d9988051a9f9c68cb27f6b7872 as builder
# renovate: datasource=github-releases depName=dagger lookupName=dagger/dagger versioning=npm
ARG DAGGER_RELEASE_VERSION=v0.2.27
WORKDIR /usr/local
RUN apk add --no-cache curl bash
# ${DAGGER_RELEASE_VERSION:1} drops v from the version
RUN bash -c "export DAGGER_VERSION=${DAGGER_RELEASE_VERSION:1} && curl -L https://dl.dagger.io/dagger/install.sh | sh"
FROM alpine:3.16.1@sha256:7580ece7963bfa863801466c0a488f11c86f85d9988051a9f9c68cb27f6b7872
COPY --from=builder /usr/local/bin/dagger /usr/local/bin/dagger
ENTRYPOINT [ "/usr/local/bin/dagger" ]
