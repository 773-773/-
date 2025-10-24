# 1. 軽量Linuxイメージを使用
FROM alpine:3.18

# 2. 作業ディレクトリ作成
WORKDIR /app

# 3. wgetとbashをインストール（Alpineはデフォで入っていない）
RUN apk add --no-cache wget bash

# 4. PocketBase 最新バイナリをダウンロード
RUN wget https://github.com/pocketbase/pocketbase/releases/latest/download/pocketbase_linux_amd64 -O pocketbase

# 5. 実行権限を付与
RUN chmod +x pocketbase

# 6. Renderで外部公開ポートを使用して起動
CMD ["./pocketbase", "serve", "--http=0.0.0.0:10000"]
