<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Đơn Nghỉ Phép - Enterprise System</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            :root {
                --primary-color: #2563eb;
                --primary-dark: #1e40af;
                --secondary-color: #0ea5e9;
                --success-color: #10b981;
                --warning-color: #f59e0b;
                --danger-color: #ef4444;
                --gray-50: #f9fafb;
                --gray-100: #f3f4f6;
                --gray-200: #e5e7eb;
                --gray-300: #d1d5db;
                --gray-600: #4b5563;
                --gray-700: #374151;
                --gray-800: #1f2937;
                --gray-900: #111827;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
                background: var(--gray-50);
                color: var(--gray-900);
                line-height: 1.6;
                min-height: 100vh;
            }

            /* Top Navigation Bar */
            .top-nav {
                background: white;
                border-bottom: 1px solid var(--gray-200);
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
                position: sticky;
                top: 0;
                z-index: 100;
            }

            .nav-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 0 24px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                height: 64px;
            }

            .nav-brand {
                display: flex;
                align-items: center;
                gap: 12px;
                font-size: 18px;
                font-weight: 700;
                color: var(--gray-900);
            }

            .nav-brand-icon {
                width: 36px;
                height: 36px;
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 18px;
            }

            .nav-actions {
                display: flex;
                align-items: center;
                gap: 16px;
            }

            .user-badge {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 8px 16px;
                background: var(--gray-100);
                border-radius: 12px;
                font-size: 14px;
            }

            .user-avatar {
                width: 32px;
                height: 32px;
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: 600;
                font-size: 13px;
            }

            .user-info {
                display: flex;
                flex-direction: column;
                gap: 2px;
            }

            .user-name {
                font-weight: 600;
                color: var(--gray-900);
                font-size: 13px;
            }

            .user-role {
                font-size: 11px;
                color: var(--gray-600);
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .btn-home {
                padding: 9px 20px;
                background: var(--primary-color);
                color: white;
                text-decoration: none;
                border-radius: 8px;
                font-weight: 600;
                font-size: 14px;
                transition: all 0.2s ease;
                border: none;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }

            .btn-home:hover {
                background: var(--primary-dark);
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
            }

            /* Main Container */
            .main-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 32px 24px;
            }

            /* Page Header */
            .page-header {
                margin-bottom: 32px;
            }

            .page-title {
                font-size: 28px;
                font-weight: 700;
                color: var(--gray-900);
                margin-bottom: 8px;
            }

            .page-subtitle {
                font-size: 14px;
                color: var(--gray-600);
            }

            /* Alert Messages */
            .alert {
                padding: 16px 20px;
                border-radius: 12px;
                margin-bottom: 24px;
                display: flex;
                align-items: center;
                gap: 12px;
                font-weight: 500;
                font-size: 14px;
                animation: slideDown 0.3s ease-out;
            }

            .alert-success {
                background: #d1fae5;
                color: #065f46;
                border-left: 4px solid var(--success-color);
            }

            .alert-error {
                background: #fee2e2;
                color: #991b1b;
                border-left: 4px solid var(--danger-color);
            }

            .alert-icon {
                font-size: 20px;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Stats Cards */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 32px;
            }

            .stat-card {
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                border: 1px solid var(--gray-200);
            }

            .stat-label {
                font-size: 13px;
                color: var(--gray-600);
                font-weight: 500;
                margin-bottom: 8px;
            }

            .stat-value {
                font-size: 24px;
                font-weight: 700;
                color: var(--gray-900);
            }

            /* Table Card */
            .table-card {
                background: white;
                border-radius: 12px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                border: 1px solid var(--gray-200);
                overflow: hidden;
            }

            .table-header {
                padding: 20px 24px;
                border-bottom: 1px solid var(--gray-200);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .table-title {
                font-size: 16px;
                font-weight: 600;
                color: var(--gray-900);
            }

            .table-container {
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            thead {
                background: var(--gray-50);
            }

            th {
                padding: 14px 20px;
                text-align: left;
                font-weight: 600;
                font-size: 12px;
                color: var(--gray-700);
                text-transform: uppercase;
                letter-spacing: 0.5px;
                border-bottom: 1px solid var(--gray-200);
            }

            tbody tr {
                border-bottom: 1px solid var(--gray-200);
                transition: background-color 0.15s ease;
            }

            tbody tr:hover {
                background: var(--gray-50);
            }

            tbody tr:last-child {
                border-bottom: none;
            }

            td {
                padding: 16px 20px;
                font-size: 14px;
                color: var(--gray-700);
                vertical-align: middle;
            }

            td strong {
                color: var(--gray-900);
                font-weight: 600;
            }

            /* Status Badges */
            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 5px 12px;
                border-radius: 6px;
                font-size: 12px;
                font-weight: 600;
                text-transform: capitalize;
            }

            .status-pending {
                background: #fef3c7;
                color: #92400e;
            }

            .status-approved {
                background: #d1fae5;
                color: #065f46;
            }

            .status-rejected {
                background: #fee2e2;
                color: #991b1b;
            }

            /* Action Buttons */
            .btn {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 7px 14px;
                border-radius: 6px;
                text-decoration: none;
                font-size: 13px;
                font-weight: 500;
                transition: all 0.2s ease;
                border: 1px solid transparent;
                cursor: pointer;
                white-space: nowrap;
            }

            .btn-primary {
                background: var(--primary-color);
                color: white;
            }

            .btn-primary:hover {
                background: var(--primary-dark);
                box-shadow: 0 2px 8px rgba(37, 99, 235, 0.3);
            }

            .btn-edit {
                background: white;
                color: var(--warning-color);
                border-color: var(--warning-color);
            }

            .btn-edit:hover {
                background: var(--warning-color);
                color: white;
            }

            .btn-delete {
                background: white;
                color: var(--danger-color);
                border-color: var(--danger-color);
            }

            .btn-delete:hover {
                background: var(--danger-color);
                color: white;
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
                color: var(--gray-600);
                font-size: 13px;
                font-weight: 500;
            }

            /* Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                padding: 24px;
                border-top: 1px solid var(--gray-200);
            }

            .pagination a {
                padding: 8px 14px;
                border-radius: 6px;
                text-decoration: none;
                font-weight: 500;
                font-size: 14px;
                color: var(--gray-700);
                background: white;
                border: 1px solid var(--gray-300);
                transition: all 0.2s ease;
            }

            .pagination a:hover {
                background: var(--gray-50);
                border-color: var(--primary-color);
                color: var(--primary-color);
            }

            .pagination a.active {
                background: var(--primary-color);
                color: white;
                border-color: var(--primary-color);
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 80px 20px;
            }

            .empty-state-icon {
                font-size: 64px;
                margin-bottom: 16px;
                opacity: 0.5;
            }

            .empty-state-title {
                font-size: 18px;
                font-weight: 600;
                color: var(--gray-900);
                margin-bottom: 8px;
            }

            .empty-state-text {
                font-size: 14px;
                color: var(--gray-600);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .nav-container {
                    height: auto;
                    padding: 16px;
                    flex-direction: column;
                    gap: 16px;
                }

                .page-title {
                    font-size: 22px;
                }

                .table-card {
                    border-radius: 8px;
                }

                table {
                    font-size: 13px;
                }

                th, td {
                    padding: 12px 10px;
                }

                .btn-group {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <!-- Top Navigation -->
        <nav class="top-nav">
            <div class="nav-container">
                <div class="nav-brand">
                    <div class="nav-brand-icon">🏢</div>
                    <span>Enterprise Leave Management</span>
                </div>
                <div class="nav-actions">
                    <div class="user-badge">
                        <div class="user-avatar">${currentUser.name.substring(0, 1).toUpperCase()}</div>
                        <div class="user-info">
                            <div class="user-name">${currentUser.name}</div>
                            <div class="user-role">${roleName}</div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/home" class="btn-home">
                        <span>🏠</span> Trang chủ
                    </a>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="main-container">
            <!-- Alerts -->
            <c:if test="${param.updated == 'true'}">
                <div class="alert alert-success">
                    <span class="alert-icon">✅</span>
                    <span>Cập nhật đơn nghỉ thành công!</span>
                </div>
            </c:if>

            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success">
                    <span class="alert-icon">✅</span>
                    <span>${sessionScope.success}</span>
                </div>
                <c:remove var="success" scope="session"/>
            </c:if>

            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-error">
                    <span class="alert-icon">⚠️</span>
                    <span>${sessionScope.error}</span>
                </div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">Quản lý Đơn Xin Nghỉ</h1>
                <p class="page-subtitle">Xem và quản lý tất cả đơn nghỉ phép trong hệ thống</p>
            </div>

            <!-- Content -->
            <c:choose>
                <c:when test="${empty requests}">
                    <div class="table-card">
                        <div class="empty-state">
                            <div class="empty-state-icon">📋</div>
                            <div class="empty-state-title">Chưa có đơn nghỉ phép nào</div>
                            <div class="empty-state-text">Danh sách đơn nghỉ phép hiện đang trống</div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-card">
                        <div class="table-header">
                            <div class="table-title">Danh sách đơn nghỉ phép</div>
                        </div>
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Mã đơn</th>
                                        <th>Người tạo</th>
                                        <th>Từ ngày</th>
                                        <th>Đến ngày</th>
                                        <th>Lý do</th>
                                        <th>Trạng thái</th>
                                        <th>Người xử lý</th>
                                        <th>Ghi chú</th>
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
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${r.processedBy != null}">
                                                        <strong>${r.processedBy.name}</strong>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: var(--gray-600);">—</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${r.processReason != null ? r.processReason : '—'}</td>
                                            <td>${r.processedTime != null ? r.processedTime : '—'}</td>
                                            <td>
                                                <div class="btn-group">
                                                    <c:if test="${r.status == 1 && r.createdBy.id == currentUser.id}">
                                                        <a class="btn btn-edit" href="${pageContext.request.contextPath}/request/edit?rid=${r.id}">
                                                            ✏️ Sửa
                                                        </a>
                                                        <a class="btn btn-delete" href="${pageContext.request.contextPath}/request/delete?id=${r.id}" 
                                                           onclick="return confirm('Bạn có chắc muốn xóa đơn này?')">
                                                            🗑️ Xóa
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${r.status == 1 && r.createdBy.id != currentUser.id 
                                                                  && (roleName.contains('PM') || roleName.contains('Head'))}">
                                                        <a class="btn btn-primary" href="${pageContext.request.contextPath}/request/review?rid=${r.id}">
                                                            ✅ Duyệt
                                                        </a>
                                                    </c:if>
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
                        </div>

                        <!-- Pagination -->
                        <div class="pagination">
                            <c:if test="${pageindex > 1}">
                                <a href="${pageContext.request.contextPath}/request/list?page=${pageindex - 1}">
                                    ← Trước
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

                            <c:forEach var="i" begin="${start}" end="${end}">
                                <a href="${pageContext.request.contextPath}/request/list?page=${i}"
                                   class="${i == pageindex ? 'active' : ''}">
                                    ${i}
                                </a>
                            </c:forEach>

                            <c:if test="${pageindex < totalpage}">
                                <a href="${pageContext.request.contextPath}/request/list?page=${pageindex + 1}">
                                    Tiếp →
                                </a>
                            </c:if>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>