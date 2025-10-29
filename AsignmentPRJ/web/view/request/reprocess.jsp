<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Reprocess Request</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <h2>Reprocess Leave Request</h2>

    <c:if test="${not empty request}">
        <form action="${pageContext.request.contextPath}/request/reprocess" method="post">
            <input type="hidden" name="rid" value="${request.id}">

            <table border="1" cellpadding="5">
                <tr><th>Employee</th><td>${request.createdBy.name}</td></tr>
                <tr><th>From</th><td>${request.from}</td></tr>
                <tr><th>To</th><td>${request.to}</td></tr>
                <tr><th>Reason</th><td>${request.reason}</td></tr>
                <tr><th>Previous Status</th><td>${request.status.name}</td></tr>
                <tr><th>Processed By</th><td>${request.processedBy.name}</td></tr>
            </table>

            <br>
            <label>New Decision:</label><br>
            <input type="radio" name="status" value="3" required> Approve<br>
            <input type="radio" name="status" value="2"> Reject<br>

            <br>
            <label>Reason for Reprocess:</label><br>
            <textarea name="process_reason" rows="4" cols="50" required></textarea><br><br>

            <button type="submit">Confirm Reprocess</button>
            <a href="${pageContext.request.contextPath}/request/list">Cancel</a>
        </form>
    </c:if>

    <c:if test="${empty request}">
        <p style="color:red;">No request found!</p>
    </c:if>
</body>
</html>
