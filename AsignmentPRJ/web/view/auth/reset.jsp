<%-- 
    Document   : reset
    Created on : Nov 8, 2025, 1:03:13 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu - Leave Request System</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .reset-container {
            width: 100%;
            max-width: 480px;
            animation: fadeInUp 0.6s ease-out;
        }

        /* Logo Section */
        .logo-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo-icon {
            width: 80px;
            height: 80px;
            background: white;
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            color: #667eea;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
        }

        .logo-title {
            color: white;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .logo-subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 16px;
        }

        /* Card */
        .reset-card {
            background: white;
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            position: relative;
            overflow: hidden;
        }

        .reset-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        }

        .card-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .card-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            border-radius: 16px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: white;
            margin-bottom: 15px;
            box-shadow: 0 8px 20px rgba(16, 185, 129, 0.3);
        }

        .card-title {
            font-size: 24px;
            font-weight: 700;
            color: #1a202c;
            margin-bottom: 8px;
        }

        .card-description {
            color: #718096;
            font-size: 14px;
            line-height: 1.6;
        }

        /* OTP Timer */
        .otp-timer {
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            border-radius: 12px;
            padding: 12px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            font-size: 14px;
            color: #15803d;
        }

        .otp-timer i {
            font-size: 18px;
        }

        .timer-text {
            font-weight: 600;
        }

        .timer-expired {
            background: #fee;
            border-color: #fcc;
            color: #c53030;
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 24px;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-label i {
            color: #667eea;
            margin-right: 6px;
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 15px;
            transition: all 0.3s ease;
            background: #f7fafc;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        /* Password Input Container */
        .password-container {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #718096;
            cursor: pointer;
            font-size: 18px;
            padding: 4px;
            transition: color 0.3s ease;
        }

        .password-toggle:hover {
            color: #667eea;
        }

        /* Password Strength */
        .password-strength {
            margin-top: 8px;
            font-size: 13px;
        }

        .strength-bar {
            height: 4px;
            background: #e2e8f0;
            border-radius: 4px;
            overflow: hidden;
            margin-bottom: 6px;
        }

        .strength-fill {
            height: 100%;
            transition: all 0.3s ease;
            border-radius: 4px;
        }

        .strength-weak .strength-fill {
            width: 33%;
            background: #ef4444;
        }

        .strength-medium .strength-fill {
            width: 66%;
            background: #f59e0b;
        }

        .strength-strong .strength-fill {
            width: 100%;
            background: #10b981;
        }

        .strength-text {
            color: #718096;
            font-size: 12px;
        }

        /* Buttons */
        .btn-primary {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            border: none;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-bottom: 12px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(16, 185, 129, 0.4);
        }

        .btn-primary:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        .btn-secondary {
            width: 100%;
            padding: 14px;
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            color: #4a5568;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-secondary:hover {
            background: #f7fafc;
            border-color: #cbd5e0;
        }

        /* Alert Messages */
        .alert {
            padding: 14px 16px;
            border-radius: 12px;
            margin-bottom: 20px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
            animation: slideDown 0.4s ease-out;
        }

        .alert-danger {
            background: #fee;
            border: 1px solid #fcc;
            color: #c53030;
        }

        .alert-danger i {
            color: #e53e3e;
            font-size: 20px;
            flex-shrink: 0;
        }

        /* Loading Spinner */
        .spinner {
            display: inline-block;
            width: 16px;
            height: 16px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top-color: white;
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
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

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive */
        @media (max-width: 576px) {
            .reset-card {
                padding: 30px 24px;
            }

            .logo-title {
                font-size: 24px;
            }

            .card-title {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="reset-container">
        <!-- Logo Section -->
        <div class="logo-section">
            <div class="logo-icon">
                <i class="bi bi-calendar-check"></i>
            </div>
            <div class="logo-title">Leave Request System</div>
            <div class="logo-subtitle">Hệ thống quản lý đơn xin nghỉ</div>
        </div>

        <!-- Reset Password Card -->
        <div class="reset-card">
            <div class="card-header">
                <div class="card-icon">
                    <i class="bi bi-shield-lock"></i>
                </div>
                <h1 class="card-title">Đặt lại mật khẩu</h1>
                <p class="card-description">
                    Nhập mã OTP đã được gửi đến email của bạn và tạo mật khẩu mới
                </p>
            </div>

            <!-- OTP Timer -->
            <div class="otp-timer" id="otpTimer">
                <i class="bi bi-clock"></i>
                <span>Mã OTP có hiệu lực trong: </span>
                <span class="timer-text" id="countdown">5:00</span>
            </div>

            <!-- Error Alert -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-circle-fill"></i>
                    <div>${error}</div>
                </div>
            </c:if>

            <!-- Form -->
            <form action="reset" method="POST" id="resetForm">
                <input type="hidden" name="email" value="${email}" />

                <!-- OTP Input -->
                <div class="form-group">
                    <label class="form-label">
                        <i class="bi bi-key-fill"></i>
                        Mã OTP (6 chữ số)
                    </label>
                    <input 
                        type="text" 
                        name="otp" 
                        class="form-control" 
                        placeholder="Nhập mã OTP đã nhận qua email"
                        required 
                        autofocus
                        pattern="[0-9]{6}"
                        maxlength="6"
                        title="OTP phải là 6 chữ số"
                    />
                </div>

                <!-- New Password Input -->
                <div class="form-group">
                    <label class="form-label">
                        <i class="bi bi-lock-fill"></i>
                        Mật khẩu mới
                    </label>
                    <div class="password-container">
                        <input 
                            type="password" 
                            name="password" 
                            id="passwordInput"
                            class="form-control" 
                            placeholder="Tối thiểu 6 ký tự"
                            required 
                            minlength="6"
                            title="Mật khẩu phải có ít nhất 6 ký tự"
                        />
                        <button type="button" class="password-toggle" id="togglePassword">
                            <i class="bi bi-eye" id="eyeIcon"></i>
                        </button>
                    </div>
                    
                    <!-- Password Strength Indicator -->
                    <div class="password-strength" id="strengthIndicator" style="display: none;">
                        <div class="strength-bar">
                            <div class="strength-fill" id="strengthFill"></div>
                        </div>
                        <div class="strength-text" id="strengthText"></div>
                    </div>
                </div>

                <button type="submit" class="btn-primary" id="submitBtn">
                    <i class="bi bi-check-circle"></i>
                    <span id="btnText">Đổi mật khẩu</span>
                    <span id="btnSpinner" class="spinner" style="display: none;"></span>
                </button>

                <a href="forgot" class="btn-secondary">
                    <i class="bi bi-arrow-left"></i>
                    Gửi lại mã OTP
                </a>
            </form>
        </div>
    </div>

    <script>
        // OTP Countdown Timer (5 minutes)
        let timeLeft = 5 * 60; // 5 minutes in seconds
        const countdownElement = document.getElementById('countdown');
        const timerElement = document.getElementById('otpTimer');

        const timer = setInterval(() => {
            timeLeft--;
            
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            
            countdownElement.textContent = minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
            
            if (timeLeft <= 0) {
                clearInterval(timer);
                timerElement.classList.add('timer-expired');
                timerElement.innerHTML = '<i class="bi bi-x-circle"></i> <span>Mã OTP đã hết hạn. Vui lòng gửi lại!</span>';
            }
        }, 1000);

        // Password Toggle
        const passwordInput = document.getElementById('passwordInput');
        const toggleButton = document.getElementById('togglePassword');
        const eyeIcon = document.getElementById('eyeIcon');

        toggleButton.addEventListener('click', function() {
            const type = passwordInput.type === 'password' ? 'text' : 'password';
            passwordInput.type = type;
            
            if (type === 'text') {
                eyeIcon.classList.remove('bi-eye');
                eyeIcon.classList.add('bi-eye-slash');
            } else {
                eyeIcon.classList.remove('bi-eye-slash');
                eyeIcon.classList.add('bi-eye');
            }
        });

        // Password Strength Checker
        const strengthIndicator = document.getElementById('strengthIndicator');
        const strengthFill = document.getElementById('strengthFill');
        const strengthText = document.getElementById('strengthText');

        passwordInput.addEventListener('input', function() {
            const password = this.value;
            
            if (password.length === 0) {
                strengthIndicator.style.display = 'none';
                return;
            }
            
            strengthIndicator.style.display = 'block';
            
            let strength = 0;
            if (password.length >= 6) strength++;
            if (password.length >= 8) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;
            if (/[^a-zA-Z0-9]/.test(password)) strength++;
            
            strengthIndicator.className = 'password-strength';
            
            if (strength <= 2) {
                strengthIndicator.classList.add('strength-weak');
                strengthText.textContent = '⚠️ Mật khẩu yếu - Nên thêm chữ hoa, số hoặc ký tự đặc biệt';
            } else if (strength <= 3) {
                strengthIndicator.classList.add('strength-medium');
                strengthText.textContent = '✓ Mật khẩu trung bình - Có thể mạnh hơn';
            } else {
                strengthIndicator.classList.add('strength-strong');
                strengthText.textContent = '✓ Mật khẩu mạnh - Rất tốt!';
            }
        });

        // Form Submission
        const form = document.getElementById('resetForm');
        const submitBtn = document.getElementById('submitBtn');
        const btnText = document.getElementById('btnText');
        const btnSpinner = document.getElementById('btnSpinner');

        form.addEventListener('submit', function(e) {
            submitBtn.disabled = true;
            btnText.style.display = 'none';
            btnSpinner.style.display = 'inline-block';
        });

        // Auto-focus OTP input
        window.addEventListener('load', function() {
            const otpInput = document.querySelector('input[name="otp"]');
            if (otpInput && !otpInput.value) {
                otpInput.focus();
            }
        });

        // Auto-format OTP input (only numbers)
        document.querySelector('input[name="otp"]').addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    </script>
</body>
</html>