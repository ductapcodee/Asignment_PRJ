<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - Leave Management System</title>
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
                --purple-color: #8b5cf6;
                --pink-color: #ec4899;
                --gray-50: #f9fafb;
                --gray-100: #f3f4f6;
                --gray-200: #e5e7eb;
                --gray-300: #d1d5db;
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

            .nav-actions {
                display: flex;
                align-items: center;
                gap: 16px;
            }

            .btn-logout {
                padding: 9px 20px;
                background: white;
                color: var(--danger-color);
                border: 2px solid var(--danger-color);
                text-decoration: none;
                border-radius: 8px;
                font-weight: 600;
                font-size: 14px;
                transition: all 0.2s ease;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }

            .btn-logout:hover {
                background: var(--danger-color);
                color: white;
                transform: translateY(-1px);
            }

            /* Main Container */
            .main-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 32px 24px;
            }

            /* Welcome Card */
            .welcome-card {
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

            .welcome-title {
                font-size: 28px;
                font-weight: 700;
                color: var(--gray-900);
                margin-bottom: 8px;
            }

            .welcome-subtitle {
                font-size: 16px;
                color: var(--gray-600);
                margin-bottom: 20px;
            }

            .role-badges {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            .role-badge {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 8px 16px;
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                border-radius: 8px;
                font-size: 13px;
                font-weight: 600;
            }

            .role-badge.division-head {
                background: linear-gradient(135deg, var(--warning-color), #d97706);
            }

            /* Alert */
            .alert {
                padding: 16px 20px;
                border-radius: 12px;
                margin-bottom: 24px;
                display: flex;
                align-items: center;
                gap: 12px;
                font-weight: 500;
                font-size: 14px;
                background: #d1fae5;
                color: #065f46;
                border-left: 4px solid var(--success-color);
                animation: slideDown 0.3s ease-out;
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

            /* Section Header */
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

            .section-badge {
                background: linear-gradient(135deg, var(--warning-color), #d97706);
                color: white;
                padding: 4px 12px;
                border-radius: 6px;
                font-size: 11px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            /* Action Cards */
            .action-cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 20px;
                margin-bottom: 32px;
            }

            .action-card {
                background: white;
                border: 1px solid var(--gray-200);
                border-radius: 12px;
                padding: 24px;
                text-align: center;
                transition: all 0.3s ease;
                text-decoration: none;
                color: inherit;
                display: block;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                animation: fadeInUp 0.5s ease-out;
                animation-fill-mode: both;
            }

            .action-card:nth-child(1) { animation-delay: 0.1s; }
            .action-card:nth-child(2) { animation-delay: 0.2s; }
            .action-card:nth-child(3) { animation-delay: 0.3s; }
            .action-card:nth-child(4) { animation-delay: 0.4s; }
            .action-card:nth-child(5) { animation-delay: 0.5s; }
            .action-card:nth-child(6) { animation-delay: 0.6s; }

            .action-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 12px 28px rgba(0, 0, 0, 0.12);
                border-color: var(--primary-color);
            }

            .action-icon {
                width: 64px;
                height: 64px;
                margin: 0 auto 16px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 12px;
                font-size: 32px;
            }

            .action-card-primary .action-icon {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
            }

            .action-card-success .action-icon {
                background: linear-gradient(135deg, var(--success-color), #059669);
                color: white;
            }

            .action-card-warning .action-icon {
                background: linear-gradient(135deg, var(--warning-color), #d97706);
                color: white;
            }

            .action-card-info .action-icon {
                background: linear-gradient(135deg, #06b6d4, #0891b2);
                color: white;
            }

            .action-card-purple .action-icon {
                background: linear-gradient(135deg, var(--purple-color), #7c3aed);
                color: white;
            }

            .action-card-pink .action-icon {
                background: linear-gradient(135deg, var(--pink-color), #db2777);
                color: white;
            }

            .action-title {
                font-size: 18px;
                font-weight: 700;
                color: var(--gray-900);
                margin-bottom: 8px;
            }

            .action-description {
                font-size: 14px;
                color: var(--gray-600);
                line-height: 1.5;
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

                .welcome-card {
                    padding: 24px 20px;
                }

                .welcome-title {
                    font-size: 22px;
                }

                .action-cards {
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
                    <div class="nav-brand-icon">🏢</div>
                    <span>Enterprise Leave Management</span>
                </div>
                <div class="nav-actions">
                    <a href="${pageContext.request.contextPath}/login" class="btn-logout">
                        <span>🚪</span> Đăng xuất
                    </a>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="main-container">
            <!-- Success Alert -->
            <c:if test="${not empty sessionScope.success}">
                <div class="alert">
                    <span style="font-size: 20px;">✅</span>
                    <span>${sessionScope.success}</span>
                </div>
                <c:remove var="success" scope="session"/>
            </c:if>

            <!-- Welcome Card -->
            <div class="welcome-card">
                <div class="welcome-title">
                    👋 Xin chào, ${sessionScope.auth.displayname}!
                </div>
                <div class="welcome-subtitle">
                    Chào mừng bạn đến với hệ thống quản lý đơn xin nghỉ
                </div>
                <div class="role-badges">
                    <c:forEach var="role" items="${sessionScope.auth.roles}">
                        <c:set var="isDivisionHead" value="${role.rname eq 'IT Head' || role.rname eq 'QA Head' || role.rname eq 'Sale Head'}" />
                        <span class="role-badge ${isDivisionHead ? 'division-head' : ''}">
                            <span>🎯</span>
                            ${role.rname}
                        </span>
                    </c:forEach>
                </div>
            </div>

            <!-- Check if user is Division Head -->
            <c:set var="isDivisionLeader" value="false" />
            <c:forEach var="role" items="${sessionScope.auth.roles}">
                <c:if test="${role.rname eq 'IT Head' || role.rname eq 'QA Head' || role.rname eq 'Sale Head'}">
                    <c:set var="isDivisionLeader" value="true" />
                </c:if>
            </c:forEach>

            <!-- Common Features Section -->
            <div class="section-header">
                <span style="font-size: 24px;">👤</span>
                <h2 class="section-title">Chức năng chung</h2>
            </div>

            <!-- Common Action Cards -->
            <div class="action-cards">
                <a href="${pageContext.request.contextPath}/request/create" class="action-card action-card-primary">
                    <div class="action-icon">📝</div>
                    <div class="action-title">Tạo đơn xin nghỉ</div>
                    <div class="action-description">
                        Gửi yêu cầu nghỉ phép mới của bạn
                    </div>
                </a>

                <a href="${pageContext.request.contextPath}/request/list" class="action-card action-card-success">
                    <div class="action-icon">📋</div>
                    <div class="action-title">Xem danh sách đơn</div>
                    <div class="action-description">
                        Quản lý và theo dõi các đơn xin nghỉ
                    </div>
                </a>
            </div>

            <!-- Division Leader Features -->
            <c:if test="${isDivisionLeader}">
                <div class="section-header" style="margin-top: 40px;">
                    <span style="font-size: 24px;">⭐</span>
                    <h2 class="section-title">Chức năng dành cho Trưởng phòng</h2>
                    <span class="section-badge">Leader Only</span>
                </div>

                <div class="action-cards">
                    <a href="${pageContext.request.contextPath}/request/dashboard" class="action-card action-card-warning">
                        <div class="action-icon">📊</div>
                        <div class="action-title">Dashboard Tổng Quan</div>
                        <div class="action-description">
                            Xem thống kê và tổng quan về đơn nghỉ phép
                        </div>
                    </a>

                    <a href="${pageContext.request.contextPath}/request/agenda" class="action-card action-card-info">
                        <div class="action-icon">📅</div>
                        <div class="action-title">Leave Agenda</div>
                        <div class="action-description">
                            Xem lịch nghỉ phép của nhân viên theo tháng
                        </div>
                    </a>

                    <a href="${pageContext.request.contextPath}/request/report" class="action-card action-card-purple">
                        <div class="action-icon">📈</div>
                        <div class="action-title">Báo Cáo & Thống Kê</div>
                        <div class="action-description">
                            Tạo và xuất báo cáo chi tiết về nghỉ phép
                        </div>
                    </a>

                    <a href="${pageContext.request.contextPath}/request/team" class="action-card action-card-pink">
                        <div class="action-icon">👥</div>
                        <div class="action-title">Overview Team</div>
                        <div class="action-description">
                            Xem chi tiết thông tin nghỉ phép của từng nhân viên
                        </div>
                    </a>
                </div>
            </c:if>
        </div>
    </body>
</html>