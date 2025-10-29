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
            max-width: 1200px;
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

        /* Action Cards */
        .action-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
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

        /* Coming Soon Badge */
        .coming-soon-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: white;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            z-index: 2;
        }

        .action-card.disabled {
            opacity: 0.7;
            cursor: not-allowed;
        }

        .action-card.disabled:hover {
            transform: none;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
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

        .action-card:nth-child(1) { animation-delay: 0.1s; }
        .action-card:nth-child(2) { animation-delay: 0.2s; }
        .action-card:nth-child(3) { animation-delay: 0.3s; }

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
    <div class="dashboard-container">
        <!-- Welcome Card -->
        <div class="welcome-card">
            <div class="welcome-title">
                <i class="bi bi-emoji-smile"></i> Xin chào, ${user.displayname}!
            </div>
            <div class="welcome-subtitle">
                Chào mừng bạn đến với hệ thống quản lý đơn xin nghỉ
            </div>
            
            <div class="role-badges">
                <c:forEach var="role" items="${user.roles}">
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
        <c:forEach var="role" items="${user.roles}">
            <c:if test="${role.rname eq 'IT Head' || role.rname eq 'QA Head' || role.rname eq 'Sale Head'}">
                <c:set var="isDivisionLeader" value="true" />
            </c:if>
        </c:forEach>

        <!-- Action Cards -->
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
                    Quản lý và theo dõi các đơn xin nghỉ
                </div>
            </a>

            <!-- Agenda Management (Division Leader only) -->
            <c:if test="${isDivisionLeader}">
                <a href="#" class="action-card action-card-warning disabled" onclick="return false;">
                    <span class="coming-soon-badge">Sắp có</span>
                    <div class="action-icon">
                        <i class="bi bi-calendar-event"></i>
                    </div>
                    <div class="action-title">Quản lý Agenda</div>
                    <div class="action-description">
                        Lập kế hoạch và quản lý agenda (Đang phát triển)
                    </div>
                </a>
            </c:if>
        </div>

        <!-- Logout Section -->
        <div class="logout-section">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-logout">
                <i class="bi bi-box-arrow-right"></i>
                Đăng xuất
            </a>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>