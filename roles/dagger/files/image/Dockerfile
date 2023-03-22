FROM alpine:3.17.2@sha256:ff6bdca1701f3a8a67e328815ff2346b0e4067d32ec36b7992c1fdc001dc8517 as builder
# renovate: datasource=github-releases depName=dagger lookupName=dagger/dagger versioning=npm
ARG DAGGER_RELEASE_VERSION=v0.2.36
WORKDIR /usr/local
RUN apk add --no-cache curl bash
# ${DAGGER_RELEASE_VERSION:1} drops v from the version
RUN bash -c "export DAGGER_VERSION=${DAGGER_RELEASE_VERSION:1} && curl -L https://dl.dagger.io/dagger/install.sh | sh"
FROM alpine:3.17.2@sha256:ff6bdca1701f3a8a67e328815ff2346b0e4067d32ec36b7992c1fdc001dc8517
COPY --from=builder /usr/local/bin/dagger /usr/local/bin/dagger
COPY verify_version.sh .
ENTRYPOINT [ "/usr/local/bin/dagger" ]
