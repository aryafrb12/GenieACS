# Image GenieACS 1.2.13 di atas Node.js 20 (sama dengan versi di genie.sh)
FROM node:20-bookworm-slim

RUN npm install -g genieacs@1.2.13 && npm cache clean --force \
 && mkdir -p /opt/genieacs/ext \
 && chown -R node:node /opt/genieacs

ENV GENIEACS_EXT_DIR=/opt/genieacs/ext

USER node
WORKDIR /opt/genieacs
# Perintah default; tiap service di docker-compose menimpa ini
CMD ["genieacs-cwmp"]
