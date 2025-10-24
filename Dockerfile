FROM alpine:3.18

WORKDIR /app

RUN apk add --no-cache wget unzip bash

RUN wget https://github.com/pocketbase/pocketbase/releases/latest/download/pocketbase_0.31.0_linux_amd64.zip -O pocketbase.zip
RUN unzip pocketbase.zip -d .
RUN chmod +x pocketbase

# ←ここで事前にデータ削除
RUN rm -rf pb_data

# ←起動時にも必ず削除するように変更（commandで指定）
CMD sh -c "rm -rf pb_data && ./pocketbase serve --http=0.0.0.0:10000"

