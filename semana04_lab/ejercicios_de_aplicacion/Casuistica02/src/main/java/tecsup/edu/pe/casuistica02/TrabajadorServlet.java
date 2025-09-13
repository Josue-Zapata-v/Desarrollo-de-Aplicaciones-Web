package tecsup.edu.pe.casuistica02;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/trabajador")
public class TrabajadorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Parámetros
        String nombre = request.getParameter("nombre");
        double sueldo = Double.parseDouble(request.getParameter("sueldo"));
        String estado = request.getParameter("estado");
        int hijos = Integer.parseInt(request.getParameter("hijos"));

        // Bonificación según estado civil
        double porcentaje = 0;
        switch (estado) {
            case "Casado": porcentaje = 13; break;
            case "Viudo": porcentaje = 15; break;
            case "Soltero": porcentaje = 5; break;
        }

        // Bonificación adicional por hijos (1.5% c/u, máximo 6%)
        double adicionalHijos = hijos * 1.5;
        if (adicionalHijos > 6) {
            adicionalHijos = 6; // límite máximo
        }

        // Total porcentaje
        double porcentajeTotal = porcentaje + adicionalHijos;

        // Cálculo del neto
        double montoBonificacion = sueldo * porcentajeTotal / 100;
        double neto = sueldo + montoBonificacion;

        // Respuesta HTML
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<title>Resultado Neto</title>");
        out.println("<style>");
        out.println("table { border-collapse: collapse; margin-top: 20px; }");
        out.println("table, th, td { border: 1px solid black; padding: 10px; }");
        out.println("th { background-color: #f2f2f2; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h2>Resultado del Neto a Cobrar</h2>");

        out.println("<table>");
        out.println("<tr><th>Nombre</th><td>" + nombre + "</td></tr>");
        out.println("<tr><th>Sueldo Base</th><td>S/ " + sueldo + "</td></tr>");
        out.println("<tr><th>Estado Civil</th><td>" + estado + "</td></tr>");
        out.println("<tr><th>Número de Hijos</th><td>" + hijos + "</td></tr>");
        out.println("<tr><th>Bonificación Estado Civil</th><td>" + porcentaje + "%</td></tr>");
        out.println("<tr><th>Bonificación por Hijos</th><td>" + adicionalHijos + "%</td></tr>");
        out.println("<tr><th>Total Bonificación</th><td>" + porcentajeTotal + "% (S/ " + montoBonificacion + ")</td></tr>");
        out.println("<tr><th><b>Neto a Cobrar</b></th><td><b>S/ " + neto + "</b></td></tr>");
        out.println("</table>");

        out.println("<br><a href='index.html'>Volver</a>");
        out.println("</body></html>");
    }
}
