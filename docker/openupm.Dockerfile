FROM node:slim

RUN apt update && apt upgrade -y

RUN npm install -g openupm-cli

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["node"]