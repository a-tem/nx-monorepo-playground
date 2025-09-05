# 🚀 Quick Start - Widget Monorepo

## What Was Created

Your monorepo is now fully prepared for Docker deployment! Here's what was added:

### 📁 New Files and Structure

```
widget/
├── 🐳 Docker Files
│   ├── Dockerfile.widget          # Production build for frontend
│   ├── Dockerfile.widget.dev      # Development build for frontend
│   ├── docker-compose.yml         # Main configuration
│   ├── docker-compose.dev.yml     # Development environment
│   ├── docker-compose.prod.yml    # Production environment
│   └── .dockerignore              # Build optimization
│
├── 🌐 Nginx Configuration
│   ├── nginx.conf                 # Basic configuration
│   └── nginx/nginx.conf           # Production configuration with proxy
│
├── 🐍 Python Backend (ready for future)
│   ├── apps/directory/
│   │   ├── Dockerfile
│   │   └── requirements.txt
│   └── apps/matching/
│       ├── Dockerfile
│       └── requirements.txt
│
├── 📜 Scripts and Configuration
│   ├── scripts/
│   │   ├── build.sh               # Build script
│   │   ├── deploy.sh              # Deployment script
│   │   └── init-db.sql            # Database initialization
│   ├── Makefile                   # Commands to simplify work
│   ├── env.example                # Environment variables example
│   └── DOCKER_README.md           # Detailed documentation
│
└── 📚 Documentation
    ├── DOCKER_README.md           # Complete guide
    └── QUICK_START.md             # This file
```

## ⚡ Quick Launch (3 Steps)

### 1️⃣ Preparation

```bash
# Clone the repository (if you haven't already)
cd /Users/artem/Documents/Learn/playground/widget

# Run initial setup
make setup
```

### 2️⃣ Configuration

Edit the `.env` file (created from `env.example`):

```bash
# Main settings
NODE_ENV=production
REACT_APP_API_URL=http://localhost/api

# Database (change passwords!)
POSTGRES_DB=widget_db
POSTGRES_USER=widget_user
POSTGRES_PASSWORD=your_secure_password_here

# Security (change keys!)
JWT_SECRET=your-jwt-secret-key-here
ENCRYPTION_KEY=your-encryption-key-here
```

### 3️⃣ Launch

```bash
# Development (recommended to start)
make dev

# Or Production
make prod
```

## 🌐 Access to Services

### Development

- **Frontend**: http://localhost:4200
- **Database**: localhost:5433
- **Redis**: localhost:6380

### Production

- **Frontend**: http://localhost:3000
- **Database**: localhost:5432
- **Redis**: localhost:6379

## 🛠 Useful Commands

```bash
# Main commands
make help          # Show all commands
make dev           # Launch development
make prod          # Launch production
make stop          # Stop all services
make logs          # Show logs
make health        # Check service health

# Development
make test          # Run tests
make lint          # Run linting
make clean         # Clean Docker resources

# Database
make db-shell      # Connect to database
make db-backup     # Create backup
```

## 🐍 Adding Python Backend Services

When you're ready to add backend services:

### 1. Uncomment services in docker-compose.yml

```yaml
# In docker-compose.yml find and uncomment:
directory-service:
  # ... configuration is already ready

matching-service:
  # ... configuration is already ready
```

### 2. Update Nginx Configuration

```bash
# In nginx/nginx.conf uncomment:
upstream directory_api {
    server directory-service:8000;
}

upstream matching_api {
    server matching-service:8000;
}
```

### 3. Add Your Python Code

```bash
# Create main files for each service:
apps/directory/main.py      # FastAPI application
apps/matching/main.py       # FastAPI application
```

## 🔧 Production Configuration

### SSL/HTTPS

```bash
# Create folder for certificates
mkdir ssl

# Add your certificates
cp your-cert.pem ssl/
cp your-key.pem ssl/
```

### Environment Variables

```bash
# For production create .env.prod
cp env.example .env.prod

# Edit with production values
# Use: docker-compose -f docker-compose.prod.yml --env-file .env.prod up -d
```

## 🚨 If Something Doesn't Work

### Check Logs

```bash
make logs
```

### Check Service Health

```bash
make health
```

### Restart Services

```bash
make stop
make dev  # or make prod
```

### Clean Everything and Start Over

```bash
make clean
make setup
make dev
```

## 📞 Help

- **Detailed Documentation**: `DOCKER_README.md`
- **All Commands**: `make help`
- **Project Structure**: `tree` or `ls -la`

---

**🎉 Done!** Your monorepo is now fully prepared for Docker deployment. You can start development or add backend services!
