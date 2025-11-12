# ベース：軽量 Alpine Linux
FROM alpine:3.18

# 作業ディレクトリ
WORKDIR /app

# 必要パッケージ
RUN apk add --no-cache wget unzip bash ca-certificates

# PocketBase ダウンロード
ARG PB_VERSION=0.24.4
ENV PB_FILE=pocketbase_${PB_VERSION}_linux_amd64.zip

RUN wget -O pocketbase.zip "https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${PB_FILE}" \
    && unzip pocketbase.zip -d . \
    && rm pocketbase.zip \
    && chmod +x /app/pocketbase

# 公開フォルダ・hooksをコピー
COPY pb_public /app/pb_public
COPY pb_hooks /app/pb_hooks
RUN chmod -R 755 /app/pb_hooks

# 起動スクリプトをコピー
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# 永続ディスク設定
VOLUME /app/pb_data

# ポート
EXPOSE 8080

# PocketBase起動
ENTRYPOINT ["/bin/bash", "/app/start.sh"]
