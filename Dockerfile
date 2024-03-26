FROM ghost:alpine

COPY package.json package.json
RUN npm install --omit=dev

COPY copy-adapter.sh copy-adapter.sh
RUN chmod +x copy-adapter.sh && ./copy-adapter.sh

EXPOSE 2368
CMD [ "node", "current/index.js" ]