FROM python:slim@sha256:e97b88e416c3c01eb427b21fd8cd3ebf006e6ee38afcfcc3cae1c54ee2ab0a75
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
