FROM alpine:3.16.2@sha256:bc41182d7ef5ffc53a40b044e725193bc10142a1243f395ee852a8d9730fc2ad as builder
# renovate: datasource=github-releases depName=dagger lookupName=dagger/dagger versioning=npm
ARG DAGGER_RELEASE_VERSION=v0.2.36
WORKDIR /usr/local
RUN apk add --no-cache curl bash
# ${DAGGER_RELEASE_VERSION:1} drops v from the version
RUN bash -c "export DAGGER_VERSION=${DAGGER_RELEASE_VERSION:1} && curl -L https://dl.dagger.io/dagger/install.sh | sh"
FROM alpine:3.16.2@sha256:bc41182d7ef5ffc53a40b044e725193bc10142a1243f395ee852a8d9730fc2ad
COPY --from=builder /usr/local/bin/dagger /usr/local/bin/dagger
COPY verify_version.sh .
ENTRYPOINT [ "/usr/local/bin/dagger" ]
