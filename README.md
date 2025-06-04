 🚗 Car Parking Reservation System

📋 Project Overview
This is a web-based **Car Parking Reservation System** built using JSP, Servlets, MySQL, and deployed on GlassFish server. The system allows users to book parking slots, view their bookings, and manage profiles. Admins and users have separate panels with respective functionalities.

⭐ Key Features
 -> 🚗 Car Parking Slot Booking
Users can book parking slots easily via the user-friendly booking page.

 -> 🔐 Role-Based Authentication
Separate login for Admin and Users ensuring secure access and permissions.

 -> 🛠️ Admin Management Panel
Admin can manage all bookings, view reports, and control system settings.

 -> 📅 Booking Overview Pages
Includes Dashboard, Today’s Bookings, All Bookings, and Profile sections for users.
 
 -> 🎨 Responsive UI with JSP, HTML, and CSS.


📁 Project Structure
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


🗄️ Database Setup
To run this project locally, follow these steps to set up the database:

1. **Create the database:**

   Open MySQL client (phpMyAdmin, MySQL Workbench, or terminal) and create a new database named:

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

   In your Java files (for example, `DBConnection.java` or any config files), update the database URL, username, and password to match your local MySQL setup.

---

🚀 How to Run

1. Import the project into your IDE (NetBeans, Eclipse, etc.).

2. Ensure you have GlassFish server configured.

3. Build and deploy the project on GlassFish server.

4. Open your browser and navigate to:

   ```
   http://localhost:8080/CarParkingSystem
   ```

5. Use the login page to access the system with appropriate credentials.

📦 Dependencies

- ☕ Java JDK 8+
- 🐬 GlassFish Server 4.x or above
- 🐬 MySQL Server 5.x or above
- 🔌 MySQL Connector/J JDBC Driver
- 🖥️ IDE: NetBeans or Eclipse (recommended)


📞 Contact

For any issues or questions, please contact **Lalit Patel** at:  
📧 lalitpatel062002@gmail.com
📞 6260306620

