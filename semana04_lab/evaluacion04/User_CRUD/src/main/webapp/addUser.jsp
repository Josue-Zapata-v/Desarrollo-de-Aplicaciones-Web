<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Agregar Usuario</title>
</head>
<body>
<h2>Agregar Nuevo Usuario</h2>
<form action="insert" method="post">
    <p>Nombre: <input type="text" name="name" required></p>
    <p>Email: <input type="email" name="email" required></p>
    <p>Password: <input type="password" name="password" required></p>
    <p>Rol:
        <select name="role">
            <option value="admin">Admin</option>
            <option value="teacher">Teacher</option>
            <option value="student">Student</option>
        </select>
    </p>
    <input type="submit" value="Guardar">
    <a href="list">Cancelar</a>
</form>
</body>
</html>
