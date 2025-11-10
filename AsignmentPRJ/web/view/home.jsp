<%-- 
    Document   : home
    Created on : Oct 23, 2025, 12:50:06 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - Leave Request System</title>

        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Inter', sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 20px 0;
            }

            .dashboard-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 0 15px;
            }

            /* Welcome Card */
            .welcome-card {
                background: white;
                border-radius: 20px;
                padding: 40px;
                margin-bottom: 30px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                position: relative;
                overflow: hidden;
            }

            .welcome-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 5px;
                background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            }

            .welcome-title {
                font-size: 32px;
                font-weight: 700;
                color: #1a202c;
                margin-bottom: 10px;
            }

            .welcome-subtitle {
                font-size: 18px;
                color: #718096;
                margin-bottom: 20px;
            }

            .role-badges {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
                margin-bottom: 20px;
            }

            .role-badge {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 8px 20px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .role-badge.division-head {
                background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
                box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
            }

            /* Section Divider */
            .section-divider {
                background: white;
                border-radius: 12px;
                padding: 15px 25px;
                margin: 30px 0 20px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            }

            .section-title {
                font-size: 20px;
                font-weight: 700;
                color: #1a202c;
                margin: 0;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .section-title .badge {
                background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
                color: white;
                padding: 4px 12px;
                border-radius: 12px;
                font-size: 11px;
                font-weight: 700;
            }

            /* Action Cards */
            .action-cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .action-card {
                background: white;
                border-radius: 16px;
                padding: 30px;
                text-align: center;
                transition: all 0.3s ease;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
                text-decoration: none;
                color: inherit;
                display: block;
                position: relative;
                overflow: hidden;
                border: 2px solid transparent;
            }

            .action-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 100%;
                background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .action-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
                border-color: rgba(102, 126, 234, 0.3);
            }

            .action-card:hover::before {
                opacity: 1;
            }

            .action-icon {
                width: 80px;
                height: 80px;
                margin: 0 auto 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 20px;
                font-size: 40px;
                position: relative;
                z-index: 1;
            }

            .action-card-primary .action-icon {
                background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
                color: white;
                box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3);
            }

            .action-card-success .action-icon {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                color: white;
                box-shadow: 0 8px 20px rgba(16, 185, 129, 0.3);
            }

            .action-card-warning .action-icon {
                background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
                color: white;
                box-shadow: 0 8px 20px rgba(245, 158, 11, 0.3);
            }

            .action-card-info .action-icon {
                background: linear-gradient(135deg, #06b6d4 0%, #0891b2 100%);
                color: white;
                box-shadow: 0 8px 20px rgba(6, 182, 212, 0.3);
            }

            .action-card-purple .action-icon {
                background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
                color: white;
                box-shadow: 0 8px 20px rgba(139, 92, 246, 0.3);
            }

            .action-card-pink .action-icon {
                background: linear-gradient(135deg, #ec4899 0%, #db2777 100%);
                color: white;
                box-shadow: 0 8px 20px rgba(236, 72, 153, 0.3);
            }

            .action-title {
                font-size: 20px;
                font-weight: 700;
                color: #1a202c;
                margin-bottom: 10px;
                position: relative;
                z-index: 1;
            }

            .action-description {
                font-size: 14px;
                color: #718096;
                position: relative;
                z-index: 1;
                line-height: 1.6;
            }

            /* Logout Button */
            .logout-section {
                text-align: center;
                margin-top: 30px;
            }

            .btn-logout {
                background: white;
                color: #ef4444;
                border: 2px solid #ef4444;
                padding: 12px 30px;
                border-radius: 12px;
                font-weight: 600;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 10px;
                text-decoration: none;
            }

            .btn-logout:hover {
                background: #ef4444;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(239, 68, 68, 0.3);
            }

            /* Animations */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .welcome-card {
                animation: fadeInUp 0.5s ease-out;
            }

            .action-card {
                animation: fadeInUp 0.5s ease-out;
                animation-fill-mode: both;
            }

            .action-card:nth-child(1) {
                animation-delay: 0.1s;
            }
            .action-card:nth-child(2) {
                animation-delay: 0.2s;
            }
            .action-card:nth-child(3) {
                animation-delay: 0.3s;
            }
            .action-card:nth-child(4) {
                animation-delay: 0.4s;
            }
            .action-card:nth-child(5) {
                animation-delay: 0.5s;
            }
            .action-card:nth-child(6) {
                animation-delay: 0.6s;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .welcome-card {
                    padding: 30px 20px;
                }

                .welcome-title {
                    font-size: 24px;
                }

                .welcome-subtitle {
                    font-size: 16px;
                }

                .action-cards {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <c:if test="${not empty sessionScope.success}">
            <div style="
                 background: #d4edda;
                 border: 1px solid #c3e6cb;
                 color: #155724;
                 padding: 12px 18px;
                 border-radius: 6px;
                 margin: 15px 0;
                 font-size: 15px;
                 ">
                ✅ ${sessionScope.success}
            </div>
            <c:remove var="success" scope="session"/>
        </c:if>

        <div class="dashboard-container">
            <!-- Welcome Card -->
            <div class="welcome-card">
                <div class="welcome-title">
                    <i class="bi bi-emoji-smile"></i> Xin chào, ${sessionScope.auth.displayname}!
                </div>
                <div class="welcome-subtitle">
                    Chào mừng bạn đến với hệ thống quản lý đơn xin nghỉ
                </div>

                <div class="role-badges">
                    <c:forEach var="role" items="${sessionScope.auth.roles}">
                        <c:set var="isDivisionHead" value="${role.rname eq 'IT Head' || role.rname eq 'QA Head' || role.rname eq 'Sale Head'}" />
                        <span class="role-badge ${isDivisionHead ? 'division-head' : ''}">
                            <i class="bi bi-shield-check"></i>
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
            <div class="section-divider">
                <h2 class="section-title">
                    <i class="bi bi-person-circle"></i>
                    Chức năng chung
                </h2>
            </div>

            <!-- Common Action Cards -->
            <div class="action-cards">
                <!-- Create Leave Request -->
                <a href="${pageContext.request.contextPath}/request/create" class="action-card action-card-primary">
                    <div class="action-icon">
                        <i class="bi bi-plus-circle"></i>
                    </div>
                    <div class="action-title">Tạo đơn xin nghỉ</div>
                    <div class="action-description">
                        Gửi yêu cầu nghỉ phép mới của bạn
                    </div>
                </a>

                <!-- View Leave Requests -->
                <a href="${pageContext.request.contextPath}/request/list" class="action-card action-card-success">
                    <div class="action-icon">
                        <i class="bi bi-list-check"></i>
                    </div>
                    <div class="action-title">Xem danh sách đơn</div>
                    <div class="action-description">
                        Quản lý và theo dõi các đơn xin nghỉ của bạn
                    </div>
                </a>
            </div>

            <!-- Division Leader Features Section -->
            <c:if test="${isDivisionLeader}">
                <div class="section-divider">
                    <h2 class="section-title">
                        <i class="bi bi-star-fill"></i>
                        Chức năng dành cho Trưởng phòng
                        <span class="badge">LEADER ONLY</span>
                    </h2>
                </div>

                <!-- Leader Action Cards -->
                <div class="action-cards">
                    <!-- Dashboard -->
                    <a href="${pageContext.request.contextPath}/request/dashboard" class="action-card action-card-warning">
                        <div class="action-icon">
                            <i class="bi bi-speedometer2"></i>
                        </div>
                        <div class="action-title">Dashboard Tổng Quan</div>
                        <div class="action-description">
                            Xem thống kê và tổng quan về đơn nghỉ phép của phòng ban
                        </div>
                    </a>

                    <!-- Calendar/Agenda -->
                    <a href="${pageContext.request.contextPath}/request/agenda" class="action-card action-card-info">
                        <div class="action-icon">
                            <i class="bi bi-calendar-event"></i>
                        </div>
                        <div class="action-title">Leave Agenda</div>
                        <div class="action-description">
                            Xem lịch nghỉ phép của nhân viên theo tháng
                        </div>
                    </a>

                    <!-- Reports -->
                    <a href="${pageContext.request.contextPath}/request/report" class="action-card action-card-purple">
                        <div class="action-icon">
                            <i class="bi bi-file-earmark-bar-graph"></i>
                        </div>
                        <div class="action-title">Báo Cáo & Thống Kê</div>
                        <div class="action-description">
                            Tạo và xuất báo cáo chi tiết về nghỉ phép (Excel, CSV)
                        </div>
                    </a>

                    <!-- Team Overview -->
                    <a href="${pageContext.request.contextPath}/request/team" class="action-card action-card-pink">
                        <div class="action-icon">
                            <i class="bi bi-people"></i>
                        </div>
                        <div class="action-title">Oveview Team</div>
                        <div class="action-description">
                            Xem chi tiết thông tin nghỉ phép của từng nhân viên
                        </div>
                    </a>
                </div>
            </c:if>


            <!-- Logout Section -->
            <div class="logout-section">
                <a href="${pageContext.request.contextPath}/login" class="btn-logout">
                    <i class="bi bi-box-arrow-right"></i>
                    Đăng xuất
                </a>
            </div>
        </div>

        <!-- Bootstrap 5 JS Bundle -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html> 