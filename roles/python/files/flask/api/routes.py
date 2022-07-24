from flask import jsonify, request, abort
from . import api


@api.route('/healthz')
def healthz():
    return jsonify({'healthy': True})


@api.route('/readyz')
def readyz():
    return jsonify({'ready': True})
