import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/registerServlet")
public class registerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost/carparkingdb?useSSL=false&allowPublicKeyRetrieval=true",
                "root", "Root");

            String query = "INSERT INTO users (name, email, phone, password, role) VALUES (?, ?, ?, ?, 'user')";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, password);

            int i = ps.executeUpdate();
            con.close();

            if (i > 0) {
                response.sendRedirect("register.jsp?status=success");
            } else {
                response.sendRedirect("register.jsp?status=error");
            }

        } catch (Exception e) {
            e.printStackTrace(); // for debugging in console
            response.sendRedirect("register.jsp?status=error");
        }
    }
}
