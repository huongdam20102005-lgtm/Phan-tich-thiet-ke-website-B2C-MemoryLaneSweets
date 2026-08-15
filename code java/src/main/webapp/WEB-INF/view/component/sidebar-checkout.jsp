<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="checkout-sidebar">

    <h3 class="sidebar-title">Thông tin đơn hàng</h3>

    <c:set var="cart" value="${sessionScope.cart}" />
    <c:set var="cartItems" value="${cart.items}" />

    
    <%-- FIX LỖI QUAN TRỌNG: THÊM <c:choose> VÀO ĐÂY --%>
    <c:choose> 

        <c:when test="${not empty cartItems}">

            <c:forEach var="item" items="${cartItems}">

                <div class="checkout-item">

                    <img src="${pageContext.request.contextPath}/images/${item.value.cake.imageURL}"
                            class="item-image"
                            alt="${item.value.cake.cakeName}">

                    <div class="item-info">
                        <p class="item-name">${item.value.cake.cakeName}</p>
                        <p class="item-qty">Số lượng: ${item.value.quantity}</p>
                    </div>

                    <div class="item-price">
                        <fmt:formatNumber value="${item.value.totalPrice}" pattern="#,##0" /> VNĐ
                    </div>

                </div>

            </c:forEach>

        </c:when>

        <c:otherwise>
            <p>Giỏ hàng của bạn đang trống.</p>
        </c:otherwise>
    
    <%-- FIX LỖI QUAN TRỌNG: THÊM </c:choose> VÀO ĐÂY --%>
    </c:choose> 


    <div class="order-summary">
        <div class="order-row">
            <span>Tạm tính:</span>
            <strong><fmt:formatNumber value="${cart.totalMoney}" pattern="#,##0" /> VNĐ</strong>
        </div>

        <div class="order-row">
            <span>Phí vận chuyển:</span>
            <strong>20.000 VNĐ</strong>
        </div>

        <div class="order-total">
            <span>Tổng cộng:</span>
            <%-- Cần đảm bảo ${cart.totalMoney} là BigDecimal hoặc Long --%>
            <strong><fmt:formatNumber value="${cart.totalMoney + 20000}" pattern="#,##0" /> VNĐ</strong>
        </div>
    </div>
</div>