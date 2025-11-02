#!/bin/sh
set -e

mkdir -p /app/pb_data
mkdir -p /app/pb_public

echo "🚀 Launching PocketBase (direct public folder mode)"
echo "📂 Using /app/pb_public as static directory"

./pocketbase serve \
  --http=0.0.0.0:${PORT:-8080} \
  --dir=/app/pb_data \
  --publicDir=/app/pb_public
