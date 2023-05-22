from typing import Union

from fastapi import FastAPI, Request

app = FastAPI()


@app.get("/")
async def read_root():
    return {"Hello": "World"}


@app.get("/items/{item_id}")
async def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}


@app.get("/_healthcheck")
async def healthcheck():
    return {"status": "ok"}


@app.post("/login")
async def login(req: Request):
    body = await req.json()
    return {"username": body["username"], "password": body["password"]}
