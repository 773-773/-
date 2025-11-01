#!/bin/bash
cd /app
mkdir -p /app/pb_data
chmod -R 777 /app/pb_data

PORT=${PORT:-8080}

# ✅ baseUrl がサポートされる最新版用
./pocketbase serve --http="0.0.0.0:${PORT}" --dir="/app/pb_data" --baseUrl="/pb"
