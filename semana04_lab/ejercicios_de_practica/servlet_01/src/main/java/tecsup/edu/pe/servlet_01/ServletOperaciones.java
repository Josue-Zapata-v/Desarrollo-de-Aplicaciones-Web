package tecsup.edu.pe.servlet_01;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/operaciones")
public class ServletOperaciones extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            double num1 = Double.parseDouble(request.getParameter("num1"));
            double num2 = Double.parseDouble(request.getParameter("num2"));
            String op = request.getParameter("op");

            double resultado = 0;
            String operacion = "";

            switch (op) {
                case "suma":
                    resultado = num1 + num2;
                    operacion = "Suma";
                    break;
                case "resta":
                    resultado = num1 - num2;
                    operacion = "Resta";
                    break;
                case "mult":
                    resultado = num1 * num2;
                    operacion = "Multiplicación";
                    break;
                case "div":
                    if (num2 != 0) {
                        resultado = num1 / num2;
                        operacion = "División";
                    } else {
                        out.println("<h1>Error: División entre cero no permitida.</h1>");
                        return;
                    }
                    break;
                default:
                    out.println("<h1>Operación no válida. Usa suma, resta, mult o div.</h1>");
                    return;
            }

            // Respuesta HTML
            out.println("<html><body>");
            out.println("<h1>Resultado de la " + operacion + "</h1>");
            out.println("<p>" + num1 + " " + simboloOperacion(op) + " " + num2 + " = " + resultado + "</p>");
            out.println("</body></html>");

        } catch (NumberFormatException e) {
            out.println("<h1>Error: Ingrese números válidos.</h1>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            double num1 = Double.parseDouble(request.getParameter("num1"));
            double num2 = Double.parseDouble(request.getParameter("num2"));
            String op = request.getParameter("op");

            double resultado = 0;
            String operacion = "";

            switch (op) {
                case "suma":
                    resultado = num1 + num2;
                    operacion = "Suma";
                    break;
                case "resta":
                    resultado = num1 - num2;
                    operacion = "Resta";
                    break;
                case "mult":
                    resultado = num1 * num2;
                    operacion = "Multiplicación";
                    break;
                case "div":
                    if (num2 != 0) {
                        resultado = num1 / num2;
                        operacion = "División";
                    } else {
                        out.println("<h1>Error: División entre cero no permitida.</h1>");
                        return;
                    }
                    break;
                default:
                    out.println("<h1>Operación no válida. Usa suma, resta, mult o div.</h1>");
                    return;
            }

            // Respuesta HTML
            out.println("<html><body>");
            out.println("<h1>Resultado de la " + operacion + "</h1>");
            out.println("<p>" + num1 + " " + simboloOperacion(op) + " " + num2 + " = " + resultado + "</p>");
            out.println("</body></html>");

        } catch (NumberFormatException e) {
            out.println("<h1>Error: Ingrese números válidos.</h1>");
        }
    }

    private String simboloOperacion(String op) {
        switch (op) {
            case "suma": return "+";
            case "resta": return "-";
            case "mult": return "*";
            case "div": return "/";
            default: return "";
        }
    }
}
