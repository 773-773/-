# ベース：軽量Linux
FROM alpine:3.18

WORKDIR /app

# キャッシュを完全に破棄（重要）
ARG CACHEBUST=$(date +%s)

RUN apk add --no-cache wget unzip bash

# ✅ PocketBase 最新バージョン
ENV PB_VERSION=0.33.0
ENV PB_FILE=pocketbase_${PB_VERSION}_linux_amd64.zip

# ✅ 古い pocketbase を完全削除して再取得
RUN rm -f pocketbase && \
    wget https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${PB_FILE} -O pocketbase.zip && \
    unzip pocketbase.zip -d . && \
    rm pocketbase.zip && \
    chmod +x pocketbase && \
    ./pocketbase --help

VOLUME /app/pb_data
RUN mkdir -p /app/pb_data

COPY pb_public /app/pb_public
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
RUN chmod -R 777 /app

EXPOSE 8080

CMD ["sh", "/app/start.sh"]
