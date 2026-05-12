FROM node:20-alpine AS builder

WORKDIR /app
COPY package*.json tsconfig*.json ./
COPY packages/backend/package.json ./packages/backend/
RUN npm ci
COPY . .
RUN npm run build -w packages/backend

FROM node:20-alpine AS runner
WORKDIR /app
COPY --from=builder /app/packages/backend/dist ./dist
COPY --from=builder /app/packages/backend/node_modules ./node_modules
COPY --from=builder /app/packages/backend/package.json ./
COPY --from=builder /app/packages/backend/prisma ./prisma

EXPOSE 3000
CMD ["node", "dist/app.js"]
