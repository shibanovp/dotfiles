FROM alpine:3.18.0@sha256:02bb6f428431fbc2809c5d1b41eab5a68350194fb508869a33cb1af4444c9b11 as builder
# renovate: datasource=github-releases depName=dagger lookupName=dagger/dagger versioning=npm
ARG DAGGER_RELEASE_VERSION=v0.5.1
WORKDIR /usr/local
RUN apk add --no-cache curl bash
# ${DAGGER_RELEASE_VERSION:1} drops v from the version
RUN bash -c "export DAGGER_VERSION=${DAGGER_RELEASE_VERSION:1} && curl -L https://dl.dagger.io/dagger/install.sh | sh"
FROM alpine:3.18.0@sha256:02bb6f428431fbc2809c5d1b41eab5a68350194fb508869a33cb1af4444c9b11
COPY --from=builder /usr/local/bin/dagger /usr/local/bin/dagger
COPY verify_version.sh .
ENTRYPOINT [ "/usr/local/bin/dagger" ]
