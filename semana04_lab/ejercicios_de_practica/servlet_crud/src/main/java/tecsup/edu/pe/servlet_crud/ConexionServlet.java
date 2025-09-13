package tecsup.edu.pe.servlet_crud;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/conexion")
public class ConexionServlet extends HttpServlet {

    private static final String URL = "jdbc:mysql://localhost:3306/escuela";
    private static final String USER = "root";
    private static final String PASS = "";

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Registrar el driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Conexión y consulta
            try (
                    Connection conn = DriverManager.getConnection(URL, USER, PASS);
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM curso")
            ) {
                out.println("<html><head><title>Lista de Cursos</title></head><body>");
                out.println("<style>");
                out.println("table { border-collapse: collapse; width: 60%; margin: 20px 0; }");
                out.println("th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }");
                out.println("th { background-color: #f2f2f2; }");
                out.println("</style></head><body>");

                out.println("<h2>Lista de Cursos:</h2>");
                out.println("<table>");
                out.println("<tr><th>ID</th><th>Nombre</th><th>Crédito</th></tr>");

                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString(1) + "</td>");
                    out.println("<td>" + rs.getString(2) + "</td>");
                    out.println("<td>" + rs.getInt(3) + "</td>");
                    out.println("</tr>");
                }

                out.println("</table>");
                out.println("<a href='index.html'>Registrar nuevo curso</a>");
                out.println("</body></html>");
            }

        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        }
    }
}
