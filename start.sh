#!/bin/bash
cd /app

# ✅ pb_data が Render で自動マウントされるので自分では作らない

# ✅ PocketBase起動
./pocketbase serve --http="0.0.0.0:${PORT}" --dir="/app/pb_data" --publicDir="/app/pb_public"
