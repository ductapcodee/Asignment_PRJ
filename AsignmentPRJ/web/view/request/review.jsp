<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Review Leave Request</title>

    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f4f6fa;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 680px;
            margin: 40px auto;
            background: white;
            padding: 28px 34px;
            border-radius: 14px;
            box-shadow: 0 5px 14px rgba(0,0,0,0.08);
        }
        h2 {
            margin-top: 0;
            font-size: 22px;
            font-weight: 600;
            color: #111827;
            margin-bottom: 20px;
        }
        .info p {
            margin: 8px 0;
            font-size: 15px;
        }
        .label {
            font-weight: 600;
            color: #374151;
        }
        .status {
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 6px;
        }
        .status.pending { background:#fbbf24; color:#78350f; }
        .status.approved { background:#22c55e; color:#064e3b; }
        .status.rejected { background:#ef4444; color:#450a0a; }

        textarea {
            width: 100%;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            padding: 10px;
            font-size: 14px;
            margin-top: 12px;
            resize: vertical;
            min-height: 90px;
        }
        .actions {
            margin-top: 18px;
            display: flex;
            gap: 12px;
        }
        button {
            flex: 1;
            padding: 10px 0;
            border-radius: 8px;
            border: none;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
        }
        .btn-approve { background: #22c55e; color: white; }
        .btn-reject { background: #ef4444; color: white; }
        .back-link {
            display: inline-block;
            margin-top: 22px;
            text-decoration: none;
            padding: 10px 16px;
            font-weight: 600;
            border-radius: 8px;
            background: #4f46e5;
            color: white;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Review Leave Request</h2>

    <div class="info">
        <p><span class="label">Nhân viên:</span> ${request.createdBy.name}</p>
        <p><span class="label">Bộ phận:</span> ${request.createdBy.division.dname}</p>
        <p><span class="label">Thời gian nghỉ:</span> 
            <fmt:formatDate value="${request.from}" pattern="dd/MM/yyyy"/> → 
            <fmt:formatDate value="${request.to}" pattern="dd/MM/yyyy"/></p>
        <p><span class="label">Lý do nghỉ:</span> ${request.reason}</p>

        <p><span class="label">Trạng thái:</span>
            <c:choose>
                <c:when test="${request.status == 1}"><span class="status pending">Pending</span></c:when>
                <c:when test="${request.status == 2}"><span class="status rejected">Rejected</span></c:when>
                <c:when test="${request.status == 3}"><span class="status approved">Approved</span></c:when>
            </c:choose>
        </p>
    </div>

    <form action="${pageContext.request.contextPath}/request/review" method="post">
        <input type="hidden" name="rid" value="${request.id}" />

        <textarea name="process_reason" placeholder="Nhập lý do xử lý..." required></textarea>

        <div class="actions">
            <button type="submit" name="action" value="approve" class="btn-approve">✔ Duyệt</button>
            <button type="submit" name="action" value="reject" class="btn-reject">✖ Từ chối</button>
        </div>
    </form>

    <a class="back-link" href="${pageContext.request.contextPath}/request/list">⟵ Quay về danh sách</a>

</div>

</body>
</html>
