FROM ghost:5-alpine

WORKDIR /var/lib/ghost

RUN npm install -g ghos3 && \
    ln -s /usr/local/lib/node_modules/ghos3 ./current/core/server/adapters/storage/s3

# RUN npm install --prefix /tmp/ghos3 ghos3 && \
#     cp -r /tmp/ghos3/node_modules/ghos3 ./current/core/server/adapters/storage/s3 && \
#     rm -r /tmp/ghos3
