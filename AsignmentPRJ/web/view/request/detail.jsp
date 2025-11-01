<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết đơn nghỉ</title>
    <style>
        body { 
            font-family: "Segoe UI", sans-serif;
            background:#f2f5f9;
            margin:0;
            padding:50px 0;
        }
        .card {
            width:700px;
            margin:auto;
            background:white;
            border-radius:16px;
            box-shadow:0 4px 12px rgba(0,0,0,0.1);
            overflow:hidden;
            animation: fadeIn 0.4s ease-in-out;
        }
        @keyframes fadeIn { from{opacity:0; transform:translateY(10px);} to{opacity:1; transform:none;} }

        .header {
            background:#3498db;
            color:white;
            padding:20px 30px;
        }
        .header h2 {
            margin:0;
            font-size:24px;
        }

        .section {
            padding:25px 35px;
            border-bottom:1px solid #e0e6ed;
        }

        .label {
            font-weight:600;
            color:#34495e;
            margin-top:10px;
        }
        .value {
            color:#2c3e50;
            margin:4px 0 12px;
        }

        .status {
            display:inline-block;
            padding:6px 14px;
            border-radius:20px;
            font-weight:600;
        }
        .pending { background:#fffaf0; color:#d4a017; border:1px solid #f1c40f; }
        .approved { background:#eafaf1; color:#1d8a4e; border:1px solid #2ecc71; }
        .rejected { background:#fdecea; color:#a8231a; border:1px solid #e74c3c; }

        .footer {
            text-align:center;
            padding:20px;
        }
        .btn {
            background:#3498db;
            color:white;
            border:none;
            border-radius:8px;
            padding:10px 20px;
            text-decoration:none;
            font-size:15px;
            cursor:pointer;
            transition:0.25s;
        }
        .btn:hover {
            background:#2e7ecb;
        }

        .info-grid {
            display:grid;
            grid-template-columns:150px auto;
            row-gap:10px;
        }

        .note {
            background:#f8f9fa;
            border-left:4px solid #3498db;
            padding:10px 15px;
            border-radius:6px;
            margin-top:5px;
        }
    </style>
</head>
<body>

<div class="card">
    <div class="header">
        <h2>Chi tiết đơn nghỉ phép</h2>
        <div style="font-size:14px; opacity:0.9;">
            Tạo lúc: ${request.formattedCreatedTime}
        </div>
    </div>

    <div class="section">
        <div class="info-grid">
            <div class="label">👤 Nhân viên:</div>
            <div class="value">${request.createdBy.name}</div>

            <div class="label">🏢 Bộ phận:</div>
            <div class="value">
                <c:out value="${request.createdBy.division.dname}" default="Không xác định"/>
            </div>

            <div class="label">📅 Từ ngày:</div>
            <div class="value"><fmt:formatDate value="${request.from}" pattern="dd/MM/yyyy"/></div>

            <div class="label">📅 Đến ngày:</div>
            <div class="value"><fmt:formatDate value="${request.to}" pattern="dd/MM/yyyy"/></div>

            <div class="label">⏰ Số ngày nghỉ:</div>
            <div class="value">${request.leaveDays}</div>

            <div class="label">📄 Lý do:</div>
            <div class="value note">${request.reason}</div>

            <div class="label">📌 Trạng thái:</div>
            <div class="value">
                <c:choose>
                    <c:when test="${request.status == 1}">
                        <span class="status pending">⏳ Đang chờ duyệt</span>
                    </c:when>
                    <c:when test="${request.status == 2}">
                        <span class="status approved">✅ Đã duyệt</span>
                    </c:when>
                    <c:otherwise>
                        <span class="status rejected">❌ Đã từ chối</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <c:if test="${request.isProcessed()}">
        <div class="section">
            <div class="label">👔 Xử lý bởi:</div>
            <div class="value">${request.processedBy.name}</div>

            <div class="label">📝 Ghi chú xử lý:</div>
            <div class="value note">
                <c:out value="${request.processReason}" default="(Không có ghi chú)"/>
            </div>
        </div>
    </c:if>

    <div class="footer">
        <a href="${pageContext.request.contextPath}/request/agenda" class="btn">⬅ Quay lại lịch nghỉ</a>
    </div>
</div>

</body>
</html>
