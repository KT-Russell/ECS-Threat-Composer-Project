# Stage 1: Build Stage

FROM node:18-alpine AS builder

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
FROM node:18-alpine

# Add a non-root user  
RUN addgroup -S appgroup && adduser -S appuser -G appgroup 

WORKDIR /app

# install production dependencies -serve to host static build
RUN yarn global add serve 

# Copy over only the built files from builder stage
COPY --from=builder /app/build ./build

# Change ownership for non-root execution
RUN chown -R appuser:appgroup /app

# Swich to non-root user
USER appuser

EXPOSE 3000

# Serve the abuild & health endpoint
CMD ["serve", "-s", "build", "-l", "3000"]


