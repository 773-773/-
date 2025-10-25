# ========= 1. ベースイメージ =========
FROM alpine:3.18

# ========= 2. 作業ディレクトリ =========
WORKDIR /app

# ========= 3. 必要なツール追加 =========
RUN apk add --no-cache wget unzip bash

# ========= 4. PocketBase の安定バージョン指定 =========
ARG PB_VER=0.21.3
ENV PB_FILE=pocketbase_${PB_VER}_linux_amd64.zip

# ========= 5. PocketBaseダウンロード&解凍 =========
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v${PB_VER}/${PB_FILE} -O pocketbase.zip \
  && unzip pocketbase.zip -d . \
  && rm pocketbase.zip \
  && chmod +x pocketbase

# ========= 6. データ保存フォルダ（Renderの永続ディスクと一致）=========
# ※ Renderで /app/pb_data をマウントすること
VOLUME /app/pb_data
RUN mkdir -p /app/pb_data /app/pb_migrations

# ========= 7. 権限を付与 =========
RUN chmod -R 777 /app

# ========= 8. PocketBase起動 =========
CMD ["./pocketbase", "serve", "--dir", "/app/pb_migrations", "--http=0.0.0.0:10000"]
