<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 
     Lưu ý: Header này giả định bạn đã có các lớp CSS và font awesome 
     (fa-solid) để hiển thị biểu tượng đúng.
--%>
<style>

    .main-menu .dropdown {
        position: relative;
    }

    .main-menu .dropdown-menu {
        list-style: none;
        margin: 0;
        padding: 0;

        display: none;
        position: absolute;

        background: #ffffff;
        border: 1px solid #e6e2da;
        border-radius: 8px;

        min-width: 260px;
        z-index: 9999;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);

        transform: translateY(6px);
    }

    .main-menu .dropdown:hover > .dropdown-menu {
        display: block;
    }

    .main-menu .dropdown-menu li {
        list-style: none;
        padding: 0;
    }

    .main-menu .dropdown-menu li a {
        display: block;
        padding: 14px 24px;

        font-size: 15px;
        font-weight: 700;

        color: #8a5a3b;            /* đồng bộ màu */
        text-decoration: none;
        letter-spacing: 0.4px;

        white-space: nowrap;       /* QUAN TRỌNG: không xuống dòng */
        text-overflow: ellipsis;
        overflow: hidden;

        transition: 0.25s;
    }

    .main-menu .dropdown-menu li a:hover {
        background: #f1e5cf;
        color: #c17d44;
    }


    /* ==============================
       HEADER UI
       ============================== */

    .header-area {
        background-image: url('${pageContext.request.contextPath}/images/header-bg.jpg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;

        background-color: #f8f8f8;
        border-bottom: 1px solid #eee;
        padding: 10px 0;
    }

    .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .main-menu {
        list-style: none;
        display: flex;
        gap: 25px;
        align-items: center;
        margin: 0;
        padding: 0;
    }

    .main-menu a {
        text-decoration: none;
        color: #222;
        font-weight: bold;
    }


    /* ==============================
       SEARCH FIELD
       ============================== */

        .header-area {
        /* Dùng biến JSP ở đây */
        background-image: url('${pageContext.request.contextPath}/images/header-bg.jpg'); 
        background-size: cover;          
        background-position: center center; 
        background-repeat: no-repeat;    
        
        /* Giữ nguyên các thuộc tính định kiểu khác từ style.css (hoặc copy vào đây) */
        background-color: #f8f8f8; 
        border-bottom: 1px solid #eee;
        padding: 10px 0;
    }
    
    /* CSS cơ bản cho form tìm kiếm để giữ nguyên bố cục */
    .search-form-inline {
        display: inline-flex; /* Giúp input và button nằm trên cùng một hàng */
        align-items: center;
        margin-right: 15px; /* Tạo khoảng cách với giỏ hàng */
    }
    
    .search-form-inline input[type="text"] {
        padding: 5px 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        margin-right: 5px;
        width: 150px; /* Điều chỉnh chiều rộng input */
        transition: width 0.3s ease;
    }
    
    .search-form-inline button[type="submit"] {
        background: none;
        border: none;
        padding: 0;
        cursor: pointer;
        color: inherit; /* Kế thừa màu chữ */
    }
    
    .cart-count {
        background-color: #a0522d;
        color: white;
        border-radius: 50%;
        padding: 2px 6px;
        font-size: 12px;
        position: relative;
        top: -10px;
        left: -5px;
        font-weight: bold;
        line-height: 1;
    }

</style>
<header class="header-area">
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;500;600;700&display=swap" rel="stylesheet">

    <div class="container">
        <nav class="navbar">
            
            <%-- ✅ 1. HTML: Thêm nút menu hamburger --%>
            <button class="mobile-menu-toggle" onclick="toggleMobileMenu()">
                <i class="fa-solid fa-bars"></i>
            </button>
            
            <div class="logo">
                <a href="${pageContext.request.contextPath}/home" style="color: #6F4E37;">Memory Lane Sweets</a>
            </div>

            <ul class="main-menu">
                <li><a href="${pageContext.request.contextPath}/home">TRANG CHỦ</a></li>
                <!-- DROPDOWN -->
                <li class="dropdown">
                    <a href="${pageContext.request.contextPath}/menu" class="dropdown-toggle">
                        SẢN PHẨM 
                    </a>
                    
                </li>
            </ul>
            <div class="navbar-icons">
                
                <form action="${pageContext.request.contextPath}/search" method="GET" class="search-form-inline">
                    <input type="text" name="keyword" placeholder="Tìm kiếm bánh..." required>
                    
                    <button type="submit" title="Tìm kiếm">
                           <i class="fa-solid fa-search"></i>
                    </button>
                </form>
                <a href="${pageContext.request.contextPath}/cart" class="giohang" title="Giỏ Hàng">
                    <i class="fa-solid fa-shopping-cart"></i>
                    <c:if test="${not empty sessionScope.cart}">
                        <span class="cart-count">${sessionScope.cart.totalQuantity}</span>
                    </c:if>
                </a> 
                
                <c:choose>
                    <c:when test="${not empty sessionScope.loggedInUser}">
                        <%-- TRẠNG THÁI 1: ĐÃ ĐĂNG NHẬP --%>
                        <a href="${pageContext.request.contextPath}/profile" title="Tài khoản cá nhân" style="margin-left: 10px;">
                            <i class="fa-solid fa-user"></i>
                        </a> 
                        <a href="${pageContext.request.contextPath}/logout" title="Đăng xuất" style="margin-left: 5px;">
                            <i class="fa-solid fa-right-from-bracket"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <%-- TRẠNG THÁI 2: CHƯA ĐĂNG NHẬP --%>
                        <a href="${pageContext.request.contextPath}/login.jsp" title="Đăng nhập / Đăng ký" style="margin-left: 10px;">
                            <i class="fa-solid fa-user"></i>
                        </a>
                    </c:otherwise>
                </c:choose>
                </div>
        </nav>
        
        <%-- ✅ 2. HTML: Tạo menu ẩn cho mobile --%>
        <div class="mobile-menu" id="mobileMenu">
            <ul>
                <li><a href="${pageContext.request.contextPath}/home">TRANG CHỦ</a></li>
                <li><a href="${pageContext.request.contextPath}/category?id=1">Bánh Ngọt</a></li>
                <li><a href="${pageContext.request.contextPath}/category?id=2">Bánh Sinh Nhật</a></li>
                <li><a href="${pageContext.request.contextPath}/category?id=3">Bánh Mặn</a></li>
                <li><a href="${pageContext.request.contextPath}/category?id=4">Cookie & Minicakes</a></li>
            </ul>
        </div>
        
    </div>
</header>

<%-- ✅ 4. JavaScript: Xử lý hiển thị menu (Đặt ở cuối header để đảm bảo menu đã load) --%>
<script>
function toggleMobileMenu() {
    const menu = document.getElementById("mobileMenu");
    menu.style.display = (menu.style.display === "block") ? "none" : "block";
}
</script>