# ========= 1. ベースイメージ =========
FROM alpine:3.18

# ========= 2. 作業ディレクトリ =========
WORKDIR /app

# ========= 3. 必要なツール追加 =========
RUN apk add --no-cache wget unzip bash

# ========= 4. PocketBase 安定バージョン指定 =========
ARG PB_VER=0.21.2
ENV PB_FILE=pocketbase_${PB_VER}_linux_amd64.zip

# ========= 5. PocketBaseダウンロード&解凍 =========
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v${PB_VER}/${PB_FILE} -O pb.zip \
  && unzip pb.zip -d . \
  && rm pb.zip \
  && chmod +x pocketbase

# ========= 6. 永続ディスク設定 =========
VOLUME /app/pb_data
RUN mkdir -p /app/pb_data /app/pb_migrations

# ========= 7. 書き込み権限を付与 =========
RUN chmod -R 777 /app

# ========= 8. PocketBase起動 =========
CMD ["./pocketbase", "serve", "--dir", "/app/pb_data", "--http=0.0.0.0:10000"]
