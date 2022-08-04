FROM python:slim@sha256:d200e51c26670504c2f2edefdeef4fa2a20dbf68d7f2a0a480d0ddca0e7f969a
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
ENV PORT=5000
ENV PYTHONUNBUFFERED True
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app
COPY . ./
