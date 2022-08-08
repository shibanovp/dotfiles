
package ci

import (
    "dagger.io/dagger"
    "universe.dagger.io/docker"
)

dagger.#Plan & {
    client: {
        env: {
            IMAGE: string | *"cra-typescript"
            DOCKER_USERNAME: string | *"typescript"
            DOCKER_PASSWORD?: dagger.#Secret
        }
        filesystem: "./roles/react/files/cra/typescript": read: contents: dagger.#FS
    }
    actions: {
        image: docker.#Dockerfile & {
            source: client.filesystem."./roles/react/files/cra/typescript".read.contents
            target: "builder"
        }
        test: {
            functional: docker.#Run & {
                input: image.output
                env: {
                    CI: "true"
                }
                command: {
                    name: "npm"
                    args: ["test"]
                }
                always: true
            }
        }
        prod_image: docker.#Dockerfile & {
            source: client.filesystem."./roles/react/files/cra/typescript".read.contents
            _dep: test
        }
        push: {
            docker.#Push & {
                "image": prod_image.output
                dest:    client.env.IMAGE
                auth: {
                    username: client.env.DOCKER_USERNAME
                    secret: client.env.DOCKER_PASSWORD
                }
            }
        }
    }
}

