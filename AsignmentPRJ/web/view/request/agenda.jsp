<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leave Agenda - Leave Management System</title>
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
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .page-subtitle {
            font-size: 14px;
            color: var(--gray-600);
        }

        /* Statistics Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 32px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--gray-200);
            transition: all 0.3s ease;
            animation: fadeInUp 0.5s ease-out;
            animation-fill-mode: both;
        }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.12);
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 12px;
        }

        .stat-card.total .stat-icon {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
        }

        .stat-card.pending .stat-icon {
            background: linear-gradient(135deg, var(--warning-color), #d97706);
            color: white;
        }

        .stat-card.approved .stat-icon {
            background: linear-gradient(135deg, var(--success-color), #059669);
            color: white;
        }

        .stat-card.rejected .stat-icon {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
            color: white;
        }

        .stat-label {
            font-size: 13px;
            font-weight: 600;
            color: var(--gray-600);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: var(--gray-900);
        }

        /* Filter Section */
        .filter-section {
            background: white;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--gray-200);
        }

        .filter-group {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 16px;
            align-items: end;
        }

        .filter-item label {
            display: block;
            font-weight: 600;
            color: var(--gray-700);
            margin-bottom: 8px;
            font-size: 14px;
        }

        .filter-item select,
        .filter-item input {
            width: 100%;
            padding: 10px 12px;
            border: 2px solid var(--gray-200);
            border-radius: 8px;
            font-size: 14px;
            font-family: inherit;
            transition: all 0.2s ease;
        }

        .filter-item select:focus,
        .filter-item input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .btn-export {
            padding: 10px 20px;
            background: linear-gradient(135deg, var(--success-color), #059669);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-export:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }

        /* View Toggle */
        .view-toggle {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
            background: white;
            padding: 8px;
            border-radius: 12px;
            width: fit-content;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--gray-200);
        }

        .btn-view {
            padding: 10px 20px;
            background: transparent;
            border: none;
            color: var(--gray-600);
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-view.active {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
        }

        .btn-view:hover:not(.active) {
            background: var(--gray-100);
            color: var(--gray-900);
        }

        /* Calendar Container */
        .calendar-container {
            background: white;
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--gray-200);
        }

        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
            padding-bottom: 24px;
            border-bottom: 2px solid var(--gray-200);
        }

        .calendar-title {
            font-size: 24px;
            font-weight: 700;
            color: var(--gray-900);
        }

        .calendar-nav {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .btn-nav {
            padding: 10px 18px;
            background: white;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-nav:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        .btn-today {
            background: var(--gray-100);
            color: var(--gray-700);
            border-color: var(--gray-300);
        }

        .btn-today:hover {
            background: var(--gray-200);
            color: var(--gray-900);
            border-color: var(--gray-400);
        }

        /* Calendar Grid */
        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 1px;
            background: var(--gray-200);
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid var(--gray-200);
        }

        .calendar-day-header {
            background: linear-gradient(135deg, var(--gray-700), var(--gray-900));
            color: white;
            padding: 16px;
            text-align: center;
            font-weight: 700;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .calendar-day {
            background: white;
            min-height: 120px;
            padding: 12px;
            position: relative;
            transition: all 0.2s ease;
        }

        .calendar-day:hover {
            background: var(--gray-50);
        }

        .calendar-day.other-month {
            background: var(--gray-50);
            opacity: 0.5;
        }

        .calendar-day.today {
            background: linear-gradient(135deg, #ebf5ff, #e0f2fe);
            border: 2px solid var(--primary-color);
        }

        .day-number {
            font-weight: 700;
            color: var(--gray-900);
            margin-bottom: 8px;
            font-size: 14px;
        }

        .calendar-day.today .day-number {
            color: var(--primary-color);
        }

        .leave-item {
            padding: 6px 8px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 600;
            margin-bottom: 4px;
            cursor: pointer;
            transition: all 0.2s ease;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            color: white;
        }

        .leave-item:hover {
            transform: translateX(2px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        .leave-item.pending {
            background: linear-gradient(135deg, var(--warning-color), #d97706);
        }

        .leave-item.approved {
            background: linear-gradient(135deg, var(--success-color), #059669);
        }

        .leave-item.rejected {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
        }

        /* List View */
        .list-view {
            display: none;
        }

        .list-view.active {
            display: block;
        }

        .leave-list-item {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            margin-bottom: 12px;
            border: 1px solid var(--gray-200);
            border-left: 4px solid;
            transition: all 0.2s ease;
        }

        .leave-list-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .leave-list-item.pending {
            border-left-color: var(--warning-color);
        }

        .leave-list-item.approved {
            border-left-color: var(--success-color);
        }

        .leave-list-item.rejected {
            border-left-color: var(--danger-color);
        }

        .employee-name {
            font-weight: 700;
            font-size: 16px;
            color: var(--gray-900);
            margin-bottom: 8px;
        }

        .leave-dates {
            color: var(--gray-600);
            font-size: 14px;
            margin-bottom: 8px;
        }

        .leave-reason {
            color: var(--gray-600);
            font-size: 13px;
            margin-top: 8px;
            line-height: 1.5;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 700;
            color: white;
            margin-top: 12px;
        }

        .status-badge.pending {
            background: linear-gradient(135deg, var(--warning-color), #d97706);
        }

        .status-badge.approved {
            background: linear-gradient(135deg, var(--success-color), #059669);
        }

        .status-badge.rejected {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
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

            .calendar-container {
                padding: 20px 16px;
            }

            .calendar-day {
                min-height: 80px;
                font-size: 12px;
                padding: 8px;
            }

            .leave-item {
                font-size: 9px;
                padding: 4px 6px;
            }

            .filter-group {
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
                <a href="${pageContext.request.contextPath}/home" class="btn-home">
                    <span>🏠</span> Về Trang Chủ
                </a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="page-title">
                <span>📅</span>
                Leave Agenda - ${sessionScope.auth.employee.division.dname}
            </div>
            <div class="page-subtitle">
                Xem và quản lý lịch nghỉ phép của nhân viên theo tháng
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="stats-container">
            <div class="stat-card total">
                <div class="stat-icon">📊</div>
                <div class="stat-label">Total Requests</div>
                <div class="stat-value">${stats[0]}</div>
            </div>
            <div class="stat-card pending">
                <div class="stat-icon">⏳</div>
                <div class="stat-label">Pending</div>
                <div class="stat-value">${stats[1]}</div>
            </div>
            <div class="stat-card approved">
                <div class="stat-icon">✅</div>
                <div class="stat-label">Approved</div>
                <div class="stat-value">${stats[2]}</div>
            </div>
            <div class="stat-card rejected">
                <div class="stat-icon">❌</div>
                <div class="stat-label">Rejected</div>
                <div class="stat-value">${stats[3]}</div>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <div class="filter-group">
                <div class="filter-item">
                    <label>📌 Status</label>
                    <select id="filterStatus">
                        <option value="all">All Status</option>
                        <option value="1">Pending</option>
                        <option value="2">Approved</option>
                        <option value="3">Rejected</option>
                    </select>
                </div>
                <div class="filter-item">
                    <label>👤 Employee</label>
                    <input type="text" id="filterEmployee" placeholder="Search employee...">
                </div>
                <div class="filter-item">
                    <button class="btn-export" onclick="exportToExcel()">
                        <span>📊</span> Export to Excel
                    </button>
                </div>
            </div>
        </div>

        <!-- View Toggle -->
        <div class="view-toggle">
            <button class="btn-view active" onclick="switchView('calendar')">
                <span>📅</span> Calendar View
            </button>
            <button class="btn-view" onclick="switchView('list')">
                <span>📋</span> List View
            </button>
        </div>

        <!-- Calendar View -->
        <div class="calendar-container" id="calendarView">
            <div class="calendar-header">
                <div class="calendar-title">
                    <jsp:useBean id="currentMonth" scope="request" type="java.time.YearMonth"/>
                    ${currentMonth.month} ${currentMonth.year}
                </div>
                <div class="calendar-nav">
                    <a href="?year=${currentMonth.year}&month=${currentMonth.minusMonths(1).monthValue}" class="btn-nav">
                        ◀ Prev
                    </a>
                    <a href="?today=true" class="btn-nav btn-today">Today</a>
                    <a href="?year=${currentMonth.year}&month=${currentMonth.plusMonths(1).monthValue}" class="btn-nav">
                        Next ▶
                    </a>
                </div>
            </div>

            <div class="calendar-grid">
                <div class="calendar-day-header">Sun</div>
                <div class="calendar-day-header">Mon</div>
                <div class="calendar-day-header">Tue</div>
                <div class="calendar-day-header">Wed</div>
                <div class="calendar-day-header">Thu</div>
                <div class="calendar-day-header">Fri</div>
                <div class="calendar-day-header">Sat</div>

                <%
                    java.time.YearMonth ym = (java.time.YearMonth) request.getAttribute("currentMonth");
                    java.time.LocalDate firstDay = ym.atDay(1);
                    java.time.LocalDate today = java.time.LocalDate.now();
                    int startDayOfWeek = firstDay.getDayOfWeek().getValue() % 7;
                    int daysInMonth = ym.lengthOfMonth();
                
                    // Days from previous month
                    java.time.LocalDate prevMonthDate = firstDay.minusDays(startDayOfWeek);
                    for (int i = 0; i < startDayOfWeek; i++) {
                %>
                <div class="calendar-day other-month">
                    <div class="day-number"><%= prevMonthDate.plusDays(i).getDayOfMonth() %></div>
                </div>
                <%
                    }
                
                    // Current month days
                    for (int day = 1; day <= daysInMonth; day++) {
                        java.time.LocalDate currentDate = ym.atDay(day);
                        String todayClass = currentDate.equals(today) ? "today" : "";
                %>
                <div class="calendar-day <%= todayClass %>">
                    <div class="day-number"><%= day %></div>
                    <c:forEach items="${requests}" var="req">
                        <%
                            model.RequestForLeave r = (model.RequestForLeave) pageContext.getAttribute("req");
                            java.time.LocalDate reqFrom = r.getFrom().toLocalDate();
                            java.time.LocalDate reqTo = r.getTo().toLocalDate();
                            
                            if (!currentDate.isBefore(reqFrom) && !currentDate.isAfter(reqTo)) {
                                String statusClass = r.getStatus() == 1 ? "pending" : (r.getStatus() == 2 ? "approved" : "rejected");
                        %>
                        <div class="leave-item <%= statusClass %>" 
                             title="${req.createdBy.name}: ${req.reason}"
                             onclick="showDetails(${req.id})">
                            ${req.createdBy.name}
                        </div>
                        <%
                            }
                        %>
                    </c:forEach>
                </div>
                <%
                    }
                
                    // Remaining days to fill the grid
                    int totalCells = startDayOfWeek + daysInMonth;
                    int remainingCells = (7 - (totalCells % 7)) % 7;
                    for (int i = 1; i <= remainingCells; i++) {
                %>
                <div class="calendar-day other-month">
                    <div class="day-number"><%= i %></div>
                </div>
                <%
                    }
                %>
            </div>
        </div>

        <!-- List View -->
        <div class="list-view" id="listView">
            <c:forEach items="${requests}" var="req">
                <div class="leave-list-item ${req.status == 1 ? 'pending' : (req.status == 2 ? 'approved' : 'rejected')}">
                    <div class="employee-name">👤 ${req.createdBy.name}</div>
                    <div class="leave-dates">
                        📅 <fmt:formatDate value="${req.from}" pattern="dd/MM/yyyy"/> - 
                        <fmt:formatDate value="${req.to}" pattern="dd/MM/yyyy"/>
                    </div>
                    <div class="leave-reason">
                        💬 ${req.reason}
                    </div>
                    <span class="status-badge ${req.status == 1 ? 'pending' : (req.status == 2 ? 'approved' : 'rejected')}">
                        ${req.status == 1 ? 'Pending' : (req.status == 2 ? 'Approved' : 'Rejected')}
                    </span>
                </div>
            </c:forEach>
        </div>
    </div>

    <script>
        function switchView(view) {
            const calendarView = document.getElementById('calendarView');
            const listView = document.getElementById('listView');
            const buttons = document.querySelectorAll('.btn-view');

            buttons.forEach(btn => btn.classList.remove('active'));

            if (view === 'calendar') {
                calendarView.style.display = 'block';
                listView.classList.remove('active');
                buttons[0].classList.add('active');
            } else {
                calendarView.style.display = 'none';
                listView.classList.add('active');
                buttons[1].classList.add('active');
            }
        }

        function showDetails(requestId) {
            window.location.href = '${pageContext.request.contextPath}/request/detail?rid=' + requestId;
        }

        function exportToExcel() {
            alert('Export feature coming soon!');
            // TODO: Implement export to Excel functionality
        }

        // Filter functionality
        document.getElementById('filterStatus').addEventListener('change', applyFilters);
        document.getElementById('filterEmployee').addEventListener('input', applyFilters);

        function applyFilters() {
            const status = document.getElementById('filterStatus').value;
            const employee = document.getElementById('filterEmployee').value.toLowerCase();

            document.querySelectorAll('.leave-item, .leave-list-item').forEach(item => {
                let show = true;

                // Filter by status
                if (status !== 'all') {
                    const itemStatus = item.classList.contains('pending') ? '1' :
                            (item.classList.contains('approved') ? '2' : '3');
                    if (itemStatus !== status)
                        show = false;
                }

                // Filter by employee name
                if (employee && !item.textContent.toLowerCase().includes(employee)) {
                    show = false;
                }

                item.style.display = show ? '' : 'none';
            });
        }
    </script>
</body>
</html>