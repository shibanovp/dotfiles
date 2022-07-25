
package flask

import (
    "dagger.io/dagger"
    "dagger.io/dagger/core"
)

dagger.#Plan & {
    client: env: GREETING: string | *"flask"
    actions: {
        image: core.#Pull & {
            source: "alpine:3"
        }
        test: core.#Exec & {
            input: image.output
            args: ["echo", "Testing \(client.env.GREETING) app"]
            always: true
        }
    }
}
