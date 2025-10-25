FROM alpine:3.18

# 安定して書き込み可能な場所
WORKDIR /app

RUN apk add --no-cache wget unzip bash

# PocketBase安定バージョン（v0.21.2）
ARG PB_VER=v0.21.2
RUN wget https://github.com/pocketbase/pocketbase/releases/download/${PB_VER}/pocketbase_0.21.2_linux_amd64.zip -O pocketbase.zip
RUN unzip pocketbase.zip -d .
RUN chmod +x pocketbase

# データ保存ディレクトリ
RUN mkdir -p /app/pb_data /app/pb_migrations

# ✅ 権限をすべて許可
RUN chmod -R 777 /app

# ✅ pb_data は削除しない。初回起動で空の状態からPocketBaseが自動生成する
CMD ["./pocketbase", "serve", "--dir", "/app/pb_migrations", "--http=0.0.0.0:10000"]
