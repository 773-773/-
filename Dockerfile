# ベース：軽量 Linux
FROM alpine:3.18

# 作業ディレクトリ
WORKDIR /app

# 必要パッケージ
RUN apk add --no-cache wget unzip bash

# ✅ PocketBase の安定版を “明示固定”
ARG PB_VERSION=0.22.14
ENV PB_FILE=pocketbase_${PB_VERSION}_linux_amd64.zip

# ✅ PocketBase 本体を取得＆展開（存在が確認できる版）
RUN wget -q https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${PB_FILE} -O pocketbase.zip \
  && unzip pocketbase.zip -d . \
  && rm pocketbase.zip \
  && chmod +x /app/pocketbase \
  && /app/pocketbase --help >/dev/null

# ✅ 公開フォルダ（静的ファイル）
COPY pb_public /app/pb_public

# ✅ 起動スクリプト
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# ✅ Render の永続ディスクは「実行時に」/app/pb_data にマウントされる
#    ここでは存在前提にしない（作成は start.sh で行う）
VOLUME /app/pb_data

# 任意：パーミッション緩め（Renderの権限差異での書込失敗対策）
RUN chmod -R 777 /app

# Render は PORT 環境変数を割り当てる
EXPOSE 8080

CMD ["sh", "/app/start.sh"]
