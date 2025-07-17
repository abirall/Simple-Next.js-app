# Step 1: Build the app
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json* ./
RUN npm install

# Copy app source and build
COPY . .
RUN npm run build

# Step 2: Run the built app in production
FROM node:18-alpine

WORKDIR /app

# Install only production dependencies (optional but recommended)
COPY package.json package-lock.json* ./
RUN npm install --omit=dev

# Copy the built app from builder
COPY --from=builder /app ./

# Expose port
EXPOSE 3000

# Start Next.js in production mode
CMD ["npm", "start" "dev"]



