FROM alpine:3.18

# ルートで動作させる（書き込み制限回避）
WORKDIR /

RUN apk add --no-cache wget unzip bash

# PocketBase安定バージョン（v0.21.2を使用）
ARG PB_VER=v0.21.2
RUN wget https://github.com/pocketbase/pocketbase/releases/download/${PB_VER}/pocketbase_0.21.2_linux_amd64.zip -O pocketbase.zip
RUN unzip pocketbase.zip -d .
RUN chmod +x pocketbase

# ✅ 必要なフォルダを作成（書き込み権限のある場所）
RUN mkdir -p /pb_data /pb_migrations

# ✅ 起動前にデータを初期化し、PocketBaseを起動
# （--dir はマイグレーション用、--http は正しい起動フラグ）
CMD sh -c "rm -rf /pb_data/* && ./pocketbase serve --dir /pb_migrations --http=0.0.0.0:10000"
