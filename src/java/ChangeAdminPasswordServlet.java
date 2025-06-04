import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ChangeAdminPasswordServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String oldPass = request.getParameter("oldPassword");
        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        // Check if new password and confirm password match
        if (!newPass.equals(confirmPass)) {
            response.sendRedirect("admin/adminProfile.jsp?message=not_matched");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/carparkingdb?useSSL=false&allowPublicKeyRetrieval=true", 
                "root", "Root");

            Statement st = con.createStatement();
            String check = "SELECT * FROM users WHERE name='Admin' AND password='" + oldPass + "' AND role='admin'";
            ResultSet rs = st.executeQuery(check);

            if (rs.next()) {
                String update = "UPDATE users SET password='" + newPass + "' WHERE name='Admin' AND role='admin'";
                int x = st.executeUpdate(update);

                if (x > 0) {
                    response.sendRedirect("admin/adminProfile.jsp?message=success");
                } else {
                    response.sendRedirect("admin/adminProfile.jsp?message=fail");
                }
            } else {
                response.sendRedirect("admin/adminProfile.jsp?message=wrong_old");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/adminProfile.jsp?message=fail");
        }
    }
}
