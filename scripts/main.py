from typing import Optional
import uvicorn
from fastapi import FastAPI, HTTPException

import sys
import os

sys.path.append(os.path.join(os.path.dirname(__file__), ".."))

from scripts.sentence import Sentence

app = FastAPI()


@app.get("/correct/{lang}")
async def correct(lang: str, params: str, output: Optional[str] = None):
    sent = Sentence(lang, params, output)

    if not sent.is_valid_lang():
        raise HTTPException(status_code=404, detail=f"language not found [{lang}]")

    return {"lang": sent.lang, "input": params, "output": sent.correct()}


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
