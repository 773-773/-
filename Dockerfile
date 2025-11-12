# ベース：軽量 Alpine Linux
FROM alpine:3.18

# 作業ディレクトリ
WORKDIR /app

# 必要パッケージをインストール
RUN apk add --no-cache wget unzip bash ca-certificates

# ✅ PocketBase の安定版を固定
ARG PB_VERSION=0.24.4
ENV PB_FILE=pocketbase_${PB_VERSION}_linux_amd64.zip

# ✅ PocketBase 本体を取得
RUN wget -O pocketbase.zip "https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${PB_FILE}" \
  && unzip pocketbase.zip -d . \
  && rm pocketbase.zip \
  && chmod +x /app/pocketbase

# ✅ pb_public フォルダ（HTML群）をコンテナにコピー
# 🚨 注意: 「../pb_public」ではなく「pb_public」
COPY pb_public /app/pb_public
COPY pb_hooks /app/pb_hooks
# ✅ （一時的に無効化）バックアップZIPのコピーを停止
# COPY buckup_2025_10_31.zip /app/buckup_2025_10_31.zip

# ✅ 起動スクリプトをコピー
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# ✅ 永続ディスク設定
VOLUME /app/pb_data

# ✅ ポート設定
EXPOSE 8080

# ✅ PocketBase を start.sh 経由で起動
ENTRYPOINT ["sh", "/app/start.sh"]
