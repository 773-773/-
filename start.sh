#!/bin/sh
set -e

# デバッグ出力で現状を可視化
echo "[diag] PORT=${PORT}"
echo "[diag] PB_PUBLIC_URL=${PB_PUBLIC_URL}"

mkdir -p /app/pb_data

PUBLIC_URL="https://delivery-eye.onrender.com"
echo "[diag] Using publicURL=${PUBLIC_URL}"

exec /app/pocketbase serve \
  --http=0.0.0.0:${PORT:-8080} \
  --dir=/app/pb_data \
  --publicDir=/app/pb_public \
  --publicURL="${PUBLIC_URL}"
