<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.users.user_crud.User" %>
<%
    User user = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5" style="max-width: 600px;">
    <h2 class="text-center mb-4">Editar Usuario</h2>

    <form action="update" method="post" class="card p-4 shadow-sm">
        <input type="hidden" name="id" value="<%= user.getId() %>">

        <div class="mb-3">
            <label for="name" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="name" name="name"
                   value="<%= user.getName() %>" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Correo electrónico</label>
            <input type="email" class="form-control" id="email" name="email"
                   value="<%= user.getEmail() %>" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Contraseña</label>
            <input type="password" class="form-control" id="password" name="password"
                   value="<%= user.getPassword() %>" required>
        </div>

        <div class="mb-3">
            <label for="role" class="form-label">Rol</label>
            <select class="form-select" id="role" name="role" required>
                <option value="admin" <%= "admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
                <option value="teacher" <%= "teacher".equals(user.getRole()) ? "selected" : "" %>>Teacher</option>
                <option value="student" <%= "student".equals(user.getRole()) ? "selected" : "" %>>Student</option>
            </select>
        </div>

        <div class="d-flex justify-content-between">
            <a href="list" class="btn btn-secondary">Cancelar</a>
            <button type="submit" class="btn btn-success">Actualizar</button>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
