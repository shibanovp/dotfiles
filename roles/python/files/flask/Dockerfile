FROM python:slim@sha256:bbd675086307828b7cd54071ba91df91d4b0f7a62531de0e256793ad0a9d9f6a
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
