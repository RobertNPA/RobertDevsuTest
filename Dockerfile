FROM node:18-alpine AS builder
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm ci

COPY . .


FROM node:18-alpine
WORKDIR /usr/src/app


RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

COPY --from=builder /usr/src/app .

ENV PORT=8000
EXPOSE $PORT


HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget -q -O - http://localhost:$PORT/health || exit 1

CMD ["node", "index.js"] 