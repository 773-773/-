FROM alpine:3.18

WORKDIR /app

RUN apk add --no-cache wget unzip bash

# PocketBase本体をダウンロード
RUN wget https://github.com/pocketbase/pocketbase/releases/latest/download/pocketbase_0.31.0_linux_amd64.zip -O pocketbase.zip
RUN unzip pocketbase.zip -d .
RUN chmod +x pocketbase

# ✅ 起動前にデータ削除して初期化する
CMD sh -c "rm -rf pb_data && ./pocketbase serve --http=0.0.0.0:10000"
