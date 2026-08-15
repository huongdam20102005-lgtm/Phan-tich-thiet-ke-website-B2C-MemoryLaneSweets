<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${categoryName} - Một chút ngọt ngào </title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
              crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>

<jsp:include page="header.jsp" />

<%-- Sửa class chính thành 'container' để áp dụng CSS responsive chuẩn --%>
<main class="container category-page">
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/home">TRANG CHỦ</a> /
        <span>${categoryName}</span>
    </div>

    <h1>${categoryName}</h1>

    <div class="category-content-wrapper">

        <aside class="filter-sidebar">
            <h3>GIÁ SẢN PHẨM</h3>
            <form action="${pageContext.request.contextPath}/category" method="GET">
                <input type="hidden" name="id" value="${categoryId}" />

                <div class="filter-group">
                    <label><input type="radio" name="priceFilter" value=""
                        ${empty param.priceFilter ? 'checked' : ""}/> Tất cả giá</label>
                </div>
                <div class="filter-group">
                    <label><input type="radio" name="priceFilter" value="0-100000"
                        ${param.priceFilter == '0-100000' ? 'checked' : ""}/> Dưới 100.000đ</label>
                </div>
                <div class="filter-group">
                    <label><input type="radio" name="priceFilter" value="100000-200000"
                        ${param.priceFilter == '100000-200000' ? 'checked' : ""}/> 100.000đ - 200.000đ</label>
                </div>
                <div class="filter-group">
                    <label><input type="radio" name="priceFilter" value="200000-300000"
                        ${param.priceFilter == '200000-300000' ? 'checked' : ""}/> 200.000đ - 300.000đ</label>
                </div>
                <div class="filter-group">
                    <label><input type="radio" name="priceFilter" value="300000-max"
                        ${param.priceFilter == '300000-max' ? 'checked' : ""}/> Trên 300.000đ</label>
                </div>

                <%-- ✅ Xóa class 'btn' nếu nó không cần thiết, hoặc giữ nguyên nếu cần style riêng --%>
                <button type="submit" class="filter-apply-btn">Lọc</button> 
            </form>
        </aside>

        <section class="product-listing">
            <div class="category-product-grid">
                <c:choose>
                    <c:when test="${not empty cakeList}">
                        <c:forEach var="cake" items="${cakeList}">
                            <div class="product-card">
                                <%-- Sửa đường dẫn chi tiết sản phẩm --%>
                                <a href="${pageContext.request.contextPath}/product-detail?id=${cake.cakeID}" title="${cake.cakeName}">
                                    <img src="${pageContext.request.contextPath}/images/${cake.imageURL}" alt="${cake.cakeName}" class="product-img" />
                                    <h4 class="product-name">${cake.cakeName}</h4>
                                </a>
                                <fmt:formatNumber value="${cake.price}" type="number" var="formattedPrice" groupingUsed="true" />
                                <p class="product-price">${formattedPrice}đ</p>
                                
                                <%-- ✅ Chuyển nút thêm vào giỏ thành Form (Đảm bảo logic giỏ hàng nhất quán) --%>
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
                    </c:when>
                    <c:otherwise>
                        <p style="grid-column: 1 / -1; text-align: center; margin-top: 50px; font-style: italic;">
                            Không tìm thấy sản phẩm nào trong danh mục này hoặc với tiêu chí lọc đã chọn.
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </div>
</main>

<jsp:include page="footer.jsp" />

</body>
</html>