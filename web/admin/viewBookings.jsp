<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String adminName = (String) session.getAttribute("userName");
    if (adminName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Bookings - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
        }

        /* Top Navbar */
        .topbar {
            background: linear-gradient(to right, #1e90ff, #3742fa);
            color: white;
            padding: 15px 30px;
            font-size: 20px;
            font-weight: bold;
        }

        /* Layout */
        .container {
            display: flex;
            height: calc(100vh - 60px); /* Full height minus topbar */
        }

        /* Sidebar */
        .sidebar {
            width: 220px;
            background-color:blue;
            border-right: 1px solid #ddd;
            padding-top: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.05);
        }

        .sidebar a {
          color: white;
            text-decoration: none;
            padding: 14px 20px;
            font-size: 16px;
            display: flex;
            align-items: center;
            gap: 10px;
            border-left: 4px solid transparent;
            transition: background-color 0.3s, border-color 0.3s;
  
        }

        .sidebar a:hover {
           background-color: #1e90ff;
            border-left: 4px solid white;
        }

        /* Main Content */
        .main {
            flex-grow: 1;
            padding: 30px;
        }

        .loggedin {
            font-size: 14px;
            margin-bottom: 20px;
            color: #555;
        }

        table {
            width: 100%;
            background-color: white;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #2f44fd;
            color: white;
            text-align: left;
        }

        tr:hover {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>

<!-- Top Navbar -->
<div class="topbar">
    <i class="fa fa-user-shield"></i> Admin Panel
</div>

<!-- Sidebar + Main -->
<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <a href="adminDashboard.jsp"><i class="fa fa-home"></i> Dashboard</a>
        <a href="viewUsers.jsp"><i class="fa fa-users"></i> View Users</a>
        <a href="viewBookings.jsp"><i class="fa fa-calendar-check"></i> View Bookings</a>
        <a href="manageSlots.jsp"><i class="fa fa-sliders"></i> Manage Slots</a>
        <a href="adminProfile.jsp"><i class="fa fa-user"></i> Profile</a>
        <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>

    <!-- Main Content -->
    <div class="main">
        <div class="loggedin">Logged in as: <strong><%= adminName %></strong></div>
        <h3><i class="fa fa-calendar-day"></i> Upcoming Bookings</h3>

        <%
            String url = "jdbc:mysql://localhost/carparkingdb?useSSL=false&allowPublicKeyRetrieval=true";
            String dbUser = "root";
            String dbPass = "Root";

            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, dbUser, dbPass);

                String sql = "SELECT id, user_email, booking_date, time_slot, slot_number, location " +
                             "FROM bookings WHERE booking_date >= CURDATE() " +
                             "ORDER BY booking_date DESC, time_slot ASC";
                pst = conn.prepareStatement(sql);
                rs = pst.executeQuery();
        %>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>User Email</th>
                    <th>Booking Date</th>
                    <th>Time Slot</th>
                    <th>Slot Number</th>
                    <th>Location</th>
                </tr>
            </thead>
            <tbody>
            <%
                while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("user_email") %></td>
                    <td><%= rs.getDate("booking_date") %></td>
                    <td><%= rs.getString("time_slot") %></td>
                    <td><%= rs.getInt("slot_number") %></td>
                    <td><%= rs.getString("location") %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <%
            } catch (Exception e) {
        %>
            <p style="color:red;">Error: <%= e.getMessage() %></p>
        <%
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception ignored) {}
                if (pst != null) try { pst.close(); } catch (Exception ignored) {}
                if (conn != null) try { conn.close(); } catch (Exception ignored) {}
            }
        %>
    </div>
</div>

</body>
</html>
