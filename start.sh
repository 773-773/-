#!/bin/sh
set -e

# 永続ディレクトリを確実に作成
mkdir -p /app/pb_data

# デバッグ出力（Renderログで確認できる）
echo "[diag] PORT=${PORT}"
echo "[diag] PB_PUBLIC_URL=${PB_PUBLIC_URL}"

# PocketBase が自分のURLを正確に認識できるようにする
PUBLIC_URL="https://delivery-eye.onrender.com"
echo "[diag] Using publicURL=${PUBLIC_URL}"

# PocketBase 起動（v0.24.4で正式対応）
exec /app/pocketbase serve \
  --http=0.0.0.0:${PORT:-8080} \
  --dir=/app/pb_data \
  --publicDir=/app/pb_public \
  --publicURL=${PUBLIC_URL}
