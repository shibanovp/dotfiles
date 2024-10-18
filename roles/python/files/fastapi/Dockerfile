FROM python:slim@sha256:02699283cc784486281bb4bdf233b8cf443f038d9b9c91873d31bd4cbd622a3d
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
