from fastapi import FastAPI
import socket

app = FastAPI()


@app.get("/")
async def root():
    hostname = socket.gethostname()
    return {"message": f"Hello World from {hostname}"}