# ベース：軽量Linux
FROM alpine:3.18

# 作業ディレクトリ
WORKDIR /app

# キャッシュ破棄トリック
ARG CACHEBUST=1

# 必要パッケージを追加
RUN apk add --no-cache wget unzip bash

# ✅ PocketBaseのバージョン設定（最新）
ENV PB_VERSION=0.33.0
ENV PB_FILE=pocketbase_${PB_VERSION}_linux_amd64.zip

# ✅ PocketBaseをダウンロードして展開
RUN rm -f pocketbase && \
    wget https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${PB_FILE} -O pocketbase.zip \
    && unzip pocketbase.zip -d . \
    && rm pocketbase.zip \
    && chmod +x pocketbase

# ✅ 永続ディスクをマウント
VOLUME /app/pb_data
RUN mkdir -p /app/pb_data

# ✅ 公開フォルダ
COPY pb_public /app/pb_public

# ✅ 起動スクリプト
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
RUN chmod -R 777 /app

# ✅ ポート指定
EXPOSE 8080

# ✅ 起動コマンド
CMD ["sh", "/app/start.sh"]
