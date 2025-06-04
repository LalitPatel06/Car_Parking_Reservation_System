<%@ page import="java.sql.*" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking History</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
            overflow-y: auto;
        }
        .loggedin {
            font-size: 14px;
            margin-bottom: 20px;
            color: #555;
        }
        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        table thead {
            background-color: #007bff;
            color: #fff;
        }
        table th, table td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }
        table tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        table tr:hover {
            background-color: #e9ecef;
        }
        .no-records {
            text-align: center;
            padding: 30px;
            color: #888;
            font-size: 18px;
        }
        .back-button {
            display: inline-block;
            margin-top: 20px;
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
        }
        .back-button:hover {
            background-color: #5a6268;
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
        <div class="loggedin">Logged in as: <strong><%= userEmail %></strong></div>
        <h2><i class="fa fa-history"></i> My Booking History</h2>

        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/carparkingdb?useSSL=false&allowPublicKeyRetrieval=true",
                    "root", "Root"
                );

                String query = "SELECT id, booking_date, time_slot, slot_number, location " +
                               "FROM bookings WHERE user_email = ? " +
                               "ORDER BY booking_date DESC, time_slot ASC, slot_number ASC";
                ps = conn.prepareStatement(query);
                ps.setString(1, userEmail);
                rs = ps.executeQuery();

                if (!rs.isBeforeFirst()) {
        %>
            <div class="no-records">You have no booking history yet.</div>
        <%
                } else {
        %>
            <table>
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Date</th>
                        <th>Time Slot</th>
                        <th>Slot Number</th>
                        <th>Location</th>
                    </tr>
                </thead>
                <tbody>
        <%
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        Date date = rs.getDate("booking_date");
                        String timeSlot = rs.getString("time_slot");
                        int slotNumber = rs.getInt("slot_number");
                        String location = rs.getString("location");
        %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= date %></td>
                        <td><%= timeSlot %></td>
                        <td><%= slotNumber %></td>
                        <td><%= location %></td>
                    </tr>
        <%
                    }
        %>
                </tbody>
            </table>
        <%
                }
            } catch (Exception e) {
        %>
            <div class="no-records">Error fetching booking history: <%= e.getMessage() %></div>
        <%
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </div>
</div>

</body>
</html>
