#!/bin/bash

function_postgres_ready() {
python << END
import socket
import time
import os

port = int(os.environ["POSTGRES_PORT"])
host = os.environ["POSTGRES_HOST"]

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

s.connect(('db', port))
s.close()
END
}

until function_postgres_ready; do
  >&2 echo "======= POSTGRES IS UNAVAILABLE, WAITING"
  sleep 1
done
echo "======= POSTGRES IS UP, CONNECTING"

echo '======= MAKING MIGRATIONS'
python manage.py makemigrations

echo '======= RUNNING MIGRATIONS'
python manage.py migrate


echo '======= RUNNING SERVER'
python manage.py runserver 0.0.0.0:8001
