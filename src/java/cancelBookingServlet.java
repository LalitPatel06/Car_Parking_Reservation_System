import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/cancelBookingServlet")
public class cancelBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1) Verify that the user is still logged in
        HttpSession session = request.getSession(false);
        String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;
        if (userEmail == null) {
            // No userEmail in session → redirect to login
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2) Read bookingId and redirect target, but be defensive
        String bookingIdStr = request.getParameter("bookingId");
        String redirectTo   = request.getParameter("redirectTo");

        // If redirectTo is missing or empty, go back to dashboard by default
        if (redirectTo == null || redirectTo.trim().isEmpty()) {
            redirectTo = "user/userDashboard.jsp";
        }

        // If bookingIdStr is missing or not an integer, skip deletion
        if (bookingIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/" + redirectTo);
            return;
        }

        int bookingId;
        try {
            bookingId = Integer.parseInt(bookingIdStr);
        } catch (NumberFormatException nfe) {
            // Invalid bookingId → just redirect back
            response.sendRedirect(request.getContextPath() + "/" + redirectTo);
            return;
        }

        // 3) Delete the booking from the database (only if it belongs to this user)
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/carparkingdb?useSSL=false&allowPublicKeyRetrieval=true",
                    "root", "Root")) {

                String deleteSQL = 
                    "DELETE FROM bookings WHERE id = ? AND user_email = ?";
                try (PreparedStatement ps = conn.prepareStatement(deleteSQL)) {
                    ps.setInt(1, bookingId);
                    ps.setString(2, userEmail);
                    ps.executeUpdate();
                    // Even if no rows were deleted (because id didn’t match or wrong user), we just proceed
                }
            }
        } catch (Exception e) {
            // On any exception, we simply ignore the deletion and continue
            e.printStackTrace();
        }

        // 4) Redirect back to whatever page requested the cancel
        response.sendRedirect(request.getContextPath() + "/" + redirectTo);
    }
}
