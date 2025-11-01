#!/bin/sh
set -e

# データ保存ディレクトリを確保
mkdir -p /app/pb_data

# 公開ディレクトリの存在チェック＆ZIP解凍
if [ -f /app/pb_public/pb_public.zip ] && [ ! -d /app/pb_public/dist ]; then
  echo "🗜️ Extracting pb_public.zip..."
  unzip -oq /app/pb_public/pb_public.zip -d /app/pb_public/
fi

# 起動ログ
echo "🚀 Starting PocketBase on port ${PORT:-8080}..."
exec /app/pocketbase serve --http=0.0.0.0:${PORT:-8080} --dir=/app/pb_data --publicDir=/app/pb_public
