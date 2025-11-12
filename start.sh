#!/bin/bash
set -e

echo "🔍 Checking directory structure..."
ls -R /app | head -n 50

echo "🚀 Starting PocketBase with hooks support..."
/app/pocketbase serve \
  --http="0.0.0.0:8080" \
  --dir="/app/pb_data" \
  --publicDir="/app/pb_public" \
  --hooksDir="/app/pb_hooks"
