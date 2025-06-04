<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    // Ensure the admin is logged in
    String adminName = (String) session.getAttribute("userName");
    if (adminName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>View Users - Admin</title>

    <!-- Font Awesome (Solid icons) -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      crossorigin="anonymous"
    />

    <style>
        body, html {
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 60px;
            background: linear-gradient(to right, #1e90ff, #3742fa);
            color: white;
            display: flex;
            align-items: center;
            padding: 0 20px;
            font-size: 20px;
            font-weight: bold;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }
        .navbar i {
            margin-right: 10px;
        }

        .sidebar {
            position: fixed;
            top: 60px;
            left: 0;
            width: 220px;
            height: calc(100vh - 60px);
            background-color: #3742fa;
            display: flex;
            flex-direction: column;
            padding-top: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
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

        .content {
            margin-top: 60px;
            margin-left: 220px;
            padding: 30px;
            overflow-y: auto;
            width: calc(100% - 220px);
            background-color: #f0f2f5;
        }
        .content .header {
            margin-bottom: 20px;
        }
        .content .header .email-display {
            font-size: 16px;
            color: #3742fa;
            margin-bottom: 12px;
            font-weight: 600;
        }
        .content .header h2 {
            font-size: 24px;
            color: #2f3542;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        .user-table th,
        .user-table td {
            text-align: left;
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            color: #57606f;
        }
        .user-table th {
            background-color: #3742fa;
            color: white;
        }
        .user-table tr:hover {
            background-color: #f5f6fa;
        }
    </style>
</head>

<body>

    <!-- Top Navbar -->
    <div class="navbar">
        <i class="fas fa-user-shield"></i> Admin Panel
    </div>

    <!-- Left Sidebar -->
    <div class="sidebar">
            <a href="adminDashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
        <a href="viewUsers.jsp"><i class="fas fa-users"></i> View Users</a>
        <a href="viewBookings.jsp"><i class="fas fa-calendar-check"></i> View Bookings</a>
        <a href="manageSlots.jsp"><i class="fas fa-car-side"></i> Manage Slots</a>
        <a href="adminProfile.jsp"><i class="fas fa-user-circle"></i> Profile</a>
        <a href="logout.jsp"><i class="fas fa-right-from-bracket"></i> Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div class="header">
            <div class="email-display">
                Logged in as: <%= adminName %>
            </div>
            <h2><i class="fas fa-users"></i> Registered Users</h2>
        </div>

        <%
            String url = "jdbc:mysql://localhost:3306/carparkingdb?useSSL=false&allowPublicKeyRetrieval=true";
            String user = "root";
            String pass = "Root";

            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, pass);

                String sql = "SELECT id, name, email, phone FROM users WHERE role <> 'admin' ORDER BY name ASC";
                pst = conn.prepareStatement(sql);
                rs = pst.executeQuery();
        %>

        <table class="user-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                </tr>
            </thead>
            <tbody>
            <%
                while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("phone") %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <%
            } catch (Exception e) {
        %>
            <p style="color: red; margin-top: 20px;">Error: <%= e.getMessage() %></p>
        <%
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception ignore) {}
                if (pst != null) try { pst.close(); } catch (Exception ignore) {}
                if (conn != null) try { conn.close(); } catch (Exception ignore) {}
            }
        %>
    </div>
</body>
</html>
