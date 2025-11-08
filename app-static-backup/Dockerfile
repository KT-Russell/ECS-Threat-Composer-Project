# Stage 1: Build Stage

FROM node:25-alpine AS builder

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

COPY . . 

RUN yarn build

# Stage 2 - Runtime 

FROM node:25-alpine

WORKDIR /app

COPY --from=builder /app/build/ ./build

RUN yarn global add serve


RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
EXPOSE 3000

CMD ["serve", "-s", "build"]