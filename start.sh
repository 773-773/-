#!/bin/bash
cd /app

# pb_data ディレクトリを確実に作成
mkdir -p /app/pb_data
chmod -R 777 /app/pb_data

# ✅ Render のリバースプロキシ干渉を回避するため、baseUrl を /pb に固定
./pocketbase serve --http="0.0.0.0:${PORT}" --dir="/app/pb_data" --baseUrl="/pb"
