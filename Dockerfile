# ========= 1. ベースイメージ =========
FROM alpine:3.18

# ========= 2. 作業ディレクトリ =========
WORKDIR /app

# ========= 3. 必要なツール追加 =========
RUN apk add --no-cache wget unzip bash

# ========= 4. PocketBaseバージョン指定 =========
# ★ 最新安定版 v0.21.2 を直接指定（URLも正確）
ENV PB_VERSION=0.21.2
ENV PB_FILE=pocketbase_${PB_VERSION}_linux_amd64.zip

# ========= 5. PocketBaseダウンロード・解凍 =========
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${PB_FILE} -O pocketbase.zip \
  && unzip pocketbase.zip -d . \
  && rm pocketbase.zip \
  && chmod +x pocketbase

# ========= 6. 永続データ用ディレクトリ =========
# RenderのDiskは /app/pb_data にマウントする必要がある
VOLUME /app/pb_data

# ========= 7. マイグレーションフォルダ =========
RUN mkdir -p /app/pb_data /app/pb_migrations

# ========= 8. 権限を付与 =========
RUN chmod -R 777 /app

# ========= 9. PocketBase起動 =========
# --dir は永続ディスクの場所（必須）
# --http は公開ポート（Renderは10000固定）
CMD ["./pocketbase", "serve", "--dir", "/app/pb_data", "--http=0.0.0.0:10000"]
