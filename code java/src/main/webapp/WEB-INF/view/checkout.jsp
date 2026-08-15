<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<jsp:include page="/WEB-INF/view/header.jsp" />
<%@ page contentType="text/html;charset=UTF-8" %>

<jsp:include page="/WEB-INF/view/header.jsp" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout_payment.css">

<!-- CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout_payment.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout-sidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<div class="checkout-page">

    <!-- CỘT TRÁI – FORM GIAO HÀNG -->
    <div class="checkout-container">
        <div class="checkout-title">Thông tin giao hàng</div>

        <form action="${pageContext.request.contextPath}/checkout" method="post" class="form-block">
            <label>Họ tên</label>
            <input type="text" name="name" required />

            <label>Số điện thoại</label>
            <input type="text" name="phone" required />

            <label>Địa chỉ giao hàng</label>
            <input type="text" name="address" required />

            <button class="btn-checkout" type="submit">
                Tiếp tục đến phương thức thanh toán
            </button>
        </form>
    </div>

    <!-- CỘT PHẢI – SIDEBAR -->
    <jsp:include page="/WEB-INF/view/component/sidebar-checkout.jsp" />

</div>

<jsp:include page="/WEB-INF/view/footer.jsp" />

