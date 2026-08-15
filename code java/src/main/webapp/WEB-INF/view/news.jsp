<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp" /> 

<div class="container blog-page">
    <h2>TRANG CHỦ / TIN TỨC & KHUYẾN MÃI</h2>
    
    <div class="row">
        <%-- PHẦN CHÍNH: DANH SÁCH BÀI VIẾT (Tương tự image_039a58.jpg) --%>
        <div class="col-main">
            <h3>Bài viết mới nhất</h3>
            
            <c:forEach var="article" items="${requestScope.articleList}">
                <div class="article-item">
                    <img src="${pageContext.request.contextPath}/images/blog/${article.imageURL}" alt="${article.title}">
                    <div class="article-content">
                        <h4><a href="article?id=${article.articleID}">${article.title}</a></h4>
                        <p class="article-meta">
                            Viết bởi: ${article.author} / 
                            <fmt:formatDate value="${article.publishedDate}" pattern="dd/MM/yyyy" />
                        </p>
                        <p class="article-summary">
                            ${article.content}
                            <a href="article?id=${article.articleID}">[...xem thêm]</a>
                        </p>
                    </div>
                </div>
            </c:forEach>
            
            <%-- PHÂN TRANG --%>
            <div class="pagination-section">
                <c:forEach begin="1" end="${totalPages}" var="page">
                    <a href="news?page=${page}" class="${page == currentPage ? 'active' : ''}">${page}</a>
                </c:forEach>
            </div>
        </div>
        
        <%-- THANH BÊN (SIDEBAR) --%>
        <div class="col-sidebar">
            <div class="sidebar-box">
                <h4>Danh mục Blog</h4>
                <ul>
                    <li><a href="#">Bánh ngọt và Bánh mỳ</a></li>
                    <li><a href="#">Tin tức & Khuyến mại</a></li>
                    <li><a href="#">Liên hệ</a></li>
                    <li><a href="#">Tuyển dụng</a></li>
                </ul>
            </div>
            <%-- Có thể thêm các Sidebar Box khác như Quảng cáo, Bài viết nổi bật... --%>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />