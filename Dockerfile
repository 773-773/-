FROM alpine:3.18

# ✅ Renderの無料環境で書き込み可能な/appディレクトリを使用
WORKDIR /app

RUN apk add --no-cache wget unzip bash

# ✅ PocketBaseの安定バージョンを指定
ARG PB_VER=v0.21.2
RUN wget https://github.com/pocketbase/pocketbase/releases/download/${PB_VER}/pocketbase_0.21.2_linux_amd64.zip -O pocketbase.zip
RUN unzip pocketbase.zip -d .
RUN chmod +x pocketbase

# ✅ データ保存用ディレクトリを作成（Renderで唯一書き込める場所）
RUN mkdir -p /app/pb_data /app/pb_migrations
RUN chmod -R 777 /app/pb_data /app/pb_migrations

# ✅ PocketBase起動（初回はpb_dataをクリアして確実に起動する）
CMD sh -c "rm -rf /app/pb_data/* && ./pocketbase serve --dir /app/pb_migrations --http=0.0.0.0:10000"
