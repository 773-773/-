#!/bin/sh
set -e

# 永続ディレクトリが存在しない場合は作成
mkdir -p /app/pb_data

# 環境変数 PORT が Render で自動注入されるため、それをPocketBaseに渡す
# Google OAuthが動かない場合は --publicDir と --dir を絶対パスで指定しないと失敗する
echo "Starting PocketBase on port ${PORT:-8080}..."
exec /app/pocketbase serve --http=0.0.0.0:${PORT:-8080} --dir=/app/pb_data --publicDir=/app/pb_public
