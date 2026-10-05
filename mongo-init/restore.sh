#!/bin/bash
# Dijalankan otomatis oleh image mongo HANYA saat volume data masih kosong
# (pertama kali). Pengganti: mongorestore --db genieacs --drop /root/db
set -e
if ls /dump/*.bson >/dev/null 2>&1; then
  echo ">> Restore config/presets/provisions/virtualParameters GenieACS..."
  mongorestore --db genieacs --drop /dump
else
  echo ">> /dump kosong, skip restore."
fi
