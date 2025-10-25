FROM alpine:3.18

# ✅ 安定して書き込み可能な場所
WORKDIR /app

RUN apk add --no-cache wget unzip bash

# ✅ PocketBaseの安定バージョン（v0.21.2）
ARG PB_VER=v0.21.2
RUN wget https://github.com/pocketbase/pocketbase/releases/download/${PB_VER}/pocketbase_0.21.2_linux_amd64.zip -O pocketbase.zip
RUN unzip pocketbase.zip -d .
RUN chmod +x pocketbase

# ✅ Renderの無料環境で確実に書き込みできるようにする
RUN mkdir -p /app/pb_data /app/pb_migrations
RUN chmod -R 777 /app

# ✅ 初回起動時にpb_dataを必ずクリア → 書き込み可能な状態で生成
CMD sh -c "rm -rf /app/pb_data/* && ./pocketbase serve --dir /app/pb_migrations --http=0.0.0.0:10000"
