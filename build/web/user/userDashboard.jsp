<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userName = (String) session.getAttribute("userName");
    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Dashboard</title>
  <script src="https://unpkg.com/lucide@latest"></script>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 h-screen flex font-sans">

  <!-- Sidebar -->
  <aside class="w-64 bg-white shadow-lg p-6 flex flex-col space-y-6">
    <h2 class="text-2xl font-bold text-gray-800 mb-4">User Panel</h2>
    <nav class="flex flex-col space-y-4 text-gray-700">
      <a href="bookSlot.jsp" class="flex items-center space-x-3 hover:text-blue-600">
        <i data-lucide="parking-circle"></i><span>Book Slot</span>
      </a>
      <a href="viewTodayBooking.jsp" class="flex items-center space-x-3 hover:text-blue-600">
        <i data-lucide="calendar-days"></i><span>Today's Bookings</span>
      </a>
      <a href="viewBookingHistory.jsp" class="flex items-center space-x-3 hover:text-blue-600">
        <i data-lucide="history"></i><span>All Booking</span>
      </a>
      <a href="editProfile.jsp" class="flex items-center space-x-3 hover:text-blue-600">
        <i data-lucide="user"></i><span>My Profile</span>
      </a>
      <a href="logout.jsp" class="flex items-center space-x-3 hover:text-red-600">
        <i data-lucide="log-out"></i><span>Logout</span>
      </a>
    </nav>
  </aside>

  <!-- Main Content -->
  <main class="flex-1 p-10 bg-gray-50 overflow-auto">
    <h1 class="text-4xl font-bold mb-6 text-gray-800">Welcome, <%= userName %> !</h1>

    <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
      <a href="bookSlot.jsp" class="bg-blue-100 hover:bg-blue-200 p-6 rounded-lg shadow flex items-center space-x-4 transition">
        <i data-lucide="parking-circle" class="w-8 h-8 text-blue-600"></i>
        <div>
          <h2 class="text-xl font-semibold">Book Parking Slot</h2>
          <p class="text-sm text-gray-600">Reserve a new spot now</p>
        </div>
      </a>

      <a href="viewTodayBooking.jsp" class="bg-green-100 hover:bg-green-200 p-6 rounded-lg shadow flex items-center space-x-4 transition">
        <i data-lucide="calendar-days" class="w-8 h-8 text-green-600"></i>
        <div>
          <h2 class="text-xl font-semibold">Today's Bookings</h2>
          <p class="text-sm text-gray-600">Check your current bookings</p>
        </div>
      </a>

      <a href="viewBookingHistory.jsp" class="bg-yellow-100 hover:bg-yellow-200 p-6 rounded-lg shadow flex items-center space-x-4 transition">
        <i data-lucide="history" class="w-8 h-8 text-yellow-600"></i>
        <div>
          <h2 class="text-xl font-semibold">Booking History</h2>
          <p class="text-sm text-gray-600">Past reservations overview</p>
        </div>
      </a>
    </div>
  </main>

  <script>
    lucide.createIcons();
  </script>
</body>
</html>
