<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // Invalidate the admin session
    session.invalidate();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Logout</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #333;
        }
        .logout-container {
            text-align: center;
            background: white;
            padding: 40px 60px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 20px;
            color: #c0392b;
        }
        p {
            font-size: 18px;
            margin-bottom: 30px;
        }
        a {
            color: #2980b9;
            text-decoration: none;
            font-weight: 600;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        // Redirect to login page after 3 seconds
        setTimeout(function() {
            window.location.href = '<%= request.getContextPath() %>/login.jsp';
        }, 3000);
    </script>
</head>
<body>

<div class="logout-container">
    <h2>Logged Out Successfully</h2>
    <p>You have been logged out. Redirecting to the login page...</p>
    <p>If you are not redirected automatically, <a href="<%= request.getContextPath() %>/login.jsp">click here</a>.</p>
</div>

</body>
</html>
