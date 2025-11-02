# ベース：軽量 Alpine Linux
FROM alpine:3.18

# 作業ディレクトリ
WORKDIR /app

# 必要パッケージをインストール
RUN apk add --no-cache wget unzip bash ca-certificates

# ✅ PocketBase の安定版を固定（v0.24.4）
ARG PB_VERSION=0.24.4
ENV PB_FILE=pocketbase_${PB_VERSION}_linux_amd64.zip

# ✅ PocketBase 本体を取得＆展開（キャッシュ防止付き）
RUN wget -O pocketbase.zip "https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${PB_FILE}?$(date +%s)" \
  && unzip pocketbase.zip -d . \
  && rm pocketbase.zip \
  && chmod +x /app/pocketbase \
  && /app/pocketbase --help >/dev/null

# ✅ あなたの pb_public（HTML群）を PocketBase 公開ディレクトリに配置
# Render が確実に中身を含むように「./pb_public」で明示
COPY ./pb_public /app/pb_public

# ✅ バックアップZIPをRender環境にコピー
COPY buckup_2025_10_31.zip /app/buckup_2025_10_31.zip

# ✅ 永続ディスク（RenderのPersistent Disk対策）
VOLUME /app/pb_data

# ✅ 権限緩和（Renderの権限差エラー防止）
RUN chmod -R 777 /app

# ✅ Render が利用するポート
EXPOSE 8080

# ✅ PocketBase起動コマンド（publicDirを明示指定）
CMD ["/app/pocketbase", "serve", "--http=0.0.0.0:8080", "--publicDir", "/app/pb_public"]
