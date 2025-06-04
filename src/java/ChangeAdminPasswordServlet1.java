import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ChangeAdminPasswordServlet1 extends HttpServlet
{
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String oldPass = request.getParameter("oldPassword");
        String newPass = request.getParameter("newPassword");

        out.println("<html><body>");
        try
        {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carparkingdb?useSSL=false&allowPublicKeyRetrieval=true", "root", "Root");

            Statement st = con.createStatement();
            String check = "SELECT * FROM users WHERE name='Admin' AND password='" + oldPass + "' AND role='admin'";
            ResultSet rs = st.executeQuery(check);

            if(rs.next())
            {
                String update = "UPDATE users SET password='" + newPass + "' WHERE name='Admin' AND role='admin'";
                int x = st.executeUpdate(update);

                if(x > 0)
                {
                    response.sendRedirect("admin/changeAdminPassword.jsp?message=Password+changed+successfully!");
                }
                else
                {
                    response.sendRedirect("admin/changeAdminPassword.jsp?message=Failed+to+change+password.");
                }
            }
            else
            {
                response.sendRedirect("admin/changeAdminPassword.jsp?message=Old+password+is+incorrect.");
            }

            con.close();
        }
        catch(Exception e)
        {
            out.println("Error: " + e);
            response.sendRedirect("admin/changeAdminPassword.jsp?message=An+error+occurred.");
        }

        out.println("</body></html>");
        out.close();
    }
}
