#!/bin/bash
cd /app

# pb_data ディレクトリを確実に作成
mkdir -p /app/pb_data
chmod -R 777 /app/pb_data

# ✅ PORT が未設定ならデフォルト8080を使う
if [ -z "$PORT" ]; then
  PORT=8080
fi

# ✅ Render のリバースプロキシ干渉を回避（PocketBaseを /pb 配下で起動）
echo "Starting PocketBase on port ${PORT} with baseUrl=/pb"
./pocketbase serve --http="0.0.0.0:${PORT}" --dir="/app/pb_data" --baseUrl="/pb"
