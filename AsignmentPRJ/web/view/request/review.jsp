<%-- 
    Document   : review
    Created on : Oct 25, 2025, 9:26:34 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Review Leave Requests from Your Team</title>
    </head>
    <body>

        <table border="1" cellpadding="6">
            <tr><th>ID</th><th>Employee</th><th>From</th><th>To</th><th>Reason</th><th>Status</th><th>Action</th></tr>
            <c:forEach var="r" items="${requests}">
                <tr>
                    <td>${r.id}</td>
                    <td>${r.createdBy}</td>
                    <td>${r.fromDate}</td>
                    <td>${r.toDate}</td>
                    <td>${r.reason}</td>
                    <td>${r.status}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/request/review" method="post">
                            <input type="hidden" name="rid" value="${r.id}">
                            <button name="action" value="approve">Approve</button>
                            <button name="action" value="reject">Reject</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
