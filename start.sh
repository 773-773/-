#!/bin/sh
set -e

# 永続ディレクトリが存在しない場合は作成
mkdir -p /app/pb_data

# Renderで自動注入される環境変数をPocketBaseに渡す
echo "Starting PocketBase on port ${PORT:-8080}..."
exec /app/pocketbase serve \
  --http=0.0.0.0:${PORT:-8080} \
  --dir=/app/pb_data \
  --publicDir=/app/pb_public
