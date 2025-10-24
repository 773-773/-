# 1. 軽量Linuxイメージを使用
FROM alpine:3.18

# 2. 作業ディレクトリ作成
WORKDIR /app

# 3. 必要なコマンドをインストール（wget、unzip、bash）
RUN apk add --no-cache wget unzip bash

# 4. PocketBase 最新バイナリ（zip形式）をダウンロード
RUN wget https://github.com/pocketbase/pocketbase/releases/latest/download/pocketbase_0.31.0_linux_amd64.zip -O pocketbase.zip

# 5. zipを解凍
RUN unzip pocketbase.zip -d .

# 6. 実行権限を付与
RUN chmod +x pocketbase

# 7. Renderで外部公開ポートを使用して起動
CMD ["./pocketbase", "serve", "--http=0.0.0.0:10000"]

