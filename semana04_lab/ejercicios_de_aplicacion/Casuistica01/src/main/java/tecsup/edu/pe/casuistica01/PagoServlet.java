package tecsup.edu.pe.casuistica01;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/pago")
public class PagoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Parámetros del formulario
        String nombre = request.getParameter("nombre");
        double importe = Double.parseDouble(request.getParameter("importe"));
        String colegio = request.getParameter("colegio");
        String categoria = request.getParameter("categoria");

        // Determinar descuento según tabla
        int descuento = 0;
        if ("Nacional".equalsIgnoreCase(colegio)) {
            switch (categoria) {
                case "A": descuento = 50; break;
                case "B": descuento = 40; break;
                case "C": descuento = 30; break;
            }
        } else if ("Particular".equalsIgnoreCase(colegio)) {
            switch (categoria) {
                case "A": descuento = 25; break;
                case "B": descuento = 20; break;
                case "C": descuento = 15; break;
            }
        }

        // Calcular importe final
        double montoDescuento = importe * descuento / 100;
        double totalPagar = importe - montoDescuento;

        // Respuesta al navegador
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<title>Resultado del Pago</title>");
        out.println("<style>");
        out.println("table { border-collapse: collapse; margin-top: 20px; }");
        out.println("table, th, td { border: 1px solid black; padding: 10px; }");
        out.println("th { background-color: #f2f2f2; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h2>Resultado del Pago</h2>");

        out.println("<table>");
        out.println("<tr><th>Alumno</th><td>" + nombre + "</td></tr>");
        out.println("<tr><th>Colegio</th><td>" + colegio + "</td></tr>");
        out.println("<tr><th>Categoría</th><td>" + categoria + "</td></tr>");
        out.println("<tr><th>Importe Inicial</th><td>S/ " + importe + "</td></tr>");
        out.println("<tr><th>Descuento</th><td>" + descuento + "% (S/ " + montoDescuento + ")</td></tr>");
        out.println("<tr><th>Total a pagar</th><td><b>S/ " + totalPagar + "</b></td></tr>");
        out.println("</table>");

        out.println("<br><a href='index.html'>Volver</a>");
        out.println("</body></html>");
    }
}
