<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Lấy đối tượng Cake từ Request Attribute --%>
<c:set var="cake" value="${requestScope.cake}" />
<c:set var="maxStock" value="${cake.quantity}" /> <%-- Lấy số lượng tồn kho --%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${cake.cakeName} - Một chút ngọt ngào </title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/detail.css">

    <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
              crossorigin="anonymous"
              referrerpolicy="no-referrer" />
</head>
<body>

<jsp:include page="header.jsp" />

<main class="container product-detail-page">

    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/home">Trang Chủ</a> /
        <span>${requestScope.categoryName}</span> /
        <span>${cake.cakeName}</span>
    </div>

    <%-- KHỐI HIỂN THỊ THÔNG BÁO LỖI (VÍ DỤ: LỖI TỒN KHO) --%>
    <%-- Lưu ý: errorMessage được đặt trong session từ CartServlet --%>
    <c:if test="${not empty sessionScope.errorMessage}">
        <p class="error-message-box detail-error" style="color:red; text-align:center;">
            <i class="fas fa-exclamation-triangle"></i> ${sessionScope.errorMessage}
        </p>
        <c:remove var="errorMessage" scope="session"/>
    </c:if>

    <div class="product-detail-wrapper">

        <div class="product-images">
            <img src="${pageContext.request.contextPath}/images/${cake.imageURL}"
                 alt="${cake.cakeName}" class="main-product-img">
        </div>

        <div class="product-info">
            <h1 class="product-title">${cake.cakeName}</h1>

            <%-- KHÔI PHỤC THÔNG TIN SẢN PHẨM (SKU & TỒN KHO) --%>
            <p class="product-sku">Mã số: <strong>${cake.cakeID}</strong></p>
            <p class="product-stock">Tồn kho: <strong>${maxStock}</strong> sản phẩm</p>

            <fmt:formatNumber value="${cake.price}" type="number" var="formattedPrice" groupingUsed="true"/>
            <p class="product-price">Giá: <strong>${formattedPrice}đ</strong></p>

            <hr class="detail-divider">

            <form action="${pageContext.request.contextPath}/cart" method="post" class="add-to-cart-section">
                <div class="quantity-control">
                    <button type="button" class="btn-qty-minus">−</button>
                    <input type="number" name="quantity" value="1" min="1" class="qty-input">
                    <button type="button" class="btn-qty-plus">+</button>
                </div>

                <input type="hidden" name="productID" value="${cake.cakeID}" />
                <input type="hidden" name="action" value="add" />

                <button type="submit" class="btn btn-add-cart">
                    <i class="fa-solid fa-cart-shopping"></i> THÊM VÀO GIỎ
                </button>

            </form>

            <hr class="detail-divider">

            <div class="product-description">
                <h3>Mô tả</h3>
                <p>${cake.description}</p>
            </div>
        </div>


    </div>

    <div class="related-products-section">
        <h2 class="section-title">SẢN PHẨM KHÁC</h2>
        <div class="related-product-list">

            <c:forEach var="related" items="${requestScope.relatedProducts}">
                <div class="product-card">
                    <a href="${pageContext.request.contextPath}/product-detail?id=${related.cakeID}">
                        <img src="${pageContext.request.contextPath}/images/${related.imageURL}"
                             alt="${related.cakeName}">
                        <p class="related-name">${related.cakeName}</p>
                    </a>
                </div>
            </c:forEach>

        </div>
    </div>

    <div class="newsletter-signup">
        <span class="promo-label">NHẬN TIN KHUYẾN MÃI</span>
        <input type="email" placeholder="Email" class="promo-email-input">
        <button class="btn btn-promo-register">ĐĂNG KÝ</button>
    </div>

</main>

<jsp:include page="footer.jsp" />

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const minusButton = document.querySelector('.btn-qty-minus');
        const plusButton = document.querySelector('.btn-qty-plus');
        const qtyInput = document.querySelector('.qty-input');

        // Lấy số lượng tồn kho (maxQuantity) từ biến JSTL/EL
        const maxQuantity = parseInt('${maxStock}'); // Sử dụng biến JSTL/EL

        if (minusButton && plusButton && qtyInput && !isNaN(maxQuantity)) {

            // Xử lý nút Trừ (-)
            minusButton.addEventListener('click', function() {
                let currentValue = parseInt(qtyInput.value);
                if (currentValue > 1) {
                    qtyInput.value = currentValue - 1;
                }
            });

            // Xử lý nút Cộng (+)
            plusButton.addEventListener('click', function() {
                let currentValue = parseInt(qtyInput.value);
                // Giới hạn bằng số lượng tối đa (tồn kho)
                if (currentValue < maxQuantity) {
                    qtyInput.value = currentValue + 1;
                }
            });

            // Xử lý khi người dùng nhập tay vào ô input
            qtyInput.addEventListener('change', function() {
                let currentValue = parseInt(qtyInput.value);

                if (isNaN(currentValue) || currentValue < 1) {
                    qtyInput.value = 1; // Mặc định là 1 nếu nhập không hợp lệ
                } else if (currentValue > maxQuantity) {
                    qtyInput.value = maxQuantity; // Giới hạn max bằng tồn kho
                }
            });
        }
    });
</script>

</body>
</html>