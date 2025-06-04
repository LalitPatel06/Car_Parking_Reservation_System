
# 🚗 Car Parking Reservation System

## 📋 Project Overview
This is a web-based **Car Parking Reservation System** built using JSP, Servlets, MySQL, and deployed on GlassFish server. The system allows users to book parking slots, view their bookings, and manage profiles. Admins and users have separate panels with respective functionalities.

---

## ⭐ Key Features
- 🚗 **Car Parking Slot Booking**: Users can book parking slots easily via the user-friendly booking page.
- 🔐 **Role-Based Authentication**: Separate login for Admin and Users ensuring secure access and permissions.
- 🛠️ **Admin Management Panel**: Admin can manage all bookings, view reports, and control system settings.
- 📅 **Booking Overview Pages**: Includes Dashboard, Today’s Bookings, All Bookings, and Profile sections for users.
- 🎨 **Responsive UI**: Designed with JSP, HTML, and CSS.

---

## 🛠️ Tech Stack

- **Frontend**: HTML, CSS
- **Backend**: Java, Servlets, JSP
- **Database**: MySQL (with JDBC for connectivity)
- **IDE**: NetBeans
- **Version Control**: Git & GitHub![Screenshot 2025-06-04 233659](https://github.com/user-attachments/assets/8c21c99c-a18e-45b8-b082-95ed51caa3d5)


---
## 📸 Screenshots

###  Home Page
![Home Page](https://github.com/LalitPatel06/Car_Parking_Reservation_System/blob/607ca9159cabd160b1cd131b99f73e97c7256c87/Screenshot%202025-06-04%20233638.png)

### Registration Page
![Registration Page](https://github.com/user-attachments/assets/8c21c99c-a18e-45b8-b082-95ed51caa3d5)

### 🔐 Login Page
![Login Page](https://github.com/user-attachments/assets/382853b2-6861-46ac-badb-07bdff7f0b22)

### 📅 User Booking Page
![User Booking](https://github.com/user-attachments/assets/2caa9f34-0f9e-4463-9159-c91a936783a1)

### Booking Slots Page
![Booking Slots](https://github.com/user-attachments/assets/a9d9e611-5e0f-481e-85bf770e1a7f6b30)

### Today Booking Page
![Today Booking](https://github.com/user-attachments/assets/be8ec704-bad9-422c-976500d2b5511b16)


### 📊 Booking History and Edit Profile Page
![Booking History and Edit Profile](https://github.com/user-attachments/assets/52efa337-f0eb-4b9d-b96d-f8cb9c8376c3)

### 🏠 Admin Dashboard
![Admin Dashboard](https://github.com/user-attachments/assets/9b108d78-fee4-430b-84c0-6db90883e3ad)

### View Users Page and View Booking Page
![View Users and View Booking](https://github.com/user-attachments/assets/1c73acde-0a99-46c9-8712-46a52e5aeadc)



## 📁 Project Structure

```
CarParkingSystem/
│
├── 🗄️ car_parking.sql                # Database export file
├── 🌐 Web Pages/
│   ├── 🔒 WEB-INF/
│   │   └── web.xml                  # Web deployment descriptor
│   ├── 👤 admin/                   # Admin related JSP, HTML files
│   ├── 👥 user/                    # User related JSP, HTML, CSS, images
│   │   ├── 🖼️ images/              # Images folder
│   │   └── ...                    # Other user files (JSP, HTML, CSS)
│   └── ...                       
├── 📂 Source Packages/
│   └── (default package)           # Java servlet source files
├── 📚 Libraries/
│   ├── 🔌 mysql-connector.jar      # MySQL Connector/J library
│   └── ...                        # Other libraries like JDK, GlassFish server
└── 📄 README.md                   # This README file
```

---

## 🗄️ Database Setup

To run this project locally, follow these steps to set up the database:

1. **Create the database:**

```sql
CREATE DATABASE car_parking;
```

2. **Import the database schema and data:**

Import the provided `car_parking.sql` file included in this project.

- Using phpMyAdmin:  
  - Select the `car_parking` database  
  - Click on **Import**  
  - Choose the `car_parking.sql` file  
  - Click **Go**

- Using command line:

```bash
mysql -u your_username -p car_parking < car_parking.sql
```

3. **Update database connection details:**

In your Java files (e.g., `DBConnection.java`), update the database URL, username, and password to match your local MySQL setup.

---

## 🚀 How to Run

1. Import the project into your IDE (NetBeans, Eclipse, etc.).
2. Ensure you have GlassFish server configured.
3. Build and deploy the project on GlassFish server.
4. Open your browser and navigate to:

```
http://localhost:8080/CarParkingSystem
```

5. Use the login page to access the system with appropriate credentials.

---

## 📦 Dependencies

- ☕ Java JDK 8+
- 🐬 GlassFish Server 4.x or above
- 🐬 MySQL Server 5.x or above
- 🔌 MySQL Connector/J JDBC Driver
- 🖥️ IDE: NetBeans or Eclipse (recommended)

---

## 📞 Contact

For any issues or questions, please contact **Lalit Patel** at:  
📧 lalitpatel062002@gmail.com  
📞 6260306620
