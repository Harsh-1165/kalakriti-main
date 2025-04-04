# Stage 1: Build the frontend
FROM node:18 AS build

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the project and build frontend
COPY . .
RUN npm run build

# Stage 2: Run backend server
FROM node:18

WORKDIR /app

# Copy built files from stage 1
COPY --from=build /app /app

# Install only production dependencies
RUN npm install --omit=dev

# Expose the backend port
EXPOSE 5000

# Start the server
CMD ["node", "server/index.js"]
