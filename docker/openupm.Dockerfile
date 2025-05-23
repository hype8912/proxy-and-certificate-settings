FROM node:slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g openupm-cli

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["node"]