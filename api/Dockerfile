FROM python:3.6.0-alpine

WORKDIR /api

COPY . /api

RUN apk update && \
    apk add --no-cache --virtual build-deps gcc python3-dev musl-dev && \
    apk add postgresql-dev
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

