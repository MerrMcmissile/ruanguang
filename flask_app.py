from pathlib import Path

from flask import Flask, send_from_directory


app = Flask(__name__, static_folder=None)
APP_DIRECTORY = Path(__file__).resolve().parent


@app.get("/")
def index():
    return send_from_directory(APP_DIRECTORY, "index.html")


@app.get("/health")
def health():
    return {"status": "ok"}
