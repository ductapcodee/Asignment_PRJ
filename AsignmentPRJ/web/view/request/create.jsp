<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tạo Đơn Nghỉ Phép - Enterprise System</title>
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

            /* Alert Messages */
            .alert {
                padding: 16px 20px;
                border-radius: 12px;
                margin-bottom: 24px;
                display: flex;
                align-items: center;
                gap: 12px;
                font-weight: 500;
                font-size: 14px;
                animation: slideDown 0.3s ease-out;
            }

            .alert-success {
                background: #d1fae5;
                color: #065f46;
                border-left: 4px solid var(--success-color);
            }

            .alert-error {
                background: #fee2e2;
                color: #991b1b;
                border-left: 4px solid var(--danger-color);
            }

            .alert-icon {
                font-size: 20px;
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

            .btn:active {
                transform: translateY(0);
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
                <span>Tạo đơn nghỉ phép</span>
            </div>

            <!-- Main Card -->
            <div class="card">
                <!-- Card Header -->
                <div class="card-header">
                    <h1 class="card-title">
                        <span>📝</span>
                        <span>Tạo Đơn Xin Nghỉ Phép</span>
                    </h1>
                    <div class="card-subtitle">Điền thông tin để gửi yêu cầu nghỉ phép</div>
                </div>

                <!-- Card Body -->
                <div class="card-body">
                    <!-- Alert Messages -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-error">
                            <span class="alert-icon">⚠️</span>
                            <span>${error}</span>
                        </div>
                    </c:if>

                    <c:if test="${not empty message}">
                        <div class="alert alert-success">
                            <span class="alert-icon">✅</span>
                            <span>${message}</span>
                        </div>
                    </c:if>

                    <!-- Employee Info -->
                    <div class="info-section">
                        <div class="info-section-title">👤 Thông tin nhân viên</div>
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="info-label">Họ và tên</span>
                                <span class="info-value">${sessionScope.auth.displayname}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Vai trò</span>
                                <span class="info-value">
                                    ${sessionScope.auth.roles != null && !sessionScope.auth.roles.isEmpty()
                                      ? sessionScope.auth.roles[0].rname : 'N/A'}
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Phòng ban</span>
                                <span class="info-value">
                                    ${sessionScope.auth.employee != null 
                                      ? sessionScope.auth.employee.division.dname : 'N/A'}
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Người giám sát</span>
                                <span class="info-value">
                                    ${sessionScope.auth.employee.supervisor != null 
                                      ? sessionScope.auth.employee.supervisor.name 
                                      : 'Chưa có'}
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Leave Request Form -->
                    <form action="${pageContext.request.contextPath}/request/create" method="post" id="createForm">
                        <div class="form-group">
                            <label class="form-label">
                                📅 Từ ngày
                                <span class="required">*</span>
                            </label>
                            <input type="date" 
                                   name="from" 
                                   value="${from}" 
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
                                   value="${to}" 
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
                                      placeholder="Vui lòng nhập lý do xin nghỉ phép chi tiết...">${reason}</textarea>
                            <span class="form-help">Mô tả rõ lý do nghỉ phép của bạn</span>
                        </div>

                        <div class="button-group">
                            <button type="submit" class="btn btn-primary">
                                <span>📤</span>
                                <span>Gửi đơn</span>
                            </button>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">
                                <span>↩️</span>
                                <span>Hủy bỏ</span>
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            // Form validation
            document.getElementById('createForm').addEventListener('submit', function(e) {
                const fromDate = new Date(document.querySelector('input[name="from"]').value);
                const toDate = new Date(document.querySelector('input[name="to"]').value);
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                
                if (fromDate < today) {
                    e.preventDefault();
                    alert('Ngày bắt đầu không thể là ngày trong quá khứ!');
                    return false;
                }
                
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