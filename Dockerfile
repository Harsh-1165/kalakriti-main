# --------------------
# Build frontend
# --------------------
FROM node:18 AS frontend-builder
WORKDIR /app

COPY package*.json ./
COPY tsconfig*.json ./
COPY tailwind.config.js postcss.config.js vite.config.ts ./
COPY index.html ./
COPY ./src ./src

RUN npm install
RUN npm run build

# --------------------
# Backend setup
# --------------------
FROM node:18 AS backend

WORKDIR /app

# Copy backend
COPY ./server ./server

# Copy frontend build output
COPY --from=frontend-builder /app/dist ./public

# Copy other needed files
COPY package*.json ./
COPY .env ./

RUN npm install --omit=dev

# Expose the port your server runs on
EXPOSE 5000

CMD ["node", "server/index.js"]

