<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.invalidate();
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Logout</title>
     <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
            color: #27ae60;
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
        setTimeout(function() {
            window.location.href = '<%= contextPath %>/login.jsp';
        }, 3000);
    </script>
</head>
<body>
<div>
    <h2>Logged Out Successfully</h2>
    <p>You have been logged out. Redirecting to login page...</p>
    <p>If not redirected, <a href="<%= contextPath %>/login.jsp">click here</a>.</p>
</div>
</body>
</html>
