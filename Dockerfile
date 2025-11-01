# ベース：軽量 Alpine Linux
FROM alpine:3.18

# 作業ディレクトリ
WORKDIR /app

# 必要パッケージ
RUN apk add --no-cache wget unzip bash ca-certificates

# PocketBase の安定版（v0.22.14 固定）
ARG PB_VERSION=0.23.6

ENV PB_FILE=pocketbase_${PB_VERSION}_linux_amd64.zip

# PocketBase を取得＆展開
RUN wget -q https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${PB_FILE} -O pocketbase.zip \
  && unzip pocketbase.zip -d . \
  && rm pocketbase.zip \
  && chmod +x /app/pocketbase \
  && /app/pocketbase --help >/dev/null

# 公開フォルダ（静的ファイル）
COPY pb_public /app/pb_public

# 起動スクリプト
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Renderの永続ディスク（/app/pb_data）にマウントされる
VOLUME /app/pb_data

# パーミッション対策
RUN chmod -R 777 /app

# Renderが割り当てるPORTを使う
EXPOSE 8080

# PocketBase起動
CMD ["sh", "/app/start.sh"]
