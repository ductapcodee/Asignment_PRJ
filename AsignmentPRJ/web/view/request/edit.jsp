<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa đơn xin nghỉ</title>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background-color: #f4f6f8;
            margin: 30px;
        }
        form {
            background: #fff;
            padding: 25px;
            max-width: 500px;
            margin: 0 auto;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input, textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        button {
            margin-top: 15px;
            padding: 10px 15px;
            border: none;
            background-color: #1976d2;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #125aa0;
        }
        .back {
            text-align: center;
            margin-top: 15px;
        }
        .back a {
            text-decoration: none;
            color: #1976d2;
        }
    </style>
</head>
<body>
    <h2>✏️ Chỉnh sửa đơn xin nghỉ</h2>

    <form action="edit" method="post">
        <input type="hidden" name="rid" value="${request.id}">

        <label>Từ ngày:</label>
        <input type="date" name="from" value="${request.from}">

        <label>Đến ngày:</label>
        <input type="date" name="to" value="${request.to}">

        <label>Lý do:</label>
        <textarea name="reason" rows="3">${request.reason}</textarea>

        <button type="submit">Lưu thay đổi</button>

        <div class="back">
            <a href="${pageContext.request.contextPath}/request/list">← Quay lại danh sách</a>
        </div>
    </form>
</body>
</html>
