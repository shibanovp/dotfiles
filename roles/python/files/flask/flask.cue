
package flask

import (
    "time"
    "dagger.io/dagger"
	"dagger.io/dagger/core"
    "universe.dagger.io/docker"
)

dagger.#Plan & {
    client: {
        filesystem: ".": read: contents: dagger.#FS
        env: {
            REGISTRY_IMAGE: string | *"flask:latest"
            DOCKER_USERNAME: dagger.#Secret
            DOCKER_PASSWORD: dagger.#Secret
        }
    }
    actions: {
        image: docker.#Dockerfile & {
            source: client.filesystem.".".read.contents
        }
        test: {
            functional: docker.#Run & {
                input: image.output
                command: {
                    name: "python"
                    args: ["-m", "pytest", "-v"]
                }
                always: true
            }
            load: {
                start: core.#Start & {
                    input: image.output.rootfs
                    env: {
                        PORT: "5000"
                    }
                    args: [
                        "sh", "-c", "exec /opt/venv/bin/gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app"
                    ]
                    workdir: "/app"
                }
                sleep: core.#Exec & {
                    input: image.output.rootfs
                    args: [
                        "sh", "-c",
                        #"""
                            echo Wait for server to start
                            sleep 1
                            """#,
                    ]
                    always: true
                }
                locust: core.#Exec & {
                    input: image.output.rootfs
                    args: [
                        "sh", "-c",
                        #"""
                            /opt/venv/bin/locust --headless --users 1 --spawn-rate 1 --host http://localhost:5000 --run-time 10s --locustfile tests/locustfile.py
                            """#
                    ]
                    workdir: "/app"
                    always: true
                    _dep: sleep
                }
                sig: core.#SendSignal & {
                    input:  start
                    signal: core.SIGTERM
                    _dep:   locust
                }
                stop: core.#Stop & {
                    input:   start
                    timeout: time.Second * 5
                    _dep:    sig
                }
            }
        }
        push: {
            docker.#Push & {
                "image": image.output
                dest:    client.env.REGISTRY_IMAGE
                auth: {
                    username: "admin"
                    secret: client.env.DOCKER_PASSWORD
                }
            }
            _dep: test
        }
    }
}

