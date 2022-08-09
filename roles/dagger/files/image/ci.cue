
package ci

import (
    "strings"
    "dagger.io/dagger"
    "dagger.io/dagger/core"
    "universe.dagger.io/docker"
)

dagger.#Plan & {
    client: {
        filesystem: {
            context: read: {
                // set the build context
                path: "./roles/dagger/files/image" 
                contents: dagger.#FS
            }
        }
        env: {
            IMAGE: string | *"dagger"
            DAGGER_RELEASE_VERSION: string | *"0.0.0"
            DOCKER_USERNAME: string | *"dagger"
            DOCKER_PASSWORD?: dagger.#Secret
        }
    }
    actions: {
        _daggerVersion: strings.TrimPrefix(client.env.DAGGER_RELEASE_VERSION, "v")
        image: {
            docker.#Dockerfile & {
                source: client.filesystem.context.read.contents
                buildArg: DAGGER_RELEASE_VERSION: client.env.DAGGER_RELEASE_VERSION
            }
        }
        test: core.#Exec & {
            input: image.output.rootfs
            env: {
                DAGGER_VERSION: _daggerVersion
            }
            args: [
                "sh", "verify_version.sh"
            ]
            always: true
        }
        push: {
            tagged: docker.#Push & {
                "image": image.output
                dest:    strings.Join([client.env.IMAGE,_daggerVersion], ":")
                auth: {
                    username: client.env.DOCKER_USERNAME
                    secret: client.env.DOCKER_PASSWORD
                }
            }
            latest: docker.#Push & {
                "image": image.output
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
