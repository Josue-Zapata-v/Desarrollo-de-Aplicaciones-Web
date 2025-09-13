<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.users.user_crud.User" %>
<%
    List<User> listUser = (List<User>) request.getAttribute("listUser");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">
    <h2 class="text-center mb-4">Lista de Usuarios</h2>

    <div class="mb-3 text-end">
        <a href="new" class="btn btn-primary">Agregar Nuevo Usuario</a>
    </div>

    <table class="table table-bordered table-hover text-center bg-white">
        <thead class="table-secondary">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Email</th>
            <th>Rol</th>
            <th>Creado</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <% if (listUser != null && !listUser.isEmpty()) {
            for (User u : listUser) { %>
        <tr>
            <td><%= u.getId() %></td>
            <td><%= u.getName() %></td>
            <td><%= u.getEmail() %></td>
            <td><%= u.getRole() %></td>
            <td><%= u.getCreatedAt() %></td>
            <td>
                <a href="edit?id=<%= u.getId() %>" class="btn btn-sm btn-outline-warning">Editar</a>
                <a href="delete?id=<%= u.getId() %>" class="btn btn-sm btn-outline-danger"
                   onclick="return confirm('¿Seguro que deseas eliminar este usuario?');">Eliminar</a>
            </td>
        </tr>
        <% }
        } else { %>
        <tr>
            <td colspan="6" class="text-muted">No hay usuarios registrados.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
