# Use Node.js 18 as base
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json first (to install dependencies)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all files
COPY . .

# Expose port
EXPOSE 5000

# Start the app
CMD ["npm", "start"]
