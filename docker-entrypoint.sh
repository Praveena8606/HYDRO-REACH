#!/bin/bash

# Exit on any error
set -e

echo "Starting HydroReach Docker Container..."

# Wait for database to be ready
echo "Waiting for database..."
while ! nc -z db 5432; do
  sleep 0.1
done
echo "Database started"

# Wait for Redis to be ready
echo "Waiting for Redis..."
while ! nc -z redis 6379; do
  sleep 0.1
done
echo "Redis started"

# Run database migrations
echo "Running database migrations..."
python manage.py migrate --noinput

# Create superuser if it doesn't exist
echo "Creating superuser if needed..."
python manage.py shell << EOF
from django.contrib.auth.models import User
from user.models import UserProfile

# Create superuser
if not User.objects.filter(username='admin').exists():
    user = User.objects.create_superuser('admin', 'admin@hydroreach.com', 'admin123')
    UserProfile.objects.create(
        user=user,
        full_name='HydroReach Admin',
        user_type='admin',
        phone='1234567890'
    )
    print('Superuser created: admin/admin123')
else:
    print('Superuser already exists')
EOF

# Collect static files
echo "Collecting static files..."
python manage.py collectstatic --noinput --clear

# Load initial data if needed
echo "Loading initial data..."
python manage.py shell << EOF
from core.models import WaterStock, Tanker
from django.contrib.auth.models import User

# Create initial water stock locations
if not WaterStock.objects.exists():
    WaterStock.objects.create(
        location='Central Reservoir',
        current_stock=50000,
        max_capacity=100000
    )
    WaterStock.objects.create(
        location='North Station',
        current_stock=25000,
        max_capacity=50000
    )
    print('Initial water stock created')

# Create sample tankers
if not Tanker.objects.exists():
    Tanker.objects.create(
        tanker_number='TK001',
        capacity=5000,
        status='available'
    )
    Tanker.objects.create(
        tanker_number='TK002',
        capacity=3000,
        status='available'
    )
    print('Sample tankers created')
EOF

echo "Initialization complete!"

# Execute the main command
exec "$@"
