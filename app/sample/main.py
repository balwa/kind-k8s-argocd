from fastapi import FastAPI
import socket

app = FastAPI()


@app.get("/")
async def root():
    hostname = socket.gethostname()
    return {"message": f"Hello World from {hostname}"}

@app.get("/ping")
async def ping():
    return {"message": "pong"}

@app.get("/health")
async def health():
    return {"message": "ok"}