# ベース：軽量 Alpine Linux
FROM alpine:3.18

# 作業ディレクトリ
WORKDIR /app

# 必要パッケージ
RUN apk add --no-cache wget unzip bash ca-certificates

# ✅ PocketBase の安定版を固定
ARG PB_VERSION=0.24.4
ENV PB_FILE=pocketbase_${PB_VERSION}_linux_amd64.zip

# ✅ PocketBase 本体を取得
RUN wget -O pocketbase.zip "https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${PB_FILE}" \
    && unzip pocketbase.zip -d . \
    && rm pocketbase.zip \
    && chmod +x /app/pocketbase

# ✅ 公開フォルダとメールテンプレートを含める
COPY pb_public /app/pb_public
COPY pb_hooks  /app/pb_hooks

# 起動スクリプト
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# 永続ディレクトリ
VOLUME /app/pb_data

# ポート
EXPOSE 8080

# 起動
ENTRYPOINT ["sh", "/app/start.sh"]
