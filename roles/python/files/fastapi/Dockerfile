FROM python:slim@sha256:2124d4f8ccbd537500de16660a876263949ed9a9627cfb6141f418d36f008e9e
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
ENV PORT=8000
ENV PYTHONUNBUFFERED True
ENV HOST=0.0.0.0

CMD exec uvicorn --port $PORT --host $HOST main:app
COPY . ./
