
package flask

import (
    "dagger.io/dagger"
    // "dagger.io/dagger/core"
    "universe.dagger.io/docker"
)

dagger.#Plan & {
    client: filesystem: ".": read: contents: dagger.#FS
    actions: 
        ci: docker.#Build & {
            steps: [
                docker.#Dockerfile & {
                    source: client.filesystem.".".read.contents
                },
                docker.#Run & {
                    command: {
                        name: "python"
                        args: ["-m", "pytest", "-v"]
                    }
                    always: true
                }
            ]
    }
}