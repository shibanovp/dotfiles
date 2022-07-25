from flask import json
from project import create_app


def test_readyz():
    flask_app = create_app()

    with flask_app.test_client() as test_client:
        response = test_client.get('/api/readyz')
        data = json.loads(response.get_data(as_text=True))
        assert response.status_code == 200
        assert data['ready'] == True
