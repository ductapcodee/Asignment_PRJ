<%-- 
    Document   : create
    Created on : Oct 25, 2025, 8:36:38 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Create Leave Request</title>
    </head>
    <body>
        <h2>Đơn xin nghỉ phép</h2>
        <form action="${pageContext.request.contextPath}/request/create" method="post">
            <p>User: ${sessionScope.auth.displayname}</p>
            <p>Role: ${sessionScope.auth.roles != null && !sessionScope.auth.roles.isEmpty()
                       ? sessionScope.auth.roles[0].rname : 'N/A'}</p>
            <p>Department: ${sessionScope.auth.employee != null 
                             ? sessionScope.auth.employee.division.dname : 'N/A'}</p>
            <p>Supervisor: 
                ${sessionScope.auth.employee.supervisor != null 
                  ? sessionScope.auth.employee.supervisor.name 
                  : 'No supervisor'}
            </p>

            <label>From:</label>
            <input type="date" name="from" required><br>

            <label>To:</label>
            <input type="date" name="to" required><br>

            <label>Reason:</label>
            <textarea name="reason" required></textarea><br>

            <button type="submit">Gửi đơn</button>
        </form>

        <p style="color:green">${message}</p>
    </body>
</html>
