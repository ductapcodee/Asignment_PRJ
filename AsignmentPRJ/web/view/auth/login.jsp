<%-- 
    Document   : login
    Created on : Oct 22, 2025, 11:43:23 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Leave Request System</title>

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

            .login-container {
                width: 100%;
                max-width: 450px;
                animation: fadeInUp 0.6s ease-out;
            }

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

            .login-card {
                background: white;
                border-radius: 24px;
                padding: 48px 40px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
                position: relative;
                overflow: hidden;
            }

            .login-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 6px;
                background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            }

            .login-header {
                text-align: center;
                margin-bottom: 40px;
            }

            .login-icon {
                width: 80px;
                height: 80px;
                margin: 0 auto 20px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 40px;
                color: white;
                box-shadow: 0 8px 24px rgba(102, 126, 234, 0.4);
            }

            .login-title {
                font-size: 28px;
                font-weight: 700;
                color: #1a202c;
                margin-bottom: 8px;
            }

            .login-subtitle {
                font-size: 14px;
                color: #718096;
            }

            /* Error Alert */
            .alert-error {
                background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                border: 1px solid #fca5a5;
                color: #991b1b;
                padding: 14px 16px;
                border-radius: 12px;
                margin-bottom: 24px;
                display: flex;
                align-items: center;
                gap: 12px;
                font-size: 14px;
                font-weight: 500;
                animation: shake 0.4s ease-in-out;
            }

            @keyframes shake {
                0%, 100% {
                    transform: translateX(0);
                }
                25% {
                    transform: translateX(-10px);
                }
                75% {
                    transform: translateX(10px);
                }
            }

            /* Form Groups */
            .form-group {
                margin-bottom: 24px;
            }

            .form-label {
                display: block;
                font-size: 14px;
                font-weight: 600;
                color: #374151;
                margin-bottom: 8px;
            }

            .input-wrapper {
                position: relative;
            }

            .input-icon {
                position: absolute;
                left: 16px;
                top: 50%;
                transform: translateY(-50%);
                color: #9ca3af;
                font-size: 18px;
                transition: color 0.3s ease;
            }

            .form-input {
                width: 100%;
                padding: 14px 16px 14px 48px;
                border: 2px solid #e5e7eb;
                border-radius: 12px;
                font-size: 15px;
                color: #1a202c;
                transition: all 0.3s ease;
                background: #f9fafb;
            }

            .form-input:focus {
                outline: none;
                border-color: #667eea;
                background: white;
                box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            }

            .form-input:focus + .input-icon {
                color: #667eea;
            }

            .form-input::placeholder {
                color: #9ca3af;
            }

            /* Password Toggle */
            .password-toggle {
                position: absolute;
                right: 16px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                color: #9ca3af;
                cursor: pointer;
                font-size: 18px;
                padding: 4px;
                transition: color 0.3s ease;
            }

            .password-toggle:hover {
                color: #667eea;
            }

            /* Submit Button */
            .btn-login {
                width: 100%;
                padding: 16px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 12px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 4px 16px rgba(102, 126, 234, 0.4);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }

            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 24px rgba(102, 126, 234, 0.5);
            }

            .btn-login:active {
                transform: translateY(0);
            }

            /* Footer */
            .login-footer {
                text-align: center;
                margin-top: 24px;
                color: #718096;
                font-size: 13px;
            }

            /* Responsive */
            @media (max-width: 480px) {
                .login-card {
                    padding: 36px 24px;
                }

                .login-title {
                    font-size: 24px;
                }

                .login-icon {
                    width: 64px;
                    height: 64px;
                    font-size: 32px;
                }
            }

            /* Loading State */
            .btn-login.loading {
                pointer-events: none;
                opacity: 0.7;
            }

            .btn-login.loading::after {
                content: '';
                width: 16px;
                height: 16px;
                border: 2px solid #ffffff;
                border-top-color: transparent;
                border-radius: 50%;
                animation: spin 0.6s linear infinite;
                margin-left: 8px;
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="login-card">
                <!-- Header -->
                <div class="login-header">
                    <div class="login-icon">
                        <i class="bi bi-shield-lock"></i>
                    </div>
                    <h1 class="login-title">Đăng nhập</h1>
                    <p class="login-subtitle">Hệ thống quản lý đơn xin nghỉ</p>
                </div>

                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div class="alert-error">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                        <span>${error}</span>
                    </div>
                </c:if>

                <c:if test="${param.error eq 'invalid'}">
                    <div class="alert-error">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                        <span>Tên đăng nhập hoặc mật khẩu không đúng!</span>
                    </div>
                </c:if>

                <!-- Login Form -->
                <form action="login" method="POST" id="loginForm">
                    <!-- Username Field -->
                    <div class="form-group">
                        <label for="txtUsername" class="form-label">
                            Tên đăng nhập
                        </label>
                        <div class="input-wrapper">
                            <input 
                                type="text" 
                                name="username" 
                                id="txtUsername" 
                                class="form-input"
                                placeholder="Nhập tên đăng nhập"
                                required
                                autofocus
                                autocomplete="username"
                                />
                            <i class="bi bi-person input-icon"></i>
                        </div>
                    </div>

                    <!-- Password Field -->
                    <div class="form-group">
                        <label for="txtPassword" class="form-label">
                            Mật khẩu
                        </label>
                        <div class="input-wrapper">
                            <input 
                                type="password" 
                                name="password" 
                                id="txtPassword" 
                                class="form-input"
                                placeholder="Nhập mật khẩu"
                                required
                                autocomplete="current-password"
                                />
                            <i class="bi bi-lock input-icon"></i>
                            <button type="button" class="password-toggle" id="togglePassword">
                                <i class="bi bi-eye" id="toggleIcon"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="btn-login" id="btnLogin">
                        <i class="bi bi-box-arrow-in-right"></i>
                        Đăng nhập
                    </button>
                </form>

                <!-- Forgot Password Link -->
                <div style="text-align:center; margin-top:16px;">
                    <a href="forgot" style="color:#667eea; font-size:14px; text-decoration:none;">
                        <i class="bi bi-question-circle"></i> Quên mật khẩu?
                    </a>
                </div>

                <!-- Footer -->
                <div class="login-footer">
                    © 2025 Leave Request System. All rights reserved.
                </div>

            </div>
        </div>

        <!-- Bootstrap 5 JS Bundle -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Custom JavaScript -->
        <script>
            // Password Toggle
            const togglePassword = document.getElementById('togglePassword');
            const passwordInput = document.getElementById('txtPassword');
            const toggleIcon = document.getElementById('toggleIcon');

            togglePassword.addEventListener('click', function () {
                const type = passwordInput.type === 'password' ? 'text' : 'password';
                passwordInput.type = type;

                // Toggle icon
                if (type === 'password') {
                    toggleIcon.classList.remove('bi-eye-slash');
                    toggleIcon.classList.add('bi-eye');
                } else {
                    toggleIcon.classList.remove('bi-eye');
                    toggleIcon.classList.add('bi-eye-slash');
                }
            });

            // Form Submit Loading State
            const loginForm = document.getElementById('loginForm');
            const btnLogin = document.getElementById('btnLogin');

            loginForm.addEventListener('submit', function () {
                btnLogin.classList.add('loading');
                btnLogin.innerHTML = '<i class="bi bi-box-arrow-in-right"></i> Đang đăng nhập...';
            });

            // Auto focus on error
            window.addEventListener('DOMContentLoaded', function () {
                const hasError = ${not empty error or param.error eq 'invalid'};
                if (hasError) {
                    document.getElementById('txtUsername').focus();
                }
            });
        </script>
    </body>
</html>