from fastapi import APIRouter
router = APIRouter()

from . import healthz, readyz