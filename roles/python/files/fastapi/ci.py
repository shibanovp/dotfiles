import sys
import os

import anyio
import dagger

CONTEXT = os.environ.get("CONTEXT",  os.path.dirname(os.path.realpath(__file__)))
PORT = int(os.environ.get("PORT", 8000))
IMAGE = os.environ.get("IMAGE", "api")
PUSH_IMAGE = os.environ.get("PUSH_IMAGE", "False").lower() in ("true", "1", "t")
LOCUST_RUN_TIME = os.environ.get("LOCUST_RUN_TIME", "5s")


async def test():
    async with dagger.Connection(dagger.Config(log_output=sys.stderr)) as client:
        directory = client.host().directory(CONTEXT)

        image = client.container().build(directory)

        api = (
            image.with_env_variable("PORT", str(PORT))
            .with_exposed_port(PORT)
            .with_exec([])
        )
        await image.with_exec(["python", "-m", "pytest", "-v"]).exit_code()

        await (
            image.with_service_binding("api", api)
            .with_exec(
                [
                    "/opt/venv/bin/locust",
                    "--headless",
                    "--users",
                    "1",
                    "--spawn-rate",
                    "1",
                    "--host",
                    f"http://api:{PORT}",
                    "--run-time",
                    LOCUST_RUN_TIME,
                    "--locustfile",
                    "tests/locustfile.py",
                ]
            )
            .exit_code()
        )
        if PUSH_IMAGE:
            await image.publish(IMAGE)


if __name__ == "__main__":
    anyio.run(test)
