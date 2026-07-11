from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.routers import contact, health

app = FastAPI(
    title="__CLIENT_NAME__ API",
    version="0.1.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(health.router)
app.include_router(contact.router, prefix="/api")
