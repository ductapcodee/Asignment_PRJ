<%-- 
    Document   : forgot
    Created on : Nov 8, 2025, 1:02:57 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="forgot" method="POST">
    <label>Email đăng ký tài khoản:</label>
    <input type="email" name="email" required class="form-control" />
    <button class="btn btn-primary mt-3">Gửi OTP</button>

    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>
</form>

    </body>
</html>
