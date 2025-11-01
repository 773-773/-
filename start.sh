#!/bin/sh
set -e

mkdir -p /app/pb_data

# デバッグ出力
echo "[diag] PORT=${PORT}"
echo "[diag] PB_PUBLIC_URL=${PB_PUBLIC_URL}"

# 明示的にURLを渡す
PUBLIC_URL="https://delivery-eye.onrender.com"
echo "[diag] Using publicURL=${PUBLIC_URL}"

exec /app/pocketbase serve \
  --http=0.0.0.0:${PORT:-8080} \
  --dir=/app/pb_data \
  --publicDir=/app/pb_public \
  --publicURL=${PUBLIC_URL}
