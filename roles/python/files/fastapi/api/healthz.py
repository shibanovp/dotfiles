from . import router
from pydantic import BaseModel


class Healthz(BaseModel):
    healthy: bool = True


@router.get('/healthz', response_model=Healthz)
def healthz():
    return Healthz(healthy=True)
