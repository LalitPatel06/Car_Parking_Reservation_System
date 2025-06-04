import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class adminDashboardServlet extends HttpServlet {

    private final String DB_URL = "jdbc:mysql://localhost:3306/carparkingdb";
    private final String DB_USER = "root";
    private final String DB_PASS = "Root"; // Change to your MySQL password

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userCount = 0;
        int bookingCount = 0;
        int availableSlots = 0;

        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // Count users
            Statement stmt1 = conn.createStatement();
            ResultSet rs1 = stmt1.executeQuery("SELECT COUNT(*) FROM users");
            if (rs1.next()) userCount = rs1.getInt(1);
                
            // Count bookings
            Statement stmt2 = conn.createStatement();
            ResultSet rs2 = stmt2.executeQuery("SELECT COUNT(*) FROM bookings");
            if (rs2.next()) bookingCount = rs2.getInt(1);

            // Count available parking slots
//            Statement stmt3 = conn.createStatement();
//            ResultSet rs3 = stmt3.executeQuery("SELECT COUNT(*) FROM parking_slots WHERE status = 'available'");
//            if (rs3.next()) availableSlots = rs3.getInt(1);

            // Close resources
            rs1.close(); rs2.close(); //rs3.close();
            stmt1.close(); stmt2.close(); //stmt3.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Set values in request scope
        request.setAttribute("userCount", userCount);
        request.setAttribute("bookingCount", bookingCount);
        request.setAttribute("availableSlots", availableSlots);

        // Forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/adminDashboard.jsp");
        dispatcher.forward(request, response);
    }
}
