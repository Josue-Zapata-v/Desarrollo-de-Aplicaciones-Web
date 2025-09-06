<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Filtros de Medicamentos</title>
</head>
<body>
<h1>Medicamentos - Filtros</h1>

<%
    String url = "jdbc:mysql://localhost:3306/farmacia_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
    String username = "root";
    String password = "";

    String filtroEspecialidad = request.getParameter("especialidad");
    String filtroTipo = request.getParameter("tipo");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection(url, username, password)) {

            // 1. Statement - Listar todos los medicamentos
            out.println("<h2>Todos los Medicamentos (Statement)</h2>");
            Statement stmt = con.createStatement();
            ResultSet rs1 = stmt.executeQuery("SELECT cod_medicamento, descripcion, marca, stock FROM medicamento");
            out.println("<table border='1'><tr><th>ID</th><th>Descripción</th><th>Marca</th><th>Stock</th></tr>");
            while (rs1.next()) {
                out.println("<tr><td>" + rs1.getInt("cod_medicamento") + "</td><td>"
                        + rs1.getString("descripcion") + "</td><td>"
                        + rs1.getString("marca") + "</td><td>"
                        + rs1.getInt("stock") + "</td></tr>");
            }
            out.println("</table><hr>");
            rs1.close();
            stmt.close();

            // 2. PreparedStatement - Filtro por nombre de especialidad
            out.println("<h2>Buscar por Especialidad (PreparedStatement)</h2>");
%>
<form method="get">
    <label>Nombre Especialidad:</label>
    <input type="text" name="especialidad" value="<%= (filtroEspecialidad != null ? filtroEspecialidad : "") %>" required>
    <button type="submit">Buscar</button>
</form>
<%
    if (filtroEspecialidad != null && !filtroEspecialidad.trim().isEmpty()) {
        PreparedStatement pstmt = con.prepareStatement(
                "SELECT m.cod_medicamento, m.descripcion, m.marca, m.stock " +
                        "FROM medicamento m " +
                        "INNER JOIN especialidad e ON m.cod_espec = e.cod_espec " +
                        "WHERE e.descripcion = ?"
        );
        pstmt.setString(1, filtroEspecialidad.trim());
        ResultSet rs2 = pstmt.executeQuery();

        out.println("<table border='1'><tr><th>ID</th><th>Descripción</th><th>Marca</th><th>Stock</th></tr>");
        while (rs2.next()) {
            out.println("<tr><td>" + rs2.getInt("cod_medicamento") + "</td><td>"
                    + rs2.getString("descripcion") + "</td><td>"
                    + rs2.getString("marca") + "</td><td>"
                    + rs2.getInt("stock") + "</td></tr>");
        }
        out.println("</table><hr>");
        rs2.close();
        pstmt.close();
    }

    // 3. CallableStatement - Filtro por nombre de tipo de medicamento
    out.println("<h2>Buscar por Tipo de Medicamento (CallableStatement)</h2>");
%>
<form method="get">
    <label>Nombre Tipo:</label>
    <input type="text" name="tipo" value="<%= (filtroTipo != null ? filtroTipo : "") %>" required>
    <button type="submit">Buscar</button>
</form>
<%
            if (filtroTipo != null && !filtroTipo.trim().isEmpty()) {
                CallableStatement cstmt = con.prepareCall("{CALL sp_medicamentos_por_tipo_nombre(?)}");
                cstmt.setString(1, filtroTipo.trim());
                ResultSet rs3 = cstmt.executeQuery();

                out.println("<table border='1'><tr><th>ID</th><th>Descripción</th><th>Marca</th><th>Stock</th></tr>");
                while (rs3.next()) {
                    out.println("<tr><td>" + rs3.getInt("cod_medicamento") + "</td><td>"
                            + rs3.getString("descripcion") + "</td><td>"
                            + rs3.getString("marca") + "</td><td>"
                            + rs3.getInt("stock") + "</td></tr>");
                }
                out.println("</table><hr>");
                rs3.close();
                cstmt.close();
            }

        }
    } catch (ClassNotFoundException e) {
        out.println("<p style='color:red;'>Error: No se encontró el driver JDBC.</p>");
    } catch (SQLException e) {
        out.println("<p style='color:red;'>Error SQL: " + e.getMessage() + "</p>");
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error general: " + e.getMessage() + "</p>");
    }
%>

</body>
</html>
