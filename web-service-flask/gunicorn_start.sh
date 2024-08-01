#!/bin/sh

gunicorn app:app \
    --name myflaskapp \
    --bind 0.0.0.0:5000 \
    --workers 3