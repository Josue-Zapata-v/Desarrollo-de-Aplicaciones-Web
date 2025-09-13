package tecsup.edu.pe.servlet_01;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/mayuscula")
public class ServletMayusculas extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        PrintWriter out = response.getWriter();
        String nombre = "Ricardo Coello Palomino";

        out.println("<html><body>");
        out.println("<h1> " + nombre.toUpperCase() + " </h1>");
        out.println("</body></html>");
    }
}