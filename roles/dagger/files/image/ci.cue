
package ci

import (
    "strings"
    "dagger.io/dagger"
	"dagger.io/dagger/core"
    "universe.dagger.io/docker"
)

dagger.#Plan & {
    client: {
        filesystem: ".": read: contents: dagger.#FS
        env: {
            IMAGE: string | *"dagger"
            DAGGER_RELEASE_VERSION: string | *"0.0.0"
            DOCKER_USERNAME: string | *"dagger"
            DOCKER_PASSWORD?: dagger.#Secret
        }
    }
    actions: {
        build: {
            docker.#Dockerfile & {
                source: client.filesystem.".".read.contents
                buildArg: DAGGER_RELEASE_VERSION: client.env.DAGGER_RELEASE_VERSION
            }
        }
        test: core.#Exec & {
            input: build.output.rootfs
            env: {
                DAGGER_VERSION: strings.TrimPrefix(client.env.DAGGER_RELEASE_VERSION, "v")
            }
            args: [
                "sh", "verify_version.sh"
            ]
            always: true
        }
        push: {
            docker.#Push & {
                "image": build.output
                dest:    client.env.IMAGE
                auth: {
                    username: client.env.DOCKER_USERNAME
                    secret: client.env.DOCKER_PASSWORD
                }
            }
            _dep: test.output
        }
    }
}
