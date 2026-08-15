<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!-- Header -->
<jsp:include page="/WEB-INF/view/header.jsp" />

<!-- CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout_payment.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout-sidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<div class="checkout-page">

    <!-- ====== LEFT: Thông tin thanh toán ====== -->
    <div class="payment-container">

        <form action="${pageContext.request.contextPath}/payment" method="post" class="payment-box">

            <!-- Phương thức vận chuyển -->
            <div class="payment-title">Phương thức vận chuyển</div>
            <div class="shipping-box">
                <label class="shipping-option">
                    <input type="radio" name="shipping" value="HOME" checked>
                    Giao hàng tận nơi
                    <span class="ship-price">20,000₫</span>
                </label>
            </div>

            <!-- Phương thức thanh toán -->
            <div class="payment-title">Phương thức thanh toán</div>
            <label class="payment-option">
                <input type="radio" name="method" value="COD" checked>
                Thanh toán khi nhận hàng (COD)
            </label>

            <!-- Nút hoàn tất -->
            <button class="btn-pay" type="submit">Hoàn tất đơn hàng</button>
        </form>
    </div>

    <!-- ====== RIGHT: Sidebar giỏ hàng ====== -->
    <jsp:include page="/WEB-INF/view/component/sidebar-checkout.jsp" />

</div>

<!-- Footer -->
<jsp:include page="/WEB-INF/view/footer.jsp" />
