<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Duyệt Đơn Nghỉ Phép - Enterprise System</title>
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
            --success-color: #10b981;
            --danger-color: #ef4444;
            --warning-color: #f59e0b;
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
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .page-wrapper {
            width: 100%;
            max-width: 750px;
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 24px;
            font-size: 14px;
            color: var(--gray-600);
        }

        .breadcrumb a {
            color: var(--primary-color);
            text-decoration: none;
        }

        .breadcrumb a:hover {
            color: var(--primary-dark);
        }

        .card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--gray-200);
            overflow: hidden;
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

        .card-header {
            padding: 28px 32px;
            border-bottom: 1px solid var(--gray-200);
            background: linear-gradient(135deg, var(--warning-color), #d97706);
        }

        .card-title {
            font-size: 24px;
            font-weight: 700;
            color: white;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .card-subtitle {
            font-size: 14px;
            color: rgba(255, 255, 255, 0.9);
            margin-top: 6px;
        }

        .card-body {
            padding: 32px;
        }

        .info-section {
            background: var(--gray-50);
            border: 1px solid var(--gray-200);
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 32px;
        }

        .info-grid {
            display: grid;
            gap: 16px;
        }

        .info-item {
            display: grid;
            grid-template-columns: 150px 1fr;
            gap: 12px;
            align-items: start;
        }

        .info-label {
            font-size: 13px;
            font-weight: 600;
            color: var(--gray-600);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 15px;
            color: var(--gray-900);
            font-weight: 500;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            text-transform: capitalize;
            width: fit-content;
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

        .form-section {
            margin-top: 32px;
            padding-top: 32px;
            border-top: 1px solid var(--gray-200);
        }

        .form-section-title {
            font-size: 16px;
            font-weight: 600;
            color: var(--gray-900);
            margin-bottom: 16px;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 600;
            color: var(--gray-700);
        }

        .required {
            color: var(--danger-color);
        }

        textarea {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid var(--gray-300);
            border-radius: 8px;
            font-size: 14px;
            font-family: inherit;
            transition: all 0.2s ease;
            resize: vertical;
            min-height: 100px;
            line-height: 1.5;
        }

        textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .form-help {
            display: block;
            margin-top: 6px;
            font-size: 13px;
            color: var(--gray-600);
        }

        .button-group {
            display: flex;
            gap: 12px;
            margin-top: 32px;
        }

        .btn {
            flex: 1;
            padding: 13px 24px;
            border: 2px solid transparent;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            font-family: inherit;
        }

        .btn-approve {
            background: var(--success-color);
            color: white;
        }

        .btn-approve:hover {
            background: #059669;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.3);
        }

        .btn-reject {
            background: var(--danger-color);
            color: white;
        }

        .btn-reject:hover {
            background: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(239, 68, 68, 0.3);
        }

        .btn:active {
            transform: translateY(0);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-top: 24px;
            padding: 10px 20px;
            background: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        .back-link:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        @media (max-width: 640px) {
            .card-header {
                padding: 24px 20px;
            }

            .card-body {
                padding: 20px;
            }

            .card-title {
                font-size: 20px;
            }

            .button-group {
                flex-direction: column;
            }

            .info-item {
                grid-template-columns: 1fr;
                gap: 4px;
            }
        }
    </style>
</head>
<body>
    <div class="page-wrapper">
        <!-- Breadcrumb -->
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/home">🏠 Trang chủ</a>
            <span>›</span>
            <a href="${pageContext.request.contextPath}/request/list">Quản lý đơn</a>
            <span>›</span>
            <span>Duyệt đơn</span>
        </div>

        <!-- Main Card -->
        <div class="card">
            <!-- Card Header -->
            <div class="card-header">
                <h1 class="card-title">
                    <span>✅</span>
                    <span>Duyệt Đơn Nghỉ Phép</span>
                </h1>
                <div class="card-subtitle">Xem xét và phê duyệt yêu cầu nghỉ phép</div>
            </div>

            <!-- Card Body -->
            <div class="card-body">
                <!-- Request Information -->
                <div class="info-section">
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">👤 Nhân viên</span>
                            <span class="info-value">${request.createdBy.name}</span>
                        </div>

                        <div class="info-item">
                            <span class="info-label">🏢 Bộ phận</span>
                            <span class="info-value">${request.createdBy.division.dname}</span>
                        </div>

                        <div class="info-item">
                            <span class="info-label">📅 Thời gian nghỉ</span>
                            <span class="info-value">
                                <fmt:formatDate value="${request.from}" pattern="dd/MM/yyyy"/> → 
                                <fmt:formatDate value="${request.to}" pattern="dd/MM/yyyy"/>
                            </span>
                        </div>

                        <div class="info-item">
                            <span class="info-label">📝 Lý do nghỉ</span>
                            <span class="info-value">${request.reason}</span>
                        </div>

                        <div class="info-item">
                            <span class="info-label">📌 Trạng thái</span>
                            <c:choose>
                                <c:when test="${request.status == 1}">
                                    <span class="status-badge status-pending">
                                        <span>⏳</span> Đang chờ
                                    </span>
                                </c:when>
                                <c:when test="${request.status == 2}">
                                    <span class="status-badge status-approved">
                                        <span>✓</span> Đã duyệt
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-rejected">
                                        <span>✗</span> Từ chối
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Review Form -->
                <div class="form-section">
                    <h3 class="form-section-title">Quyết định phê duyệt</h3>
                    
                    <form action="${pageContext.request.contextPath}/request/review" method="post" id="reviewForm">
                        <input type="hidden" name="rid" value="${request.id}" />

                        <div class="form-group">
                            <label class="form-label">
                                Ghi chú xử lý
                                <span class="required">*</span>
                            </label>
                            <textarea name="process_reason" 
                                      placeholder="Nhập lý do phê duyệt hoặc từ chối đơn này..." 
                                      required></textarea>
                            <span class="form-help">Vui lòng cung cấp lý do cho quyết định của bạn</span>
                        </div>

                        <div class="button-group">
                            <button type="submit" name="action" value="approve" class="btn btn-approve">
                                <span>✓</span>
                                <span>Phê duyệt</span>
                            </button>
                            <button type="submit" name="action" value="reject" class="btn btn-reject">
                                <span>✗</span>
                                <span>Từ chối</span>
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Back Link -->
                <a class="back-link" href="${pageContext.request.contextPath}/request/list">
                    <span>←</span>
                    <span>Quay về danh sách</span>
                </a>
            </div>
        </div>
    </div>

    <script>
        // Auto-resize textarea
        const textarea = document.querySelector('textarea');
        textarea.addEventListener('input', function() {
            this.style.height = 'auto';
            this.style.height = (this.scrollHeight) + 'px';
        });

        // Confirm before submit
        document.getElementById('reviewForm').addEventListener('submit', function(e) {
            const action = e.submitter.value;
            const actionText = action === 'approve' ? 'phê duyệt' : 'từ chối';
            const confirmed = confirm(`Bạn có chắc chắn muốn ${actionText} đơn này?`);
            
            if (!confirmed) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>