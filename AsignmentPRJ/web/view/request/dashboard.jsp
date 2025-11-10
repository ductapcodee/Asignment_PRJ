<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.RequestForLeave"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Leave Management Dashboard</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

            /* Stats Grid */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
                gap: 20px;
                margin-bottom: 32px;
            }

            .stat-card {
                background: white;
                border: 1px solid var(--gray-200);
                border-radius: 12px;
                padding: 24px;
                text-align: center;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
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
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            }

            .stat-icon {
                width: 56px;
                height: 56px;
                margin: 0 auto 16px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 12px;
                font-size: 28px;
            }

            .stat-card:nth-child(1) .stat-icon {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            }

            .stat-card:nth-child(2) .stat-icon {
                background: linear-gradient(135deg, var(--warning-color), #d97706);
            }

            .stat-card:nth-child(3) .stat-icon {
                background: linear-gradient(135deg, var(--success-color), #059669);
            }

            .stat-card:nth-child(4) .stat-icon {
                background: linear-gradient(135deg, var(--danger-color), #dc2626);
            }

            .stat-value {
                font-size: 36px;
                font-weight: 700;
                color: var(--gray-900);
                margin-bottom: 4px;
            }

            .stat-label {
                font-size: 14px;
                color: var(--gray-600);
                font-weight: 500;
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

            /* Request Items */
            .request-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: var(--gray-50);
                padding: 16px;
                border-radius: 10px;
                margin-bottom: 12px;
                border: 1px solid var(--gray-200);
                transition: all 0.3s ease;
            }

            .request-item:hover {
                background: #e0f2fe;
                border-color: var(--secondary-color);
                transform: translateX(4px);
            }

            .request-info {
                display: flex;
                align-items: center;
                gap: 12px;
                flex: 1;
            }

            .avatar {
                width: 48px;
                height: 48px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                font-weight: 700;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 18px;
            }

            .avatar.approved {
                background: linear-gradient(135deg, var(--success-color), #059669);
            }

            .request-details {
                flex: 1;
            }

            .request-name {
                font-weight: 600;
                color: var(--gray-900);
                font-size: 15px;
                margin-bottom: 4px;
            }

            .request-dates {
                color: var(--gray-600);
                font-size: 13px;
                margin-bottom: 4px;
            }

            .request-reason {
                color: var(--gray-600);
                font-size: 13px;
            }

            .request-actions {
                display: flex;
                gap: 8px;
            }

            .btn-action {
                padding: 8px 16px;
                border-radius: 6px;
                border: none;
                cursor: pointer;
                font-weight: 600;
                font-size: 13px;
                color: white;
                text-decoration: none;
                transition: all 0.2s ease;
                display: inline-flex;
                align-items: center;
                gap: 4px;
            }

            .btn-view {
                background: var(--primary-color);
            }

            .btn-view:hover {
                background: var(--primary-dark);
                transform: translateY(-1px);
            }

            .status-approved {
                color: var(--success-color);
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 4px;
            }

            /* Chart Section */
            .chart-controls {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 16px;
            }

            .chart-controls label {
                font-weight: 600;
                color: var(--gray-700);
            }

            .chart-controls select {
                padding: 8px 12px;
                border-radius: 8px;
                border: 1px solid var(--gray-300);
                font-size: 14px;
                cursor: pointer;
                transition: all 0.2s ease;
            }

            .chart-controls select:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            }

            canvas {
                width: 100% !important;
                height: 400px !important;
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

                .stats-grid {
                    grid-template-columns: 1fr;
                }

                .request-item {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 12px;
                }

                .request-actions {
                    width: 100%;
                }

                .btn-action {
                    flex: 1;
                    justify-content: center;
                }
            }
        </style>
    </head>
    <body>
        <!-- Top Navigation -->
        <nav class="top-nav">
            <div class="nav-container">
                <div class="nav-brand">
                    <div class="nav-brand-icon">📊</div>
                    <span>Leave Dashboard</span>
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
                <div class="page-title">📊 Leave Management Dashboard</div>
                <div class="page-subtitle">Tổng quan về các đơn xin nghỉ và thống kê</div>
            </div>

            <%-- Stats cards --%>
            <%
                Map<String, Integer> stats = (Map<String, Integer>) request.getAttribute("stats");
                if (stats != null) {
            %>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">📋</div>
                    <div class="stat-value"><%= stats.get("total") %></div>
                    <div class="stat-label">Tổng đơn xin nghỉ</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">⏳</div>
                    <div class="stat-value"><%= stats.get("pending") %></div>
                    <div class="stat-label">Đang chờ duyệt</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">✅</div>
                    <div class="stat-value"><%= stats.get("approved") %></div>
                    <div class="stat-label">Đã phê duyệt</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">❌</div>
                    <div class="stat-value"><%= stats.get("rejected") %></div>
                    <div class="stat-label">Đã từ chối</div>
                </div>
            </div>
            <% } %>

            <%-- Pending requests --%>
            <div class="section-card">
                <div class="section-header">
                    <span style="font-size: 24px;">⏳</span>
                    <h2 class="section-title">Đơn chờ phê duyệt</h2>
                </div>
                <%
                    ArrayList<RequestForLeave> pendingList = (ArrayList<RequestForLeave>) request.getAttribute("pendingRequests");
                    if (pendingList != null && !pendingList.isEmpty()) {
                        for (RequestForLeave r : pendingList) {
                %>
                <div class="request-item">
                    <div class="request-info">
                        <div class="avatar"><%= r.getCreatedBy().getName().substring(0,1).toUpperCase() %></div>
                        <div class="request-details">
                            <div class="request-name"><%= r.getCreatedBy().getName() %></div>
                            <div class="request-dates">📅 <%= r.getFrom() %> → <%= r.getTo() %></div>
                            <div class="request-reason"><%= r.getReason() %></div>
                        </div>
                    </div>
                    <div class="request-actions">
                        <a class="btn-action btn-view" href="${pageContext.request.contextPath}/request/review?rid=<%=r.getId()%>">
                            👁️ Xem chi tiết
                        </a>
                    </div>
                </div>
                <% } } else { %>
                <div class="empty-state">
                    <div class="empty-state-icon">🎉</div>
                    <p>Không có đơn nào đang chờ phê duyệt</p>
                </div>
                <% } %>
            </div>

            <%-- Upcoming leaves --%>
            <div class="section-card">
                <div class="section-header">
                    <span style="font-size: 24px;">📅</span>
                    <h2 class="section-title">Lịch nghỉ sắp tới (7 ngày)</h2>
                </div>
                <%
                    ArrayList<RequestForLeave> upcoming = (ArrayList<RequestForLeave>) request.getAttribute("upcomingLeaves");
                    if (upcoming != null && !upcoming.isEmpty()) {
                        for (RequestForLeave r : upcoming) {
                %>
                <div class="request-item">
                    <div class="request-info">
                        <div class="avatar approved"><%= r.getCreatedBy().getName().substring(0,1).toUpperCase() %></div>
                        <div class="request-details">
                            <div class="request-name"><%= r.getCreatedBy().getName() %></div>
                            <div class="request-dates">📅 <%= r.getFrom() %> → <%= r.getTo() %></div>
                        </div>
                    </div>
                    <span class="status-approved">✅ Đã phê duyệt</span>
                </div>
                <% } } else { %>
                <div class="empty-state">
                    <div class="empty-state-icon">🌻</div>
                    <p>Không có lịch nghỉ nào trong tuần này</p>
                </div>
                <% } %>
            </div>

            <!-- Monthly Chart -->
            <div class="section-card">
                <div class="section-header">
                    <span style="font-size: 24px;">📈</span>
                    <h2 class="section-title">Thống kê đơn theo tháng</h2>
                </div>
                <div class="chart-controls">
                    <label>Lọc theo quý:</label>
                    <select id="quarterSelect" onchange="filterQuarter()">
                        <option value="all">Tất cả các tháng</option>
                        <option value="1">Q1 (Tháng 1-3)</option>
                        <option value="2">Q2 (Tháng 4-6)</option>
                        <option value="3">Q3 (Tháng 7-9)</option>
                        <option value="4">Q4 (Tháng 10-12)</option>
                    </select>
                </div>
                <canvas id="monthlyChart"></canvas>
            </div>
        </div>

        <script>
            /* Monthly Stats */
            const monthlyLabels = [];
            const monthlyValues = [];
            <% 
                Map<String, Integer> monthlyStats = (Map<String, Integer>) request.getAttribute("monthlyStats");
                if (monthlyStats != null) {
                    for (Map.Entry<String, Integer> entry : monthlyStats.entrySet()) {
            %>
            monthlyLabels.push("<%= entry.getKey() %>");
            monthlyValues.push(<%= entry.getValue() %>);
            <% }} %>

            const originalMonthlyLabels = [...monthlyLabels];
            const originalMonthlyValues = [...monthlyValues];

            const monthlyCtx = document.getElementById('monthlyChart').getContext('2d');
            const monthlyChart = new Chart(monthlyCtx, {
                type: 'bar',
                data: {
                    labels: monthlyLabels,
                    datasets: [{
                        label: 'Số đơn xin nghỉ',
                        data: monthlyValues,
                        backgroundColor: 'rgba(37, 99, 235, 0.8)',
                        borderRadius: 8
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {display: false}
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {stepSize: 1}
                        },
                        x: {
                            ticks: {
                                maxRotation: 0,
                                minRotation: 0,
                                autoSkip: false
                            }
                        }
                    }
                }
            });

            function filterQuarter() {
                const q = document.getElementById("quarterSelect").value;

                if (q === "all") {
                    monthlyChart.data.labels = originalMonthlyLabels;
                    monthlyChart.data.datasets[0].data = originalMonthlyValues;
                } else {
                    const quarter = parseInt(q);
                    const start = (quarter - 1) * 3;
                    const end = start + 3;

                    monthlyChart.data.labels = originalMonthlyLabels.slice(start, end);
                    monthlyChart.data.datasets[0].data = originalMonthlyValues.slice(start, end);
                }

                monthlyChart.update();
            }
        </script>
    </body>
</html>