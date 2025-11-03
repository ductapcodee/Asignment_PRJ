<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.RequestForLeave"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Leave Management Dashboard</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                margin: 0;
                padding: 20px;
            }
            .dashboard-container {
                max-width: 1300px;
                margin: auto;
            }
            .dashboard-header {
                background: white;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                margin-bottom: 25px;
            }
            .dashboard-header h1 {
                color: #2c3e50;
                margin-bottom: 5px;
            }
            .dashboard-header .subtitle {
                color: #7f8c8d;
                font-size: 15px;
            }
            .quick-actions {
                display: flex;
                flex-wrap: wrap;
                gap: 12px;
                margin-top: 15px;
            }
            .btn-action {
                padding: 10px 20px;
                background: #3498db;
                color: white;
                text-decoration: none;
                border-radius: 8px;
                transition: all 0.3s;
                font-weight: 600;
            }
            .btn-action:hover {
                background: #2980b9;
                transform: translateY(-3px);
            }
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }
            .stat-card {
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                text-align: center;
            }
            .stat-value {
                font-size: 36px;
                font-weight: bold;
                color: #2c3e50;
            }
            .stat-label {
                color: #7f8c8d;
                font-size: 14px;
            }
            .section {
                background: white;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }
            .section h2 {
                color: #2c3e50;
                margin-bottom: 20px;
                border-bottom: 2px solid #ecf0f1;
                padding-bottom: 10px;
            }
            .pending-item, .leave-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: #f8f9fa;
                padding: 15px;
                border-radius: 10px;
                margin-bottom: 10px;
                border-left: 4px solid #3498db;
                transition: 0.3s;
            }
            .pending-item:hover, .leave-item:hover {
                background: #eaf4ff;
                transform: translateX(5px);
            }
            .pending-info {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .avatar {
                width: 45px;
                height: 45px;
                border-radius: 50%;
                background: #3498db;
                color: white;
                font-weight: bold;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 18px;
            }
            .btn-small {
                padding: 6px 12px;
                border-radius: 6px;
                border: none;
                cursor: pointer;
                font-weight: 600;
                color: white;
                transition: 0.3s;
            }
            .btn-view {
                background: #3498db;
            }
            .btn-approve {
                background: #27ae60;
            }
            .btn-reject {
                background: #e74c3c;
            }
            .btn-view:hover {
                background: #2980b9;
            }
            .btn-approve:hover {
                background: #229954;
            }
            .btn-reject:hover {
                background: #c0392b;
            }

            canvas {
                width: 100% !important;
                height: 400px !important;
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
        </style>
    </head>
    <body>
        <div class="dashboard-container">
            <div class="dashboard-header">
                <h1>🏠 Leave Management Dashboard</h1>
                <div class="subtitle">Welcome back! Here’s your team’s latest leave info.</div>
                <div style="display: flex; justify-content: flex-end; margin-bottom: 16px;">
                    <a href="${pageContext.request.contextPath}/home" class="btn-primary-home">
                        Về Trang Chủ
                    </a>
                </div>
            </div>

            <%-- Stats cards --%>
            <%
                Map<String, Integer> stats = (Map<String, Integer>) request.getAttribute("stats");
                if (stats != null) {
            %>
            <div class="stats-grid">
                <div class="stat-card"><div class="stat-value"><%= stats.get("total") %></div><div class="stat-label">Total Requests</div></div>
                <div class="stat-card"><div class="stat-value"><%= stats.get("pending") %></div><div class="stat-label">Pending</div></div>
                <div class="stat-card"><div class="stat-value"><%= stats.get("approved") %></div><div class="stat-label">Approved</div></div>
                <div class="stat-card"><div class="stat-value"><%= stats.get("rejected") %></div><div class="stat-label">Rejected</div></div>
            </div>
            <% } %>

            <%-- Pending requests --%>
            <div class="section">
                <h2>🕒 Pending Requests</h2>
                <%
                    ArrayList<RequestForLeave> pendingList = (ArrayList<RequestForLeave>) request.getAttribute("pendingRequests");
                    if (pendingList != null && !pendingList.isEmpty()) {
                        for (RequestForLeave r : pendingList) {
                %>
                <div class="pending-item">
                    <div class="pending-info">
                        <div class="avatar"><%= r.getCreatedBy().getName().substring(0,1).toUpperCase() %></div>
                        <div>
                            <strong><%= r.getCreatedBy().getName() %></strong><br>
                            <span style="color:#7f8c8d;"><%= r.getFrom() %> → <%= r.getTo() %></span><br>
                            <small><%= r.getReason() %></small>
                        </div>
                    </div>
                    <div>
                        <a class="btn-small btn-view" href="${pageContext.request.contextPath}/view/request/review.jsp?id=<%=r.getId()%>">View</a>

                    </div>
                </div>
                <% } } else { %>
                <p style="color:#7f8c8d;">No pending requests 🎉</p>
                <% } %>
            </div>

            <%-- Upcoming leaves --%>
            <div class="section">
                <h2>🌤 Upcoming Leaves (Next 7 Days)</h2>
                <%
                    ArrayList<RequestForLeave> upcoming = (ArrayList<RequestForLeave>) request.getAttribute("upcomingLeaves");
                    if (upcoming != null && !upcoming.isEmpty()) {
                        for (RequestForLeave r : upcoming) {
                %>
                <div class="leave-item">
                    <div class="pending-info">
                        <div class="avatar" style="background:#27ae60;"><%= r.getCreatedBy().getName().substring(0,1).toUpperCase() %></div>
                        <div>
                            <strong><%= r.getCreatedBy().getName() %></strong><br>
                            <span style="color:#7f8c8d;"><%= r.getFrom() %> → <%= r.getTo() %></span>
                        </div>
                    </div>
                    <span style="color:#27ae60;font-weight:bold;">✅ Approved</span>
                </div>
                <% } } else { %>
                <p style="color:#7f8c8d;">No upcoming leaves this week 🌻</p>
                <% } %>
            </div>

            <!-- Biểu đồ đơn theo tháng -->
            <div class="section">
                <h2>📆 Monthly Leave Requests</h2>
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:10px;">
                    <label style="font-weight:600;">Filter by quarter:</label>
                    <select id="quarterSelect" onchange="filterQuarter()" 
                            style="padding:6px 12px; border-radius:8px; border:1px solid #ccc;">
                        <option value="all">All months</option>
                        <option value="1">Q1 (Jan–Mar)</option>
                        <option value="2">Q2 (Apr–Jun)</option>
                        <option value="3">Q3 (Jul–Sep)</option>
                        <option value="4">Q4 (Oct–Dec)</option>
                    </select>
                </div>
                <canvas id="monthlyChart" style="margin-top:15px;"></canvas>
            </div>

            <script>
                /* ------------------ Monthly Stats ------------------ */
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
                                label: 'Leave Requests',
                                data: monthlyValues,
                                backgroundColor: 'rgba(52, 152, 219, 0.8)',
                                borderRadius: 8
                            }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {legend: {display: false}},
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
