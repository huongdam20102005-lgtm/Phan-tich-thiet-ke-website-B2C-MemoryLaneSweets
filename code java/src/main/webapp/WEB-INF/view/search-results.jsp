<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Kết quả Tìm kiếm: ${keyword}</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <%-- Xóa các CSS không cần thiết nếu đã có trong style.css --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

</head>
<body>

    <jsp:include page="header.jsp" />

    <%-- ✅ Đổi class chính thành "container category-page" và dùng thẻ <main> --%>
    <main class="container category-page"> 

        <div class="search-summary">
            <h1>KẾT QUẢ TÌM KIẾM</h1>

            <%-- Lấy biến từ requestScope --%>
            <c:set var="keyword" value="${requestScope.keyword}" />
            <c:set var="results" value="${requestScope.searchResults}" />

            <p class="search-info">Tìm kiếm cho: <strong><c:out value="${keyword}" /></strong></p>
            <hr>
        </div>

        <c:choose>
            <c:when test="${empty results}">
                <div class="no-results-message">
                    <i class="fa-solid fa-face-frown" style="font-size: 40px; color: #ff6f61;"></i>
                    <p style="font-size: 1.2em; margin-top: 15px;">
                        Không tìm thấy mẫu bánh nào phù hợp với từ khóa "<strong><c:out value="${keyword}" /></strong>". Vui lòng thử từ khóa khác.
                    </p>
                </div>
            </c:when>
            <c:otherwise>
                <p class="result-count">Tìm thấy <c:out value="${fn:length(results)}" /> sản phẩm:</p>

                <%-- ✅ Đổi class lưới sản phẩm thành "category-product-grid" để CSS responsive áp dụng --%>
                <div class="category-product-grid"> 
                    <c:forEach var="cake" items="${results}">
                        <%-- ✅ Đổi class thẻ sản phẩm thành "product-card" --%>
                        <div class="product-card"> 

                            <a href="${pageContext.request.contextPath}/product-detail?id=${cake.cakeID}" title="${cake.cakeName}">
                                <%-- ✅ Đổi class ảnh thành "product-img" --%>
                                <img src="${pageContext.request.contextPath}/images/${cake.imageURL}"
                                          alt="${cake.cakeName}"
                                          class="product-img"> 
                                <h4 class="product-name">
                                    <c:out value="${cake.cakeName}" />
                                </h4>
                            </a>

                            <fmt:formatNumber value="${cake.price}" type="number" var="formattedPrice" groupingUsed="true" />
                            <p class="product-price">${formattedPrice}đ</p>
                            
                            <form action="${pageContext.request.contextPath}/cart" method="post" class="add-to-cart-form">
                                <input type="hidden" name="action" value="add" />
                                <input type="hidden" name="productID" value="${cake.cakeID}" />
                                <input type="hidden" name="quantity" value="1" />
                                <%-- ✅ Dùng class chuẩn btn-add-cart --%>
                                <button type="submit" class="btn-add-cart">
                                    <i class="fa-solid fa-cart-shopping"></i> THÊM VÀO GIỎ
                                </button>
                            </form>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </main>

    <jsp:include page="footer.jsp" />

</body>
</html>