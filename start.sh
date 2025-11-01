#!/bin/sh
set -e

mkdir -p /app/pb_data

echo "⚙️  PocketBase UI auto-restore system started"
echo "🧹 Cleaning old pb_public directory..."
rm -rf /app/pb_public
mkdir -p /app/pb_public

# === ZIPファイル検出と展開 ===
UNZIPPED=false

try_unzip() {
  ZIP_PATH="$1"
  if [ -f "$ZIP_PATH" ]; then
    echo "📦 Found $ZIP_PATH — extracting..."
    unzip -oq "$ZIP_PATH" -d /app/pb_public && UNZIPPED=true
  fi
}

# 3回まで再試行（各5秒間隔）
for i in 1 2 3; do
  if [ "$UNZIPPED" = false ]; then
    echo "🔍 [Attempt $i] Searching for pb_public.zip..."
    try_unzip /app/pb_public/pb_public.zip
    try_unzip /app/pb_public.zip
  fi
  if [ "$UNZIPPED" = true ]; then
    echo "✅ Extraction successful!"
    break
  else
    echo "⏳ Extraction failed. Retrying in 5 seconds..."
    sleep 5
  fi
done

# 展開に失敗した場合は停止（安全のため）
if [ "$UNZIPPED" = false ]; then
  echo "❌ ERROR: pb_public.zip not found or extraction failed after 3 attempts."
  echo "🧾 Please ensure pb_public.zip exists in your repository root or pb_public/."
  exit 1
fi

# === PocketBase 起動 ===
echo "🚀 Starting PocketBase on port ${PORT:-8080}..."
exec /app/pocketbase serve \
  --http=0.0.0.0:${PORT:-8080} \
  --dir=/app/pb_data \
  --publicDir=/app/pb_public
