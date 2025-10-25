# ========= 1. ベースイメージ =========
FROM alpine:3.18

# ========= 2. 作業ディレクトリ =========
WORKDIR /app

# ========= 3. 必要なツール追加 =========
RUN apk add --no-cache wget unzip bash

# ========= 4. PocketBase安定バージョン指定 =========
ARG PB_VER=v0.21.2

# ========= 5. PocketBaseダウンロード&解凍 =========
RUN wget https://github.com/pocketbase/pocketbase/releases/download/${PB_VER}/pocketbase_0.21.2_linux_amd64.zip -O pocketbase.zip \
  && unzip pocketbase.zip -d . \
  && rm pocketbase.zip \
  && chmod +x pocketbase

# ========= 6. データ保存フォルダ（永続ディスクと一致させる）=========
# ※ RenderのDiskで /app/pb_data をマウントする必要あり
VOLUME /app/pb_data
RUN mkdir -p /app/pb_data /app/pb_migrations

# ========= 7. Renderで書き込み可能になるように権限付与 =========
RUN chmod -R 777 /app

# ========= 8. PocketBase起動 =========
# --dir に永続ディスクの場所を指定（データ保存用）
# --migrations にマイグレーション用フォルダを指定
CMD ["./pocketbase", "serve", "--dir", "/app/pb_data", "--migrations", "/app/pb_migrations", "--http=0.0.0.0:10000"]
