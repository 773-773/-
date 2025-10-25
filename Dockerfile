# ========= 1. ベースイメージ =========
FROM alpine:3.18

# ========= 2. 作業ディレクトリ =========
WORKDIR /app

# ========= 3. 必要なツール追加 =========
RUN apk add --no-cache wget unzip bash

# ========= 4. PocketBaseバージョン指定 =========
ENV PB_VERSION=0.21.2
ENV PB_FILE=pocketbase_${PB_VERSION}_linux_amd64.zip

# ========= 5. PocketBaseダウンロード & 解凍 =========
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${PB_FILE} -O pocketbase.zip \
  && unzip pocketbase.zip -d . \
  && rm pocketbase.zip \
  && chmod +x pocketbase

# ========= 6. 永続データディレクトリ =========
VOLUME /app/pb_data
RUN mkdir -p /app/pb_data

# ========= 7. 権限を付与 =========
RUN chmod -R 777 /app

# ========= 8. PocketBase起動 =========
# Render は $PORT 環境変数を使う必要がある
CMD ["sh", "-c", "./pocketbase serve --dir /app/pb_data --http 0.0.0.0:${PORT}"]
