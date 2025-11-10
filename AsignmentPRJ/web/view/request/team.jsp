<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Team Overview</title>
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
                --gray-600: #4b5563;
                --gray-700: #374151;
                --gray-900: #111827;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
                background: var(--gray-50);
                color: var(--gray-900);
                line-height: 1.6;
                min-height: 100vh;
            }

            /* Top Navigation */
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

            .btn-home {
                padding: 9px 20px;
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                border: none;
                text-decoration: none;
                border-radius: 8px;
                font-weight: 600;
                font-size: 14px;
                transition: all 0.2s ease;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }

            .btn-home:hover {
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
                background: white;
                border-radius: 16px;
                padding: 32px;
                margin-bottom: 32px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                border: 1px solid var(--gray-200);
                animation: fadeInUp 0.4s ease-out;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .page-title {
                font-size: 28px;
                font-weight: 700;
                color: var(--gray-900);
                margin-bottom: 8px;
            }

            .page-subtitle {
                font-size: 16px;
                color: var(--gray-600);
            }

            /* Section Card */
            .section-card {
                background: white;
                border: 1px solid var(--gray-200);
                border-radius: 12px;
                padding: 24px;
                margin-bottom: 24px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                animation: fadeInUp 0.5s ease-out;
            }

            .section-header {
                display: flex;
                align-items: center;
                gap: 12px;
                margin-bottom: 20px;
                padding-bottom: 12px;
                border-bottom: 2px solid var(--gray-200);
            }

            .section-title {
                font-size: 20px;
                font-weight: 700;
                color: var(--gray-900);
            }

            /* Table Styles */
            .data-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 16px;
            }

            .data-table thead {
                background: var(--gray-100);
            }

            .data-table th {
                padding: 12px 16px;
                text-align: left;
                font-weight: 600;
                font-size: 13px;
                color: var(--gray-700);
                text-transform: uppercase;
                letter-spacing: 0.5px;
                border-bottom: 2px solid var(--gray-200);
            }

            .data-table tbody tr {
                border-bottom: 1px solid var(--gray-200);
                transition: all 0.2s ease;
            }

            .data-table tbody tr:hover {
                background: var(--gray-50);
            }

            .data-table td {
                padding: 14px 16px;
                font-size: 14px;
                color: var(--gray-700);
            }

            .badge {
                display: inline-block;
                padding: 4px 12px;
                border-radius: 6px;
                font-size: 12px;
                font-weight: 600;
                text-align: center;
            }

            .badge.approved {
                background: #d1fae5;
                color: #065f46;
            }

            .badge.pending {
                background: #fef3c7;
                color: #92400e;
            }

            .badge.denied {
                background: #fee2e2;
                color: #991b1b;
            }

            .badge.yes {
                background: #d1fae5;
                color: #065f46;
            }

            /* On Leave List */
            .on-leave-list {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 12px;
                margin-top: 16px;
            }

            .on-leave-item {
                background: #d1fae5;
                padding: 12px 16px;
                border-radius: 8px;
                border-left: 4px solid var(--success-color);
                font-weight: 500;
                color: #065f46;
            }

            .empty-state {
                text-align: center;
                padding: 40px;
                color: var(--gray-600);
            }

            .empty-state-icon {
                font-size: 48px;
                margin-bottom: 12px;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .nav-container {
                    height: auto;
                    padding: 16px;
                    flex-direction: column;
                    gap: 16px;
                }

                .main-container {
                    padding: 20px 16px;
                }

                .page-header {
                    padding: 24px 20px;
                }

                .page-title {
                    font-size: 22px;
                }

                .data-table {
                    font-size: 12px;
                }

                .data-table th,
                .data-table td {
                    padding: 10px 8px;
                }

                .on-leave-list {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>

    <body>
        <!-- Top Navigation -->
        <nav class="top-nav">
            <div class="nav-container">
                <div class="nav-brand">
                    <div class="nav-brand-icon">👥</div>
                    <span>Team Overview</span>
                </div>
                <a href="${pageContext.request.contextPath}/home" class="btn-home">
                    <span>🏠</span> Về Trang Chủ
                </a>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="main-container">
            <!-- Page Header -->
            <div class="page-header">
                <div class="page-title">👥 Team Overview</div>
                <div class="page-subtitle">Tổng quan về thông tin nghỉ phép của từng nhân viên</div>
            </div>

            <!-- Team Members Table -->
            <div class="section-card">
                <div class="section-header">
                    <span style="font-size: 24px;">📊</span>
                    <h2 class="section-title">Thành viên trong nhóm</h2>
                </div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Tên nhân viên</th>
                            <th>Phòng ban</th>
                            <th>Quản lý</th>
                            <th>Tổng đơn</th>
                            <th>Đã duyệt</th>
                            <th>Chờ duyệt</th>
                            <th>Tổng ngày nghỉ</th>
                            <th>Nghỉ hôm nay</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="emp" items="${teamMembers}">
                            <c:set var="m" value="${metricsMap[emp.id]}" />
                            <tr>
                                <td><strong>${emp.name}</strong></td>
                                <td>${emp.division.dname}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${emp.supervisor != null}">${emp.supervisor.name}</c:when>
                                        <c:otherwise><span style="color: var(--gray-600);">-</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${m.totalRequests}</td>
                                <td><span class="badge approved">${m.approvedRequests}</span></td>
                                <td><span class="badge pending">${m.pendingRequests}</span></td>
                                <td><strong>${m.totalLeaveDays}</strong></td>
                                <td>
                                    <c:if test="${m.onLeaveToday}">
                                        <span class="badge yes">Có</span>
                                    </c:if>
                                    <c:if test="${!m.onLeaveToday}">
                                        <span style="color: var(--gray-600);">Không</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Employees On Leave Today -->
            <div class="section-card">
                <div class="section-header">
                    <span style="font-size: 24px;">🏖️</span>
                    <h2 class="section-title">Nhân viên nghỉ hôm nay</h2>
                </div>
                <c:if test="${empty onLeaveToday}">
                    <div class="empty-state">
                        <div class="empty-state-icon">✅</div>
                        <p>Không có ai nghỉ hôm nay</p>
                    </div>
                </c:if>
                <c:if test="${not empty onLeaveToday}">
                    <div class="on-leave-list">
                        <c:forEach var="e" items="${onLeaveToday}">
                            <div class="on-leave-item">
                                <strong>${e.name}</strong>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </div>
    </body>
</html>