# Step 1: Build the React app using a Node.js image
FROM node:18 AS builder

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the project files

# Build the app for production
RUN npm run build

# Step 2: Serve the built app using the "serve" package
FROM node:18

# Install serve globally
RUN npm install -g serve

# Set working directory inside the container
WORKDIR /app

# Copy the build output from the builder stage
COPY --from=builder /app/dist /app

# Expose port 80
EXPOSE 80
# Run the app using "serve"
CMD ["serve", "-s", "build", "-l", "80"]
