<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <%-- Đã thêm thư viện Functions --%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Memory Lane Sweets's Bakery</title>

    <%-- Đường dẫn CSS (Giả định nằm tại /css/style.css) --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <%-- Thư viện Font Awesome --%>
    <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
              crossorigin="anonymous"
              referrerpolicy="no-referrer" />
</head>
<body>

    <%-- 1. HEADER (Được include từ file header.jsp) --%>
    <jsp:include page="header.jsp" />

    <%-- 2. BANNER CHÍNH --%>
    <section class="main-banner">
        <div class="banner-content">
            <h1>Memory Lane Sweets</h1>
            <p>Mang đến trải nghiệm tốt nhất cho bạn</p>
            <button class="btn btn-primary">ĐẶT NGAY</button>
        </div>
        <%-- Ảnh nền Banner: Dùng ảnh làm background mờ --%>
        <div class="banner-bg">
            <img src="${pageContext.request.contextPath}/images/banner_bg.jpg" alt="Hình ảnh các loại bánh mỳ và bánh ngọt hấp dẫn">
        </div>
    </section>

    <main class="container">

        <%-- 3. KHU VỰC SẢN PHẨM MỚI (Cần class .new-products) --%>
        <section class="product-section new-products">
            <h2 class="section-title">SẢN PHẨM MỚI</h2>
            <div class="product-list">

                <c:forEach var="cake" items="${requestScope.newCakes}" varStatus="status">
                    <%-- Ẩn từ sản phẩm thứ 7 (index 6) trở đi --%>
                    <div class="product-card ${status.index >= 6 ? 'hidden-product' : ''}">
                        <a href="${pageContext.request.contextPath}/product-detail?id=${cake.cakeID}" title="${cake.cakeName}">
                            <img src="${pageContext.request.contextPath}/images/${cake.imageURL}"
                                alt="${cake.cakeName}"
                                class="product-img">
                            <h4 class="product-name">${cake.cakeName}</h4>
                        </a>
                        <fmt:formatNumber value="${cake.price}" type="number" var="formattedPrice" groupingUsed="true"/>
                        <p class="product-price">${formattedPrice}đ</p>

                        <%-- ✅ Form Thêm vào Giỏ hàng --%>
                        <form action="${pageContext.request.contextPath}/cart" method="post" class="add-to-cart-form">
                            <input type="hidden" name="action" value="add" />
                            <input type="hidden" name="productID" value="${cake.cakeID}" />
                            <input type="hidden" name="quantity" value="1" />
                            <button type="submit" class="btn-add-cart">
                                <i class="fa-solid fa-cart-shopping"></i> THÊM VÀO GIỎ
                            </button>
                        </form>
                    </div>
                </c:forEach>

            </div>
            <%-- Nút Xem Thêm cho sản phẩm mới (Thay thế thẻ <a> cũ) --%>
            <c:if test="${fn:length(requestScope.newCakes) > 6}">
                <div class="text-center">
                    <button id="btn-show-new-products" class="btn btn-secondary" onclick="showMore('new-products')">XEM THÊM</button>
                </div>
            </c:if>
        </section>

        <hr class="divider"/>

        <%-- 4. KHU VỰC SẢN PHẨM BÁN CHẠY (Cần class .best-sellers) --%>
        <section class="product-section best-sellers">
            <h2 class="section-title">SẢN PHẨM BÁN CHẠY</h2>
            <div class="product-list">

                <c:forEach var="cake" items="${requestScope.bestSellers}" varStatus="status">
                    <%-- Ẩn từ sản phẩm thứ 4 (index 3) trở đi --%>
                    <div class="product-card ${status.index >= 3 ? 'hidden-product' : ''}">
                        <a href="${pageContext.request.contextPath}/product-detail?id=${cake.cakeID}" title="${cake.cakeName}">
                            <img src="${pageContext.request.contextPath}/images/${cake.imageURL}"
                                alt="${cake.cakeName}"
                                class="product-img">
                            <h4 class="product-name">${cake.cakeName}</h4>
                        </a>
                        <fmt:formatNumber value="${cake.price}" type="number" var="formattedPrice" groupingUsed="true"/>
                        <p class="product-price">${formattedPrice}đ</p>

                        <form action="${pageContext.request.contextPath}/cart" method="post" class="add-to-cart-form">
                            <input type="hidden" name="action" value="add" />
                            <input type="hidden" name="productID" value="${cake.cakeID}" />
                            <input type="hidden" name="quantity" value="1" />
                            <button type="submit" class="btn-add-cart">
                                <i class="fa-solid fa-cart-shopping"></i> THÊM VÀO GIỎ
                            </button>
                        </form>

                    </div>
                </c:forEach>

            </div>
            <%-- Nút Xem Thêm cho sản phẩm bán chạy --%>
            <c:if test="${fn:length(requestScope.bestSellers) > 3}">
                <div class="text-center">
                    <button id="btn-show-best-sellers" class="btn btn-secondary" onclick="showMore('best-sellers')">XEM THÊM</button>
                </div>
            </c:if>
        </section>

        <hr class="divider"/>

        <%-- 5. ĐĂNG KÝ NHẬN TIN KHUYẾN MÃI --%>
        <section class="newsletter-signup">
            <h3 class="signup-title">NHẬN TIN KHUYẾN MÃI</h3>
            <form action="NewsletterServlet" method="POST" class="signup-form">
                <input type="email" name="email" placeholder="Email" required>
                <button type="submit" class="btn btn-success">Đăng ký</button>
            </form>
        </section>

    </main>

    <%-- 6. FOOTER (Được include từ file footer.jsp) --%>
    <jsp:include page="footer.jsp" />

    <script>
        function showMore(section) {
            const hiddenItems = document.querySelectorAll(`section.${section} .hidden-product`);
            hiddenItems.forEach(item => item.style.display = 'block');

            // Ẩn nút sau khi bấm
            const button = document.getElementById(`btn-show-${section}`);
            if (button) button.style.display = 'none';
        }
    </script>


</body>
</html>