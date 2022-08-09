
from typing import Any
from typing import Generator
import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from project import create_app


@pytest.fixture(scope="function")
def app() -> Generator[FastAPI, Any, None]:
    app = create_app()
    yield app


@pytest.fixture(scope="function")
def client(
    app: FastAPI
) -> Generator[TestClient, Any, None]:
    with TestClient(app) as client:
        yield client
