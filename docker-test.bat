@echo off
echo 🐳 HydroReach Docker Setup Test Script
echo ======================================

REM Check if Docker is installed
echo [INFO] Checking Docker installation...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not installed. Please install Docker Desktop first.
    pause
    exit /b 1
)
echo [SUCCESS] Docker is installed

REM Check if Docker Compose is available
echo [INFO] Checking Docker Compose...
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker Compose is not installed. Please install Docker Compose.
    pause
    exit /b 1
)
echo [SUCCESS] Docker Compose is available

REM Check if Docker daemon is running
echo [INFO] Checking Docker daemon...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker daemon is not running. Please start Docker Desktop.
    pause
    exit /b 1
)
echo [SUCCESS] Docker daemon is running

REM Create .env file if it doesn't exist
if not exist .env (
    echo [INFO] Creating .env file from template...
    copy .env.example .env >nul
    echo [SUCCESS] .env file created
) else (
    echo [SUCCESS] .env file already exists
)

REM Build and start the development environment
echo [INFO] Building Docker containers (this may take a few minutes)...
docker-compose -f docker-compose.dev.yml build
if %errorlevel% neq 0 (
    echo [ERROR] Failed to build Docker containers
    pause
    exit /b 1
)
echo [SUCCESS] Docker containers built successfully

REM Start the services
echo [INFO] Starting HydroReach services...
docker-compose -f docker-compose.dev.yml up -d
if %errorlevel% neq 0 (
    echo [ERROR] Failed to start services
    pause
    exit /b 1
)
echo [SUCCESS] Services started successfully

REM Wait for services to be ready
echo [INFO] Waiting for services to be ready...
timeout /t 30 /nobreak >nul

REM Create sample data
echo [INFO] Creating sample data...
docker-compose -f docker-compose.dev.yml exec -T web python manage.py create_sample_data --users 5 --requests 10
if %errorlevel% neq 0 (
    echo [WARNING] Sample data creation had issues, but application should still work
) else (
    echo [SUCCESS] Sample data created successfully
)

REM Display service status
echo [INFO] Checking service status...
docker-compose -f docker-compose.dev.yml ps

echo.
echo 🎉 HydroReach Docker Setup Complete!
echo =====================================
echo.
echo 📱 Application URLs:
echo    • Main App: http://localhost:8000/
echo    • Admin Panel: http://localhost:8000/admin/
echo    • Health Check: http://localhost:8000/core/health/
echo.
echo 🔐 Default Login Credentials:
echo    • Admin: admin / admin123
echo    • Drivers: driver1-driver4 / driver123
echo    • Users: user1-user5 / user123
echo.
echo 🛠 Management Commands:
echo    • View logs: docker-compose -f docker-compose.dev.yml logs web
echo    • Stop services: docker-compose -f docker-compose.dev.yml down
echo    • Restart: docker-compose -f docker-compose.dev.yml restart
echo.
echo 📚 For more information, see DOCKER_README.md
echo.
echo ✅ HydroReach is ready to use!
echo    Open http://localhost:8000/ in your browser
echo.

pause
