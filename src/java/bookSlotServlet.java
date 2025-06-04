import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/bookSlotServlet")
public class bookSlotServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // If someone accesses /bookSlotServlet with GET, redirect back to the booking form
        resp.sendRedirect(req.getContextPath() + "/user/bookSlot.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Prepare to write HTML + JS
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Validate session & userEmail
        HttpSession session = request.getSession(false);
        String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;
        if (userEmail == null) {
            // No session → redirect to login
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Read form parameters
        String bookingDateStr = request.getParameter("bookingDate");
        String timeSlot       = request.getParameter("timeSlot");
        String location       = request.getParameter("location");
        int slotNumber        = Integer.parseInt(request.getParameter("slotNumber"));

        try {
            // Parse the chosen date & prevent past-date bookings
            LocalDate bookingDate = LocalDate.parse(bookingDateStr);
            LocalDate today       = LocalDate.now();
            if (bookingDate.isBefore(today)) {
                // Return a small HTML page that loads SweetAlert2 + shows an error
                out.println("<!DOCTYPE html>");
                out.println("<html><head>");
                out.println("  <meta charset='UTF-8'/>");
                out.println("  <title>Invalid Date</title>");
                out.println("  <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                out.println("</head><body>");
                out.println("  <script>");
                out.println("    Swal.fire({"
                        + " icon: 'error',"
                        + " title: 'Invalid Date',"
                        + " text: 'You cannot select a past date!',"
                        + "}).then(() => { history.back(); });");
                out.println("  </script>");
                out.println("</body></html>");
                return;
            }

            // Establish DB connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/carparkingdb?useSSL=false&allowPublicKeyRetrieval=true",
                "root", "Root"
            );

            // Check if this specific combination is already booked
            String checkQuery = 
                "SELECT * FROM bookings " +
                "WHERE booking_date = ? AND time_slot = ? AND slot_number = ? AND location = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setDate(1, Date.valueOf(bookingDate));
            checkStmt.setString(2, timeSlot);
            checkStmt.setInt(3, slotNumber);
            checkStmt.setString(4, location);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Already booked → show a warning via SweetAlert2, then go back
                out.println("<!DOCTYPE html>");
                out.println("<html><head>");
                out.println("  <meta charset='UTF-8'/>");
                out.println("  <title>Slot Unavailable</title>");
                out.println("  <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                out.println("</head><body>");
                out.println("  <script>");
                out.println("    Swal.fire({"
                        + " icon: 'warning',"
                        + " title: 'Slot Unavailable',"
                        + " text: 'This slot is already booked! Please select another.',"
                        + "}).then(() => { history.back(); });");
                out.println("  </script>");
                out.println("</body></html>");
            } else {
                // Insert the new booking
                String insertQuery = 
                    "INSERT INTO bookings " +
                    "(user_email, booking_date, time_slot, slot_number, location) " +
                    "VALUES (?, ?, ?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setString(1, userEmail);
                insertStmt.setDate(2, Date.valueOf(bookingDate));
                insertStmt.setString(3, timeSlot);
                insertStmt.setInt(4, slotNumber);
                insertStmt.setString(5, location);

                int rows = insertStmt.executeUpdate();
                if (rows > 0) {
                    // Success → show a SweetAlert2 success box, then redirect to dashboard
                    out.println("<!DOCTYPE html>");
                    out.println("<html><head>");
                    out.println("  <meta charset='UTF-8'/>");
                    out.println("  <title>Booking Successful</title>");
                    out.println("  <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                    out.println("</head><body>");
                    out.println("  <script>");
                    out.println("    Swal.fire({"
                            + " icon: 'success',"
                            + " title: 'Booked!',"
                            + " text: 'Your slot has been booked successfully.',"
                            + " confirmButtonText: 'Go to Dashboard'"
                            + "}).then((result) => {"
                            + "  if (result.isConfirmed) {"
                            + "    window.location = '" 
                                      + request.getContextPath() 
                                      + "/user/userDashboard.jsp';"
                            + "  }"
                            + "});");
                    out.println("  </script>");
                    out.println("</body></html>");
                } else {
                    // Insert failed → show an error
                    out.println("<!DOCTYPE html>");
                    out.println("<html><head>");
                    out.println("  <meta charset='UTF-8'/>");
                    out.println("  <title>Booking Error</title>");
                    out.println("  <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                    out.println("</head><body>");
                    out.println("  <script>");
                    out.println("    Swal.fire({"
                            + " icon: 'error',"
                            + " title: 'Error',"
                            + " text: 'Something went wrong. Try again later.',"
                            + "}).then(() => { history.back(); });");
                    out.println("  </script>");
                    out.println("</body></html>");
                }
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            // Show exception message via SweetAlert2
            String escapedMessage = e.getMessage().replace("'", "\\'");
            out.println("<!DOCTYPE html>");
            out.println("<html><head>");
            out.println("  <meta charset='UTF-8'/>");
            out.println("  <title>Server Exception</title>");
            out.println("  <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("</head><body>");
            out.println("  <script>");
            out.println("    Swal.fire({"
                    + " icon: 'error',"
                    + " title: 'Exception',"
                    + " text: '" + escapedMessage + "',"
                    + "}).then(() => { history.back(); });");
            out.println("  </script>");
            out.println("</body></html>");
        }
    }
}
