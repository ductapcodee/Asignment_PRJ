<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Review Leave Request</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        textarea { width: 300px; height: 80px; }
        button { margin-right: 10px; }
    </style>
</head>
<body>
    <h2>Review Leave Request</h2>

    <p><b>Employee:</b> ${request.createdBy.name}</p>
    <p><b>Division:</b> ${request.createdBy.division.dname}</p>
    <p><b>From:</b> <fmt:formatDate value="${request.from}" pattern="yyyy-MM-dd" /></p>
    <p><b>To:</b> <fmt:formatDate value="${request.to}" pattern="yyyy-MM-dd" /></p>
    <p><b>Reason:</b> ${request.reason}</p>
    <p><b>Status:</b>
        <c:choose>
            <c:when test="${request.status == 1}">Pending</c:when>
            <c:when test="${request.status == 2}">Rejected</c:when>
            <c:when test="${request.status == 3}">Approved</c:when>
        </c:choose>
    </p>

<form action="${pageContext.request.contextPath}/request/review" method="post">
    <input type="hidden" name="rid" value="${request.id}" />

    <textarea name="process_reason" placeholder="Lý do..." required></textarea>

    <button type="submit" name="action" value="approve" class="btn btn-success">Duyệt</button>
    <button type="submit" name="action" value="reject" class="btn btn-danger">Từ chối</button>
</form>

</body>
</html>
