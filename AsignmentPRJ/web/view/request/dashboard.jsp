<%-- 
    Document   : dashboard
    Created on : Nov 1, 2025, 10:53:47 PM
    Author     : ADMIN
--%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Leave Management Dashboard</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 20px;
            }

            .dashboard-container {
                max-width: 1400px;
                margin: 0 auto;
            }

            .dashboard-header {
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
                margin-bottom: 30px;
            }

            .dashboard-header h1 {
                color: #2c3e50;
                font-size: 32px;
                margin-bottom: 10px;
            }

            .dashboard-header .subtitle {
                color: #7f8c8d;
                font-size: 16px;
            }

            .quick-actions {
                display: flex;
                gap: 15px;
                margin-top: 20px;
                flex-wrap: wrap;
            }

            .btn-action {
                padding: 12px 24px;
                background: #3498db;
                color: white;
                text-decoration: none;
                border-radius: 8px;
                font-weight: 600;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-action:hover {
                background: #2980b9;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 25px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                padding: 25px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                position: relative;
                overflow: hidden;
                transition: all 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 5px;
                height: 100%;
                background: linear-gradient(180deg, #3498db, #2980b9);
            }

            .stat-card.pending::before {
                background: linear-gradient(180deg, #f39c12, #e67e22);
            }

            .stat-card.approved::before {
                background: linear-gradient(180deg, #27ae60, #229954);
            }

            .stat-card.rejected::before {
                background: linear-gradient(180deg, #e74c3c, #c0392b);
            }

            .stat-icon {
                font-size: 40px;
                margin-bottom: 15px;
            }

            .stat-label {
                color: #7f8c8d;
                font-size: 14px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-bottom: 10px;
            }

            .stat-value {
                font-size: 42px;
                font-weight: 700;
                color: #2c3e50;
                line-height: 1;
            }

            .stat-trend {
                margin-top: 10px;
                font-size: 13px;
                color: #27ae60;
                font-weight: 600;
            }

            .content-grid {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 30px;
                margin-bottom: 30px;
            }

            .chart-card {
                background: white;
                padding: 25px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            }

            .chart-card h2 {
                color: #2c3e50;
                font-size: 20px;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 3px solid #ecf0f1;
            }

            .upcoming-leaves {
                background: white;
                padding: 25px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            }

            .upcoming-leaves h2 {
                color: #2c3e50;
                font-size: 20px;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 3px solid #ecf0f1;
            }

            .leave-item {
                padding: 15px;
                background: #f8f9fa;
                border-radius: 10px;
                margin-bottom: 12px;
                border-left: 4px solid #3498db;
                transition: all 0.3s ease;
            }

            .leave-item:hover {
                background: #e8f4f8;
                transform: translateX(5px);
            }

            .leave-item .employee {
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 5px;
            }

            .leave-item .dates {
                color: #7f8c8d;
                font-size: 13px;
            }

            .pending-section {
                background: white;
                padding: 25px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .pending-section h2 {
                color: #2c3e50;
                font-size: 20px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .badge {
                background: #e74c3c;
                color: white;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: 600;
            }

            .pending-list {
                display: grid;
                gap: 15px;
            }

            .pending-item {
                padding: 20px;
                background: #fff9f0;
                border-radius: 10px;
                border-left: 4px solid #f39c12;
                display: flex;
                justify-content: space-between;
                align-items: center;
                transition: all 0.3s ease;
            }

            .pending-item:hover {
                background: #fff3e0;
                transform: translateX(5px);
            }

            .pending-item .info .name {
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 5px;
            }

            .pending-item .info .date {
                color: #7f8c8d;
                font-size: 13px;
            }

            .pending-item .actions {
                display: flex;
                gap: 10px;
            }

            .btn-approve {
                padding: 8px 16px;
                background: #27ae60;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-approve:hover {
                background: #229954;
                transform: scale(1.05);
            }

            .btn-reject {
                padding: 8px 16px;
                background: #e74c3c;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-reject:hover {
                background: #c0392b;
                transform: scale(1.05);
            }

            .btn-view {
                padding: 8px 16px;
                background: #3498db;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-view:hover {
                background: #2980b9;
            }

            @media (max-width: 1024px) {
                .content-grid {
                    grid-template-columns: 1fr;
                }
            }

            @media (max-width: 768px) {
                .stats-grid {
                    grid-template-columns: 1fr;
                }

                .quick-actions {
                    flex-direction: column;
                }

                .btn-action {
                    width: 100%;
                    justify-content: center;
                }
            }
        </style>
    </head>
    <body>
        <div class="dashboard-container">
            <!-- Header -->
            <div class="dashboard-header">
                <h1>? Leave Management Dashboard</h1>
                <div class="subtitle">Welcome back! Here's what's happening with your team today.</div>

                <div class="quick-actions">
                    <a href="agenda.jsp" class="btn-action">? View Calendar</a>
                    <a href="list.jsp" class="btn-action">? All Requests</a>
                    <a href="create.jsp" class="btn-action">? New Request</a>
                    <a href="#" class="btn-action" onclick="generateReport()">? Generate Report</a>
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">?</div>
                    <div class="stat-label">Total Requests</div>
                    <div class="stat-value" id="totalRequests">0</div>
                    <div class="stat-trend">? 12% from last month</div>
                </div>

                <div class="stat-card pending">
                    <div class="stat-icon">?</div>
                    <div class="stat-label">Pending</div>
                    <div class="stat-value" id="pendingCount">0</div>
                    <div class="stat-trend">Requires your attention</div>
                </div>

                <div class="stat-card approved">
                    <div class="stat-icon">?</div>
                    <div class="stat-label">Approved</div>
                    <div class="stat-value" id="approvedCount">0</div>
                    <div class="stat-trend">? 8% from last month</div>
                </div>

                <div class="stat-card rejected">
                    <div class="stat-icon">?</div>
                    <div class="stat-label">Rejected</div>
                    <div class="stat-value" id="rejectedCount">0</div>
                    <div class="stat-trend">? 3% from last month</div>
                </div>
            </div>

            <!-- Pending Requests Section -->
            <div class="pending-section">
                <h2>
                    Pending Requests
                    <span class="badge" id="pendingBadge">0</span>
                </h2>
                <div class="pending-list" id="pendingList">
                    <!-- Will be populated by JavaScript -->
                </div>
            </div>

            <!-- Charts and Upcoming Leaves -->
            <div class="content-grid">
                <div class="chart-card">
                    <h2>? Monthly Leave Trends</h2>
                    <canvas id="leaveChart"></canvas>
                </div>

                <div class="upcoming-leaves">
                    <h2>?? Upcoming Leaves (Next 7 Days)</h2>
                    <div id="upcomingList">
                        <!-- Will be populated by JavaScript -->
                    </div>
                </div>
            </div>
            //NOT FIX YET
            <!-- Employee Leave Count Chart -->
            <div class="chart-card">
                <h2>? Top Employees by Leave Count</h2>
                <canvas id="employeeChart"></canvas>
            </div>
        </div>

        <script>
            // Sample data - Replace with actual data from JSP
            const dashboardData = {
                stats: {
                    total: 145,
                    pending: 12,
                    approved: 98,
                    rejected: 35,
                    approvedDays: 234
                },
                pendingRequests: [
                    {id: 1, name: "John Doe", from: "2025-11-05", to: "2025-11-07", reason: "Family emergency"},
                    {id: 2, name: "Jane Smith", from: "2025-11-10", to: "2025-11-12", reason: "Medical appointment"},
                    {id: 3, name: "Bob Johnson", from: "2025-11-08", to: "2025-11-09", reason: "Personal matters"}
                ],
                upcomingLeaves: [
                    {name: "Alice Brown", from: "2025-11-02", to: "2025-11-04"},
                    {name: "Charlie Davis", from: "2025-11-03", to: "2025-11-05"},
                    {name: "Eva Wilson", from: "2025-11-06", to: "2025-11-08"}
                ],
                monthlyTrends: {
                    labels: ['Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov'],
                    data: [15, 22, 18, 25, 20, 28]
                },
                employeeCounts: {
                    labels: ['John Doe', 'Jane Smith', 'Bob Johnson', 'Alice Brown', 'Charlie Davis'],
                    data: [8, 6, 5, 4, 3]
                }
            };

            // Update statistics
            document.getElementById('totalRequests').textContent = dashboardData.stats.total;
            document.getElementById('pendingCount').textContent = dashboardData.stats.pending;
            document.getElementById('approvedCount').textContent = dashboardData.stats.approved;
            document.getElementById('rejectedCount').textContent = dashboardData.stats.rejected;
            document.getElementById('pendingBadge').textContent = dashboardData.stats.pending;

            // Populate pending requests
            const pendingList = document.getElementById('pendingList');
            dashboardData.pendingRequests.forEach(req => {
                const item = document.createElement('div');
                item.className = 'pending-item';
                item.innerHTML = `
                    <div class="info">
                        <div class="name">${req.name}</div>
                        <div class="date">${req.from} to ${req.to}</div>
                        <div class="date">${req.reason}</div>
                    </div>
                    <div class="actions">
                        <button class="btn-view" onclick="viewRequest(${req.id})">View</button>
                        <button class="btn-approve" onclick="approveRequest(${req.id})">? Approve</button>
                        <button class="btn-reject" onclick="rejectRequest(${req.id})">? Reject</button>
                    </div>
                `;
                pendingList.appendChild(item);
            });

            // Populate upcoming leaves
            const upcomingList = document.getElementById('upcomingList');
            dashboardData.upcomingLeaves.forEach(leave => {
                const item = document.createElement('div');
                item.className = 'leave-item';
                item.innerHTML = `
                    <div class="employee">${leave.name}</div>
                    <div class="dates">${leave.from} - ${leave.to}</div>
                `;
                upcomingList.appendChild(item);
            });

            // Monthly trends chart
            const leaveCtx = document.getElementById('leaveChart').getContext('2d');
            new Chart(leaveCtx, {
                type: 'line',
                data: {
                    labels: dashboardData.monthlyTrends.labels,
                    datasets: [{
                            label: 'Approved Leaves',
                            data: dashboardData.monthlyTrends.data,
                            borderColor: '#3498db',
                            backgroundColor: 'rgba(52, 152, 219, 0.1)',
                            tension: 0.4,
                            fill: true
                        }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            // Employee chart
            const employeeCtx = document.getElementById('employeeChart').getContext('2d');
            new Chart(employeeCtx, {
                type: 'bar',
                data: {
                    labels: dashboardData.employeeCounts.labels,
                    datasets: [{
                            label: 'Leave Days',
                            data: dashboardData.employeeCounts.data,
                            backgroundColor: [
                                'rgba(52, 152, 219, 0.8)',
                                'rgba(46, 204, 113, 0.8)',
                                'rgba(155, 89, 182, 0.8)',
                                'rgba(241, 196, 15, 0.8)',
                                'rgba(231, 76, 60, 0.8)'
                            ]
                        }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            // Action functions
            function viewRequest(id) {
                window.location.href = `detail.jsp?rid=${id}`;
            }

            function approveRequest(id) {
                if (confirm('Are you sure you want to approve this request?')) {
                    window.location.href = `process?rid=${id}&status=2`;
                }
            }

            function rejectRequest(id) {
                const reason = prompt('Please enter rejection reason:');
                if (reason !== null && reason.trim() !== "") {
                    window.location.href = `process?rid=${id}&status=3&reason=` + encodeURIComponent(reason);
                }
            }


            function generateReport() {
                alert('Generating report... This feature will export data to Excel/PDF');
            }
        </script>
    </body>
</html>