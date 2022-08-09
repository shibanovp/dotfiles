
def test_readyz(client):
    response = client.get("/api/readyz")
    assert response.status_code == 200
    assert response.json()["ready"] == True
