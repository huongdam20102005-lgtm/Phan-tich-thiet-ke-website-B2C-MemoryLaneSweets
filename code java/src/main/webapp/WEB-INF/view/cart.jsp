<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Lấy đối tượng Cart từ Session --%>
<c:set var="cart" value="${sessionScope.cart}"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - Một chút ngọt ngào </title>

    <%-- Liên kết CSS và Font Awesome --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
    <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
              crossorigin="anonymous"
              referrerpolicy="no-referrer" />
</head>
<body>

<%-- CHỈ INCLUDE header.jsp MỘT LẦN --%>
<jsp:include page="header.jsp" />

<main class="container cart-page">

    <%-- Banner và tiêu đề --%>
    <div class="cart-banner">
        <h2 class="banner-title">GIỎ HÀNG CỦA BẠN - Một chút ngọt ngào </h2>
    </div>

    <h1>GIỎ HÀNG</h1>
    <hr>

    <%-- KHỐI HIỂN THỊ THÔNG BÁO LỖI (Lấy từ Request Attribute do CartServlet đặt) --%>
    <c:if test="${not empty errorMessage}">
        <p class="error-message-box">
            <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
        </p>
    </c:if>

    <c:choose>
        <c:when test="${not empty cart and not empty cart.items}">

            <div class="cart-content-wrapper">

                <%-- Bảng Chi tiết Sản phẩm --%>
                <div class="cart-items-list">

                    <%-- DÒNG 4 CỘT TIÊU ĐỀ (CÓ CLASS FLEXBOX) --%>
                    <div class="cart-header-row">
                        <span class="col-product-detail">Thông tin chi tiết sản phẩm</span>
                        <span class="col-price">Đơn giá</span>
                        <span class="col-quantity">Số lượng</span>
                        <span class="col-total">Tổng giá</span>
                    </div>

                    <%-- LẶP QUA CÁC MỤC (MỖI MỤC LÀ MỘT HÀNG FLEX) --%>
                    <c:forEach var="itemEntry" items="${cart.items}">
                        <c:set var="item" value="${itemEntry.value}"/>

                        <div class="cart-item-row">

                            <%-- Cột 1: Thông tin sản phẩm (width: 45%) --%>
                            <div class="col-product-detail">
                                <img src="${pageContext.request.contextPath}/images/${item.cake.imageURL}" alt="${item.cake.cakeName}" class="cart-item-img">
                                <div class="item-info">
                                    <span class="item-name">${item.cake.cakeName}</span>

                                    <%-- Liên kết XÓA --%>
                                    <a href="${pageContext.request.contextPath}/cart?action=remove&productID=${item.cake.cakeID}" class="item-remove-link">
                                        Xóa
                                    </a>
                                </div>
                            </div>

                            <%-- Cột 2: Đơn giá (width: 15%) --%>
                            <div class="col-price">
                                <fmt:formatNumber value="${item.cake.price}" type="number" groupingUsed="true"/>đ
                            </div>

                            <%-- Cột 3: Số lượng (width: 20%) --%>
                            <div class="col-quantity">
                                <form action="${pageContext.request.contextPath}/cart" method="post" class="quantity-update-form">
                                    <input type="hidden" name="productID" value="${item.cake.cakeID}" />
                                    <input type="hidden" name="action" value="update" />

                                    <%-- Nút trừ (-) --%>
                                    <button type="button" class="btn-qty-minus" onclick="changeQuantity(this, -1)">-</button>

                                    <%-- Input số lượng --%>
                                    <input type="number" name="quantity" value="${item.quantity}" min="1" class="qty-input"
                                                          onchange="this.form.submit()" data-product-id="${item.cake.cakeID}">

                                    <%-- Nút cộng (+) --%>
                                    <button type="button" class="btn-qty-plus" onclick="changeQuantity(this, 1)">+</button>
                                </form>
                            </div>

                            <%-- Cột 4: Tổng giá (width: 15%) --%>
                            <div class="col-total">
                                <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/>đ
                            </div>
                        </div>
                    </c:forEach>

                    <%-- Khu vực Ghi chú --%>
                    <div class="cart-notes-and-promo">
                        <p class="note-title">Qúy khách vui lòng nhập ghi chú ở đây </p>
                        <textarea class="customer-notes" placeholder="Ghi chú thêm..."></textarea>
                    </div>

                </div>

                <%-- Tóm tắt Đơn hàng (Bên phải) --%>
                <div class="order-summary">
                    <div class="summary-line total-price">
                        <span class="label">Tổng tiền hàng:</span>
                        <span class="value">
                            <fmt:formatNumber value="${cart.totalMoney}" type="number" groupingUsed="true"/>đ
                        </span>
                    </div>


                    

                    <div class="summary-line grand-total">
                        <span class="label">Tổng thanh toán:</span>
                        <span class="value final-total">
                            <fmt:formatNumber value="${cart.totalMoney + shippingFee}" type="number" groupingUsed="true"/>đ
                        </span>
                    </div>

                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-checkout-link">
                        Đặt hàng 
                    </a>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-cart-message">
                <p>Giỏ hàng của bạn đang trống! Hãy thêm những chiếc bánh ngọt ngào vào nhé. 🛒</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Tiếp tục mua sắm</a>
            </div>
        </c:otherwise>
    </c:choose>

    <%-- KHU VỰC NHẬN KHUYẾN MÃI --%>
    <div class="promo-subscription">
        <div class="promo-box">
            <span class="promo-label">NHẬN KHUYẾN MÃI</span>
            <input type="email" placeholder="Email" class="promo-email-input">
            <button class="btn btn-promo-register">ĐĂNG KÝ</button>
        </div>
    </div>
</main>

<jsp:include page="footer.jsp" />

<%-- Script JavaScript để xử lý cập nhật số lượng --%>
<script>
    function changeQuantity(button, delta) {
        var input = button.parentNode.querySelector('.qty-input');
        var currentValue = parseInt(input.value);
        var newValue = currentValue + delta;

        if (newValue >= 1) {
            input.value = newValue;
            // Tự động submit form khi giá trị thay đổi
            input.form.submit();
        } else if (newValue === 0) {
            // Nếu giảm xuống 0, hỏi xác nhận xóa
            if (confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                var productID = input.getAttribute('data-product-id');
                // Chuyển hướng đến CartServlet với action=remove
                window.location.href = '${pageContext.request.contextPath}/cart?action=remove&productID=' + productID;
            }
        }
    }
</script>

</body>
</html>