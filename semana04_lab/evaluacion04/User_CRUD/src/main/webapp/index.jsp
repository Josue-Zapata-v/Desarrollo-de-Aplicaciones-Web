<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.users.user_crud.User" %>
<%
    List<User> listUser = (List<User>) request.getAttribute("listUser");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Usuarios</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin: auto; }
        th, td { border: 1px solid #333; padding: 8px; text-align: center; }
        th { background-color: #eee; }
        a { text-decoration: none; color: blue; }
    </style>
</head>
<body>
<h2 style="text-align:center;">Lista de Usuarios</h2>
<p style="text-align:center;"><a href="new">Agregar Nuevo Usuario</a></p>
<table>
    <tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Email</th>
        <th>Rol</th>
        <th>Creado</th>
        <th>Acciones</th>
    </tr>
    <% if (listUser != null) {
        for (User u : listUser) { %>
    <tr>
        <td><%= u.getId() %></td>
        <td><%= u.getName() %></td>
        <td><%= u.getEmail() %></td>
        <td><%= u.getRole() %></td>
        <td><%= u.getCreatedAt() %></td>
        <td>
            <a href="edit?id=<%= u.getId() %>">Editar</a> |
            <a href="delete?id=<%= u.getId() %>">Eliminar</a>
        </td>
    </tr>
    <%  }
    } %>
</table>
</body>
</html>
