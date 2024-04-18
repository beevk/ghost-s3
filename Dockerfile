FROM ghost:5.82.2

WORKDIR /var/lib/ghost

RUN npm install --prefix /tmp/ghos3 ghos3 && \
cp -r /tmp/ghos3/node_modules/ghos3 current/core/server/adapters/storage/s3 && \
ln -s current/core/server/adapters/storage/s3 content/adapters/s3 && \
rm -r /tmp/ghos3
