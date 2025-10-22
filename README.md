# HydroReach - Smart Water Delivery System

A comprehensive Django-based water management and delivery system that facilitates efficient water distribution through role-based management.

## 🌊 Overview

HydroReach is a complete water delivery management system designed to streamline the process of water request submission, approval, delivery assignment, and tracking. The system serves three main user types: administrators, drivers, and customers.

## ✨ Features

### 🔐 Authentication & User Management
- Role-based authentication (Admin/Driver/User)
- Secure login with username or email
- Profile management with statistics
- Password change functionality

### 👨‍💼 Admin Dashboard
- **Request Management**: Review, approve, and manage water requests
- **Fleet Management**: Add and manage water tankers
- **Driver Assignment**: Assign drivers and tankers to requests
- **Payment Verification**: Verify and track payments
- **Stock Management**: Monitor water inventory levels
- **Analytics**: Real-time dashboard with statistics

### 🚛 Driver Portal
- **Delivery Dashboard**: View assigned deliveries
- **Status Updates**: Update delivery status (start/complete)
- **Order Management**: View all assigned orders
- **Delivery History**: Track completed deliveries
- **Real-time Notifications**: Receive assignment updates

### 👥 Customer Portal
- **Water Requests**: Submit water delivery requests
- **Request Tracking**: Track request status in real-time
- **Payment Management**: View payment history and status
- **Profile Management**: Update personal information
- **Notifications**: Receive delivery updates

## 🛠️ Technology Stack

- **Backend**: Django 4.2.7, Python 3.9
- **Database**: SQLite (development), PostgreSQL ready
- **Frontend**: HTML5, CSS3, Bootstrap 5, JavaScript
- **Icons**: Font Awesome 6.4.0
- **Styling**: Custom CSS with responsive design

## 🚀 Installation & Setup

### Prerequisites
- Python 3.9+
- Django 4.2.7
- Git

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/DualNova-Labs/praveena-water-project.git
   cd praveena-water-project
   ```

2. **Install dependencies**
   ```bash
   pip install django
   ```

3. **Database setup**
   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

4. **Create sample data** (optional)
   ```bash
   python populate_data.py
   ```

5. **Run the server**
   ```bash
   python manage.py runserver
   ```

6. **Access the application**
   - Visit: http://127.0.0.1:8000/

## 👤 Default Login Credentials

### Admin Access
- **Username**: admin
- **Password**: admin123
- **Dashboard**: `/core/admin-dashboard/`

### Driver Access
- **Username**: driver1
- **Password**: driver123
- **Dashboard**: `/driver/dashboard/`

### User Access
- **Username**: user1
- **Password**: user123
- **Dashboard**: `/user/dashboard/`

## 📱 System Architecture

### Apps Structure
- **Core**: Main water management functionality
- **User**: Authentication and user management
- **Driver**: Driver-specific functionalities

### Database Models
- **WaterRequest**: Complete request lifecycle management
- **Tanker**: Fleet management with assignments
- **Payment**: Payment processing and verification
- **Notification**: System-wide notifications
- **UserProfile**: Extended user information

## 🔄 Workflow

1. **Request Submission**: User submits water request
2. **Payment Calculation**: System calculates cost (₹2/liter)
3. **Admin Approval**: Admin reviews and approves request
4. **Payment Verification**: Admin verifies payment
5. **Assignment**: Admin assigns tanker and driver
6. **Delivery**: Driver starts and completes delivery
7. **Notifications**: All parties receive status updates

## 🌟 Key Features

### 💰 Payment System
- Automatic cost calculation
- Multiple payment methods
- Payment verification workflow
- Transaction tracking

### 📊 Management Features
- Real-time inventory tracking
- Fleet status monitoring
- Priority-based request handling
- Comprehensive reporting

### 🔔 Notification System
- Status change notifications
- Role-based alerts
- Real-time updates

## 📁 Project Structure

```
hydroreach/
├── core/                  # Main app
├── user/                  # User management
├── driver/                # Driver functionality
├── templates/             # HTML templates
├── static/               # Static files
├── hydroreach/           # Project settings
├── db.sqlite3           # Database file
└── manage.py            # Django management
```

## 🚀 Deployment

The system is ready for deployment with:
- Environment-based settings
- Static file handling
- Database migrations
- Security configurations

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Developer

Developed by DualNova Labs for efficient water delivery management.

---

**🌊 HydroReach - Bringing Water to Your Doorstep** 🚰
