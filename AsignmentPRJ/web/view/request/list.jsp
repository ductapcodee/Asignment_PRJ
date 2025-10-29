<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Leave Request List</title>
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                margin: 30px;
                background-color: #f4f6f8;
            }
            h2 {
                text-align: center;
                color: #333;
            }
            .info {
                text-align: center;
                margin-bottom: 20px;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                background: #fff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }
            th, td {
                border-bottom: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #1976d2;
                color: white;
            }
            tr:hover {
                background-color: #f1f1f1;
            }
            .status {
                font-weight: bold;
            }
            .pending {
                color: orange;
            }
            .approved {
                color: green;
            }
            .rejected {
                color: red;
            }
            .btn {
                display: inline-block;
                padding: 6px 12px;
                color: white;
                background-color: #1976d2;
                border-radius: 4px;
                text-decoration: none;
                font-size: 14px;
            }
            .btn:hover {
                background-color: #125aa0;
            }
            .btn-edit {
                background-color: #ff9800;
            }
            .btn-edit:hover {
                background-color: #e68900;
            }
            .empty {
                text-align: center;
                color: #666;
                margin-top: 30px;
            }
        </style>
    </head>
    <body> 
            <jsp:useBean id="now" class="java.util.Date" />

        <c:if test="${param.updated == 'true'}">
            <div style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 10px;">
                ✅ Cập nhật đơn nghỉ thành công!
            </div>
        </c:if>

        <h2>📋 Danh sách đơn xin nghỉ</h2>

        <div class="info">
            Đăng nhập dưới tên: <b>${currentUser.name}</b> — 
            Vai trò: <b>${roleName}</b>
        </div>

        <c:if test="${empty requests}">
            <div class="empty">Không có đơn xin nghỉ nào được tìm thấy.</div>
        </c:if>

        <c:if test="${not empty requests}">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Người tạo</th>
                        <th>Từ ngày</th>
                        <th>Đến ngày</th>
                        <th>Lý do</th>
                        <th>Trạng thái</th>
                        <th>Người xử lý</th>
                        <th>Ghi chú xử lý</th>
                        <th>Thời gian xử lý</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="r" items="${requests}">
                        <tr>
                            <td>${r.id}</td>
                            <td>${r.createdBy.name}</td>
                            <td>${r.from}</td>
                            <td>${r.to}</td>
                            <td>${r.reason}</td>

                            <td class="status">
                                <c:choose>
                                    <c:when test="${r.status == 1}">
                                        <span class="pending">Đang chờ</span>
                                    </c:when>
                                    <c:when test="${r.status == 2}">
                                        <span class="approved">Đã duyệt</span>
                                    </c:when>
                                    <c:when test="${r.status == 3}">
                                        <span class="rejected">Từ chối</span>
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${r.processedBy != null}">
                                        ${r.processedBy.name}
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>

                            <td>${r.processReason}</td>
                            <td>${r.processedTime}</td>

                            <td>
                                <!-- Nếu đơn đang chờ và là người tạo -->
                                <c:if test="${r.status == 1 && r.createdBy.id == currentUser.id}">
                                    <a class="btn btn-edit" href="${pageContext.request.contextPath}/request/edit?rid=${r.id}">
                                        ✏️ Chỉnh sửa
                                    </a>
                                </c:if>

                                <!-- Nếu đơn đang chờ và KHÔNG phải người tạo -->
                                <c:if test="${r.status == 1 && r.createdBy.id != currentUser.id 
                                              && (roleName.contains('PM') || roleName.contains('Head'))}">
                                      <a class="btn" href="${pageContext.request.contextPath}/request/review?rid=${r.id}">
                                          ✅ Review
                                      </a>
                                </c:if>

                                <!-- Nếu đơn đã xử lý -->
                                <c:if test="${r.status != 1}">
                                    <span>✔ Đã xử lý</span>

                                    <!-- Kiểm tra ngày nghỉ hợp lệ và quyền reprocess -->
                                    <c:if test="${r.from != null}">
                            <fmt:parseDate value="${r.from}" pattern="yyyy-MM-dd" var="fromDate"/>
                            <c:if test="${fromDate.time - now.time > 2*24*60*60*1000}">
                                <c:if test="${roleName.contains('Head')}">
                                    <a class="btn btn-edit" href="${pageContext.request.contextPath}/request/reprocess?rid=${r.id}">
                                        🔁 Reprocess
                                    </a>
                                </c:if>

                                <c:if test="${roleName.contains('PM') 
                                              && r.processedBy != null 
                                              && r.processedBy.supervisor != null}">
                                      <a class="btn btn-edit" href="${pageContext.request.contextPath}/request/reprocess?rid=${r.id}">
                                          🔁 Reprocess
                                      </a>
                                </c:if>
                            </c:if>

                            <c:if test="${leaveDate.isAfter(nowPlus1)}">
                                <!-- Nếu là Division Leader -->
                                <c:if test="${roleName.contains('Head')}">
                                    <a class="btn btn-edit" href="${pageContext.request.contextPath}/request/reprocess?rid=${r.id}">
                                        🔁 Reprocess
                                    </a>
                                </c:if>

                                <!-- Nếu là PM và đơn chưa được xử lý bởi Division Leader -->
                                <c:if test="${roleName.contains('PM') 
                                              && r.processedBy != null 
                                              && r.processedBy.supervisor != null}">
                                      <a class="btn btn-edit" href="${pageContext.request.contextPath}/request/reprocess?rid=${r.id}">
                                          🔁 Reprocess
                                      </a>
                                </c:if>
                            </c:if>
                        </c:if>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</c:if>

</body>
</html>
