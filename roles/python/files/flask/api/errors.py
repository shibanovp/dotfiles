import json
from flask import jsonify
from werkzeug.exceptions import HTTPException
from . import api


@api.app_errorhandler(HTTPException)
def handle_exception(e):
    """Return JSON instead of HTML for HTTP errors."""
    response = e.get_response()
    response.data = json.dumps({
        "error": {
            "description": e.description,
            "name": e.name,
        }
    })
    response.content_type = "application/json"
    return response
