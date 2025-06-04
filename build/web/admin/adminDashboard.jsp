<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Dashboard</title>
  <script src="https://unpkg.com/lucide@latest"></script>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 h-screen flex font-sans">

  <!-- Sidebar -->
  <aside class="w-64 bg-white shadow-lg p-6 flex flex-col space-y-6">
    <h2 class="text-2xl font-bold text-gray-800 mb-4">Admin Panel</h2>
    <nav class="flex flex-col space-y-4 text-gray-700">

      <a href="adminDashboard.jsp" class="flex items-center space-x-3 hover:text-blue-600">
        <i data-lucide="layout-dashboard"></i><span>Dashboard</span>
      </a>
      <a href="viewUsers.jsp" class="flex items-center space-x-3 hover:text-blue-600">
        <i data-lucide="users"></i><span>View Users</span>
      </a>
      <a href="viewBookings.jsp" class="flex items-center space-x-3 hover:text-blue-600">
        <i data-lucide="calendar-check-2"></i><span>View Bookings</span>
      </a>
      <a href="manageSlots.jsp" class="flex items-center space-x-3 hover:text-blue-600">
        <i data-lucide="clock"></i><span>Manage Slots</span>
      </a>
      <a href="adminProfile.jsp" class="flex items-center space-x-3 hover:text-blue-600">
        <i data-lucide="user-circle"></i><span>Profile</span>
      </a>
      <a href="logout.jsp" class="flex items-center space-x-3 hover:text-red-600">
        <i data-lucide="log-out"></i><span>Logout</span>
      </a>
    </nav>
  </aside>

  <!-- Main Content -->
  <main class="flex-1 p-10 bg-gray-50 overflow-auto">
    <h1 class="text-4xl font-bold mb-6 text-gray-800">Welcome, Admin!</h1>

    <!-- Quick Actions -->
    <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6 mb-10">
      <a href="viewUsers.jsp" class="bg-blue-100 hover:bg-blue-200 p-6 rounded-lg shadow flex items-center space-x-4 transition">
        <i data-lucide="users" class="w-8 h-8 text-blue-600"></i>
        <div>
          <h2 class="text-xl font-semibold">Manage Users</h2>
          <p class="text-sm text-gray-600">View, edit, or delete user accounts</p>
        </div>
      </a>

      <a href="viewBookings.jsp" class="bg-green-100 hover:bg-green-200 p-6 rounded-lg shadow flex items-center space-x-4 transition">
        <i data-lucide="calendar-check-2" class="w-8 h-8 text-green-600"></i>
        <div>
          <h2 class="text-xl font-semibold">Check Bookings</h2>
          <p class="text-sm text-gray-600">Monitor or cancel bookings</p>
        </div>
      </a>

      <a href="manageSlots.jsp" class="bg-purple-100 hover:bg-purple-200 p-6 rounded-lg shadow flex items-center space-x-4 transition">
        <i data-lucide="clock" class="w-8 h-8 text-purple-600"></i>
        <div>
          <h2 class="text-xl font-semibold">Slot Management</h2>
          <p class="text-sm text-gray-600">Create or remove available slots</p>
        </div>
      </a>
    </div>

    <!-- Stats Panels (Optional static content for now) -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <div class="bg-white rounded-lg p-5 shadow">
        <h3 class="text-sm text-gray-600 mb-2">System Status</h3>
        <p class="text-lg font-semibold text-gray-800">Running Smoothly</p>
      </div>
      <div class="bg-white rounded-lg p-5 shadow">
        <h3 class="text-sm text-gray-600 mb-2">Pending Actions</h3>
        <p class="text-lg font-semibold text-yellow-600">3 Tasks</p>
      </div>
      <div class="bg-white rounded-lg p-5 shadow">
        <h3 class="text-sm text-gray-600 mb-2">Last Login</h3>
        <p class="text-lg font-semibold text-gray-800">Today, 10:12 AM</p>
      </div>
    </div>

  </main>

  <script>
    lucide.createIcons();
  </script>
</body>
</html>
