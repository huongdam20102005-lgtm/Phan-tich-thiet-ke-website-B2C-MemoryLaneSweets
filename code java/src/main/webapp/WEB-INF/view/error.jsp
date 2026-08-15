<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi Hệ Thống - DINO'S BAKERY</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .error-container {
            text-align: center;
            padding: 50px;
            min-height: 50vh;
        }
        .error-container h1 {
            color: #cc0000;
            font-size: 48px;
        }
        .error-container p {
            font-size: 18px;
            color: #555;
            margin-bottom: 20px;
        }
        .error-details {
            background: #f8f8f8;
            border: 1px solid #ddd;
            padding: 20px;
            margin-top: 20px;
            text-align: left;
        }
    </style>
</head>
<body>
    <main class="error-container">
        <h1>❌ Đã xảy ra lỗi hệ thống</h1>
        <p>Xin lỗi, chúng tôi không thể xử lý yêu cầu của bạn vào lúc này.</p>
        
        <%-- Hiển thị thông báo chi tiết lỗi từ Servlet (nếu có) --%>
        <c:if test="${requestScope.message != null}">
            <div class="error-details">
                <strong>Chi tiết lỗi:</strong>
                <p>${requestScope.message}</p>
            </div>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary" style="margin-top: 30px;">
            Quay lại Trang chủ
        </a>
    </main>
</body>
</html>