<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>User Registration</title>
  <link rel="stylesheet" type="text/css" href="styles.css">

  <!-- SweetAlert CDN -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

  <style>
      
      
body {
   background: url('images/carparking6.jpg');
   background-size: cover;
   background-position: center;
   margin: 0;
   padding: 0;
   position: relative;
   font-family: 'Segoe UI', sans-serif;
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

    .error-message.visible {
      display: block;
    }

    .error-icon {
      font-weight: bold;
      margin-right: 2px;
    }

    input:invalid {
      border: 1px solid red;
    }

    .form-row {
      margin-bottom: 12px;
    }

    .login-link {
      margin-top: 10px;
    }
  </style>

  <script>
    function validateForm() {
      let isValid = true;
      document.querySelectorAll(".error-message").forEach(e => e.classList.remove("visible"));

      const name = document.forms["registerForm"]["name"].value.trim();
      const email = document.forms["registerForm"]["email"].value.trim();
      const phone = document.forms["registerForm"]["phone"].value.trim();
      const password = document.forms["registerForm"]["password"].value;
      const confirmPassword = document.forms["registerForm"]["confirmPassword"].value;

      const nameRegex = /^[A-Za-z\s]{4,}$/;
      const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
      const phoneRegex = /^[6-9]\d{9}$/;
      const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$/;

      if (!nameRegex.test(name)) {
        document.getElementById("nameError").classList.add("visible");
        isValid = false;
      }

      if (!emailRegex.test(email)) {
        document.getElementById("emailError").classList.add("visible");
        isValid = false;
      }

      if (!phoneRegex.test(phone)) {
        document.getElementById("phoneError").classList.add("visible");
        isValid = false;
      }

      if (!passwordRegex.test(password)) {
        document.getElementById("passwordError").classList.add("visible");
        isValid = false;
      }

      if (password !== confirmPassword) {
        document.getElementById("confirmPasswordError").classList.add("visible");
        isValid = false;
      }

      return isValid;
    }

    function togglePassword() {
      const password = document.getElementById("password");
      const confirmPassword = document.getElementById("confirmPassword");
      const type = password.type === "password" ? "text" : "password";
      password.type = type;
      confirmPassword.type = type;
    }
  </script>
</head>

<body>
  <!-- Header -->
  <header>
    <div class="title">Car Parking Reservation System</div>
    <nav class="nav-links">
      <a href="index.html">Home</a>
      <a href="register.jsp">Register</a>
      <a href="login.jsp">Login</a>
      <a href="#">Help</a>
    </nav>
  </header>

  <!-- Registration Form -->
  <div class="hero">
    <h2>User Registration</h2>
    <form name="registerForm" action="registerServlet" method="post" onsubmit="return validateForm()">

      <!-- Name -->
      <div class="form-row">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" placeholder="Enter Username" required maxlength="30" />
        <div class="error-message" id="nameError">
          <span class="error-icon">⚠️</span> Name must be at least 4 characters and only letters.
        </div>
      </div>

      <!-- Email -->
      <div class="form-row">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" placeholder="Enter Email" required maxlength="40" />
        <div class="error-message" id="emailError">
          <span class="error-icon">⚠️</span> Enter a valid email address.
        </div>
      </div>

      <!-- Phone -->
      <div class="form-row">
        <label for="phone">Phone Number:</label>
        <input type="text" id="phone" name="phone" placeholder="Enter Phone Number" required pattern="\d{10}" maxlength="10" />
        <div class="error-message" id="phoneError">
          <span class="error-icon">⚠️</span> Phone must be 10 digits and start with 6–9.
        </div>
      </div>

      <!-- Password -->
      <div class="form-row">
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" placeholder="Password" required />
        <div class="error-message" id="passwordError">
          <span class="error-icon">⚠️</span> Must be 8+ characters, with upper, lower, number & special.
        </div>
      </div>

      <!-- Confirm Password -->
      <div class="form-row">
        <label for="confirmPassword">Re-enter Password:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required />
        <div class="error-message" id="confirmPasswordError">
          <span class="error-icon">⚠️</span> Passwords do not match.
        </div>
      </div>

      <!-- Show Password -->
      <div class="form-row">
        <label><input type="checkbox" onclick="togglePassword()"> Show Password</label>
      </div>

      <!-- Submit Button -->
      <input type="submit" value="Register" />

      <!-- Login Redirect -->
      <div class="login-link">
        <a href="login.jsp">Already have an account? Login here</a>
      </div>

    </form>
  </div>

  <!-- SweetAlert Logic -->
  <script>
    const urlParams = new URLSearchParams(window.location.search);
    
    if (urlParams.get('status') === 'error') {
      Swal.fire({
        icon: 'error',
        title: 'Registration Failed',
        text: 'Something went wrong. Please try again.',
        confirmButtonColor: '#d33'
      });
    } else if (urlParams.get('status') === 'success') {
      Swal.fire({
        icon: 'success',
        title: 'Registration Successful',
        text: 'You can now log in to your account.',
        confirmButtonColor: '#3085d6',
        confirmButtonText: 'Go to Login'
      }).then((result) => {
        if (result.isConfirmed) {
          window.location.href = 'login.jsp';
        }
      });
    }
  </script>
</body>
</html>
