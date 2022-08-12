FROM node:16-slim AS base

RUN apt-get -qy update && apt-get -qy install openssl


FROM base AS builder

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build


FROM base AS dependency

WORKDIR /prepare

COPY package.json yarn.lock ./
COPY --from=builder /app/prisma /prepare/prisma

RUN yarn install --frozen-lockfile --production \
    && npx prisma generate


FROM base AS app

WORKDIR /app

COPY --from=builder /app/dist /app/package*.json /app/yarn.lock /app/
COPY --from=builder /app/prisma /app/prisma
COPY --from=builder /app/articles /app/articles/
COPY --from=dependency /prepare/node_modules /app/node_modules

CMD ["app.js"]

