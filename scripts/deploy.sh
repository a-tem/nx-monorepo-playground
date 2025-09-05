#!/bin/bash

# Deployment script for Widget monorepo
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}[DEPLOY]${NC} $1"
}

# Default environment
ENVIRONMENT=${1:-prod}

print_header "Starting deployment for environment: $ENVIRONMENT"

# Validate environment
if [[ "$ENVIRONMENT" != "dev" && "$ENVIRONMENT" != "prod" ]]; then
    print_error "Invalid environment. Use 'dev' or 'prod'"
    exit 1
fi

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check if .env file exists
if [ ! -f .env ]; then
    print_error ".env file not found. Please create it from env.example"
    exit 1
fi

# Load environment variables
source .env

# Stop existing containers
print_status "Stopping existing containers..."
if [ "$ENVIRONMENT" = "dev" ]; then
    docker-compose -f docker-compose.dev.yml down
else
    docker-compose -f docker-compose.prod.yml down
fi

# Remove old images (optional)
if [ "$CLEAN_IMAGES" = "true" ]; then
    print_status "Cleaning up old images..."
    docker image prune -f
fi

# Build and start services
print_status "Building and starting services..."
if [ "$ENVIRONMENT" = "dev" ]; then
    docker-compose -f docker-compose.dev.yml up -d --build
else
    docker-compose -f docker-compose.prod.yml up -d --build
fi

# Wait for services to be ready
print_status "Waiting for services to be ready..."
sleep 10

# Health check
print_status "Performing health checks..."

# Check frontend
if curl -f http://localhost:3000/health > /dev/null 2>&1; then
    print_status "✅ Frontend is healthy"
else
    print_warning "⚠️  Frontend health check failed"
fi

# Check database (if running)
if [ "$ENVIRONMENT" = "prod" ]; then
    if docker exec widget-postgres-prod pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB} > /dev/null 2>&1; then
        print_status "✅ Database is healthy"
    else
        print_warning "⚠️  Database health check failed"
    fi
fi

print_header "Deployment completed! 🎉"
print_status "Services are running:"
echo "  Frontend: http://localhost:3000"
if [ "$ENVIRONMENT" = "prod" ]; then
    echo "  Database: localhost:5432"
    echo "  Redis: localhost:6379"
fi

print_status "Useful commands:"
echo "  docker-compose logs -f widget     # View frontend logs"
echo "  docker-compose ps                 # View running containers"
echo "  docker-compose down               # Stop all services"
