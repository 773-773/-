#!/bin/sh
set -e

mkdir -p /app/pb_data
mkdir -p /app/pb_public

echo "⚙️  PocketBase UI auto-restore system started"
echo "🧹 Cleaning old pb_public directory..."
rm -rf /app/pb_public/*
mkdir -p /app/pb_public

# === ZIP探索 ===
echo "🔍 Searching for pb_public.zip in all possible locations..."
FOUND_ZIP=""

for path in \
  "/app/pb_public.zip" \
  "/app/pb_public/pb_public.zip" \
  "/pb_public.zip" \
  "/pb_public/pb_public.zip" \
  "/tmp/pb_public.zip" \
  "/workspace/pb_public.zip" \
  "/workspace/pb_public/pb_public.zip"
do
  if [ -f "$path" ]; then
    FOUND_ZIP="$path"
    echo "📦 Found ZIP at: $FOUND_ZIP"
    break
  fi
done

# === 解凍処理 ===
if [ -n "$FOUND_ZIP" ]; then
  echo "📂 Extracting $FOUND_ZIP → /app/pb_public"
  unzip -o "$FOUND_ZIP" -d /app/pb_public >/app/unzip.log 2>&1 || true
  if [ "$(ls -A /app/pb_public)" ]; then
    echo "✅ Extraction completed successfully!"
  else
    echo "⚠️ Extraction command ran but directory is empty. Attempting fallback unzip..."
    mkdir -p /app/tmp_extract
    unzip -o "$FOUND_ZIP" -d /app/tmp_extract >/dev/null 2>&1 || true
    cp -r /app/tmp_extract/* /app/pb_public/ 2>/dev/null || true
  fi
else
  echo "❌ No pb_public.zip found in any location!"
fi

# === ここから PocketBase を起動 ===
echo "🚀 Launching PocketBase on port ${PORT:-8080} ..."
cd /app
./pocketbase serve \
  --http=0.0.0.0:${PORT:-8080} \
  --dir=/app/pb_data \
  --publicDir=/app/pb_public
