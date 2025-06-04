<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login Page</title>
  <link rel="stylesheet" type="text/css" href="styles.css">
  <script>
  function togglePassword() {
    const passwordField = document.getElementById("password");
    passwordField.type = passwordField.type === "password" ? "text" : "password";
  }
</script>

  <style>
     

body {
   background: url('images/carparking6.jpg');
   background-size: cover;
   background-position: center;
   margin: 0;
   padding: 0;
   position: relative;
   font-family: 'Segoe UI', sans-serif;   
   box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3); /* Subtle shadow for depth */
   overflow: hidden;
}

/* Add blur effect on top of the body background */
body::before {
    content: '';
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: inherit; /* Use same background as body */
    filter: blur(8px);
    z-index: -1;
}

/* Optional: Add dark overlay for extra clarity */
body::after {
    content: '';
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    
    background-color: rgba(0,0,0,0.3); /* semi-dark overlay */
    z-index: -1;
}

@media (min-aspect-ratio: 1000/780) {
    body {
        background-size: auto 100vh;
    }
}

@media (max-aspect-ratio: 1000/780) {
    body {
        background-size: 100vw auto;
    }
}

    .error-message {
      margin-left: 0px;
      margin-top: 2px;
      color: red;
      font-size: 0.85em;
      display: none;
    }
    body { font-family: Arial; background-color: #f5f5f5; }
    .login-container {
      width: 600px;
      margin: 150px auto;
      background-color: #fff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.2);
    }
    .login-container h2 {
        text-align: center;
      margin-bottom: 20px;
      font-size: 30px;
      color: #333;
    }
    
    input[type="text"], input[type="password"] {
      width: 100%;
      padding: 12px;
        font-size: 1rem;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    input[type="submit"] {
      width: 100%;
      height: 50px;
      padding: 8px;
      background-color: #f1c40f;
      color: #000;
      border: none;
      font-size: 1.2rem;
      border-radius: 5px;
      transition: background-color 0.3s ease;
      font-weight: 700;
      cursor: pointer;
        margin-top: 10px;

    }
    input[type="submit"]:hover {
      background-color: #d4af37;
    }
    .error {
      color: red;
      text-align: center;
    }
    
    

  </style>
</head>
<body>
     <header>
    <div class="title">Car Parking Reservation System</div>
    <nav class="nav-links">
      <a href="index.html">Home</a>
      <a href="register.jsp">Register</a>
      <a href="login.jsp">Login</a>
      <a href="#">Help</a>
    </nav>
  </header>

<div class="login-container">
  <h2>Login</h2>
  <form action="loginServlet" method="post">
    <input type="text" name="email" placeholder="Email or Username" required>
<input type="password" id="password" name="password" placeholder="Password" required>
<label>
  <input type="checkbox" onclick="togglePassword()"> Show Password
</label>
    <input type="submit" value="Login">
    
<div class="login-link">
    <a href="register.jsp">Don't have an account? Register here</a>
</div>
  </form>
  <% if (request.getAttribute("errorMessage") != null) { %>
    <p class="error"><%= request.getAttribute("errorMessage") %></p>
  <% } %>
</div>e

</body>
</html>
