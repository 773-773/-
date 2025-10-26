#!/bin/bash
cd /app

# pb_data が無ければ作成
mkdir -p /app/pb_data
chmod -R 777 /app/pb_data

# pb_public の存在確認
if [ -d "/app/pb_public" ]; then
  echo "✅ pb_public directory found."
else
  echo "❌ pb_public directory NOT found! exiting..."
  ls -la /app   # デバッグ用にフォルダ内容表示
  exit 1
fi

# PocketBase 起動
./pocketbase serve --http="0.0.0.0:${PORT}" --publicDir="pb_public"
