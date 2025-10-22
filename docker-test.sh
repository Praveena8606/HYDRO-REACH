#!/bin/bash

echo "🐳 HydroReach Docker Setup Test Script"
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is installed
print_status "Checking Docker installation..."
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker Desktop first."
    exit 1
fi
print_success "Docker is installed"

# Check if Docker Compose is available
print_status "Checking Docker Compose..."
if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Compose is not installed. Please install Docker Compose."
    exit 1
fi
print_success "Docker Compose is available"

# Check if Docker daemon is running
print_status "Checking Docker daemon..."
if ! docker info &> /dev/null; then
    print_error "Docker daemon is not running. Please start Docker Desktop."
    exit 1
fi
print_success "Docker daemon is running"

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    print_status "Creating .env file from template..."
    cp .env.example .env
    print_success ".env file created"
else
    print_success ".env file already exists"
fi

# Build and start the development environment
print_status "Building Docker containers (this may take a few minutes)..."
docker-compose -f docker-compose.dev.yml build

if [ $? -eq 0 ]; then
    print_success "Docker containers built successfully"
else
    print_error "Failed to build Docker containers"
    exit 1
fi

# Start the services
print_status "Starting HydroReach services..."
docker-compose -f docker-compose.dev.yml up -d

if [ $? -eq 0 ]; then
    print_success "Services started successfully"
else
    print_error "Failed to start services"
    exit 1
fi

# Wait for services to be ready
print_status "Waiting for services to be ready..."
sleep 30

# Check if web service is responding
print_status "Testing web service health..."
if curl -f http://localhost:8000/core/health/ &> /dev/null; then
    print_success "Web service is healthy"
else
    print_warning "Web service health check failed, but container might still be starting..."
fi

# Check if we can access the main page
print_status "Testing main application..."
if curl -f http://localhost:8000/ &> /dev/null; then
    print_success "Main application is accessible"
else
    print_warning "Main application might still be loading..."
fi

# Create sample data
print_status "Creating sample data..."
docker-compose -f docker-compose.dev.yml exec -T web python manage.py create_sample_data --users 5 --requests 10

if [ $? -eq 0 ]; then
    print_success "Sample data created successfully"
else
    print_warning "Sample data creation had issues, but application should still work"
fi

# Display service status
print_status "Checking service status..."
docker-compose -f docker-compose.dev.yml ps

echo ""
echo "🎉 HydroReach Docker Setup Complete!"
echo "====================================="
echo ""
echo "📱 Application URLs:"
echo "   • Main App: http://localhost:8000/"
echo "   • Admin Panel: http://localhost:8000/admin/"
echo "   • Health Check: http://localhost:8000/core/health/"
echo ""
echo "🔐 Default Login Credentials:"
echo "   • Admin: admin / admin123"
echo "   • Drivers: driver1-driver4 / driver123"
echo "   • Users: user1-user5 / user123"
echo ""
echo "🛠 Management Commands:"
echo "   • View logs: docker-compose -f docker-compose.dev.yml logs web"
echo "   • Stop services: docker-compose -f docker-compose.dev.yml down"
echo "   • Restart: docker-compose -f docker-compose.dev.yml restart"
echo ""
echo "📚 For more information, see DOCKER_README.md"
echo ""

# Final health check
if curl -f http://localhost:8000/core/health/ &> /dev/null; then
    print_success "✅ HydroReach is ready to use!"
    echo "   Open http://localhost:8000/ in your browser"
else
    print_warning "⚠️  Services are starting but may need a few more minutes"
    echo "   Try accessing http://localhost:8000/ in 2-3 minutes"
fi
