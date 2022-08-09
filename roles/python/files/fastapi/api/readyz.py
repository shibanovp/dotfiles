from . import router
from pydantic import BaseModel


class Readyz(BaseModel):
    ready: bool = True


@router.get('/readyz', response_model=Readyz)
def readyz():
    return Readyz(ready=True)
