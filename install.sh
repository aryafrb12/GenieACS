#!/bin/bash
set -e
DIR=/opt/genieacs-docker

apt update && apt upgrade -y
apt install -y curl git

# Install Docker kalau belum ada
if ! command -v docker >/dev/null 2>&1; then
  curl -fsSL https://get.docker.com | sh
fi
systemctl enable --now docker

# Clone repo (atau update kalau sudah pernah)
if [ -d "$DIR/.git" ]; then
  git -C "$DIR" pull
else
  git clone https://github.com/aryafrb12/GenieACS.git "$DIR"
fi
cd "$DIR"

# Download .bson + bikin .env, lalu jalankan
bash setup.sh
docker compose up -d --build

IP=$(hostname -I | awk '{print $1}')
echo "=============================================="
echo " GenieACS UI : http://$IP:3000"
echo " ACS URL ONU : http://$IP:7547"
echo "=============================================="
