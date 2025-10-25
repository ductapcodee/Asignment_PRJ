<%-- 
    Document   : list
    Created on : Oct 25, 2025, 9:25:25 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Leave Requests</title>
    </head>
    <body>
        <table border="1">
            <tr>
                <th>ID</th><th>Employee</th><th>From</th><th>To</th><th>Reason</th><th>Status</th><th>Action</th>
            </tr>
            <c:forEach var="r" items="${requests}">
                <tr>
                    <td>${r.id}</td>
                    <td>${r.employeeName}</td>
                    <td>${r.fromDate}</td>
                    <td>${r.toDate}</td>
                    <td>${r.reason}</td>
                    <td>
                <c:choose>
                    <c:when test="${r.status == 1}">In Progress</c:when>
                    <c:when test="${r.status == 2}">Approved</c:when>
                    <c:otherwise>Rejected</c:otherwise>
                </c:choose>
                </td>
                <td>
                <c:if test="${sessionScope.auth.roles[0].rname.contains('PM')}">
                    <form method="post" action="${pageContext.request.contextPath}/request/list">
                        <input type="hidden" name="rid" value="${r.id}">
                        <button name="action" value="approve">Approve</button>
                        <button name="action" value="reject">Reject</button>
                    </form>
                </c:if>
                </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
