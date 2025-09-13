package tecsup.edu.pe.casuistica03;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;

@WebServlet("/obrero")
public class ObreroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Parámetros
        String nombre = request.getParameter("nombre");
        String prenda = request.getParameter("prenda");
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        String categoria = request.getParameter("categoria");

        // Tarifa por prenda
        double tarifa = 0;
        switch (prenda) {
            case "Polo": tarifa = 0.50; break;
            case "Camisa": tarifa = 1.00; break;
            case "Pantalon": tarifa = 1.50; break;
        }

        // Ingreso bruto (sin bonificación)
        double ingreso = cantidad * tarifa;

        // Bonificación
        double bonificacion = 0;
        if (cantidad > 700) {
            switch (categoria) {
                case "A": bonificacion = 250; break;
                case "B": bonificacion = 150; break;
                case "C": bonificacion = 100; break;
                case "D": bonificacion = 50; break;
            }
        }

        // Total ingresos antes de descuentos
        double totalIngresos = ingreso + bonificacion;

        // Descuentos
        double descuentoImpuesto = totalIngresos * 0.09;
        double descuentoSeguro = totalIngresos * 0.02;
        if (descuentoSeguro > 20) descuentoSeguro = 20;
        double descuentoSolidaridad = totalIngresos * 0.01;

        double totalDescuentos = descuentoImpuesto + descuentoSeguro + descuentoSolidaridad;

        // Sueldo neto
        double sueldoNeto = totalIngresos - totalDescuentos;

        // Formatear a 2 decimales
        DecimalFormat df = new DecimalFormat("#0.00");

        // Respuesta HTML
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<title>Resultado Sueldo Obrero</title>");
        out.println("<style>");
        out.println("table { border-collapse: collapse; margin-top: 20px; }");
        out.println("table, th, td { border: 1px solid black; padding: 10px; }");
        out.println("th { background-color: #f2f2f2; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h2>Resultado del Sueldo Mensual</h2>");

        out.println("<table>");
        out.println("<tr><th>Nombre</th><td>" + nombre + "</td></tr>");
        out.println("<tr><th>Prenda</th><td>" + prenda + "</td></tr>");
        out.println("<tr><th>Cantidad</th><td>" + cantidad + "</td></tr>");
        out.println("<tr><th>Categoría</th><td>" + categoria + "</td></tr>");
        out.println("<tr><th>Ingreso por producción</th><td>S/ " + df.format(ingreso) + "</td></tr>");
        out.println("<tr><th>Bonificación</th><td>S/ " + df.format(bonificacion) + "</td></tr>");
        out.println("<tr><th>Total ingresos</th><td>S/ " + df.format(totalIngresos) + "</td></tr>");
        out.println("<tr><th>Descuento Impuesto (9%)</th><td>S/ " + df.format(descuentoImpuesto) + "</td></tr>");
        out.println("<tr><th>Descuento Seguro (2%, máx 20)</th><td>S/ " + df.format(descuentoSeguro) + "</td></tr>");
        out.println("<tr><th>Descuento Solidaridad (1%)</th><td>S/ " + df.format(descuentoSolidaridad) + "</td></tr>");
        out.println("<tr><th>Total Descuentos</th><td>S/ " + df.format(totalDescuentos) + "</td></tr>");
        out.println("<tr><th><b>Sueldo Neto</b></th><td><b>S/ " + df.format(sueldoNeto) + "</b></td></tr>");
        out.println("</table>");

        out.println("<br><a href='index.html'>Volver</a>");
        out.println("</body></html>");
    }
}
