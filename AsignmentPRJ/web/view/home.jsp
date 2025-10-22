<%-- 
    Document   : home
    Created on : Oct 23, 2025, 12:50:06 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome Page</title>
</head>
<body>
    <h2>Xin chào, ${user.displayname}!</h2>

    <p>Bạn đang đăng nhập với vai trò:</p>
    <ul>
        <c:forEach var="role" items="${user.roles}">
            <li>${role.rname}</li>
        </c:forEach>
    </ul>

    <p><a href="login">Đăng xuất</a></p>
</body>
</html>
