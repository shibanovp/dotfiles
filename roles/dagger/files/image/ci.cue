
package ci

import (
    "dagger.io/dagger"
	"dagger.io/dagger/core"
    "universe.dagger.io/docker"
)

dagger.#Plan & {
    client: {
        filesystem: ".": read: contents: dagger.#FS
        env: {
            IMAGE: string | *"dagger"
            DAGGER_VERSION: string | *"0.0.0"
            DOCKER_USERNAME: string | *"dagger"
            DOCKER_PASSWORD?: dagger.#Secret
        }
    }
    actions: {
        build: {
            docker.#Dockerfile & {
                source: client.filesystem.".".read.contents
                buildArg: DAGGER_VERSION: client.env.DAGGER_VERSION
            }
        }
        test: core.#Exec & {
            input: build.output.rootfs
            env: {
                DAGGER_VERSION: client.env.DAGGER_VERSION
            }
            args: [
                "sh", "-c",
                
                #"""
                    case $(dagger version) in
                    "dagger $DAGGER_VERSION"*) exit 0 ;;
                    *) echo expected $DAGGER_VERSION actual $(dagger version); exit 1 ;;
                    esac
                    """#,
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
