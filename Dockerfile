FROM alpine:3.18

WORKDIR /app

RUN apk add --no-cache wget unzip bash

# PocketBaseの安定バージョンをダウンロード
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.21.2/pocketbase_0.21.2_linux_amd64.zip -O pocketbase.zip
RUN unzip pocketbase.zip -d .
RUN chmod +x pocketbase

# ✅ 必要なフォルダを作成（ここが重要！）
RUN mkdir -p pb_data pb_migrations

# ✅ 起動前に初期化して起動
CMD sh -c "rm -rf pb_data/* && ./pocketbase serve --http=0.0.0.0:10000"
