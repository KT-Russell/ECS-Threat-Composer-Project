# Stage 1: Build Stage

FROM node:20-alpine AS builder

WORKDIR /app 

# Copy dependency files
COPY package.json yarn.lock ./

# Install all dependencies 
RUN yarn install --frozen-lockfile 

# Copy rest of source code
COPY . . 

# Run the build
RUN yarn build 

# Stage 2: Serve app
FROM node:20-alpine

WORKDIR /app

# Copy package files first (to fix crash exit 0 code in ECS)
COPY package.json yarn.lock ./


# install production dependencies -including express 
RUN yarn install --production --frozen-lockfile

# Copy over only the built output from builder stage
COPY --from=builder /app/build ./build
COPY server.js ./

# Add a non-root user 

USER root

# Expose port 80 internally
EXPOSE 80

# Serve the abuild & health endpoint
CMD [ "node", "server.js"]


