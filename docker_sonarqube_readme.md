# Ecommerce Node.js Project with Docker & SonarQube

[![Node.js](https://img.shields.io/badge/Node.js-18-brightgreen)](https://nodejs.org/)
[![Docker](https://img.shields.io/badge/Docker-Setup-blue)](https://www.docker.com/)
[![SonarQube](https://img.shields.io/badge/SonarQube-Analysis-yellowgreen)](https://www.sonarqube.org/)

## Project Overview
This is a Node.js e-commerce API project using MongoDB. The project is Dockerized for easy deployment and includes SonarQube integration for code quality analysis.

## Prerequisites
- Docker installed
- Docker Compose installed
- Node.js installed (optional if using Docker only)

## 1. Docker Setup

### Dockerfile
```dockerfile
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
```

### docker-compose.yml
```yaml
version: '3.8'

services:
  mongo:
    image: mongo
    container_name: ecommerce-mongo
    ports:
      - "27017:27017"
    volumes:
      - mongo-data:/data/db

  app:
    build: .
    container_name: ecommerce-app
    ports:
      - "5000:5000"
    environment:
      MONGO_URI: "mongodb://mongo:27017/ecommerce"
      PORT: 5000
    depends_on:
      - mongo

volumes:
  mongo-data:
```

### Build & Run Docker Containers
```bash
# Build the Docker image
docker build -t ecommerce-app .

# Run containers using Docker Compose
docker-compose up -d
```

Verify:
- API runs at `http://localhost:5000`
- MongoDB runs at `mongodb://localhost:27017`

## 2. SonarQube Setup

### Step 1: Pull SonarQube Docker Image
```bash
docker pull sonarqube
```

### Step 2: Run SonarQube Container
```bash
docker run -d --name sonarqube -p 9000:9000 sonarqube
```

### Step 3: Access SonarQube
- Open browser: `http://localhost:9000`
- Login: `admin / admin`
- Create a new project

### Step 4: Install Sonar Scanner
```bash
npm install -g @sonar/scan
```

### Step 5: Run SonarQube Analysis
```bash
sonar-scanner \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=<YOUR_SONARQUBE_TOKEN>
```
> Replace `<YOUR_SONARQUBE_TOKEN>` with the token generated in SonarQube.

## 3. Project Structure
```
ecommerce-api/
│
├── Dockerfile
├── docker-compose.yml
├── package.json
├── src/ (your app code)
└── README.md
```

## 4. Results
- After running `sonar-scanner`, check the SonarQube dashboard for:
  - Bugs
  - Code smells
  - Vulnerabilities
  - Test coverage

---

