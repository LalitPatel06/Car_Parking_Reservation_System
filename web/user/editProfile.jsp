<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String successFlag = request.getParameter("success");
    String errorFlag   = request.getParameter("error");

    String fullName = "";
    String phone    = "";
    boolean isPost  = "POST".equalsIgnoreCase(request.getMethod());

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/carparkingdb?useSSL=false&allowPublicKeyRetrieval=true",
            "root", "Root"
        );

        if (isPost) {
            String newName = request.getParameter("userName");
            String newPhone = request.getParameter("phone");
            String newPassword = request.getParameter("newPassword");

            if (newPassword != null && !newPassword.trim().isEmpty()) {
                ps = conn.prepareStatement("UPDATE users SET name = ?, phone = ?, password = ? WHERE email = ?");
                ps.setString(1, newName);
                ps.setString(2, newPhone);
                ps.setString(3, newPassword);
                ps.setString(4, userEmail);
            } else {
                ps = conn.prepareStatement("UPDATE users SET name = ?, phone = ? WHERE email = ?");
                ps.setString(1, newName);
                ps.setString(2, newPhone);
                ps.setString(3, userEmail);
            }

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("editProfile.jsp?success=1");
                return;
            } else {
                response.sendRedirect("editProfile.jsp?error=1");
                return;
            }
        }

        ps = conn.prepareStatement("SELECT name, phone FROM users WHERE email = ?");
        ps.setString(1, userEmail);
        rs = ps.executeQuery();
        if (rs.next()) {
            fullName = rs.getString("name");
            phone = rs.getString("phone");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>

    <!-- Font Awesome & SweetAlert2 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
        }
        .topbar {
            background: linear-gradient(to right, #1e90ff, #3742fa);
            color: white;
            padding: 15px 30px;
            font-size: 20px;
            font-weight: bold;
        }
        .container {
            display: flex;
            height: calc(100vh - 60px);
        }
        .sidebar {
            width: 220px;
            background-color: blue;
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
        .main {
            flex-grow: 1;
            padding: 30px;
        }
        .main h2 {
            margin-bottom: 20px;
        }
        form {
            background-color: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            max-width: 500px;
        }
        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn-submit {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #2f44fd;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-submit:hover {
            background-color: #1e30d9;
        }
    </style>
</head>
<body>

<div class="topbar">
    <i class="fa fa-user"></i> User Dashboard
</div>

<div class="container">
    <div class="sidebar">
        <a href="userDashboard.jsp"><i class="fa fa-home"></i> Dashboard</a>
       <a href="bookSlot.jsp"><i class="fas fa-calendar-plus"></i> BookSlot</a>
        <a href="viewTodayBooking.jsp"><i class="fa fa-calendar-day"></i> Today's Bookings</a>
        <a href="viewBookingHistory.jsp"><i class="fa fa-calendar-alt"></i> All Bookings</a>
        <a href="editProfile.jsp"><i class="fa fa-user"></i> Profile</a>
        <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>

    <div class="main">
        <h2><i class="fa fa-user-edit"></i> Edit Profile</h2>

        <form method="post" id="editProfileForm">
            <label for="userName">Full Name:</label>
            <input type="text" id="userName" name="userName" value="<%= fullName %>" required>

            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" value="<%= phone %>" required>

            <label for="newPassword">New Password (leave blank to keep current):</label>
            <input type="password" id="newPassword" name="newPassword">

            <button type="submit" class="btn-submit">Update Profile</button>
        </form>
    </div>
</div>

<!-- SweetAlert for Success/Error -->
<script>
    const urlParams = new URLSearchParams(window.location.search);
    const success = urlParams.get("success");
    const error = urlParams.get("error");

    if (success === "1") {
        Swal.fire({
            icon: 'success',
            title: 'Profile Updated',
            text: 'Your profile was updated successfully!',
            confirmButtonColor: '#3085d6'
        });
    } else if (error === "1") {
        Swal.fire({
            icon: 'error',
            title: 'Update Failed',
            text: 'Something went wrong. Please try again.',
            confirmButtonColor: '#d33'
        });
    }

    // Form Validation
    document.getElementById('editProfileForm').addEventListener('submit', function(event) {
        const name = document.getElementById('userName').value.trim();
        const phone = document.getElementById('phone').value.trim();
        const password = document.getElementById('newPassword').value;

        // Name validation
        if (name.length < 4) {
            Swal.fire({
                icon: 'warning',
                title: 'Invalid Name',
                text: 'Full Name must be at least 4 characters long.'
            });
            event.preventDefault();
            return;
        }

        // Phone validation (starts with 6 or 9, 10 digits)
        const phoneRegex = /^[69]\d{9}$/;
        if (!phoneRegex.test(phone)) {
            Swal.fire({
                icon: 'warning',
                title: 'Invalid Phone',
                text: 'Phone number must start with 6 or 9 and be exactly 10 digits.'
            });
            event.preventDefault();
            return;
        }

        // Password validation (if entered)
        if (password.trim().length > 0) {
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}$/;
            if (!passwordRegex.test(password)) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Invalid Password',
                    html: 'Password must contain:<br>- At least 1 uppercase letter<br>- At least 1 lowercase letter<br>- At least 1 digit<br>- At least 1 special character<br>- Minimum 8 characters'
                });
                event.preventDefault();
                return;
            }
        }
    });
</script>

</body>
</html>
