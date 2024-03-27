FROM ghost:latest
RUN mv content.orig/* content/


COPY package.json package.json

ENV NODE_ENV=production
RUN npm install --omit=dev

# Run scripts to add adapters, themes, and patches
COPY copy-adapter.sh copy-adapter.sh
RUN chmod +x copy-adapter.sh && ./copy-adapter.sh

# Run ghost entrypoint
CMD ["node", "current/index.js"]