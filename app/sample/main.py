from fastapi import FastAPI

app = FastAPI()


@app.get("/sample")
async def root():
    return {"message": "Hello World"}