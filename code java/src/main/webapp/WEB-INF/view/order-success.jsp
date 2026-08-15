<jsp:include page="/WEB-INF/view/header.jsp" />
<%@ page contentType="text/html;charset=UTF-8" %>

<jsp:include page="/WEB-INF/view/header.jsp" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout_payment.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<div class="content-wrap">
    <%-- Thay thế thẻ h2 và p bằng một div có class để dễ điều chỉnh --%>
    <div class="success-message-box">
        <h2 style="text-align:center;">Cảm ơn bạn đã đặt hàng!</h2>
        <p style="text-align:center;">Đơn hàng sẽ được giao sớm nhất có thể.</p>
    </div>
</div>

<jsp:include page="/WEB-INF/view/footer.jsp" />