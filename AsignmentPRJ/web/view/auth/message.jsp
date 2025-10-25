<%-- 
    Document   : message
    Created on : Oct 22, 2025, 11:43:13 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <span id="message">${requestScope.message}</span>
    </body>
</html>-->

<html>
<head>
    <title>Thông báo</title>
</head>
<body>
    <h3>${requestScope.message}</h3>
    <a href="${pageContext.request.contextPath}/home">← Quay lại trang chủ</a>
</body>
</html>