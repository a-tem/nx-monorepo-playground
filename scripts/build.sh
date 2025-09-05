#!/bin/bash

# Build script for Widget monorepo
set -e

echo "🚀 Starting build process..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check if .env file exists
if [ ! -f .env ]; then
    print_warning ".env file not found. Creating from example..."
    cp env.example .env
    print_warning "Please edit .env file with your configuration before running again."
    exit 1
fi

# Load environment variables
source .env

# Build frontend
print_status "Building frontend widget..."
docker build -f Dockerfile.widget -t widget-frontend:latest .

print_status "Build completed successfully! 🎉"

# Optional: Run tests
if [ "$RUN_TESTS" = "true" ]; then
    print_status "Running tests..."
    npx nx test widget
    npx nx test ui
    npx nx test rtk
fi

print_status "All done! You can now run:"
echo "  docker-compose up -d          # Start all services"
echo "  docker-compose -f docker-compose.dev.yml up -d    # Start development environment"
echo "  docker-compose -f docker-compose.prod.yml up -d   # Start production environment"
