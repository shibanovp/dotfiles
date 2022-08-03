
package flask

import (
    "time"
    "dagger.io/dagger"
	"dagger.io/dagger/core"
    "universe.dagger.io/docker"
)

dagger.#Plan & {
    client: {
        filesystem: {
            ".": read: contents: dagger.#FS
            "./roles/ansible/files/image/ubuntu_host": read: contents: dagger.#FS
        }
        env: {
            REGISTRY_IMAGE: string | *"flask:latest"
            DOCKER_USERNAME: dagger.#Secret
            DOCKER_PASSWORD: dagger.#Secret
        }
    }
    actions: {
        alpine_ansible_image: docker.#Dockerfile & {
            source: client.filesystem.".".read.contents
            dockerfile: {
                path: "./roles/ansible/files/image/alpine_ansible/Dockerfile"
            }
        }
        ubuntu_host_image: docker.#Dockerfile & {
            source: client.filesystem."./roles/ansible/files/image/ubuntu_host".read.contents
        }
        test: {
            role: {
                curl: {
                    _port: "2222"
                    start_ubuntu_host_start: core.#Start & {
                        input: ubuntu_host_image.output.rootfs
                        env: {
                            PORT: _port
                        }
                        args: [
                            "sh", "-c", "exec /usr/sbin/sshd -D -p $PORT"
                        ]
                    }
                    ansible_role: core.#Exec & {
                        input: alpine_ansible_image.output.rootfs
                        env: {
                            HOME: "/home/ansible"
                            ANSIBLE_HOST_KEY_CHECKING: "False"
                            PATH: "/home/ansible/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
                        }
                        user: "ansible"
                        env: {
                            PORT: _port
                        }
                        args: [
                            "sh", "-c",
                            #"""
                                ansible ubuntu_host \
                                -m include_role -a "name=dagger" \
                                -e "ansible_port=${PORT}" \
                                -i roles/ansible/files/image/alpine_ansible/inventory
                                """#
                        ]
                        always: true
                        _dep: start_ubuntu_host_start
                    }
                    sigterm: core.#SendSignal & {
                        input:  start_ubuntu_host_start
                        signal: core.SIGTERM
                        _dep:   ansible_role
                    }
                    stop: core.#Stop & {
                        input:   start_ubuntu_host_start
                        timeout: time.Second * 10
                        _dep:   sigterm
                    }
                }
                dagger: {
                    _port: "2223"
                    start_ubuntu_host_start: core.#Start & {
                        input: ubuntu_host_image.output.rootfs
                        env: {
                            PORT: _port
                        }
                        args: [
                            "sh", "-c", "exec /usr/sbin/sshd -D -p $PORT"
                        ]
                    }
                    ansible_role: core.#Exec & {
                        input: alpine_ansible_image.output.rootfs
                        env: {
                            HOME: "/home/ansible"
                            ANSIBLE_HOST_KEY_CHECKING: "False"
                            PATH: "/home/ansible/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
                        }
                        user: "ansible"
                        env: {
                            PORT: _port
                        }
                        args: [
                            "sh", "-c",
                            #"""
                                ansible ubuntu_host \
                                -m include_role -a "name=dagger" \
                                -e "ansible_port=${PORT}" \
                                -i roles/ansible/files/image/alpine_ansible/inventory
                                """#
                        ]
                        always: true
                        _dep: start_ubuntu_host_start
                    }
                    sigterm: core.#SendSignal & {
                        input:  start_ubuntu_host_start
                        signal: core.SIGTERM
                        _dep:   ansible_role
                    }
                    stop: core.#Stop & {
                        input:   start_ubuntu_host_start
                        timeout: time.Second * 10
                        _dep:   sigterm
                    }
                }
                
                helm: {
                    _port: "2224"
                    start_ubuntu_host_start: core.#Start & {
                        input: ubuntu_host_image.output.rootfs
                        env: {
                            PORT: _port
                        }
                        args: [
                            "sh", "-c", "exec /usr/sbin/sshd -D -p $PORT"
                        ]
                    }
                    ansible_role: core.#Exec & {
                        input: alpine_ansible_image.output.rootfs
                        env: {
                            HOME: "/home/ansible"
                            ANSIBLE_HOST_KEY_CHECKING: "False"
                            PATH: "/home/ansible/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
                        }
                        user: "ansible"
                        env: {
                            PORT: _port
                        }
                        args: [
                            "sh", "-c",
                            #"""
                                ansible ubuntu_host \
                                -m include_role -a "name=helm" \
                                -e "ansible_port=${PORT} os_family=Debian" \
                                -i roles/ansible/files/image/alpine_ansible/inventory
                                """#
                        ]
                        always: true
                        _dep: start_ubuntu_host_start
                    }
                    sigterm: core.#SendSignal & {
                        input:  start_ubuntu_host_start
                        signal: core.SIGTERM
                        _dep:   ansible_role
                    }
                    stop: core.#Stop & {
                        input:   start_ubuntu_host_start
                        timeout: time.Second * 10
                        _dep:   sigterm
                    }
                }
            }
            playbook: {
                terraform: {
                    _port: "3222"
                    start_ubuntu_host_start: core.#Start & {
                        input: ubuntu_host_image.output.rootfs
                        env: {
                            PORT: _port
                        }
                        args: [
                            "sh", "-c", "exec /usr/sbin/sshd -D -p $PORT"
                        ]
                    }
                    ansible: core.#Exec & {
                        input: alpine_ansible_image.output.rootfs
                        env: {
                            HOME: "/home/ansible"
                            ANSIBLE_HOST_KEY_CHECKING: "False"
                            PATH: "/home/ansible/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
                        }
                        user: "ansible"
                        env: {
                            PORT: _port
                        }
                        args: [
                            "sh", "-c",
                            #"""
                                ansible-playbook terraform.yml \
                                -e "ansible_port=${PORT}" \
                                -i roles/ansible/files/image/alpine_ansible/inventory \
                                -l ubuntu_host
                                """#
                        ]
                        always: true
                        _dep: start_ubuntu_host_start
                    }
                    sigterm: core.#SendSignal & {
                        input:  start_ubuntu_host_start
                        signal: core.SIGTERM
                        _dep:   ansible
                    }
                    stop: core.#Stop & {
                        input:   start_ubuntu_host_start
                        timeout: time.Second * 10
                        _dep:   sigterm
                    }
                }
                vagrant: {
                    _port: "3223"
                    start_ubuntu_host_start: core.#Start & {
                        input: ubuntu_host_image.output.rootfs
                        env: {
                            PORT: _port
                        }
                        args: [
                            "sh", "-c", "exec /usr/sbin/sshd -D -p $PORT"
                        ]
                    }
                    ansible: core.#Exec & {
                        input: alpine_ansible_image.output.rootfs
                        env: {
                            HOME: "/home/ansible"
                            ANSIBLE_HOST_KEY_CHECKING: "False"
                            PATH: "/home/ansible/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
                        }
                        user: "ansible"
                        env: {
                            PORT: _port
                        }
                        args: [
                            "sh", "-c",
                            #"""
                                ansible-playbook vagrant.yml \
                                -e "ansible_port=${PORT}" \
                                -i roles/ansible/files/image/alpine_ansible/inventory \
                                -l ubuntu_host
                                """#
                        ]
                        always: true
                        _dep: start_ubuntu_host_start
                    }
                    sigterm: core.#SendSignal & {
                        input:  start_ubuntu_host_start
                        signal: core.SIGTERM
                        _dep:   ansible
                    }
                    stop: core.#Stop & {
                        input:   start_ubuntu_host_start
                        timeout: time.Second * 10
                        _dep:   sigterm
                    }
                }
            }
        }
    }
}

