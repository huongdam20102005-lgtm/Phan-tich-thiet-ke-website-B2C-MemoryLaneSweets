<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<%-- 6. FOOTER (Chân trang) --%>
<footer class="footer-area">
    <div class="container">
        <div class="row">
            <%-- Cột 1: Thông tin liên hệ --%>
            <div class="footer-info">
                <h3>Memory Lane Sweets's Bakery</h3>
                <p><i class="fa-solid fa-location-dot"></i> cứ đi là đến quán - Hà Nội </p>
                <p><i class="fa-solid fa-phone"></i> 999999999</p>
                <p><i class="fa-solid fa-envelope"></i> memorylanesweets8386@gmail.com</p>
            </div>

            <%-- Cột 2: Danh mục liên kết --%>
            <div class="footer-links">
                <h4>DANH MỤC</h4>
                <ul>
                    <li><a href="#">Danh mục Sản phẩm</a></li>
                    <li><a href="#">Giới thiệu</a></li>
                    <li><a href="#">Ưu đãi</a></li>
                    <li><a href="#">Blog</a></li>
                    <li><a href="#">Liên hệ</a></li>
                </ul>
            </div>

            <%-- Cột 3: Mạng xã hội --%>
            <div class="social-media">
                <h4>MẠNG XÃ HỘI</h4>
                <a href="https://workspace.google.com/intl/vi/gmail/"><img src="${pageContext.request.contextPath}/images/icon_gmail.png" alt="Icon Gmail"></a>
                <a href="https://zalo.me/pc"><img src="${pageContext.request.contextPath}/images/icon_zalo.png" alt="Icon Zalo"></a>
                <a href="https://www.facebook.com/"><img src="${pageContext.request.contextPath}/images/icon_facebook.png" alt="Icon Facebook"></a>
            </div>
        </div>
    </div>
</footer>