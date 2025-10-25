# ====== 1. ベースイメージ ======
FROM alpine:3.18

# ====== 2. 作業ディレクトリ ======
WORKDIR /app

# ====== 3. 必要なツール ======
RUN apk add --no-cache wget unzip bash

# ====== 4. PocketBase の安定版を指定 ======
ARG PB_VER=v0.21.2
RUN wget https://github.com/pocketbase/pocketbase/releases/download/${PB_VER}/pocketbase_${PB_VER}_linux_amd64.zip -O pb.zip \
  && unzip pb.zip -d . \
  && rm pb.zip \
  && chmod +x pocketbase

# ====== 5. データ保存フォルダ（Render Disk と一致） ======
VOLUME /app/pb_data
RUN mkdir -p /app/pb_data /app/pb_migrations

# ====== 6. 権限付与 ======
RUN chmod -R 777 /app

# ====== 7. PocketBase 起動 ======
CMD ["./pocketbase", "serve", "--dir", "/app/pb_data", "--http=0.0.0.0:10000"]
