#!/bin/sh
set -e

mkdir -p /app/pb_data

# === ZIPの場所を柔軟に探す ===
if [ -f /app/pb_public/pb_public.zip ]; then
  echo "📦 Found pb_public.zip inside /app/pb_public"
  unzip -oq /app/pb_public/pb_public.zip -d /app/pb_public
elif [ -f /app/pb_public.zip ]; then
  echo "📦 Found pb_public.zip in /app root"
  mkdir -p /app/pb_public
  unzip -oq /app/pb_public.zip -d /app/pb_public
else
  echo "⚠️ No pb_public.zip found, skipping extraction"
fi

# === PocketBase 起動 ===
echo "🚀 Starting PocketBase on port ${PORT:-8080}..."
exec /app/pocketbase serve --http=0.0.0.0:${PORT:-8080} \
  --dir=/app/pb_data \
  --publicDir=/app/pb_public
