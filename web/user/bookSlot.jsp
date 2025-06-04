<%@ page import="java.sql.*" %>
<%
    // 0) Session check
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 1) Read the "check availability" parameters from query string
    String selLocation = request.getParameter("location");
    String selDate     = request.getParameter("bookingDate");
    String selTime     = request.getParameter("timeSlot");

    // Prepare a java.util.Set of already booked slot numbers for this combination
    java.util.Set bookedSlots = new java.util.HashSet();
    boolean showSlotsGrid = false;

    if (selLocation != null && selDate != null && selTime != null
            && !selLocation.equals("") && !selDate.equals("") && !selTime.equals("")) {
        showSlotsGrid = true;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/carparkingdb?useSSL=false&allowPublicKeyRetrieval=true",
                    "root", "Root");

            String sql = "SELECT slot_number FROM bookings "
                       + "WHERE location = ? AND booking_date = ? AND time_slot = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, selLocation);
            ps.setDate(2, java.sql.Date.valueOf(selDate));
            ps.setString(3, selTime);
            rs = ps.executeQuery();
            while (rs.next()) {
                bookedSlots.add(new Integer(rs.getInt("slot_number")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Book a Parking Slot</title>

    <!-- Font Awesome CDN for icons -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />

    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css"
    />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        /* Reset and basic styles */
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #eaeaea;
            color: #333;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Top navbar */
        .top-navbar {
            height: 50px;
            background-color: #007bff;
            color: white;
            display: flex;
            align-items: center;
            padding: 0 20px;
            font-weight: 600;
            font-size: 18px;
            user-select: none;
            box-shadow: 0 2px 5px rgba(0,0,0,0.15);
            flex-shrink: 0;
        }

        /* Page layout container */
        .page-container {
           display: flex;
           height: calc(100vh - 60px);
        }

        /* Sidebar styles */
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
        /* Active link style */
        .sidebar a.active {
            background-color: #1e90ff;
            border-left: 4px solid white;
        }
        /* Icon style */
        .sidebar a i {
            margin-right: 10px;
            width: 18px;
            text-align: center;
            font-size: 18px;
        }

        /* Main content area */
        .content {
            flex: 1;
            padding: 25px 40px;
            overflow-y: auto;
            background: white;
            box-shadow: inset 0 0 10px rgba(0,0,0,0.05);
            border-radius: 0 10px 10px 0;
        }

        /* Reuse your existing form styles */
        h2 {
            text-align: center;
            margin-top: 0;
            color: #333;
        }
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 15px;
            max-width: 600px;
            margin: 0 auto 20px auto;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: #444;
        }
        input, select {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
        }
        button {
            background-color: #28a745;
            color: white;
            padding: 12px 25px;
            margin-top: 20px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s ease;
        }
        button:hover {
            background-color: #218838;
        }
        .slots-container {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 15px;
            margin-top: 15px;
        }
        .slot-box {
            border: 2px solid #ccc;
            padding: 25px 0;
            text-align: center;
            cursor: pointer;
            border-radius: 10px;
            font-weight: bold;
            font-size: 18px;
            background-color: #fafafa;
            transition: 0.3s ease;
        }
        .slot-box:hover {
            background-color: #d0f0d0;
            border-color: green;
        }
        .slot-box.selected {
            background-color: #28a745;
            color: white;
            border-color: #1e7e34;
        }
        .slot-box.booked {
            background-color: #ccc;
            color: #666;
            border-color: #999;
            cursor: not-allowed;
        }
        .back-btn {
            background-color: #6c757d;
            margin-left: 10px;
        }
        .back-btn:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>

    <!-- Top Navbar -->
    <div class="top-navbar">
        User Panel
    </div>

    <!-- Main page container with sidebar and content -->
    <div class="page-container">

        <!-- Sidebar vertical menu -->
        <div class="sidebar">
            <a href="userDashboard.jsp">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
            <a href="bookSlot.jsp" class="active">
                <i class="fas fa-calendar-check"></i> BookSlot
            </a>
            <a href="viewTodayBooking.jsp">
                <i class="fas fa-calendar-day"></i> Today Booking
            </a>
            <a href="viewBookingHistory.jsp">
                <i class="fas fa-calendar-alt"></i> All Booking
            </a>
            <a href="editProfile.jsp">
                <i class="fas fa-user"></i> Profile
            </a>
            <a href="logout.jsp">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>

        <!-- Content area -->
        <div class="content">
            <h2>Book a New Parking Slot</h2>

            <!-- Step 1: Check Availability Form -->
            <div class="form-container">
                <form method="get" action="bookSlot.jsp">
                    <label>Select Location:</label>
                    <select name="location" required>
                        <option value="">--Select Location--</option>
                        <option<%= "Rajwada".equals(selLocation) ? " selected" : "" %>>Rajwada</option>
                        <option<%= "Palasia".equals(selLocation) ? " selected" : "" %>>Palasia</option>
                        <option<%= "Vijay Nagar".equals(selLocation) ? " selected" : "" %>>Vijay Nagar</option>
                        <option<%= "MG Road".equals(selLocation) ? " selected" : "" %>>MG Road</option>
                        <option<%= "Tower Square".equals(selLocation) ? " selected" : "" %>>Tower Square</option>
                    </select>

                    <label>Select Date:</label>
                    <input type="date" name="bookingDate"
                           value="<%= (selDate != null) ? selDate : "" %>" required />

                    <label>Select Time Slot:</label>
                    <select name="timeSlot" required>
                        <option value="">--Select--</option>
                        <option<%= "9:00 AM - 10:00 AM".equals(selTime) ? " selected" : "" %>>
                            9:00 AM - 10:00 AM
                        </option>
                        <option<%= "10:00 AM - 11:00 AM".equals(selTime) ? " selected" : "" %>>
                            10:00 AM - 11:00 AM
                        </option>
                        <option<%= "11:00 AM - 12:00 PM".equals(selTime) ? " selected" : "" %>>
                            11:00 AM - 12:00 PM
                        </option>
                        <option<%= "12:00 PM - 1:00 PM".equals(selTime) ? " selected" : "" %>>
                            12:00 PM - 1:00 PM
                        </option>
                        <option<%= "1:00 PM - 2:00 PM".equals(selTime) ? " selected" : "" %>>
                            1:00 PM - 2:00 PM
                        </option>
                        <!-- NEW TIME SLOTS -->
                        <option<%= "2:00 PM - 3:00 PM".equals(selTime) ? " selected" : "" %>>
                            2:00 PM - 3:00 PM
                        </option>
                        <option<%= "3:00 PM - 4:00 PM".equals(selTime) ? " selected" : "" %>>
                            3:00 PM - 4:00 PM
                        </option>
                        <option<%= "4:00 PM - 5:00 PM".equals(selTime) ? " selected" : "" %>>
                            4:00 PM - 5:00 PM
                        </option>
                        <option<%= "5:00 PM - 6:00 PM".equals(selTime) ? " selected" : "" %>>
                            5:00 PM - 6:00 PM
                        </option>
                        <option<%= "6:00 PM - 7:00 PM".equals(selTime) ? " selected" : "" %>>
                            6:00 PM - 7:00 PM
                        </option>
                        <option<%= "7:00 PM - 8:00 PM".equals(selTime) ? " selected" : "" %>>
                            7:00 PM - 8:00 PM
                        </option>
                    </select>

                    <button type="submit">Check Availability</button>
                    <button type="button" class="back-btn"
                            onclick="window.location.href='<%= request.getContextPath() %>/user/userDashboard.jsp'">
                        Go Back
                    </button>
                </form>
            </div>

            <!-- Step 2: Show Slots Grid (once location, date & time are provided) -->
            <% if (showSlotsGrid) { %>
                <div class="form-container" style="margin-top: 0;">
                    <label>Choose Slot Number:</label>
                    <div class="slots-container" id="slotsContainer">
                        <% for (int i = 1; i <= 10; i++) {
                               boolean isBooked = bookedSlots.contains(new Integer(i));
                        %>
                            <div class="slot-box<%= isBooked ? " booked" : "" %>"
                                 data-slot="<%= i %>">
                                <% if (isBooked) { %>
                                    Slot <%= i %><br/><small>(Booked)</small>
                                <% } else { %>
                                    Slot <%= i %>
                                <% } %>
                            </div>
                        <% } %>
                    </div>

                    <!-- Hidden form for final booking -->
                    <form id="confirmForm" method="post"
                          action="<%= request.getContextPath() %>/bookSlotServlet">
                        <input type="hidden" name="location" value="<%= selLocation %>" />
                        <input type="hidden" name="bookingDate" value="<%= selDate %>" />
                        <input type="hidden" name="timeSlot" value="<%= selTime %>" />
                        <input type="hidden" name="slotNumber" id="slotNumber" required />
                        <button type="button" id="bookButton" style="margin-top: 20px; display: none;">
                            Book Slot
                        </button>
                    </form>
                </div>
            <% } %>
        </div>

    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var container = document.getElementById("slotsContainer");
            if (container == null) return;

            var slotBoxes = container.getElementsByClassName("slot-box");
            var hiddenInput = document.getElementById("slotNumber");
            var bookBtn = document.getElementById("bookButton");

            for (var idx = 0; idx < slotBoxes.length; idx++) {
                (function(box) {
                    if (box.className.indexOf("booked") >= 0) {
                        return;
                    }
                    box.onclick = function() {
                        for (var j = 0; j < slotBoxes.length; j++) {
                            slotBoxes[j].className = slotBoxes[j].className.replace(" selected", "");
                        }
                        box.className += " selected";

                        hiddenInput.value = box.getAttribute("data-slot");
                        bookBtn.style.display = "inline-block";
                    };
                })(slotBoxes[idx]);
            }

            if (bookBtn) {
                bookBtn.onclick = function() {
                    if (!hiddenInput.value) {
                        Swal.fire("Select a slot first", "", "warning");
                        return;
                    }
                    Swal.fire({
                        title: 'Confirm Booking',
                        html:
                          '<p><strong>Location:</strong> ' + "<%= selLocation %>" + '</p>' +
                          '<p><strong>Date:</strong> ' + "<%= selDate %>" + '</p>' +
                          '<p><strong>Time Slot:</strong> ' + "<%= selTime %>" + '</p>' +
                          '<p><strong>Slot Number:</strong> ' + hiddenInput.value + '</p>',
                        icon: 'question',
                        showCancelButton: true,
                        confirmButtonText: 'Yes, Book It',
                        cancelButtonText: 'Cancel'
                    }).then(function(result) {
                        if (result.isConfirmed) {
                            // Submit the booking form without any redirect from here
                            document.getElementById("confirmForm").submit();
                        }
                    });
                };
            }
        });
    </script>
</body>
</html>
