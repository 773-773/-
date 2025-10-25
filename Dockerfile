FROM alpine:3.18

# ✅ PocketBaseはルートディレクトリで動かす
WORKDIR /

RUN apk add --no-cache wget unzip bash

# 📌 PocketBase安定版をダウンロード
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.21.2/pocketbase_0.21.2_linux_amd64.zip -O pocketbase.zip
RUN unzip pocketbase.zip -d .
RUN chmod +x pocketbase

# ✅ データ保存用フォルダをルートに作る
RUN mkdir -p /pb_data /pb_migrations

# ✅ 起動前にデータを初期化
CMD sh -c "rm -rf /pb_data/* && ./pocketbase serve --data /pb_data --dir /pb_migrations --http=0.0.0.0:10000"
