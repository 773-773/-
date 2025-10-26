#!/bin/bash
cd /app
chmod -R 777 /app/pb_data

# PocketBase を静的ファイルの公開ディレクトリとして pb_public をセット
./pocketbase serve --http="0.0.0.0:${PORT}" --publicDir="pb_public"
