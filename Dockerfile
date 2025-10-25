# ========= 1. ベースイメージ =========
FROM alpine:3.18

# ========= 2. 作業ディレクトリ =========
WORKDIR /app

# ========= 3. 必要なツール追加 =========
RUN apk add --no-cache wget unzip bash

# ========= 4. PocketBase の安定バージョン指定 =========
# （最新版でもOK。ここでは v0.21.3 を使用）
ARG PB_VER=v0.21.3

# ========= 5. PocketBaseダウンロード&解凍 =========
RUN wget https://github.com/pocketbase/pocketbase/releases/download/${PB_VER}/pocketbase_${PB_VER}_linux_amd64.zip -O pocketbase.zip \
  && unzip pocketbase.zip -d . \
  && rm pocketbase.zip \
  && chmod +x pocketbase

# ========= 6. データ保存フォルダ（永続ディスク用）=========
# Renderで /app/pb_data にディスクをマウントした場合に対応
RUN mkdir -p /app/pb_data

# ========= 7. 権限を付与 =========
RUN chmod -R 777 /app

# ========= 8. PocketBase起動 =========
CMD ["./pocketbase", "serve", "--dir", "/app/pb_data", "--http=0.0.0.0:10000"]
