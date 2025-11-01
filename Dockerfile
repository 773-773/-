# ベース：軽量Linux
FROM alpine:3.18

# 作業ディレクトリ
WORKDIR /app

# 必要パッケージを追加
RUN apk add --no-cache wget unzip bash

# ✅ PocketBaseのバージョン設定
ENV PB_VERSION=0.31.0
ENV PB_FILE=pocketbase_${PB_VERSION}_linux_amd64.zip

# ✅ PocketBaseをダウンロードして展開
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${PB_FILE} -O pocketbase.zip \
  && unzip pocketbase.zip -d . \
  && rm pocketbase.zip \
  && chmod +x pocketbase

# ✅ Renderの永続ディスクをマウントするだけ（新規作成禁止）
VOLUME /app/pb_data

# ✅ 公開フォルダ（HTMLなど）
COPY pb_public /app/pb_public

# ✅ 起動スクリプトをコピー＆権限付与
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
RUN chmod -R 777 /app

# ✅ ポートを指定
EXPOSE 8080

# ✅ 起動コマンド
CMD ["sh", "/app/start.sh"]
# ✅ バックアップZIPを自動展開してpb_dataに復元
COPY buckup_2025_10_31.zip /app/
RUN apk add --no-cache unzip && \
    rm -rf /app/pb_data/* && \
    unzip /app/buckup_2025_10_31.zip -d /app/pb_data && \
    chmod -R 777 /app/pb_data
