FROM node:20

RUN npm install -g pnpm

WORKDIR /app

COPY . .

RUN pnpm install

CMD ["pnpm", "dev"]