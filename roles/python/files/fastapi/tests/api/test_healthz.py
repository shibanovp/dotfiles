
def test_healthz(client):
    response = client.get("/api/healthz")
    assert response.status_code == 200
    assert response.json()["healthy"] == True
