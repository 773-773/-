#!/bin/sh
set -e

/app/pocketbase serve \
  --http=0.0.0.0:8080 \
  --dir=/app/pb_data \
  --publicDir=/app/pb_public \
  --hooksDir=/app/pb_hooks
