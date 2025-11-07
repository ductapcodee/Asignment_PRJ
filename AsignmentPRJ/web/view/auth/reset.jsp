<%-- 
    Document   : reset
    Created on : Nov 8, 2025, 1:03:13 AM
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
        <form action="reset" method="POST">
            <input type="hidden" name="email" value="${email}" />

            <label>Nhập OTP:</label>
            <input type="text" name="otp" required class="form-control"/>

            <label>Mật khẩu mới:</label>
            <input type="password" name="password" required class="form-control"/>

            <button class="btn btn-success mt-3">Đổi mật khẩu</button>

            <c:if test="${not empty error}">
                <p style="color: red;">${error}</p>
            </c:if>
        </form>

    </body>
</html>
