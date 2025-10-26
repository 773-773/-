#!/bin/sh
set -e

# PocketBaseのデータ保存先フォルダを作成（既にある場合もOK）
mkdir -p /app/pb_data
# マウントされたディスクに書き込めるように権限付与
chmod -R 777 /app/pb_data

echo "✅ Starting PocketBase with data directory: /app/pb_data"
ls -la /app/pb_data

# PocketBase を起動
exec ./pocketbase serve --dir /app/pb_data --http 0.0.0.0:${PORT}
