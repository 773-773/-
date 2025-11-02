# ベース：軽量 Alpine Linux
FROM alpine:3.18

# 作業ディレクトリ
WORKDIR /app

# 必要パッケージをインストール
RUN apk add --no-cache wget unzip bash ca-certificates

# ✅ PocketBase の安定版を固定（v0.24.4）
ARG PB_VERSION=0.24.4
ENV PB_FILE=pocketbase_${PB_VERSION}_linux_amd64.zip

# ✅ PocketBase 本体を取得＆展開
RUN wget -O pocketbase.zip "https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${PB_FILE}?$(date +%s)" \
  && unzip pocketbase.zip -d . \
  && rm pocketbase.zip \
  && chmod +x /app/pocketbase \
  && /app/pocketbase --help >/dev/null

# ✅ あなたの public フォルダ（HTML群）を PocketBase 公開ディレクトリに配置
COPY pb_public /app/pb_public


# ✅ バックアップZIPをRender環境にコピー
COPY buckup_2025_10_31.zip /app/buckup_2025_10_31.zip

# ✅ 起動スクリプトをコピー
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# ✅ 永続ディスク
VOLUME /app/pb_data

# ✅ 権限緩和（Renderのファイル権限対策）
RUN chmod -R 777 /app

# ✅ Render のポート
EXPOSE 8080

# ✅ 起動コマンド
CMD ["sh", "/app/start.sh"]
