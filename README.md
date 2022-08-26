# nestjs-prisma

```bash
$ mkdir nestjs-prisma && $_

$ npx @nestjs/cli new .
```

## Setup

```console
$ cp .env.sample .env

$ docker-compose up

$ yarn start
```

## Database

### マイグレーションファイルの作成

```
npx prisma migrate dev --name [name]
```

### マイグレーション

```
npx prisma migrate dev
```
