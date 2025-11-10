<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Leave Report Generator</title>
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
                background: #fee2e2;
                color: #991b1b;
                border-left: 4px solid var(--danger-color);
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

            /* Filter Card */
            .filter-card {
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

            /* Tab Buttons */
            .tab-buttons {
                display: flex;
                gap: 12px;
                margin-bottom: 24px;
            }

            .tab-btn {
                padding: 10px 20px;
                border: 2px solid var(--gray-300);
                background: white;
                color: var(--gray-700);
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s ease;
                font-size: 14px;
            }

            .tab-btn:hover {
                border-color: var(--primary-color);
                color: var(--primary-color);
            }

            .tab-btn.active {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                border-color: transparent;
            }

            /* Filter Grid */
            .filter-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 20px;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
            }

            .filter-group label {
                font-weight: 600;
                color: var(--gray-700);
                margin-bottom: 8px;
                font-size: 14px;
            }

            .filter-group input,
            .filter-group select {
                padding: 10px 12px;
                border: 1px solid var(--gray-300);
                border-radius: 8px;
                font-size: 14px;
                transition: all 0.2s ease;
            }

            .filter-group input:focus,
            .filter-group select:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            }

            .current-filter {
                padding: 12px 16px;
                background: var(--gray-100);
                border-radius: 8px;
                font-size: 14px;
                color: var(--gray-700);
                font-style: italic;
                margin-bottom: 16px;
            }

            /* Action Buttons */
            .action-buttons {
                display: flex;
                gap: 12px;
                flex-wrap: wrap;
            }

            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                font-size: 14px;
                transition: all 0.2s ease;
                display: inline-flex;
                align-items: center;
                gap: 6px;
                text-decoration: none;
            }

            .btn-primary {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
            }

            .btn-primary:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
            }

            .btn-success {
                background: var(--success-color);
                color: white;
            }

            .btn-success:hover {
                background: #059669;
                transform: translateY(-1px);
            }

            .btn-warning {
                background: var(--warning-color);
                color: white;
            }

            .btn-warning:hover {
                background: #d97706;
                transform: translateY(-1px);
            }

            /* Summary Stats */
            .summary-stats {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 24px;
            }

            .stat-box {
                padding: 20px;
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                border-radius: 12px;
                color: white;
                text-align: center;
            }

            .stat-box .label {
                font-size: 13px;
                opacity: 0.9;
                margin-bottom: 8px;
                font-weight: 500;
            }

            .stat-box .value {
                font-size: 36px;
                font-weight: 700;
            }

            /* Data Table */
            .data-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
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

            .status-badge {
                display: inline-block;
                padding: 4px 12px;
                border-radius: 6px;
                font-size: 12px;
                font-weight: 600;
            }

            .status-pending {
                background: #fef3c7;
                color: #92400e;
            }

            .status-approved {
                background: #d1fae5;
                color: #065f46;
            }

            .status-rejected {
                background: #fee2e2;
                color: #991b1b;
            }

            /* Pagination */
            .pagination {
                margin-top: 24px;
                text-align: center;
                display: flex;
                justify-content: center;
                gap: 8px;
                flex-wrap: wrap;
            }

            .pagination a,
            .pagination span {
                padding: 8px 14px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 600;
                font-size: 14px;
                transition: all 0.2s ease;
            }

            .pagination a {
                color: var(--primary-color);
                background: white;
                border: 1px solid var(--gray-300);
            }

            .pagination a:hover {
                background: var(--gray-100);
                border-color: var(--primary-color);
            }

            .pagination .current {
                color: white;
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                border: 1px solid transparent;
            }

            .pagination .ellipsis {
                color: var(--gray-600);
                border: none;
            }

            /* Print Styles */
            @media print {
                body {
                    background: white;
                    padding: 0;
                }

                .top-nav,
                .tab-buttons,
                #quickSection,
                #customSection,
                .current-filter,
                .btn-success,
                .btn-warning {
                    display: none !important;
                }

                .page-header,
                .filter-card {
                    box-shadow: none;
                    border: 1px solid #ccc;
                }

                .data-table th,
                .data-table td {
                    border: 1px solid #ccc;
                    padding: 8px;
                    font-size: 12px;
                }

                .stat-box {
                    background: #eee !important;
                    color: #000 !important;
                }
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

                .summary-stats {
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
                    <div class="nav-brand-icon">📈</div>
                    <span>Leave Report Generator</span>
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
                <div class="page-title">📈 Leave Report Generator</div>
                <div class="page-subtitle">Tạo báo cáo chi tiết về nghỉ phép với các bộ lọc tùy chỉnh</div>
            </div>

            <!-- Error Alert -->
            <c:if test="${not empty error}">
                <div class="alert">
                    <span style="font-size: 20px;">⚠️</span>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- Filter Form -->
            <div class="filter-card">
                <div class="section-header">
                    <span style="font-size: 24px;">🔍</span>
                    <h2 class="section-title">Tùy chọn tìm kiếm</h2>
                </div>

                <form action="${pageContext.request.contextPath}/request/report" method="get" id="reportForm">
                    <!-- Tabs -->
                    <div class="tab-buttons">
                        <button type="button" id="tabQuick" class="tab-btn" onclick="switchMode('quick')">
                            ⚡ Tìm kiếm nhanh
                        </button>
                        <button type="button" id="tabCustom" class="tab-btn active" onclick="switchMode('custom')">
                            🎯 Tùy chỉnh
                        </button>
                    </div>

                    <!-- Quick Range Section -->
                    <div id="quickSection" style="display: none;">
                        <div class="filter-grid">
                            <div class="filter-group">
                                <label>Chọn khoảng thời gian</label>
                                <select id="quickSelect" onchange="applyQuickFilter()">
                                    <option value="">Chọn...</option>
                                    <option value="today">Hôm nay</option>
                                    <option value="week">Tuần này</option>
                                    <option value="month">Tháng này</option>
                                    <option value="quarter">Quý này</option>
                                    <option value="year">Năm nay</option>
                                </select>
                            </div>

                            <div class="filter-group">
                                <label>Trạng thái</label>
                                <select name="status" id="statusFilter">
                                    <option value="all" ${param.status == 'all' ? 'selected' : ''}>Tất cả</option>
                                    <option value="1" ${param.status == '1' ? 'selected' : ''}>Chờ duyệt</option>
                                    <option value="2" ${param.status == '2' ? 'selected' : ''}>Đã duyệt</option>
                                    <option value="3" ${param.status == '3' ? 'selected' : ''}>Từ chối</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Custom Range Section -->
                    <div id="customSection">
                        <div class="filter-grid">
                            <div class="filter-group">
                                <label>Từ ngày</label>
                                <input type="date" name="from" id="fromDate" value="${param.from != null ? param.from : ''}">
                            </div>
                            <div class="filter-group">
                                <label>Đến ngày</label>
                                <input type="date" name="to" id="toDate" value="${param.to != null ? param.to : ''}">
                            </div>
                            <div class="filter-group">
                                <label>Trạng thái</label>
                                <select name="status" id="statusFilterCustom">
                                    <option value="all" ${param.status == null || param.status == 'all' || param.status == '' ? 'selected' : ''}>Tất cả</option>
                                    <option value="1" ${param.status == '1' ? 'selected' : ''}>Chờ duyệt</option>
                                    <option value="2" ${param.status == '2' ? 'selected' : ''}>Đã duyệt</option>
                                    <option value="3" ${param.status == '3' ? 'selected' : ''}>Từ chối</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="current-filter" id="currentFilter">
                        📅 Bộ lọc hiện tại: Tùy chỉnh (chọn khoảng thời gian)
                    </div>

                    <div class="action-buttons">
                        <button type="submit" class="btn btn-primary">
                            🔍 Tìm báo cáo
                        </button>
                        <button type="button" class="btn btn-success" onclick="exportReport('excel')">
                            📊 Xuất Excel
                        </button>
                        <button type="button" class="btn btn-warning" onclick="printReport()">
                            🖨️ In báo cáo
                        </button>
                        <button type="button" class="btn btn-warning" onclick="resetFilters()">
                            ♻️ Đặt lại
                        </button>
                    </div>
                </form>
            </div>

            <!-- Results -->
            <c:if test="${requests != null}">
                <div class="filter-card">
                    <div class="section-header">
                        <span style="font-size: 24px;">📊</span>
                        <h2 class="section-title">Kết quả báo cáo</h2>
                    </div>
                    
                    <!-- Summary Statistics -->
                    <div class="summary-stats">
                        <div class="stat-box">
                            <div class="label">Tổng số đơn</div>
                            <div class="value">${totalRequests != null ? totalRequests : 0}</div>
                        </div>
                        <div class="stat-box">
                            <div class="label">Tổng số ngày</div>
                            <div class="value">${totalDays != null ? totalDays : 0}</div>
                        </div>
                        <div class="stat-box">
                            <div class="label">Đã duyệt</div>
                            <div class="value">${approvedCount != null ? approvedCount : 0}</div>
                        </div>
                        <div class="stat-box">
                            <div class="label">Chờ duyệt</div>
                            <div class="value">${pendingCount != null ? pendingCount : 0}</div>
                        </div>
                    </div>

                    <!-- Data Table -->
                    <table class="data-table" id="reportTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nhân viên</th>
                                <th>Từ ngày</th>
                                <th>Đến ngày</th>
                                <th>Số ngày</th>
                                <th>Lý do</th>
                                <th>Trạng thái</th>
                                <th>Người duyệt</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requests}" var="req">
                                <tr>
                                    <td>#${req.id}</td>
                                    <td><strong>${req.createdBy.name}</strong></td>
                                    <td><fmt:formatDate value="${req.from}" pattern="dd/MM/yyyy"/></td>
                                    <td><fmt:formatDate value="${req.to}" pattern="dd/MM/yyyy"/></td>
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
                                            ${req.status == 1 ? 'Chờ duyệt' : (req.status == 2 ? 'Đã duyệt' : 'Từ chối')}
                                        </span>
                                    </td>
                                    <td>${req.processedBy != null ? req.processedBy.name : 'N/A'}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <c:if test="${totalPages != null && totalPages > 0}">
                        <div class="pagination">
                            <c:if test="${pageindex > 1}">
                                <a href="${pageContext.request.contextPath}/request/report?page=${pageindex - 1}&from=${param.from != null ? param.from : ''}&to=${param.to != null ? param.to : ''}&status=${param.status != null ? param.status : 'all'}">
                                    ← Trước
                                </a>
                            </c:if>

                            <c:set var="window" value="2" />
                            <c:set var="start" value="${pageindex - window}" />
                            <c:set var="end" value="${pageindex + window}" />

                            <c:if test="${start < 1}">
                                <c:set var="end" value="${end + (1 - start)}" />
                                <c:set var="start" value="1" />
                            </c:if>

                            <c:if test="${end > totalPages}">
                                <c:set var="start" value="${start - (end - totalPages)}" />
                                <c:set var="end" value="${totalPages}" />
                            </c:if>

                            <c:if test="${start < 1}">
                                <c:set var="start" value="1" />
                            </c:if>
                            <c:if test="${end > totalPages}">
                                <c:set var="end" value="${totalPages}" />
                            </c:if>

                            <c:if test="${start > 1}">
                                <a href="${pageContext.request.contextPath}/request/report?page=1&from=${param.from != null ? param.from : ''}&to=${param.to != null ? param.to : ''}&status=${param.status != null ? param.status : 'all'}">
                                    1
                                </a>
                                <span class="ellipsis">…</span>
                            </c:if>

                            <c:forEach var="i" begin="${start}" end="${end}">
                                <c:choose>
                                    <c:when test="${i == pageindex}">
                                        <span class="current">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/request/report?page=${i}&from=${param.from != null ? param.from : ''}&to=${param.to != null ? param.to : ''}&status=${param.status != null ? param.status : 'all'}">
                                            ${i}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${end < totalPages}">
                                <span class="ellipsis">…</span>
                                <a href="${pageContext.request.contextPath}/request/report?page=${totalPages}&from=${param.from != null ? param.from : ''}&to=${param.to != null ? param.to : ''}&status=${param.status != null ? param.status : 'all'}">
                                    ${totalPages}
                                </a>
                            </c:if>

                            <c:if test="${pageindex < totalPages}">
                                <a href="${pageContext.request.contextPath}/request/report?page=${pageindex + 1}&from=${param.from != null ? param.from : ''}&to=${param.to != null ? param.to : ''}&status=${param.status != null ? param.status : 'all'}">
                                    Sau →
                                </a>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </c:if>
        </div>

        <script>
            let mode = 'custom';

            function switchMode(selected) {
                mode = selected;
                const quick = document.getElementById('quickSection');
                const custom = document.getElementById('customSection');
                const tabQuick = document.getElementById('tabQuick');
                const tabCustom = document.getElementById('tabCustom');
                const currentFilter = document.getElementById('currentFilter');

                // ✅ Get select boxes
                const statusFilterQuick = document.getElementById('statusFilter');
                const statusFilterCustom = document.getElementById('statusFilterCustom');

                if (selected === 'quick') {
                    quick.style.display = 'block';
                    custom.style.display = 'none';
                    tabQuick.classList.add('active');
                    tabCustom.classList.remove('active');
                    currentFilter.textContent = "📅 Bộ lọc hiện tại: Lọc nhanh (chọn tùy chọn)";

                    // ✅ Enable quick, disable custom
                    statusFilterQuick.disabled = false;
                    statusFilterCustom.disabled = true;
                } else {
                    quick.style.display = 'none';
                    custom.style.display = 'block';
                    tabCustom.classList.add('active');
                    tabQuick.classList.remove('active');
                    currentFilter.textContent = "📅 Bộ lọc hiện tại: Tùy chỉnh (chọn khoảng thời gian)";

                    // ✅ Enable custom, disable quick
                    statusFilterQuick.disabled = true;
                    statusFilterCustom.disabled = false;
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
                        label = 'Hôm nay';
                        break;
                    case 'week':
                        const first = new Date(today.setDate(today.getDate() - today.getDay()));
                        const last = new Date(first);
                        last.setDate(first.getDate() + 6);
                        from = first;
                        to = last;
                        label = 'Tuần này';
                        break;
                    case 'month':
                        from = new Date(today.getFullYear(), today.getMonth(), 1);
                        to = new Date(today.getFullYear(), today.getMonth() + 1, 0);
                        label = 'Tháng này';
                        break;
                    case 'quarter':
                        const q = Math.floor(today.getMonth() / 3);
                        from = new Date(today.getFullYear(), q * 3, 1);
                        to = new Date(today.getFullYear(), (q + 1) * 3, 0);
                        label = 'Quý này';
                        break;
                    case 'year':
                        from = new Date(today.getFullYear(), 0, 1);
                        to = new Date(today.getFullYear(), 11, 31);
                        label = 'Năm nay';
                        break;
                    default:
                        from = to = null;
                        label = 'None';
                }

                if (from && to) {
                    fromDate.valueAsDate = from;
                    toDate.valueAsDate = to;
                    currentFilter.textContent = `📅 Bộ lọc hiện tại: ${label} (${from.toLocaleDateString()} → ${to.toLocaleDateString()})`;
                } else {
                    currentFilter.textContent = "📅 Bộ lọc hiện tại: None";
                }
            }

            // Default view on load
            switchMode('custom');

            function resetFilters() {
                document.getElementById('fromDate').value = '';
                document.getElementById('toDate').value = '';
                document.getElementById('statusFilter').value = 'all';
                document.getElementById('statusFilterCustom').value = 'all';
                document.getElementById('quickSelect').value = '';
                document.getElementById('currentFilter').textContent = "📅 Bộ lọc hiện tại: None";
                switchMode('custom');
                document.getElementById('reportForm').submit();
            }


            // Export functions
            function exportReport(format) {
                const form = document.getElementById('reportForm');
                const url = new URL(form.action, window.location.origin);
                url.searchParams.set('format', format);
                url.searchParams.set('from', document.getElementById('fromDate').value);
                url.searchParams.set('to', document.getElementById('toDate').value);

                // Get correct status value based on active mode
                const statusValue = mode === 'quick'
                        ? document.getElementById('statusFilter').value
                        : document.getElementById('statusFilterCustom').value;
                url.searchParams.set('status', statusValue);

                window.location.href = url.toString();
            }

            // Print function
            function printReport() {
                window.print();
            }
        </script>
    </body>
</html>