CREATE DATABASE IF NOT EXISTS carparkingdb;
USE carparkingdb;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(15) NOT NULL,
  password VARCHAR(100) NOT NULL,
  role VARCHAR(20) NOT NULL  -- e.g., 'admin' or 'user'
);

INSERT INTO users (name, email, phone, password, role)
VALUES ('Admin', 'admin@example.com', '9999999999', 'admin123', 'admin');

CREATE TABLE bookings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_email VARCHAR(100),
  booking_date DATE,
  time_slot VARCHAR(50),
  slot_number INT,
  location VARCHAR(100),
  UNIQUE (booking_date, time_slot, slot_number, location)
);


