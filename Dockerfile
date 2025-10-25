FROM alpine:3.18

# ルートに作成すると権限問題があるため /app に変更
WORKDIR /app

RUN apk add --no-cache wget unzip bash

# PocketBase 安定版（v0.21.2）をダウンロード
ARG PB_VER=v0.21.2
RUN wget https://github.com/pocketbase/pocketbase/releases/download/${PB_VER}/pocketbase_0.21.2_linux_amd64.zip -O pocketbase.zip
RUN unzip pocketbase.zip -d .
RUN chmod +x pocketbase

# 🔥 /app 内に pb_data と pb_migrations を確実に作る
RUN mkdir -p /app/pb_data /app/pb_migrations

# ✅ 権限を明示的に付与（これが重要）
RUN chmod -R 777 /app/pb_data /app/pb_migrations

# ✅ 起動前に pb_data の中身をリセットして起動
CMD sh -c "rm -rf /app/pb_data/* && ./pocketbase serve --dir /app/pb_migrations --http=0.0.0.0:10000"
