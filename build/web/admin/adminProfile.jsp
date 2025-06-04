<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    String adminEmail = (String) session.getAttribute("userEmail");
    if (adminEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    %>
<!DOCTYPE html>
<html>
<head>
    <title>Change Admin Password</title>
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
     <style>
        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
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
            font-size: 22px;
            font-weight: bold;
            z-index: 1000;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 15px 20px;
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
            max-width: 800px;
        }

        .card {
            background-color: #ffffff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }

        .card h2 {
            margin-bottom: 20px;
            color: #2f3542;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 12px;
            margin-bottom: 6px;
            color: #2f3542;
        }

        input[type="password"], input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        input[type="submit"] {
            background-color: #1e90ff;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #3742fa;
        }

        .message {
            color: red;
            font-weight: bold;
            margin-top: 10px;
        }

        .email-display {
            margin-bottom: 20px;
            font-weight: bold;
            color: #3742fa;
            font-size: 16px;
        }
    </style><!-- SweetAlert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <!-- Top Navbar -->
<div class="navbar">
    <i class="fa fa-user-shield"></i>&nbsp; Admin Panel
</div>

<!-- Left Sidebar -->
<div class="sidebar">
        <a href="adminDashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
    <a href="viewUsers.jsp"><i class="fa fa-users"></i> View Users</a>
    <a href="viewBookings.jsp"><i class="fa fa-calendar-check"></i> View Bookings</a>
    <a href="manageSlots.jsp"><i class="fa fa-car"></i> Manage Slots</a>
    <a href="adminProfile.jsp"><i class="fa fa-user-circle"></i> Profile</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- Main Content -->
<div class="content">
    <div class="card">
        <div class="email-display">
            Logged in as: <%= adminEmail %>
        </div>

    <div class="form-container">
        <h2>Change Admin Password</h2>
        <form method="post" action="<%=request.getContextPath()%>/ChangeAdminPasswordServlet">
            <label>Old Password:</label>
            <input type="password" name="oldPassword" required>

            <label>New Password:</label>
            <input type="password" name="newPassword" required>

            <label>Confirm New Password:</label>
            <input type="password" name="confirmPassword" required>

            <input type="submit" value="Change Password">
        </form>
    </div>

    <%
        String message = request.getParameter("message");
        if (message != null) {
    %>
    <script>
        <% if ("success".equals(message)) { %>
            Swal.fire("Success", "Password changed successfully!", "success");
        <% } else if ("fail".equals(message)) { %>
            Swal.fire("Error", "Failed to change password.", "error");
        <% } else if ("wrong_old".equals(message)) { %>
            Swal.fire("Error", "Old password is incorrect.", "error");
        <% } else if ("not_matched".equals(message)) { %>
            Swal.fire("Error", "New and Confirm password do not match.", "error");
        <% } %>
            
            
    // Remove query parameters after SweetAlert is shown
    if (window.location.search.includes("message=")) {
        window.history.replaceState({}, document.title, window.location.pathname);
    }


    </script>
    <%
        }
    %>
</body>
</html>
