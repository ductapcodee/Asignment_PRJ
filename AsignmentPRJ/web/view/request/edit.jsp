<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh Sửa Đơn Nghỉ Phép - Enterprise System</title>
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
                --gray-50: #f9fafb;
                --gray-100: #f3f4f6;
                --gray-200: #e5e7eb;
                --gray-300: #d1d5db;
                --gray-600: #4b5563;
                --gray-700: #374151;
                --gray-800: #1f2937;
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
                color: var(--gray-900);
            }

            .page-wrapper {
                width: 100%;
                max-width: 700px;
            }

            /* Breadcrumb */
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
                transition: color 0.2s;
            }

            .breadcrumb a:hover {
                color: var(--primary-dark);
            }

            .breadcrumb-separator {
                color: var(--gray-400);
            }

            /* Main Card */
            .card {
                background: white;
                border-radius: 16px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                border: 1px solid var(--gray-200);
                overflow: hidden;
            }

            /* Card Header */
            .card-header {
                padding: 28px 32px;
                border-bottom: 1px solid var(--gray-200);
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
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

            /* Card Body */
            .card-body {
                padding: 32px;
            }

            /* Info Section */
            .info-section {
                background: var(--gray-50);
                border: 1px solid var(--gray-200);
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 32px;
            }

            .info-section-title {
                font-size: 13px;
                font-weight: 600;
                color: var(--gray-700);
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 16px;
            }

            .info-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 16px;
            }

            .info-item {
                display: flex;
                flex-direction: column;
                gap: 4px;
            }

            .info-label {
                font-size: 12px;
                font-weight: 500;
                color: var(--gray-600);
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .info-value {
                font-size: 15px;
                font-weight: 600;
                color: var(--gray-900);
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 5px 12px;
                border-radius: 6px;
                font-size: 12px;
                font-weight: 600;
                background: #fef3c7;
                color: #92400e;
                width: fit-content;
            }

            /* Form Styles */
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
                margin-left: 2px;
            }

            .form-control {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid var(--gray-300);
                border-radius: 8px;
                font-size: 14px;
                font-family: inherit;
                transition: all 0.2s ease;
                background: white;
                color: var(--gray-900);
            }

            .form-control:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            }

            textarea.form-control {
                min-height: 120px;
                resize: vertical;
                line-height: 1.5;
            }

            .form-help {
                display: block;
                margin-top: 6px;
                font-size: 13px;
                color: var(--gray-600);
            }

            /* Date Input Enhancement */
            input[type="date"].form-control {
                position: relative;
                cursor: pointer;
            }

            input[type="date"].form-control::-webkit-calendar-picker-indicator {
                cursor: pointer;
                opacity: 0.6;
            }

            input[type="date"].form-control::-webkit-calendar-picker-indicator:hover {
                opacity: 1;
            }

            /* Buttons */
            .button-group {
                display: flex;
                gap: 12px;
                margin-top: 32px;
                padding-top: 24px;
                border-top: 1px solid var(--gray-200);
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
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                font-family: inherit;
            }

            .btn-primary {
                background: var(--primary-color);
                color: white;
            }

            .btn-primary:hover {
                background: var(--primary-dark);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(37, 99, 235, 0.3);
            }

            .btn-secondary {
                background: white;
                color: var(--gray-700);
                border-color: var(--gray-300);
            }

            .btn-secondary:hover {
                background: var(--gray-50);
                border-color: var(--gray-400);
            }

            .btn-tertiary {
                background: white;
                color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .btn-tertiary:hover {
                background: var(--primary-color);
                color: white;
            }

            .btn:active {
                transform: translateY(0);
            }

            /* Error Message */
            .error-message {
                margin-top: 24px;
                padding: 16px 20px;
                background: #fee2e2;
                color: #991b1b;
                border-radius: 8px;
                border-left: 4px solid var(--danger-color);
                font-size: 14px;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 12px;
                animation: shake 0.3s ease;
            }

            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                25% { transform: translateX(-5px); }
                75% { transform: translateX(5px); }
            }

            .error-icon {
                font-size: 20px;
            }

            /* Loading Indicator */
            .btn:disabled {
                opacity: 0.6;
                cursor: not-allowed;
            }

            /* Responsive */
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

                .info-grid {
                    grid-template-columns: 1fr;
                }

                .breadcrumb {
                    font-size: 13px;
                }
            }

            /* Animation */
            .card {
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
        </style>
    </head>
    <body>
        <div class="page-wrapper">
            <!-- Breadcrumb -->
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/home">🏠 Trang chủ</a>
                <span class="breadcrumb-separator">›</span>
                <a href="${pageContext.request.contextPath}/request/list">Quản lý đơn</a>
                <span class="breadcrumb-separator">›</span>
                <span>Chỉnh sửa</span>
            </div>

            <!-- Main Card -->
            <div class="card">
                <!-- Card Header -->
                <div class="card-header">
                    <h1 class="card-title">
                        <span>✏️</span>
                        <span>Chỉnh Sửa Đơn Nghỉ Phép</span>
                    </h1>
                    <div class="card-subtitle">Cập nhật thông tin đơn xin nghỉ của bạn</div>
                </div>

                <!-- Card Body -->
                <div class="card-body">
                    <!-- Request Info -->
                    <div class="info-section">
                        <div class="info-section-title">📋 Thông tin đơn</div>
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="info-label">Mã đơn</span>
                                <span class="info-value">#${request.id}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Người tạo</span>
                                <span class="info-value">${request.createdBy.name}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Trạng thái</span>
                                <span class="status-badge">
                                    <span>⏳</span>
                                    <span>Đang chờ duyệt</span>
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Edit Form -->
                    <form action="${pageContext.request.contextPath}/request/edit" method="post" id="editForm">
                        <input type="hidden" name="rid" value="${request.id}">

                        <div class="form-group">
                            <label class="form-label">
                                📅 Từ ngày
                                <span class="required">*</span>
                            </label>
                            <input type="date" 
                                   name="from" 
                                   value="${request.from}" 
                                   class="form-control" 
                                   required>
                            <span class="form-help">Chọn ngày bắt đầu nghỉ phép</span>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                📅 Đến ngày
                                <span class="required">*</span>
                            </label>
                            <input type="date" 
                                   name="to" 
                                   value="${request.to}" 
                                   class="form-control" 
                                   required>
                            <span class="form-help">Chọn ngày kết thúc nghỉ phép</span>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                📝 Lý do nghỉ phép
                                <span class="required">*</span>
                            </label>
                            <textarea name="reason" 
                                      class="form-control" 
                                      required 
                                      placeholder="Vui lòng nhập lý do xin nghỉ phép chi tiết...">${request.reason}</textarea>
                            <span class="form-help">Mô tả rõ lý do nghỉ phép của bạn</span>
                        </div>

                        <div class="button-group">
                            <button type="submit" class="btn btn-primary">
                                <span>💾</span>
                                <span>Lưu thay đổi</span>
                            </button>
                            <a href="${pageContext.request.contextPath}/request/list" class="btn btn-secondary">
                                <span>↩️</span>
                                <span>Quay lại</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-tertiary">
                                <span>🏠</span>
                                <span>Trang chủ</span>
                            </a>
                        </div>
                    </form>

                    <!-- Error Message -->
                    <c:if test="${error != null && !error.isEmpty()}">
                        <div class="error-message">
                            <span class="error-icon">⚠️</span>
                            <span>${error}</span>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <script>
            // Form validation
            document.getElementById('editForm').addEventListener('submit', function(e) {
                const fromDate = new Date(document.querySelector('input[name="from"]').value);
                const toDate = new Date(document.querySelector('input[name="to"]').value);
                
                if (toDate < fromDate) {
                    e.preventDefault();
                    alert('Ngày kết thúc phải sau ngày bắt đầu!');
                    return false;
                }
            });

            // Auto-resize textarea
            const textarea = document.querySelector('textarea');
            textarea.addEventListener('input', function() {
                this.style.height = 'auto';
                this.style.height = (this.scrollHeight) + 'px';
            });
        </script>
    </body>
</html>