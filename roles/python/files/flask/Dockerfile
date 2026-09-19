FROM python:slim@sha256:caaf356f40667c496d405780745b9ac25771c189a51dfcc42430d531ea09f8a2
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
