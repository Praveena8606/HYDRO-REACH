# HydroReach Docker Setup Guide

## 🐳 **Complete Docker Containerization**

This guide will help you run the HydroReach water delivery management system using Docker containers.

## 📋 **Prerequisites**

- Docker Desktop installed
- Docker Compose installed
- Git (to clone the repository)

## 🚀 **Quick Start**

### 1. **Clone and Setup**
```bash
git clone <your-repo-url>
cd hydroreach
```

### 2. **Environment Configuration**
```bash
# Copy environment template
cp .env.example .env

# Edit .env file with your settings
nano .env
```

### 3. **Development Setup**
```bash
# Build and start development environment
docker-compose -f docker-compose.dev.yml up --build

# Or run in background
docker-compose -f docker-compose.dev.yml up -d --build
```

### 4. **Production Setup**
```bash
# Build and start production environment
docker-compose -f docker-compose.prod.yml up --build

# Or run in background
docker-compose -f docker-compose.prod.yml up -d --build
```

## 🔧 **Available Docker Configurations**

### **Development Environment** (`docker-compose.dev.yml`)
- **Django Debug Mode**: Enabled
- **Auto-reload**: Code changes reflected immediately
- **Database**: PostgreSQL container
- **Cache**: Redis container
- **Port**: 8000
- **Volume Mounting**: Live code editing

### **Production Environment** (`docker-compose.prod.yml`)
- **Django Debug Mode**: Disabled
- **Web Server**: Gunicorn with 3 workers
- **Reverse Proxy**: Nginx for static files and load balancing
- **Database**: PostgreSQL with persistent volumes
- **Cache**: Redis with data persistence
- **Ports**: 80 (HTTP), 443 (HTTPS ready)
- **Security**: Production-ready settings

## 📦 **Services Overview**

### **Database (PostgreSQL)**
- **Image**: `postgres:15-alpine`
- **Port**: 5432
- **Database**: `hydroreach_db`
- **Username**: `hydroreach_user`
- **Password**: `hydroreach_password`

### **Cache (Redis)**
- **Image**: `redis:7-alpine`
- **Port**: 6379
- **Usage**: Session storage and caching

### **Web Application (Django)**
- **Framework**: Django 4.2.7
- **WSGI Server**: Gunicorn (production)
- **Development Server**: Django runserver (development)
- **Port**: 8000

### **Reverse Proxy (Nginx)** - Production Only
- **Image**: `nginx:alpine`
- **Ports**: 80, 443
- **Features**: Static file serving, load balancing, SSL ready

## 🛠 **Management Commands**

### **Create Sample Data**
```bash
# Create sample users, requests, and tankers
docker-compose exec web python manage.py create_sample_data

# Create specific number of users and requests
docker-compose exec web python manage.py create_sample_data --users 20 --requests 50
```

### **Database Operations**
```bash
# Run migrations
docker-compose exec web python manage.py migrate

# Create superuser
docker-compose exec web python manage.py createsuperuser

# Collect static files
docker-compose exec web python manage.py collectstatic
```

### **Container Management**
```bash
# View logs
docker-compose logs web
docker-compose logs db
docker-compose logs redis

# Access container shell
docker-compose exec web bash
docker-compose exec db psql -U hydroreach_user -d hydroreach_db

# Stop services
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

## 🔐 **Default Login Credentials**

After running the sample data command:

### **Admin Access**
- **Username**: `admin`
- **Password**: `admin123`
- **URL**: `http://localhost:8000/admin/`

### **Driver Accounts**
- **Usernames**: `driver1`, `driver2`, `driver3`, `driver4`
- **Password**: `driver123`
- **Dashboard**: `http://localhost:8000/driver/dashboard/`

### **Community Users**
- **Usernames**: `user1` to `user10`
- **Password**: `user123`
- **Dashboard**: `http://localhost:8000/user/dashboard/`

