<%-- 
    Document   : agenda
    Created on : Nov 1, 2025, 10:49:27 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Leave Agenda - Calendar View</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f5f7fa;
                padding: 20px;
            }

            .header {
                background: white;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                margin-bottom: 25px;
            }

            .header h1 {
                color: #2c3e50;
                font-size: 28px;
                margin-bottom: 10px;
            }

            .header .breadcrumb {
                color: #7f8c8d;
                font-size: 14px;
            }

            .stats-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 20px;
                margin-bottom: 25px;
            }

            .stat-card {
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                border-left: 4px solid #3498db;
            }

            .stat-card.pending {
                border-left-color: #f39c12;
            }
            .stat-card.approved {
                border-left-color: #27ae60;
            }
            .stat-card.rejected {
                border-left-color: #e74c3c;
            }

            .stat-card .label {
                color: #7f8c8d;
                font-size: 13px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 8px;
            }

            .stat-card .value {
                font-size: 32px;
                font-weight: 700;
                color: #2c3e50;
            }

            .calendar-container {
                background: white;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .calendar-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
                padding-bottom: 20px;
                border-bottom: 2px solid #ecf0f1;
            }

            .calendar-title {
                font-size: 24px;
                font-weight: 700;
                color: #2c3e50;
            }

            .calendar-nav {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            .btn-nav {
                padding: 8px 16px;
                background: #3498db;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-nav:hover {
                background: #2980b9;
                transform: translateY(-2px);
            }

            .btn-today {
                background: #95a5a6;
            }

            .btn-today:hover {
                background: #7f8c8d;
            }

            .calendar-grid {
                display: grid;
                grid-template-columns: repeat(7, 1fr);
                gap: 2px;
                background: #ecf0f1;
                border: 2px solid #ecf0f1;
                border-radius: 8px;
                overflow: hidden;
            }

            .calendar-day-header {
                background: #34495e;
                color: white;
                padding: 12px;
                text-align: center;
                font-weight: 600;
                font-size: 14px;
            }

            .calendar-day {
                background: white;
                min-height: 120px;
                padding: 8px;
                position: relative;
            }

            .calendar-day.other-month {
                background: #f8f9fa;
                opacity: 0.5;
            }

            .calendar-day.today {
                background: #ebf5fb;
                border: 2px solid #3498db;
            }

            .day-number {
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 5px;
                font-size: 14px;
            }

            .leave-item {
                background: #3498db;
                color: white;
                padding: 4px 6px;
                border-radius: 4px;
                font-size: 11px;
                margin-bottom: 3px;
                cursor: pointer;
                transition: all 0.2s ease;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .leave-item:hover {
                transform: scale(1.05);
                box-shadow: 0 2px 6px rgba(0,0,0,0.2);
            }

            .leave-item.pending {
                background: #f39c12;
            }
            .leave-item.approved {
                background: #27ae60;
            }
            .leave-item.rejected {
                background: #e74c3c;
            }

            .view-mode-toggle {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }

            .btn-view {
                padding: 10px 20px;
                background: white;
                border: 2px solid #3498db;
                color: #3498db;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-view.active,
            .btn-view:hover {
                background: #3498db;
                color: white;
            }

            .list-view {
                display: none;
            }

            .list-view.active {
                display: block;
            }

            .leave-list-item {
                background: white;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 10px;
                border-left: 4px solid #3498db;
            }

            .leave-list-item.pending {
                border-left-color: #f39c12;
            }
            .leave-list-item.approved {
                border-left-color: #27ae60;
            }
            .leave-list-item.rejected {
                border-left-color: #e74c3c;
            }

            .leave-list-item .employee-name {
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 5px;
            }

            .leave-list-item .leave-dates {
                color: #7f8c8d;
                font-size: 14px;
            }

            .filter-section {
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                margin-bottom: 20px;
            }

            .filter-group {
                display: flex;
                gap: 15px;
                flex-wrap: wrap;
            }

            .filter-item {
                flex: 1;
                min-width: 200px;
            }

            .filter-item label {
                display: block;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 5px;
                font-size: 14px;
            }

            .filter-item select,
            .filter-item input {
                width: 100%;
                padding: 10px;
                border: 2px solid #ecf0f1;
                border-radius: 6px;
                font-size: 14px;
            }

            .btn-export {
                padding: 10px 20px;
                background: #27ae60;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-export:hover {
                background: #229954;
                transform: translateY(-2px);
            }

            @media (max-width: 768px) {
                .calendar-grid {
                    grid-template-columns: repeat(7, 1fr);
                }

                .calendar-day {
                    min-height: 80px;
                    font-size: 12px;
                }

                .leave-item {
                    font-size: 9px;
                }
            }
            /*btn*/
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
        </style>
    </head>
    <body>
        <div class="header">
            <h1>📅 Leave Agenda - ${sessionScope.auth.employee.division.dname}</h1>
            <div class="breadcrumb">
                Dashboard / Leave Management / Agenda
            </div>
            <div style="display: flex; justify-content: flex-end; margin-bottom: 16px;">
                <a href="${pageContext.request.contextPath}/home" class="btn-primary-home">
                    Về Trang Chủ
                </a>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="stats-container">
            <div class="stat-card">
                <div class="label">Total Requests</div>
                <div class="value">${stats[0]}</div>
            </div>
            <div class="stat-card pending">
                <div class="label">Pending</div>
                <div class="value">${stats[1]}</div>
            </div>
            <div class="stat-card approved">
                <div class="label">Approved</div>
                <div class="value">${stats[2]}</div>
            </div>
            <div class="stat-card rejected">
                <div class="label">Rejected</div>
                <div class="value">${stats[3]}</div>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <div class="filter-group">
                <div class="filter-item">
                    <label>Status</label>
                    <select id="filterStatus">
                        <option value="all">All Status</option>
                        <option value="1">Pending</option>
                        <option value="2">Approved</option>
                        <option value="3">Rejected</option>
                    </select>
                </div>
                <div class="filter-item">
                    <label>Employee</label>
                    <input type="text" id="filterEmployee" placeholder="Search employee...">
                </div>
                <div class="filter-item" style="display: flex; align-items: flex-end;">
                    <button class="btn-export" onclick="exportToExcel()">📊 Export to Excel</button>
                </div>
            </div>
        </div>

        <!-- View Toggle -->
        <c:set var="view" value="${param.view != null ? param.view : 'calendar'}"/>
        <div class="view-mode-toggle">
            <button class="btn-view active" onclick="switchView('calendar')">📅 Calendar View</button>
            <button class="btn-view" onclick="switchView('list')">📋 List View</button>
        </div>

        <!-- Calendar View -->
        <div class="calendar-container" id="calendarView">
            <div class="calendar-header">
                <div class="calendar-title">
                    <jsp:useBean id="currentMonth" scope="request" type="java.time.YearMonth"/>
                    ${currentMonth.month} ${currentMonth.year}
                </div>
                <div class="calendar-nav">
                    <a href="?year=${currentMonth.year}&month=${currentMonth.minusMonths(1).monthValue}" class="btn-nav">◀ Prev</a>
                    <a href="?today=true" class="btn-nav btn-today">Today</a>

                    <a href="?year=${currentMonth.year}&month=${currentMonth.plusMonths(1).monthValue}" class="btn-nav">Next ▶</a>
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

                <jsp:useBean id="requests" scope="request" type="java.util.ArrayList"/>
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
                    <div class="employee-name">${req.createdBy.name}</div>
                    <div class="leave-dates">
                        <fmt:formatDate value="${req.from}" pattern="dd/MM/yyyy"/> - 
                        <fmt:formatDate value="${req.to}" pattern="dd/MM/yyyy"/>
                    </div>
                    <div style="margin-top: 5px; color: #7f8c8d; font-size: 13px;">
                        ${req.reason}
                    </div>
                    <div style="margin-top: 8px;">
                        <span style="padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: 600;
                              background: ${req.status == 1 ? '#f39c12' : (req.status == 2 ? '#27ae60' : '#e74c3c')};
                              color: white;">
                            ${req.status == 1 ? 'Pending' : (req.status == 2 ? 'Approved' : 'Rejected')}
                        </span>
                    </div>
                </div>
            </c:forEach>
            </div>

        </div>

        <script>
            function showDetails(requestId) {
                window.location.href = '/request/detail?rid=' + requestId;
            }
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