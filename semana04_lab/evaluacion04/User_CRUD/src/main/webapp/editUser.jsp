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
</head>
<body>
<h2>Editar Usuario</h2>
<form action="update" method="post">
    <input type="hidden" name="id" value="<%= user.getId() %>">
    <p>Nombre: <input type="text" name="name" value="<%= user.getName() %>" required></p>
    <p>Email: <input type="email" name="email" value="<%= user.getEmail() %>" required></p>
    <p>Password: <input type="password" name="password" value="<%= user.getPassword() %>" required></p>
    <p>Rol:
        <select name="role">
            <option value="admin" <%= "admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
            <option value="teacher" <%= "teacher".equals(user.getRole()) ? "selected" : "" %>>Teacher</option>
            <option value="student" <%= "student".equals(user.getRole()) ? "selected" : "" %>>Student</option>
        </select>
    </p>
    <input type="submit" value="Actualizar">
    <a href="list">Cancelar</a>
</form>
</body>
</html>
