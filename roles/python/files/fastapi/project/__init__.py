from fastapi import FastAPI
import api

def create_app():
    app = FastAPI()
    app.include_router(api.router, prefix="/api")
    return app
