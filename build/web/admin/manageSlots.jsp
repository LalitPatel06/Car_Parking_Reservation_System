<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    // 1. Session check — only allow admin
    String adminName = (String) session.getAttribute("userName");
    if (adminName == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 2. Database connection parameters — adjust as needed
    String url    = "jdbc:mysql://localhost/carparkingdb?useSSL=false&allowPublicKeyRetrieval=true";
    String dbUser = "root";
    String dbPass = "Root";

    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    String message = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPass);

        // 3. Handle “Add New Slot” form submission
        if ("add".equals(request.getParameter("action"))) {
            String slotNumber = request.getParameter("slot_number").trim();
            String location   = request.getParameter("location").trim();
            String rateStr    = request.getParameter("rate").trim();
            String status     = request.getParameter("status").trim();

            if (slotNumber.isEmpty() || location.isEmpty() || rateStr.isEmpty() || status.isEmpty()) {
                message = "All fields are required to add a new slot.";
            } else {
                // Insert into slots table
                String insertSql = 
                    "INSERT INTO slots (slot_number, location, rate, status) VALUES (?, ?, ?, ?)";
                pst = conn.prepareStatement(insertSql);
                pst.setString(1, slotNumber);
                pst.setString(2, location);
                pst.setBigDecimal(3, new java.math.BigDecimal(rateStr));
                pst.setString(4, status);
                pst.executeUpdate();
                pst.close();
                message = "New slot added successfully.";
            }
        }

        // 4. Handle “Delete Slot” action
        if ("delete".equals(request.getParameter("action"))) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                String deleteSql = "DELETE FROM slots WHERE id = ?";
                pst = conn.prepareStatement(deleteSql);
                pst.setInt(1, id);
                pst.executeUpdate();
                pst.close();
                message = "Slot deleted successfully.";
            }
        }

        // 5. Fetch all slots
        String fetchSql = 
            "SELECT id, slot_number, location, rate, status " +
            "FROM slots " +
            "ORDER BY slot_number ASC";
        pst = conn.prepareStatement(fetchSql);
        rs = pst.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Slots - Admin</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f0f2f5;
            margin: 20px;
        }
        .header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .header-row h2 {
            color: #2f3542;
            margin: 0;
        }
        .back-btn {
            text-decoration: none;
            background-color: #1e90ff;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .back-btn i {
            margin-right: 6px;
        }
        .back-btn:hover {
            background-color: #187bcd;
        }
        .message {
            margin: 10px 0;
            color: #2f3542;
            font-weight: bold;
        }
        .add-form {
            background: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            width: 100%;
            max-width: 600px;
        }
        .add-form input[type=text],
        .add-form input[type=number],
        .add-form select {
            width: 100%;
            padding: 8px 10px;
            margin: 6px 0 12px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .add-form label {
            font-weight: 600;
            color: #333;
        }
        .add-form button {
            background-color: #28a745;
            color: white;
            padding: 10px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }
        .add-form button:hover {
            background-color: #218838;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background: white;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            text-align: left;
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            color: #57606f;
        }
        th {
            background-color: #3742fa;
            color: white;
        }
        tr:hover {
            background-color: #f5f6fa;
        }
        .action-links a {
            margin-right: 10px;
            color: #1e90ff;
            text-decoration: none;
        }
        .action-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="header-row">
    <h2><i class="fa fa-parking"></i> Manage Parking Slots</h2>
    <a href="adminDashboard.jsp" class="back-btn">
        <i class="fa fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

<% if (message != null) { %>
    <div class="message"><%= message %></div>
<% } %>

<div class="add-form">
    <form method="post" action="manageSlots.jsp?action=add">
        <label for="slot_number">Slot Number:</label>
        <input type="text" id="slot_number" name="slot_number" placeholder="e.g. A12" required>

        <label for="location">Location:</label>
        <input type="text" id="location" name="location" placeholder="e.g. Level 1 – East Wing" required>

        <label for="rate">Rate (per hour):</label>
        <input type="number" step="0.01" id="rate" name="rate" placeholder="e.g. 2.50" required>

        <label for="status">Status:</label>
        <select id="status" name="status" required>
            <option value="Available">Available</option>
            <option value="Out of Service">Out of Service</option>
        </select>

        <button type="submit"><i class="fa fa-plus-circle"></i> Add New Slot</button>
    </form>
</div>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Slot Number</th>
            <th>Location</th>
            <th>Rate ($/hr)</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
<%
        while (rs.next()) {
%>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("slot_number") %></td>
            <td><%= rs.getString("location") %></td>
            <td><%= rs.getBigDecimal("rate") %></td>
            <td><%= rs.getString("status") %></td>
            <td class="action-links">
                <!-- Edit link (requires you create editSlot.jsp) -->
                <a href="editSlot.jsp?id=<%= rs.getInt("id") %>"><i class="fa fa-edit"></i> Edit</a>
                <!-- Delete action -->
                <a href="manageSlots.jsp?action=delete&id=<%= rs.getInt("id") %>"
                   onclick="return confirm('Are you sure you want to delete this slot?');">
                    <i class="fa fa-trash-alt"></i> Delete
                </a>
            </td>
        </tr>
<%
        }
%>
    </tbody>
</table>

<%
    } catch (Exception e) {
%>
    <p style="color:red;">Error: <%= e.getMessage() %></p>
<%
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
        if (pst != null) try { pst.close(); } catch (Exception ignored) {}
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>

</body>
</html>
