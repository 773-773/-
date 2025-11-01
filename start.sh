#!/bin/bash
cd /app
mkdir -p /app/pb_data
chmod -R 777 /app/pb_data
./pocketbase serve --http="0.0.0.0:${PORT}" --dir="/app/pb_data" --publicDir="/app/pb_public"
