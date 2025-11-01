#!/bin/sh
set -e

# ----------------------------------------
# ✅ 永続ディレクトリ（Render側のマウント先）
# ----------------------------------------
mkdir -p /app/pb_data

# ----------------------------------------
# ✅ pb_public.zip があれば自動展開
#    （GitHubにZIPで入れておけばOK）
# ----------------------------------------
if [ -f /app/pb_public.zip ] && [ ! -d /app/pb_public ]; then
  echo "📦 Unzipping pb_public.zip..."
  unzip -oq /app/pb_public.zip -d /app/pb_public
fi

# ----------------------------------------
# ✅ 起動メッセージ
# ----------------------------------------
echo "🚀 Starting PocketBase on port ${PORT:-8080}..."

# ----------------------------------------
# ✅ PocketBase起動
#    --publicURL は v0.24.4 で削除されたため不要
# ----------------------------------------
exec /app/pocketbase serve \
  --http=0.0.0.0:${PORT:-8080} \
  --dir=/app/pb_data \
  --publicDir=/app/pb_public
