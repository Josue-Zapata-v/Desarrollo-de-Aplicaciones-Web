package tecsup.edu.pe.servlet_crud;

import java.io.*;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

@WebServlet("/curso")
public class CursoServlet extends HttpServlet {
    private static final String URL = "jdbc:mysql://localhost:3306/escuela";
    private static final String USER = "root";
    private static final String PASS = "";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("listar".equals(accion)) {
            listar(response);
        } else if ("editar".equals(accion)) {
            editar(request, response);
        } else if ("eliminar".equals(accion)) {
            eliminar(request, response);
        } else {
            response.sendRedirect("index.html");
        }
    }

    private void listar(HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html; charset=UTF-8");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASS);
            Statement stm = conn.createStatement();
            ResultSet rs = stm.executeQuery("SELECT * FROM Curso");

            out.println("<html><body>");
            out.println("<h2>Lista de Cursos</h2>");
            out.println("<table border='1'>");
            out.println("<tr><th>Codigo</th><th>Nombre</th><th>Credito</th><th>Acciones</th></tr>");

            while (rs.next()) {
                String codigo = rs.getString("ChrCurCodigo");
                String nombre = rs.getString("vchCurNombre");
                int creditos = rs.getInt("intCurCreditos");

                out.println("<tr>");
                out.println("<td>" + codigo + "</td>");
                out.println("<td>" + nombre + "</td>");
                out.println("<td>" + creditos + "</td>");
                out.println("<td>");
                out.println("<a href='curso?accion=editar&codigo=" + codigo + "'>Editar</a> | ");
                out.println("<a href='curso?accion=eliminar&codigo=" + codigo + "'>Eliminar</a>");
                out.println("</td>");
                out.println("</tr>");
            }

            out.println("</table>");
            out.println("<a href='index.html'>Registrar nuevo curso</a>");
            out.println("</body></html>");

            rs.close();
            stm.close();
            conn.close();

        } catch (Exception e) {
            out.println("<p>Error al listar cursos: " + e.getMessage() + "</p>");
        }
    }

    private void editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String codigo = request.getParameter("codigo");
        PrintWriter out = response.getWriter();
        response.setContentType("text/html; charset=UTF-8");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASS);
            PreparedStatement stm = conn.prepareStatement("SELECT * FROM Curso WHERE chrCurCodigo = ?");
            stm.setString(1, codigo);
            ResultSet rs = stm.executeQuery();

            out.println("<html><body>");
            if (rs.next()) {
                out.println("<h2>Editar Curso</h2>");
                out.println("<form action='curso' method='post'>");
                out.println("<input type='hidden' name='accion' value='actualizar'>");
                out.println("<label>Codigo:</label>");
                out.println("<input type='text' name='codigo' value='" + rs.getString("chrCurCodigo") + "' readonly /><br/>");
                out.println("<label>Nombre:</label>");
                out.println("<input type='text' name='nombre' value='" + rs.getString("vchCurNombre") + "' /><br/>");
                out.println("<label>Creditos:</label>");
                out.println("<input type='text' name='creditos' value='" + rs.getInt("intCurCreditos") + "' /><br/>");
                out.println("<input type='submit' value='Actualizar'>");
                out.println("</form>");
            }
            out.println("</body></html>");

            rs.close();
            stm.close();
            conn.close();

        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String codigo = request.getParameter("codigo");
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASS);
            PreparedStatement stm = conn.prepareStatement("DELETE FROM Curso WHERE chrCurCodigo = ?");
            stm.setString(1, codigo);
            int rows = stm.executeUpdate();

            out.println("<html><body>");
            if (rows > 0) {
                out.println("<p>Curso eliminado correctamente.</p>");
            } else {
                out.println("<p>Error al eliminar el curso.</p>");
            }
            out.println("<a href='curso?accion=listar'>Volver a la lista</a>");
            out.println("</body></html>");

            stm.close();
            conn.close();

        } catch (Exception e) {
            out.println("<p>Error al eliminar curso: " + e.getMessage() + "</p>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        String nombre = request.getParameter("nombre");
        String credito = request.getParameter("creditos");
        String codigo = request.getParameter("codigo");

        PrintWriter out = response.getWriter();
        response.setContentType("text/html; charset=UTF-8");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASS);

            if ("actualizar".equals(accion)) {
                PreparedStatement stm = conn.prepareStatement(
                        "UPDATE Curso SET vchCurNombre=?, intCurCreditos=? WHERE chrCurCodigo=?");
                stm.setString(1, nombre);
                stm.setInt(2, Integer.parseInt(credito));
                stm.setString(3, codigo);
                stm.executeUpdate();

                out.println("<p>Curso actualizado correctamente.</p>");
            } else {
                PreparedStatement stm = conn.prepareStatement(
                        "INSERT INTO Curso VALUES (?, ?, ?)");
                stm.setString(1, codigo);
                stm.setString(2, nombre);
                stm.setInt(3, Integer.parseInt(credito));
                stm.executeUpdate();

                out.println("<p>Curso agregado correctamente.</p>");
            }

            out.println("<a href='curso?accion=listar'>Volver a la lista</a>");
            out.println("</body></html>");

            conn.close();

        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
}
