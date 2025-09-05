# Makefile for Widget Monorepo Docker Management

.PHONY: help build dev prod stop clean logs test lint

# Default target
help: ## Show this help message
	@echo "Widget Monorepo - Docker Management"
	@echo "=================================="
	@echo ""
	@echo "Available commands:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Environment setup
setup: ## Initial setup - copy env file and make scripts executable
	@echo "Setting up environment..."
	@if [ ! -f .env ]; then cp env.example .env; echo "Created .env from example. Please edit it."; fi
	@chmod +x scripts/*.sh
	@echo "Setup complete!"

# Build commands
build: ## Build all Docker images
	@echo "Building Docker images..."
	@docker build -f Dockerfile.widget -t widget-frontend:latest .

build-dev: ## Build development images
	@echo "Building development images..."
	@docker-compose -f docker-compose.dev.yml build

build-prod: ## Build production images
	@echo "Building production images..."
	@docker-compose -f docker-compose.prod.yml build

# Development
dev: ## Start development environment
	@echo "Starting development environment..."
	@docker-compose -f docker-compose.dev.yml up -d
	@echo "Development environment started!"
	@echo "Frontend: http://localhost:3000"
	@echo "Database: localhost:5433"
	@echo "Redis: localhost:6380"

# Production
prod: ## Start production environment
	@echo "Starting production environment..."
	@docker-compose -f docker-compose.prod.yml up -d
	@echo "Production environment started!"
	@echo "Frontend: http://localhost:3000"

# Stop services
stop: ## Stop all services
	@echo "Stopping all services..."
	@docker-compose -f docker-compose.dev.yml down 2>/dev/null || true
	@docker-compose -f docker-compose.prod.yml down 2>/dev/null || true
	@echo "All services stopped!"

stop-dev: ## Stop development services
	@echo "Stopping development services..."
	@docker-compose -f docker-compose.dev.yml down

stop-prod: ## Stop production services
	@echo "Stopping production services..."
	@docker-compose -f docker-compose.prod.yml down

# Logs
logs: ## Show logs for all services
	@docker-compose logs -f

logs-dev: ## Show development logs
	@docker-compose -f docker-compose.dev.yml logs -f

logs-prod: ## Show production logs
	@docker-compose -f docker-compose.prod.yml logs -f

logs-widget: ## Show widget frontend logs
	@docker-compose logs -f widget

# Cleanup
clean: ## Clean up Docker resources
	@echo "Cleaning up Docker resources..."
	@docker-compose -f docker-compose.dev.yml down -v 2>/dev/null || true
	@docker-compose -f docker-compose.prod.yml down -v 2>/dev/null || true
	@docker system prune -f
	@echo "Cleanup complete!"

clean-images: ## Remove all Docker images
	@echo "Removing Docker images..."
	@docker rmi $(docker images -q) 2>/dev/null || true
	@echo "Images removed!"

# Testing
test: ## Run tests
	@echo "Running tests..."
	@npx nx test widget
	@npx nx test ui
	@npx nx test rtk

test-e2e: ## Run e2e tests
	@echo "Running e2e tests..."
	@npx nx e2e widget-e2e

# Linting
lint: ## Run linting
	@echo "Running linting..."
	@npx nx lint widget
	@npx nx lint ui
	@npx nx lint rtk

# Health checks
health: ## Check health of all services
	@echo "Checking service health..."
	@curl -f http://localhost:3000/health && echo "✅ Frontend is healthy" || echo "❌ Frontend is not responding"

# Database operations
db-shell: ## Connect to database shell
	@docker exec -it widget-postgres-prod psql -U widget_user -d widget_db

db-backup: ## Backup database
	@echo "Creating database backup..."
	@docker exec widget-postgres-prod pg_dump -U widget_user widget_db > backup_$(shell date +%Y%m%d_%H%M%S).sql
	@echo "Backup created!"

# Quick start
start: setup dev ## Quick start - setup and start development environment

# Full deployment
deploy: setup build-prod prod ## Full deployment - setup, build, and start production
