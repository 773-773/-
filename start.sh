#!/bin/sh
set -e

mkdir -p /app/pb_data

echo "[diag] PORT=${PORT}"
echo "[diag] PB_PUBLIC_URL=${PB_PUBLIC_URL}"

exec /app/pocketbase serve \
  --http=0.0.0.0:${PORT:-8080} \
  --dir=/app/pb_data \
  --publicDir=/app/pb_public
