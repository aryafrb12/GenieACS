#!/bin/bash
# Download file database bawaan beryindo + siapkan .env
set -e
cd "$(dirname "$0")"
mkdir -p db ext
BASE=https://github.com/beryindo/genieacs/raw/refs/heads/main
for f in config presets provisions virtualParameters; do
  curl -fsSL -o "db/$f.bson"          "$BASE/$f.bson"
  curl -fsSL -o "db/$f.metadata.json" "$BASE/$f.metadata.json"
done
if [ ! -f .env ]; then
  echo "GENIEACS_UI_JWT_SECRET=$(head -c 32 /dev/urandom | base64 | tr -d '/+=')" > .env
  echo ">> .env dibuat dengan JWT secret acak"
fi
chmod +x mongo-init/restore.sh
echo ">> Selesai. Lanjut: docker compose up -d --build"
