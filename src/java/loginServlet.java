import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/carparkingdb"; // Change as needed
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Root";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        if (!email.contains("@")) {
            request.setAttribute("errorMessage", "Please enter a valid email address.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Connect to database
  Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost/carparkingdb?useSSL=false&allowPublicKeyRetrieval=true", "root", "Root");

            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                String name = rs.getString("name");

                // Store user info in session
                HttpSession session = request.getSession();
                session.setAttribute("userName", name);
                session.setAttribute("userEmail", email);
                session.setAttribute("userRole", role);

              if ("admin".equals(role)) {
    response.sendRedirect("admin/adminDashboard.jsp");
} else {
    response.sendRedirect("user/userDashboard.jsp");
}



            } else {
                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
