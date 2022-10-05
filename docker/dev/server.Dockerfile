FROM node:16.17.0

WORKDIR /app

COPY ./package*.json ./
COPY pnpm-lock.yaml .

RUN npm install -g pnpm\
  && pnpm fetch --prod\
  && pnpm install -r --frozen-lockfile --prod

COPY ./dist/apps/server .

EXPOSE 3001

CMD ["node", "main.js"]
