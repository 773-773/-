# ========= 1. ベースイメージ =========
FROM alpine:3.18

# ========= 2. 作業ディレクトリ =========
WORKDIR /app

# ========= 3. 必要なツール追加 =========
RUN apk add --no-cache wget unzip bash

# ========= 4. PocketBase安定バージョン指定 =========
ARG PB_VER=v0.21.2

# ========= 5. バイナリのダウンロードと解凍 =========
RUN wget https://github.com/pocketbase/pocketbase/releases/download/${PB_VER}/pocketbase_0.21.2_linux_amd64.zip -O pocketbase.zip \
  && unzip pocketbase.zip -d . \
  && rm pocketbase.zip \
  && chmod +x pocketbase

# ========= 6. データ保存ディレクトリ（Renderの永続ディスクと一致させる）=========
# RenderでMountした `/app/pb_data` をそのままPocketBaseが使う
VOLUME /app/pb_data

# ========= 7. マイグレーションフォルダ作成 =========
RUN mkdir -p /app/pb_migrations

# ========= 8. 権限付与 =========
RUN chmod -R 777 /app

# ========= 9. PocketBase起動 =========
CMD ["./pocketbase", "serve", "--dir", "/app/pb_migrations", "--http=0.0.0.0:10000"]
