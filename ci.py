import sys
import os
import logging

import anyio
import dagger

PORT = int(os.environ.get("PORT", 2222))
logging.getLogger().setLevel(level=os.getenv('LOGLEVEL', "INFO").upper())

async def test():
    roles = ["dagger", "helm", "dbeaver", "sonarqube tasks_from=scanner"]
    async with dagger.Connection(dagger.Config(log_output=sys.stderr)) as client:
        context = client.host().directory(".")

        ansible_image = client.container().build(
            context, "roles/ansible/files/image/alpine_ansible/Dockerfile"
        )
        host_image = client.container().build(
            context, "roles/ansible/files/image/ubuntu_host/Dockerfile"
        )

        host = (
            host_image.with_env_variable("PORT", str(PORT))
            .with_exposed_port(PORT)
            .with_exec([])
        )
        for role in roles:
            result = (
                ansible_image.with_service_binding("host", host)
                .with_env_variable("ANSIBLE_HOST_KEY_CHECKING", "False")
                .with_exec(
                    [
                        "ansible",
                        "ubuntu_host",
                        "-m",
                        "include_role",
                        "-a",
                        f"name={role}",
                        "-e",
                        f"ansible_port={PORT}",
                        "-i",
                        "roles/ansible/files/image/alpine_ansible/inventory",
                    ]
                )
            )

            await result.exit_code()
            logging.info(f"{role=} success")


if __name__ == "__main__":
    anyio.run(test)
