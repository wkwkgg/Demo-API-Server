from fastapi.testclient import TestClient
from scripts.main import app

client = TestClient(app)


def test_get_correction():
    response = client.get("/correct/en?params=Hello%20World")
    assert response.status_code == 200
    assert response.json() == {
        "lang": "en",
        "input": "Hello World",
        "output": "a sentence that may be correct",
    }


def test_bad_lang():
    response = client.get("/correct/enr?params=Hello%20World")
    assert response.status_code == 404
    assert response.json() == {"detail": "language not found [enr]"}
