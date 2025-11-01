# ベース：軽量 Alpine Linux
FROM alpine:3.18

WORKDIR /app

# PocketBase に必要な最低限のパッケージ
RUN apk add --no-cache wget unzip bash ca-certificates

# PocketBase のバージョン固定（安定版）
ARG PB_VERSION=0.22.14
ENV PB_FILE=pocketbase_${PB_VERSION}_linux_amd64.zip

# PocketBase ダウンロード＆展開
RUN wget -q https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${PB_FILE} -O pocketbase.zip \
  && unzip pocketbase.zip -d . \
  && rm pocketbase.zip \
  && chmod +x /app/pocketbase

# 公開フォルダ（静的ファイル）
COPY pb_public /app/pb_public

# 起動スクリプト
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Renderの永続ディスクは/app/pb_dataにマウントされる
VOLUME /app/pb_data

# 権限トラブル対策（Render環境によってroot以外ユーザーで動作するため）
RUN chmod -R 777 /app

# Render は自動で PORT 環境変数を渡す
EXPOSE 8080

# ✅ 起動コマンド
CMD ["/app/start.sh"]
