# Widget Monorepo - Docker Deployment Guide

This document describes how to prepare and deploy the Widget monorepo using Docker and Docker Compose.

## 📋 Project Structure

```
widget/
├── apps/
│   ├── widget/                 # React frontend application
│   ├── directory/              # Python backend service (future)
│   └── matching/               # Python backend service (future)
├── libs/
│   ├── ui/                     # UI components
│   └── rtk/                    # Redux Toolkit
├── docker-compose.yml          # Main configuration
├── docker-compose.dev.yml      # Development environment
├── docker-compose.prod.yml     # Production environment
├── Dockerfile.widget           # Dockerfile for frontend
├── nginx.conf                  # Nginx configuration
└── scripts/                    # Build and deployment scripts
```

## 🚀 Quick Start

### 1. Environment Setup

```bash
# Clone the repository
git clone <your-repo-url>
cd widget

# Run initial setup
make setup
```

### 2. Configuration Editing

Edit the `.env` file according to your needs:

```bash
# Main settings
NODE_ENV=production
REACT_APP_API_URL=http://localhost/api

# Database
POSTGRES_DB=widget_db
POSTGRES_USER=widget_user
POSTGRES_PASSWORD=your_secure_password

# Security
JWT_SECRET=your-jwt-secret-key
ENCRYPTION_KEY=your-encryption-key
```

### 3. Running in Development Mode

```bash
# Start development environment
make dev

# Or using docker-compose directly
docker-compose -f docker-compose.dev.yml up -d
```

### 4. Running in Production Mode

```bash
# Start production environment
make prod

# Or using docker-compose directly
docker-compose -f docker-compose.prod.yml up -d
```

## 🛠 Available Commands

### Makefile Commands

```bash
make help          # Show all available commands
make setup         # Initial setup
make dev           # Start development environment
make prod          # Start production environment
make stop          # Stop all services
make logs          # Show logs for all services
make health        # Check service health
make clean         # Clean Docker resources
make test          # Run tests
make lint          # Run linting
```

### Docker Compose Commands

```bash
# Development
docker-compose -f docker-compose.dev.yml up -d
docker-compose -f docker-compose.dev.yml down
docker-compose -f docker-compose.dev.yml logs -f

# Production
docker-compose -f docker-compose.prod.yml up -d
docker-compose -f docker-compose.prod.yml down
docker-compose -f docker-compose.prod.yml logs -f
```

## 🌐 Service Access

### Development

- **Frontend**: http://localhost:3000
- **Database**: localhost:5433
- **Redis**: localhost:6380

### Production

- **Frontend**: http://localhost:3000
- **Database**: localhost:5432
- **Redis**: localhost:6379
- **Nginx Proxy**: http://localhost:80

## 📁 Adding Python Backend Services

### 1. Creating a New Service

```bash
# Create a folder for the new service
mkdir apps/your-service

# Copy Dockerfile from apps/directory/
cp apps/directory/Dockerfile apps/your-service/

# Create requirements.txt
cp apps/directory/requirements.txt apps/your-service/
```

### 2. Updating docker-compose.yml

Add the new service to `docker-compose.yml`:

```yaml
your-service:
  build:
    context: ./apps/your-service
    dockerfile: Dockerfile
  container_name: your-service-backend
  ports:
    - '8003:8000'
  environment:
    - PYTHONPATH=/app
    - ENVIRONMENT=production
  networks:
    - widget-network
  restart: unless-stopped
  depends_on:
    - postgres
    - redis
```

### 3. Updating Nginx Configuration

Add upstream and location to `nginx/nginx.conf`:

```nginx
upstream your_service_api {
    server your-service:8000;
}

location /api/your-service/ {
    proxy_pass http://your_service_api/;
    # ... other proxy settings
}
```

## 🔧 Nginx Configuration

Nginx is used as a reverse proxy for:

- Serving frontend static files
- Proxying requests to backend API
- CORS configuration
- Rate limiting
- Gzip compression

## 🗄 Database

### PostgreSQL

- **Development**: `widget_db_dev` on port 5433
- **Production**: `widget_db` on port 5432

### Database Connection

```bash
# Development
docker exec -it widget-postgres-dev psql -U widget_user -d widget_db_dev

# Production
docker exec -it widget-postgres-prod psql -U widget_user -d widget_db
```

### Database Backup

```bash
# Create backup
make db-backup

# Or manually
docker exec widget-postgres-prod pg_dump -U widget_user widget_db > backup.sql
```

## 🔍 Monitoring and Logs

### Viewing Logs

```bash
# All services
make logs

# Specific service
make logs-widget

# Development logs
make logs-dev

# Production logs
make logs-prod
```

### Health Checks

```bash
# Check service health
make health

# Or manually
curl http://localhost:3000/health
```

## 🚨 Troubleshooting

### Port Issues

If ports are occupied, change them in `docker-compose.yml`:

```yaml
ports:
  - '3001:80' # Change 3000 to 3001
```

### Permission Issues

```bash
# Make scripts executable
chmod +x scripts/*.sh
```

### Docker Resource Cleanup

```bash
# Full cleanup
make clean

# Remove all images
make clean-images
```

## 🔒 Security

### Production Settings

1. **Change passwords** in `.env` file
2. **Configure SSL certificates** for HTTPS
3. **Restrict database access**
4. **Use secrets** for sensitive data

### SSL/HTTPS

For production, it's recommended to configure SSL:

```bash
# Create folder for certificates
mkdir ssl

# Add your certificates
cp your-cert.pem ssl/
cp your-key.pem ssl/
```

## 📈 Scaling

### Horizontal Scaling

```yaml
# In docker-compose.yml
widget:
  deploy:
    replicas: 3
```

### Load Balancing

Nginx automatically balances load between replicas.

## 🤝 Development

### Local Development

```bash
# Run only frontend for development
npx nx serve widget

# Run with Docker for full stack
make dev
```

### Testing

```bash
# Unit tests
make test

# E2E tests
make test-e2e

# Linting
make lint
```

## 📞 Support

If you encounter issues:

1. Check logs: `make logs`
2. Check service health: `make health`
3. Check configuration in `.env`
4. Clean Docker resources: `make clean`

---

**Note**: This guide is prepared for the current project structure. When adding new services, update the corresponding configuration files.
