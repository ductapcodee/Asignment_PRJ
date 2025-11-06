<%-- 
    Document   : report
    Created on : Nov 1, 2025, 11:06:39 PM
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
        <title>Leave Report Generator</title>
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

            .container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .header {
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
                margin-bottom: 30px;
            }

            .header h1 {
                color: #2c3e50;
                font-size: 32px;
                margin-bottom: 10px;
            }

            .filter-card {
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
                margin-bottom: 30px;
            }

            .filter-card h2 {
                color: #2c3e50;
                font-size: 24px;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 3px solid #ecf0f1;
            }

            .filter-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 25px;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
            }

            .filter-group label {
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 8px;
                font-size: 14px;
            }

            .filter-group input,
            .filter-group select {
                padding: 12px;
                border: 2px solid #ecf0f1;
                border-radius: 8px;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .filter-group input:focus,
            .filter-group select:focus {
                outline: none;
                border-color: #3498db;
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            }

            .action-buttons {
                display: flex;
                gap: 15px;
                flex-wrap: wrap;
            }

            .btn {
                padding: 12px 24px;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                text-decoration: none;
            }

            .btn-primary {
                background: #3498db;
                color: white;
            }

            .btn-primary:hover {
                background: #2980b9;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
            }

            .btn-success {
                background: #27ae60;
                color: white;
            }

            .btn-success:hover {
                background: #229954;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(39, 174, 96, 0.4);
            }

            .btn-warning {
                background: #f39c12;
                color: white;
            }

            .btn-warning:hover {
                background: #e67e22;
                transform: translateY(-2px);
            }

            .results-card {
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }

            .results-card h2 {
                color: #2c3e50;
                font-size: 24px;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 3px solid #ecf0f1;
            }

            .summary-stats {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-box {
                padding: 20px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 12px;
                color: white;
                text-align: center;
            }

            .stat-box .label {
                font-size: 14px;
                opacity: 0.9;
                margin-bottom: 8px;
            }

            .stat-box .value {
                font-size: 36px;
                font-weight: 700;
            }

            .data-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            .data-table thead {
                background: #34495e;
                color: white;
            }

            .data-table th,
            .data-table td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ecf0f1;
            }

            .data-table tbody tr:hover {
                background: #f8f9fa;
            }

            .status-badge {
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
            }

            .status-pending {
                background: #f39c12;
                color: white;
            }

            .status-approved {
                background: #27ae60;
                color: white;
            }

            .status-rejected {
                background: #e74c3c;
                color: white;
            }

            @media (max-width: 768px) {
                .filter-grid {
                    grid-template-columns: 1fr;
                }

                .action-buttons {
                    flex-direction: column;
                }

                .btn {
                    width: 100%;
                    justify-content: center;
                }
            }
            .error-message {
                background-color: #e74c3c;
                color: white;
                padding: 12px 20px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-weight: 600;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                animation: fadeIn 0.4s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-5px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            /* === PRINT VIEW IMPROVEMENTS === */
            @media print {
                body {
                    background: white !important;
                    padding: 0;
                    color: #000;
                }

                .header, .filter-card, .results-card {
                    box-shadow: none !important;
                }

                .header h1 {
                    text-align: center;
                    color: #000;
                }

                /* Ẩn phần không cần in */
                #tabQuick,
                #tabCustom,
                #quickSection,
                #currentFilter {
                    display: none !important;
                }

                /* Giữ lại phần form gọn gàng */
                .filter-card {
                    border: 1px solid #ccc;
                    margin-bottom: 20px;
                    padding: 15px;
                }

                /* Nút hành động */
                .action-buttons {
                    display: flex;
                    justify-content: center;
                    gap: 20px;
                    margin-top: 15px;
                }

                .btn {
                    background: #f2f2f2 !important;
                    color: #000 !important;
                    border: 1px solid #ccc !important;
                    box-shadow: none !important;
                    font-size: 13px;
                    padding: 8px 14px;
                    text-transform: uppercase;
                }

                /* Bảng dữ liệu */
                .data-table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 15px;
                }

                .data-table th,
                .data-table td {
                    border: 1px solid #ccc;
                    padding: 8px;
                    font-size: 13px;
                }

                .data-table thead {
                    background: #eee !important;
                    color: #000 !important;
                }

                /* Ẩn phần nền gradient */
                .stat-box {
                    background: #eee !important;
                    color: #000 !important;
                }

                /* Ẩn phần không cần khi in (VD: Reset Filter, Export Excel) */
                button.btn-success,
                button.btn-warning {
                    display: none !important;
                }
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
        <div class="container">
            <!-- Header -->
            <div class="header">
                <h1>📊 Leave Report Generator</h1>
                <p style="color: #7f8c8d; margin-top: 10px;">
                    Generate comprehensive leave reports with custom filters
                </p>
                <div style="display: flex; justify-content: flex-end; margin-bottom: 16px;">
                    <a href="${pageContext.request.contextPath}/home" class="btn-primary-home">
                        Về Trang Chủ
                    </a>
                </div>
            </div>


            <!-- Filter Form -->
            <div class="filter-card">
                <h2>🔍 Filter Options</h2>
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/request/report" method="get" id="reportForm">

                    <!-- Tabs -->
                    <div style="display: flex; gap: 10px; margin-bottom: 20px;">
                        <button type="button" id="tabQuick" class="btn btn-primary" onclick="switchMode('quick')">Quick Range</button>
                        <button type="button" id="tabCustom" class="btn btn-warning" onclick="switchMode('custom')">Custom Range</button>
                    </div>

                    <!-- Quick Range Section -->
                    <div id="quickSection" style="display: none;">
                        <div class="filter-grid">
                            <div class="filter-group">
                                <label>Quick Select</label>
                                <select id="quickSelect" onchange="applyQuickFilter()">
                                    <option value="">Select...</option>
                                    <option value="today">Today</option>
                                    <option value="week">This Week</option>
                                    <option value="month">This Month</option>
                                    <option value="quarter">This Quarter</option>
                                    <option value="year">This Year</option>
                                </select>
                            </div>

                            <div class="filter-group">
                                <label>Status</label>
                                <select name="status" id="statusFilter">
                                    <option value="all" ${param.status == 'all' ? 'selected' : ''}>All Status</option>
                                    <option value="1" ${param.status == '1' ? 'selected' : ''}>Pending</option>
                                    <option value="2" ${param.status == '2' ? 'selected' : ''}>Approved</option>
                                    <option value="3" ${param.status == '3' ? 'selected' : ''}>Rejected</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Custom Range Section -->
                    <div id="customSection">
                        <div class="filter-grid">
                            <div class="filter-group">
                                <label>From Date</label>
                                <input type="date" name="from" id="fromDate" value="${param.from}">
                            </div>
                            <div class="filter-group">
                                <label>To Date</label>
                                <input type="date" name="to" id="toDate" value="${param.to}">
                            </div>
                            <div class="filter-group">
                                <label>Status</label>
                                <select name="status" id="statusFilterCustom">
                                    <option value="all" ${param.status == 'all' ? 'selected' : ''}>All Status</option>
                                    <option value="1" ${param.status == '1' ? 'selected' : ''}>Pending</option>
                                    <option value="2" ${param.status == '2' ? 'selected' : ''}>Approved</option>
                                    <option value="3" ${param.status == '3' ? 'selected' : ''}>Rejected</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <p id="currentFilter" style="margin-top: 10px; font-size: 14px; color: #555; font-style: italic;">
                        📅 Currently applied: None
                    </p>

                    <div class="action-buttons" style="margin-top: 15px;">
                        <button type="submit" class="btn btn-primary">
                            🔍 Generate Report
                        </button>
                        <button type="button" class="btn btn-success" onclick="exportReport('excel')">
                            📊 Export Excel
                        </button>
                        <button type="button" class="btn btn-warning" onclick="printReport()">
                            🖨️ Print
                        </button>
                        <button type="button" class="btn btn-warning" onclick="resetFilters()">
                            ♻ Reset Filter
                        </button>

                    </div>
                </form>
            </div>

            <script>
                let mode = 'custom'; // default

                function switchMode(selected) {
                    mode = selected;
                    const quick = document.getElementById('quickSection');
                    const custom = document.getElementById('customSection');
                    const tabQuick = document.getElementById('tabQuick');
                    const tabCustom = document.getElementById('tabCustom');
                    const quickSelect = document.getElementById('quickSelect');
                    const currentFilter = document.getElementById('currentFilter');

                    if (selected === 'quick') {
                        quick.style.display = 'block';
                        custom.style.display = 'none';
                        tabQuick.classList.add('btn-success');
                        tabCustom.classList.remove('btn-success');
                        currentFilter.textContent = "📅 Currently applied: Quick Range (Choose option)";
                        quickSelect.value = '';
                    } else {
                        quick.style.display = 'none';
                        custom.style.display = 'block';
                        tabCustom.classList.add('btn-success');
                        tabQuick.classList.remove('btn-success');
                        currentFilter.textContent = "📅 Currently applied: Custom Range (choose From–To)";
                    }
                }

                function applyQuickFilter() {
                    const select = document.getElementById('quickSelect');
                    const fromDate = document.getElementById('fromDate');
                    const toDate = document.getElementById('toDate');
                    const currentFilter = document.getElementById('currentFilter');
                    const today = new Date();
                    let from, to, label;

                    switch (select.value) {
                        case 'today':
                            from = to = today;
                            label = 'Today';
                            break;
                        case 'week':
                            const first = new Date(today.setDate(today.getDate() - today.getDay()));
                            const last = new Date(first);
                            last.setDate(first.getDate() + 6);
                            from = first;
                            to = last;
                            label = 'This Week';
                            break;
                        case 'month':
                            from = new Date(today.getFullYear(), today.getMonth(), 1);
                            to = new Date(today.getFullYear(), today.getMonth() + 1, 0);
                            label = 'This Month';
                            break;
                        case 'quarter':
                            const q = Math.floor(today.getMonth() / 3);
                            from = new Date(today.getFullYear(), q * 3, 1);
                            to = new Date(today.getFullYear(), (q + 1) * 3, 0);
                            label = 'This Quarter';
                            break;
                        case 'year':
                            from = new Date(today.getFullYear(), 0, 1);
                            to = new Date(today.getFullYear(), 11, 31);
                            label = 'This Year';
                            break;
                        default:
                            from = to = null;
                            label = 'None';
                    }

                    if (from && to) {
                        fromDate.valueAsDate = from;
                        toDate.valueAsDate = to;
                        currentFilter.textContent = `📅 Currently applied: ${label} (${from.toLocaleDateString()} → ${to.toLocaleDateString()})`;
                    } else {
                        currentFilter.textContent = "📅 Currently applied: None";
                    }
                }

                // default view on load
                switchMode('custom');
                function resetFilters() {
                    // Xóa tất cả các giá trị filter
                    document.getElementById('fromDate').value = '';
                    document.getElementById('toDate').value = '';
                    document.getElementById('statusFilter').value = 'all';
                    document.getElementById('statusFilterCustom').value = 'all';
                    document.getElementById('quickSelect').value = '';
                    document.getElementById('currentFilter').textContent = "📅 Currently applied: None";

                    // Đặt lại chế độ về custom
                    switchMode('custom');

                    // ✅ Gửi form để load lại toàn bộ dữ liệu
                    document.getElementById('reportForm').submit();
                }

            </script>


            <!-- Results -->
            <c:if test="${requests != null}">
                <div class="results-card">
                    <h2>📈 Report Results</h2>

                    <!-- Summary Statistics -->
                    <div class="summary-stats">
                        <div class="stat-box">
                            <div class="label">Total Requests</div>
                            <div class="value">${requests.size()}</div>
                        </div>
                        <div class="stat-box">
                            <div class="label">Total Days</div>
                            <div class="value" id="totalDays">0</div>
                        </div>
                        <div class="stat-box">
                            <div class="label">Approved</div>
                            <div class="value" id="approvedCount">0</div>
                        </div>
                        <div class="stat-box">
                            <div class="label">Pending</div>
                            <div class="value" id="pendingCount">0</div>
                        </div>
                    </div>

                    <!-- Data Table -->
                    <table class="data-table" id="reportTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Employee</th>
                                <th>From</th>
                                <th>To</th>
                                <th>Days</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th>Processed By</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requests}" var="req">
                                <tr>
                                    <td>#${req.id}</td>
                                    <td>${req.createdBy.name}</td>
                                    <td><fmt:formatDate value="${req.from}" pattern="MM/dd/yyyy"/></td>
                                    <td><fmt:formatDate value="${req.to}" pattern="MM/dd/yyyy"/></td>
                                    <td>
                                        <jsp:useBean id="req" scope="page" type="model.RequestForLeave"/>
                                        <%
                                            long days = req.getTo().toLocalDate().toEpochDay() - 
                                                       req.getFrom().toLocalDate().toEpochDay() + 1;
                                            out.print(days);
                                        %>
                                    </td>
                                    <td>${req.reason}</td>
                                    <td>
                                        <span class="status-badge status-${req.status == 1 ? 'pending' : (req.status == 2 ? 'approved' : 'rejected')}">
                                            ${req.status == 1 ? 'Pending' : (req.status == 2 ? 'Approved' : 'Rejected')}
                                        </span>
                                    </td>
                                    <td>${req.processedBy != null ? req.processedBy.name : 'N/A'}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <!-- Pagination -->
                    <c:if test="${totalPages != null && totalPages > 0}">
                        <div style="margin-top:20px; text-align:center;">

                            <!-- Prev -->
                            <c:if test="${pageindex > 1}">
                                <a href="${pageContext.request.contextPath}/request/report?page=${pageindex - 1}&from=${param.from != null ? param.from : ''}&to=${param.to != null ? param.to : ''}&status=${param.status != null ? param.status : 'all'}"
                                   style="padding:8px 14px; border-radius:8px; text-decoration:none; font-weight:600; background:white; border:1px solid #ddd; box-shadow:0 2px 6px rgba(0,0,0,0.15); color:#4f46e5; transition:0.2s;">
                                    « Prev
                                </a>
                            </c:if>

                            <!-- compute start/end with window = 2 -->
                            <c:set var="window" value="2" />
                            <c:set var="start" value="${pageindex - window}" />
                            <c:set var="end" value="${pageindex + window}" />

                            <!-- if start < 1, push end to right -->
                            <c:if test="${start < 1}">
                                <c:set var="end" value="${end + (1 - start)}" />
                                <c:set var="start" value="1" />
                            </c:if>

                            <!-- if end > totalPages, push start to left -->
                            <c:if test="${end > totalPages}">
                                <c:set var="start" value="${start - (end - totalPages)}" />
                                <c:set var="end" value="${totalPages}" />
                            </c:if>

                            <!-- final clamp to bounds -->
                            <c:if test="${start < 1}">
                                <c:set var="start" value="1" />
                            </c:if>
                            <c:if test="${end > totalPages}">
                                <c:set var="end" value="${totalPages}" />
                            </c:if>

                            <!-- If there are pages before start, show first + ellipsis -->
                            <c:if test="${start > 1}">
                                <a href="${pageContext.request.contextPath}/request/report?page=1&from=${param.from != null ? param.from : ''}&to=${param.to != null ? param.to : ''}&status=${param.status != null ? param.status : 'all'}"
                                   style="margin:0 4px; padding:8px 14px; border-radius:8px; text-decoration:none; font-weight:600; color:#4f46e5; background:white; border:1px solid #ddd;">
                                    1
                                </a>
                                <span style="margin:0 6px; color:#9ca3af;">…</span>
                            </c:if>

                            <!-- Page numbers from start to end -->
                            <c:forEach var="i" begin="${start}" end="${end}">
                                <c:choose>
                                    <c:when test="${i == pageindex}">
                                        <span style="margin:0 4px; padding:8px 14px; border-radius:8px; font-weight:600; color:white; background:linear-gradient(135deg,#6a5af9,#836fff); border:1px solid #ddd;">
                                            ${i}
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/request/report?page=${i}&from=${param.from != null ? param.from : ''}&to=${param.to != null ? param.to : ''}&status=${param.status != null ? param.status : 'all'}"
                                           style="margin:0 4px; padding:8px 14px; border-radius:8px; text-decoration:none; font-weight:600; color:#4f46e5; background:white; border:1px solid #ddd;">
                                            ${i}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <!-- If there are pages after end, show ellipsis + last -->
                            <c:if test="${end < totalPages}">
                                <span style="margin:0 6px; color:#9ca3af;">…</span>
                                <a href="${pageContext.request.contextPath}/request/report?page=${totalPages}&from=${param.from != null ? param.from : ''}&to=${param.to != null ? param.to : ''}&status=${param.status != null ? param.status : 'all'}"
                                   style="margin:0 4px; padding:8px 14px; border-radius:8px; text-decoration:none; font-weight:600; color:#4f46e5; background:white; border:1px solid #ddd;">
                                    ${totalPages}
                                </a>
                            </c:if>

                            <!-- Next -->
                            <c:if test="${pageindex < totalPages}">
                                <a href="${pageContext.request.contextPath}/request/report?page=${pageindex + 1}&from=${param.from != null ? param.from : ''}&to=${param.to != null ? param.to : ''}&status=${param.status != null ? param.status : 'all'}"
                                   style="padding:8px 14px; border-radius:8px; text-decoration:none; font-weight:600; background:white; border:1px solid #ddd; box-shadow:0 2px 6px rgba(0,0,0,0.15); color:#4f46e5; transition:0.2s;">
                                    Next »
                                </a>
                            </c:if>

                        </div>
                    </c:if>



                </div>
            </c:if>
        </div>

        <script>
            // Calculate summary stats
            if (document.getElementById('totalDays')) {
                let totalDays = 0;
                let approved = 0;
                let pending = 0;

                document.querySelectorAll('#reportTable tbody tr').forEach(row => {
                    const days = parseInt(row.cells[4].textContent);
                    totalDays += days;

                    const status = row.cells[6].textContent.trim();
                    if (status === 'Approved')
                        approved++;
                    if (status === 'Pending')
                        pending++;
                });

                document.getElementById('totalDays').textContent = totalDays;
                document.getElementById('approvedCount').textContent = approved;
                document.getElementById('pendingCount').textContent = pending;
            }

            // Quick filter presets
            function applyQuickFilter() {
                const select = document.getElementById('quickSelect');
                const fromDate = document.getElementById('fromDate');
                const toDate = document.getElementById('toDate');

                const today = new Date();
                let from, to;

                switch (select.value) {
                    case 'today':
                        from = to = today;
                        break;
                    case 'week':
                        from = new Date(today.setDate(today.getDate() - today.getDay()));
                        to = new Date(today.setDate(today.getDate() - today.getDay() + 6));
                        break;
                    case 'month':
                        from = new Date(today.getFullYear(), today.getMonth(), 1);
                        to = new Date(today.getFullYear(), today.getMonth() + 1, 0);
                        break;
                    case 'quarter':
                        const quarter = Math.floor(today.getMonth() / 3);
                        from = new Date(today.getFullYear(), quarter * 3, 1);
                        to = new Date(today.getFullYear(), (quarter + 1) * 3, 0);
                        break;
                    case 'year':
                        from = new Date(today.getFullYear(), 0, 1);
                        to = new Date(today.getFullYear(), 11, 31);
                        break;
                    default:
                        return;
                }

                fromDate.valueAsDate = from;
                toDate.valueAsDate = to;
            }

            // Export functions
            function exportReport(format) {
                const form = document.getElementById('reportForm');
                const url = new URL(form.action, window.location.origin);
                url.searchParams.set('format', format);
                url.searchParams.set('from', document.getElementById('fromDate').value);
                url.searchParams.set('to', document.getElementById('toDate').value);
                url.searchParams.set('status', document.getElementById('statusFilter').value);

                window.location.href = url.toString();
            }

            // Print function
            function printReport() {
                window.print();
            }
        </script>
    </body>
</html>