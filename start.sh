#!/bin/sh
set -e

# 🚨 古いキャッシュを削除（PocketBase が古い public データを保持している場合に対応）
rm -rf /app/pb_data/public

# ✅ ディレクトリを再生成
mkdir -p /app/pb_data
mkdir -p /app/pb_public

echo "🚀 Launching PocketBase (direct public folder mode)"
echo "📂 Using /app/pb_public as static directory"

# ✅ PocketBase起動（Render のポート環境変数を利用）
./pocketbase serve \
  --http=0.0.0.0:${PORT:-8080} \
  --dir=/app/pb_data \
  --publicDir=/app/pb_public
