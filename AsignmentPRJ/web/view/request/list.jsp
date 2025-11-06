<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Leave Request Management</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 20px;
            }

            .container {
                max-width: 1400px;
                margin: 0 auto;
            }

            /* Header Section */
            .header {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 16px;
                padding: 30px;
                margin-bottom: 24px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            }

            .header-title {
                font-size: 32px;
                font-weight: 700;
                color: #1a202c;
                margin-bottom: 16px;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 20px;
                flex-wrap: wrap;
            }

            .info-badge {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 10px 20px;
                border-radius: 12px;
                font-size: 14px;
                font-weight: 500;
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
            }

            /* Success Alert */
            .alert-success {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                color: white;
                padding: 16px 24px;
                border-radius: 12px;
                margin-bottom: 24px;
                display: flex;
                align-items: center;
                gap: 12px;
                font-weight: 500;
                box-shadow: 0 4px 16px rgba(16, 185, 129, 0.3);
                animation: slideDown 0.3s ease-out;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Table Container */
            .table-container {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 16px;
                overflow: hidden;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            thead {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }

            th {
                color: white;
                padding: 18px 16px;
                text-align: left;
                font-weight: 600;
                font-size: 13px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            th:first-child {
                border-radius: 0;
            }

            tbody tr {
                border-bottom: 1px solid #e5e7eb;
                transition: all 0.2s ease;
            }

            tbody tr:hover {
                background: linear-gradient(90deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
                transform: scale(1.01);
            }

            td {
                padding: 16px;
                color: #374151;
                font-size: 14px;
            }

            /* Status Badges */
            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 6px 14px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .status-pending {
                background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
                color: white;
                box-shadow: 0 2px 8px rgba(245, 158, 11, 0.3);
            }

            .status-approved {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                color: white;
                box-shadow: 0 2px 8px rgba(16, 185, 129, 0.3);
            }

            .status-rejected {
                background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                color: white;
                box-shadow: 0 2px 8px rgba(239, 68, 68, 0.3);
            }

            /* Action Buttons */
            .btn {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 8px 16px;
                border-radius: 8px;
                text-decoration: none;
                font-size: 13px;
                font-weight: 600;
                transition: all 0.2s ease;
                border: none;
                cursor: pointer;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            .btn-primary {
                background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
                color: white;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(59, 130, 246, 0.4);
            }
            .btn-primary-home {
                background: linear-gradient(135deg, #6a5af9 0%, #836fff 100%);
                color: white;
                padding: 10px 22px;
                border-radius: 999px; /* bo tròn đẹp */
                border: none;
                cursor: pointer;
                font-size: 14px;
                font-weight: 600;
                text-decoration: none;
                box-shadow: 0 3px 8px rgba(106, 90, 249, 0.3);
                transition: 0.25s ease;
                display: inline-block;
            }

            /* Hover: sáng hơn + nổi lên */
            .btn-primary-home:hover {
                background: linear-gradient(135deg, #7c6cfa 0%, #9a82ff 100%);
                transform: translateY(-2px);
                box-shadow: 0 7px 18px rgba(106, 90, 249, 0.45);
            }


            .btn-edit {
                background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
                color: white;
            }

            .btn-edit:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(245, 158, 11, 0.4);
            }

            .btn-reprocess {
                background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
                color: white;
            }

            .btn-reprocess:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(139, 92, 246, 0.4);
            }

            .btn-group {
                display: flex;
                gap: 8px;
                flex-wrap: wrap;
            }

            .processed-label {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                color: #059669;
                font-weight: 600;
                font-size: 13px;
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 80px 20px;
                color: white;
            }

            .empty-state-icon {
                font-size: 64px;
                margin-bottom: 16px;
                opacity: 0.9;
            }

            .empty-state-text {
                font-size: 20px;
                font-weight: 600;
                margin-bottom: 8px;
            }

            .empty-state-subtext {
                font-size: 14px;
                opacity: 0.8;
            }

            /* Responsive */
            @media (max-width: 1200px) {
                table {
                    font-size: 13px;
                }

                th, td {
                    padding: 12px 10px;
                }
            }

            @media (max-width: 768px) {
                .header-title {
                    font-size: 24px;
                }

                .table-container {
                    overflow-x: auto;
                }

                table {
                    min-width: 1000px;
                }
            }

            /* Smooth animations */
            .table-container {
                animation: fadeIn 0.4s ease-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>
    <body>
        <jsp:useBean id="now" class="java.util.Date" />

        <div class="container">
            <!-- Success Alert -->
            <c:if test="${param.updated == 'true'}">
                <div class="alert-success">
                    <span style="font-size: 20px;">✅</span>
                    <span>Cập nhật đơn nghỉ thành công!</span>
                </div>
            </c:if>

            <!-- Header -->
            <div class="header">
                <div class="header-title">
                    <span>📋</span>
                    Quản lý đơn xin nghỉ
                </div>

                <div class="user-info">


                    <div class="info-badge">
                        <span>👤</span>
                        <span>${currentUser.name}</span>
                    </div>
                    <div class="info-badge">
                        <span>🎯</span>
                        <span>${roleName}</span>
                    </div>

                </div>
                <div style="display: flex; justify-content: flex-end; margin-bottom: 16px;">
                    <a href="${pageContext.request.contextPath}/home" class="btn-primary-home">
                        Về Trang Chủ
                    </a>
                </div>
            </div>

            <!-- Empty State -->
            <c:if test="${empty requests}">
                <div class="empty-state">
                    <div class="empty-state-icon">📭</div>
                    <div class="empty-state-text">Không có đơn xin nghỉ nào</div>
                    <div class="empty-state-subtext">Danh sách đơn xin nghỉ trống</div>
                </div>
            </c:if>

            <!-- Table -->
            <c:if test="${not empty requests}">
                <div class="table-container">
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
                                    <td><strong>#${r.id}</strong></td>
                                    <td>${r.createdBy.name}</td>
                                    <td>${r.from}</td>
                                    <td>${r.to}</td>
                                    <td>${r.reason}</td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${r.status == 1}">
                                                <span class="status-badge status-pending">
                                                    <span>⏳</span> Đang chờ
                                                </span>
                                            </c:when>
                                            <c:when test="${r.status == 2}">
                                                <span class="status-badge status-approved">
                                                    <span>✓</span> Đã duyệt
                                                </span>
                                            </c:when>
                                            <c:when test="${r.status == 3}">
                                                <span class="status-badge status-rejected">
                                                    <span>✗</span> Từ chối
                                                </span>
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${r.processedBy != null}">
                                                <strong>${r.processedBy.name}</strong>
                                            </c:when>
                                            <c:otherwise><span style="color: #9ca3af;">Chưa xử lý</span></c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>${r.processReason != null ? r.processReason : '-'}</td>
                                    <td>${r.processedTime != null ? r.processedTime : '-'}</td>

                                    <td>
                                        <div class="btn-group">
                                            <!-- Nếu đơn đang chờ và là người tạo -->
                                            <c:if test="${r.status == 1 && r.createdBy.id == currentUser.id}">
                                                <a class="btn btn-edit" href="${pageContext.request.contextPath}/request/edit?rid=${r.id}">
                                                    ✏️ Chỉnh sửa
                                                </a>
                                            </c:if>

                                            <!-- Nếu đơn đang chờ và KHÔNG phải người tạo -->
                                            <c:if test="${r.status == 1 && r.createdBy.id != currentUser.id 
                                                          && (roleName.contains('PM') || roleName.contains('Head'))}">
                                                  <a class="btn btn-primary" href="${pageContext.request.contextPath}/request/review?rid=${r.id}">
                                                      ✅ Review
                                                  </a>
                                            </c:if>

                                            <!-- Nếu đơn đã xử lý -->
                                            <c:if test="${r.status != 1}">
                                                <span class="processed-label">
                                                    <span>✔</span> Đã xử lý
                                                </span>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <!-- Pagination -->
                    <div style="display:flex; justify-content:center; align-items:center; margin:20px 0; gap:8px;">

                        <!-- Previous -->
                        <c:if test="${pageindex > 1}">
                            <a href="${pageContext.request.contextPath}/request/list?page=${pageindex - 1}"
                               style="
                               padding:8px 14px;
                               border-radius:8px;
                               text-decoration:none;
                               font-weight:600;
                               background:white;
                               border:1px solid #ddd;
                               box-shadow:0 2px 6px rgba(0,0,0,0.15);
                               color:#4f46e5;
                               transition:0.2s;">
                                « Trước
                            </a>
                        </c:if>

                        <c:set var="start" value="${pageindex - 2}"/>
                        <c:set var="end" value="${pageindex + 2}"/>

                        <c:if test="${start < 1}">
                            <c:set var="end" value="${end + (1 - start)}"/>
                            <c:set var="start" value="1"/>
                        </c:if>

                        <c:if test="${end > totalpage}">
                            <c:set var="start" value="${start - (end - totalpage)}"/>
                            <c:set var="end" value="${totalpage}"/>
                        </c:if>

                        <c:if test="${start < 1}">
                            <c:set var="start" value="1"/>
                        </c:if>

                        <!-- Page Numbers -->
                        <c:forEach var="i" begin="${start}" end="${end}">
                            <a href="${pageContext.request.contextPath}/request/list?page=${i}"
                               style="
                               margin:0 4px;
                               padding:8px 14px;
                               border-radius:8px;
                               text-decoration:none;
                               font-weight:600;
                               color:${i == pageindex ? 'white' : '#4f46e5'};
                               background:${i == pageindex ? 'linear-gradient(135deg,#6a5af9,#836fff)' : 'white'};
                               box-shadow:0 2px 6px rgba(0,0,0,0.15);
                               border:1px solid #ddd;
                               transition:0.25s;">
                                ${i}
                            </a>
                        </c:forEach>


                        <!-- Next -->
                        <c:if test="${pageindex < totalpage}">
                            <a href="${pageContext.request.contextPath}/request/list?page=${pageindex + 1}"
                               style="
                               padding:8px 14px;
                               border-radius:8px;
                               text-decoration:none;
                               font-weight:600;
                               background:white;
                               border:1px solid #ddd;
                               box-shadow:0 2px 6px rgba(0,0,0,0.15);
                               color:#4f46e5;
                               transition:0.2s;">
                                Tiếp »
                            </a>
                        </c:if>

                    </div>

                </div>
            </c:if>
        </div>
    </body>
</html>