#!/bin/bash
cd /app

# pb_data が無ければ作成
mkdir -p /app/pb_data
chmod -R 777 /app/pb_data

# PocketBaseをAPIと静的サイトの両方で起動
./pocketbase serve --http="0.0.0.0:${PORT}" --dir="/app/pb_data" --publicDir="/app/pb_public"
