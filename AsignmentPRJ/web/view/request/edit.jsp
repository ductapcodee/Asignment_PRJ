<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Leave Request</title>
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
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }

            .container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                padding: 40px;
                max-width: 600px;
                width: 100%;
            }

            h2 {
                color: #667eea;
                margin-bottom: 30px;
                text-align: center;
                font-size: 28px;
                font-weight: 600;
            }

            .info-section {
                background: #f8f9ff;
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 30px;
                border-left: 4px solid #667eea;
            }

            .info-item {
                display: flex;
                margin-bottom: 12px;
                font-size: 14px;
            }

            .info-item:last-child {
                margin-bottom: 0;
            }

            .info-label {
                font-weight: 600;
                color: #555;
                min-width: 110px;
            }

            .info-value {
                color: #333;
            }

            .form-group {
                margin-bottom: 25px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 600;
                font-size: 14px;
            }

            input[type="date"],
            textarea {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid #e0e0e0;
                border-radius: 8px;
                font-size: 14px;
                font-family: inherit;
                transition: all 0.3s ease;
            }

            input[type="date"]:focus,
            textarea:focus {
                outline: none;
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            textarea {
                min-height: 120px;
                resize: vertical;
            }

            .button-group {
                display: flex;
                gap: 15px;
            }

            button {
                flex: 1;
                padding: 14px;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }

            button[type="submit"] {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            button[type="submit"]:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
            }

            .btn-cancel {
                background: #6c757d;
                color: white;
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .btn-cancel:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(108, 117, 125, 0.3);
            }

            button:active,
            .btn-cancel:active {
                transform: translateY(0);
            }

            .error {
                margin-top: 20px;
                padding: 12px 15px;
                background: #f8d7da;
                color: #721c24;
                border-radius: 8px;
                text-align: center;
                font-weight: 500;
            }

            .required {
                color: #e74c3c;
            }

            @media (max-width: 600px) {
                .container {
                    padding: 25px;
                }

                h2 {
                    font-size: 24px;
                }

                .info-item {
                    flex-direction: column;
                }

                .info-label {
                    margin-bottom: 4px;
                }

                .button-group {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>✏️ Chỉnh Sửa Đơn Nghỉ Phép</h2>

            <div class="info-section">
                <div class="info-item">
                    <span class="info-label">Mã đơn:</span>
                    <span class="info-value">#${request.id}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Người tạo:</span>
                    <span class="info-value">${request.createdBy.name}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Trạng thái:</span>
                    <span class="info-value">Chờ duyệt</span>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/request/edit" method="post">
                <input type="hidden" name="rid" value="${request.id}">

                <div class="form-group">
                    <label>Từ ngày: <span class="required">*</span></label>
                    <input type="date" name="from" value="${request.from}" required>
                </div>

                <div class="form-group">
                    <label>Đến ngày: <span class="required">*</span></label>
                    <input type="date" name="to" value="${request.to}" required>
                </div>

                <div class="form-group">
                    <label>Lý do nghỉ phép: <span class="required">*</span></label>
                    <textarea name="reason" required placeholder="Nhập lý do xin nghỉ phép...">${request.reason}</textarea>
                </div>

                <div class="button-group">
                    <button type="submit">Cập Nhật</button>
                    <a href="${pageContext.request.contextPath}/request/list" class="btn-cancel">Hủy</a>
                    <!-- Nút quay về home -->
                    <a href="${pageContext.request.contextPath}/home" class="btn-cancel">Trang chủ</a>
                </div>
            </form>

            <c:if test="${error != null && !error.isEmpty()}">
                <div class="error">${error}</div>
            </c:if>
        </div>
    </body>
</html>