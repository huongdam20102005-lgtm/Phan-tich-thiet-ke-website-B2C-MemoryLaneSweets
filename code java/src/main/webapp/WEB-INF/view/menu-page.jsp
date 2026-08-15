<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh mục Sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <%-- Thêm CSS riêng cho trang Menu nếu cần --%>
    <style>
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 4 cột như ảnh */
            gap: 30px;
            margin-top: 40px;
            padding: 50px 0;
        }
        .menu-item {
            text-align: center;
            text-decoration: none;
            color: #333;
            padding: 20px;
            border: 1px solid #eee;
            border-radius: 8px;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .menu-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        }
        .menu-item img {
            width: 100%;
            height: 150px; /* Chiều cao cố định cho ảnh */
            object-fit: cover;
            border-radius: 6px;
            margin-bottom: 15px;
        }
        .menu-item h3 {
            font-size: 18px;
            color: #a0522d;
            margin: 0;
        }
        @media (max-width: 768px) {
            .menu-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" /> 

    <main class="container">
        <h1 class="section-title" style="margin-top: 30px;">DANH MỤC SẢN PHẨM CHÍNH</h1>

        <div class="menu-grid">
            
            <a href="${pageContext.request.contextPath}/category?id=1" class="menu-item">
                <img src="${pageContext.request.contextPath}/images/category/banh-ngot.jpg" alt="Bánh Ngọt">
                <h3>BÁNH NGỌT</h3>
            </a>

            <a href="${pageContext.request.contextPath}/category?id=2" class="menu-item">
                <img src="${pageContext.request.contextPath}/images/category/banh-sinh-nhat.jpg" alt="Bánh Sinh Nhật">
                <h3>BÁNH SINH NHẬT</h3>
            </a>

            <a href="${pageContext.request.contextPath}/category?id=3" class="menu-item">
                <img src="${pageContext.request.contextPath}/images/category/banh-man.jpg" alt="Bánh Mặn">
                <h3>BÁNH MẶN</h3>
            </a>

            <a href="${pageContext.request.contextPath}/category?id=4" class="menu-item">
                <img src="${pageContext.request.contextPath}/images/category/cookie.jpg" alt="Cookie & Minicakes">
                <h3>COOKIE & MINICAKES</h3>
            </a>

            <%-- Bạn có thể thêm các mục khác vào đây --%>
            
        </div>
    </main>

    <jsp:include page="footer.jsp" /> 

</body>
</html>