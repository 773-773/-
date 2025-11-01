#!/bin/sh
set -e

# データ保存ディレクトリ
mkdir -p /app/pb_data

# ZIP展開（もし未展開なら）
if [ -f /app/pb_public.zip ] && [ ! -d /app/pb_public ]; then
  echo "Unzipping pb_public.zip..."
  unzip -oq /app/pb_public.zip -d /app/pb_public
fi

# 起動ログ
echo "Starting PocketBase on port ${PORT:-8080}..."
exec /app/pocketbase serve --http=0.0.0.0:${PORT:-8080} --dir=/app/pb_data --publicDir=/app/pb_public
