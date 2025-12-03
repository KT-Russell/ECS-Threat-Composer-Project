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

# Must install serve to serve static files (the app)
RUN yarn global add serve 

# Copy over only the built output from builder stage
COPY --from=builder /app/build ./build

# Add a non-root user 
RUN addgroup -S group && adduser -S user -G group
USER user

# Expose the port Serve will use
EXPOSE 3000

# Start the app/build 
CMD ["serve", "-s", "build"]