## 🌐 **Application URLs**

### **Main Application**
- **Homepage**: `http://localhost:8000/`
- **User Login**: `http://localhost:8000/user/login/`
- **User Signup**: `http://localhost:8000/user/signup/`
- **Admin Dashboard**: `http://localhost:8000/core/admin-dashboard/`

### **Health Checks**
- **Health Check**: `http://localhost:8000/core/health/`
- **Test Connection**: `http://localhost:8000/core/test/`

## 📊 **Key Features Available**

### **For Community Users**
- ✅ Water request submission with priority levels
- ✅ Real-time delivery tracking
- ✅ Payment processing
- ✅ Request history and status monitoring
- ✅ Professional dashboard with statistics

### **For Drivers**
- ✅ Delivery assignment management
- ✅ Status update system (Start → On the Way → Delivered)
- ✅ Delivery history tracking
- ✅ Professional driver dashboard
- ✅ Real-time order management

### **For Administrators**
- ✅ Complete request lifecycle management
- ✅ Fleet and tanker management
- ✅ Stock level monitoring with alerts
- ✅ Payment verification system
- ✅ Delivery tracking administration
- ✅ Comprehensive analytics dashboard

## 🔧 **Environment Variables**

Key environment variables in `.env`:

```bash
# Django Settings
DEBUG=1
SECRET_KEY=your-secret-key-here
ALLOWED_HOSTS=localhost,127.0.0.1,0.0.0.0

# Database
DATABASE_URL=postgresql://hydroreach_user:hydroreach_password@db:5432/hydroreach_db

# Redis
REDIS_URL=redis://redis:6379/0

# Security (Production)
SECURE_SSL_REDIRECT=False
SECURE_HSTS_SECONDS=0
```

## 🚨 **Troubleshooting**

### **Common Issues**

1. **Port Already in Use**
   ```bash
   # Change ports in docker-compose.yml
   ports:
     - "8001:8000"  # Change from 8000 to 8001
   ```

2. **Database Connection Issues**
   ```bash
   # Check database status
   docker-compose logs db
   
   # Restart database
   docker-compose restart db
   ```

3. **Permission Issues**
   ```bash
   # Fix file permissions
   chmod +x docker-entrypoint.sh
   ```

4. **Static Files Not Loading**
   ```bash
   # Collect static files
   docker-compose exec web python manage.py collectstatic --noinput
   ```

### **Reset Everything**
```bash
# Stop all containers and remove volumes
docker-compose down -v

# Remove all images
docker-compose down --rmi all

# Rebuild from scratch
docker-compose up --build
```

## 📈 **Performance Optimization**

### **Production Recommendations**
- Use environment-specific settings
- Configure proper logging
- Set up SSL certificates
- Use external database for scaling
- Configure Redis persistence
- Set up monitoring and alerts

### **Development Tips**
- Use volume mounts for live editing
- Enable Django debug toolbar
- Use development-specific settings
- Keep containers lightweight

## 🔄 **Updates and Maintenance**

### **Updating the Application**
```bash
# Pull latest changes
git pull origin main

# Rebuild containers
docker-compose up --build

# Run any new migrations
docker-compose exec web python manage.py migrate
```

### **Backup and Restore**
```bash
# Backup database
docker-compose exec db pg_dump -U hydroreach_user hydroreach_db > backup.sql

# Restore database
docker-compose exec -T db psql -U hydroreach_user hydroreach_db < backup.sql
```

## 🎯 **Next Steps**

1. **Customize Environment**: Update `.env` with your specific settings
2. **Add Sample Data**: Run the sample data command to populate the system
3. **Explore Features**: Test all user roles and functionalities
4. **Configure Production**: Set up SSL, domain, and production settings
5. **Monitor Performance**: Set up logging and monitoring tools

---

**🌊 HydroReach - Smart Water Delivery System**  
*Professional water distribution management with modern Docker deployment*
