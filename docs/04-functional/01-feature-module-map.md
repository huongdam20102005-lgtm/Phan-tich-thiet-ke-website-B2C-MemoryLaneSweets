# BẢN ĐỒ TÍNH NĂNG & PHÂN HỆ HỆ THỐNG (FEATURE & MODULE MAP)

> **Mã tài liệu**: `DOC-FUN-01`  
> **Dự án**: Website Bán Bánh Ngọt B2C (Memory Lane Sweets)  

Tài liệu này xác lập cấu trúc liên kết toàn diện: **Mục tiêu Kinh doanh (Business) $\rightarrow$ Yêu cầu (Requirement) $\rightarrow$ Tính năng (Feature) $\rightarrow$ Giao diện (UI) $\rightarrow$ Xử lý Backend (Servlet API) $\rightarrow$ Trạng thái Triển khai (Status)**.

---

## BẢNG ÁNH XẠ TÍNH NĂNG CHI TIẾT (FEATURE MAP F001 - F013)

| Mã Feature | Tên Tính năng (Feature Name) | Mục đích Nghiệp vụ (Business Purpose) | Tác nhân (Actor) | Yêu cầu liên kết | Quy trình liên quan | Giao diện View (JSP) | Điểm cuối Backend (Servlet / API) | Trạng thái Triển khai |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **F001** | **Trang chủ & Bánh nổi bật** | Quảng bá các mẫu bánh mới ra mắt và bánh bán chạy nhất của cửa hàng nhằm kích thích nhu cầu mua | Khách hàng | BR-001, UR-001, FR-001 | `BP-01` | `trangchu.jsp` | `HomeServlet` (`/home`, `""`) | **Implemented** |
| **F002** | **Menu Danh mục Tổng hợp** | Phân luồng điều hướng khách hàng truy cập vào 4 danh mục bánh chính một cách khoa học | Khách hàng | BR-001, UR-001, FR-002 | `BP-01` | `menu-page.jsp` | `MenuServlet` (`/menu`) | **Implemented** |
| **F003** | **Duyệt Danh mục & Lọc theo Giá** | Cho phép xem bánh theo nhóm và lọc theo 4 mức ngân sách (0-100k, 100-200k, 200-300k, >300k) | Khách hàng | BR-001, UR-001, FR-002 | `BP-01` | `product-category.jsp` | `CategoryServlet` (`/category`) | **Implemented** |
| **F004** | **Xem Chi tiết Bánh & Gợi ý liên quan** | Cung cấp thông số bánh (ảnh, giá, mô tả, tồn kho) và gợi ý 4 mẫu bánh liên quan cùng nhóm | Khách hàng | BR-001, UR-003, FR-004 | `BP-01` | `product-detail.jsp` | `ProductDetailServlet` (`/product-detail`) | **Implemented** |
| **F005** | **Tìm kiếm Bánh theo Tên** | Hỗ trợ tìm nhanh bánh theo từ khóa chứa trong tên bánh | Khách hàng | BR-001, UR-002, FR-003 | `BP-01` | `search-results.jsp` | `SearchServlet` (`/search`) | **Implemented** |
| **F006** | **Quản lý Giỏ hàng (Cart Management)** | Gom nhiều sản phẩm, tăng giảm số lượng, kiểm tra tồn kho thời gian thực, xóa món | Khách hàng | BR-002, UR-004, FR-005, FR-006 | `BP-02` | `cart.jsp` | `CartServlet` (`/cart`) | **Implemented** |
| **F007** | **Nhập Thông tin Giao hàng (Checkout)** | Thu thập Họ tên, Số điện thoại và Địa chỉ người nhận bánh | Khách hàng | BR-003, UR-005, FR-008 | `BP-03` | `checkout.jsp`, `sidebar-checkout.jsp` | `CheckoutServlet` (`/checkout`) | **Implemented** |
| **F008** | **Chọn Thanh toán COD & Hoàn tất Đơn** | Tính tổng thanh toán kèm 20k ship, lưu đơn hàng, lưu chi tiết và tự động trừ tồn kho | Khách hàng, Hệ thống | BR-002, BR-003, FR-009, FR-010 | `BP-03` | `payment.jsp`, `order-success.jsp` | `PaymentServlet` (`/payment`), `OrderSuccessServlet` | **Implemented** |
| **F009** | **Xác thực Tài khoản & Quản lý Hồ sơ** | Đăng ký, đăng nhập, đổi mật khẩu, quản lý địa chỉ cá nhân và xem lịch sử đơn hàng | Khách thành viên | UR-006, FR-011, FR-012 | `BP-07` | `header.jsp` *(links)*, *login.jsp (missing)* | *LoginServlet / ProfileServlet (missing)* | **Not Implemented** *(Gap)* |
| **F010** | **Quản trị Sản phẩm & Danh mục (Admin)** | Thêm, sửa, xóa bánh, cập nhật giá và tồn kho | Quản trị viên | BR-004, UR-007, FR-013 | `BP-04` | *Admin views (missing)* | *AdminProductServlet (missing)* | **Not Implemented** *(Gap)* |
| **F011** | **Quản trị Đơn hàng (Admin)** | Quản lý danh sách đơn hàng, cập nhật trạng thái đơn và in hóa đơn | Quản trị viên | BR-004, UR-007, FR-014 | `BP-05` | *Admin views (missing)* | *AdminOrderServlet (missing)* | **Not Implemented** *(Gap)* |
| **F012** | **Đánh giá & Bình luận Sản phẩm** | Khách hàng chấm sao 1-5 và nhận xét chất lượng bánh | Khách hàng | BR-005, FR-015 | `BP-06` | *Review component (missing)* | *ReviewServlet (missing)* | **Not Implemented** *(Mới có DDL SQL)* |
| **F013** | **Đăng ký Bản tin Khuyến mãi** | Thu thập email khách hàng để gửi thông tin ưu đãi | Khách hàng | FR-016 | `BP-01` | Form tại footer & trangchu | `NewsletterServlet` *(chưa có servlet)* | **Partially Implemented** *(Chỉ có HTML Form)* |

---

## CẤU TRÚC PHÂN RÃ HỆ THỐNG (MODULE BREAKDOWN STRUCTURE)

```
HỆ THỐNG WEBSITE BÁN BÁNH (MEMORY LANE SWEETS)
│
├── MODULE 1: STOREFRONT & CATALOG (Trưng bày & Tìm kiếm)
│   ├── F001: Trang chủ & Bánh nổi bật (Top 6 New, Top 3 Best Sellers)
│   ├── F002: Menu Danh mục chính (4 Nhóm)
│   ├── F003: Danh mục sản phẩm & Bộ lọc giá 4 phân khúc
│   ├── F004: Chi tiết sản phẩm & Gợi ý bánh liên quan (Top 4)
│   └── F005: Tìm kiếm bánh theo từ khóa
│
├── MODULE 2: SHOPPING CART & INVENTORY (Giỏ hàng & Kiểm soát Tồn kho)
│   ├── F006: Quản lý giỏ hàng Session & Kiểm tra vượt tồn kho
│   └── F007: Tính toán thành tiền tự động & Cộng phí ship 20.000 VNĐ
│
├── MODULE 3: ORDERING & FULFILLMENT (Đặt hàng & Xử lý Giao dịch)
│   ├── F008: Nhập thông tin người nhận (Checkout Form)
│   ├── F009: Xác nhận phương thức COD & Ghi nhận bảng Orders / OrderDetails
│   └── F010: Tự động cập nhật giảm số lượng tồn kho bảng Cakes
│
└── MODULE 4: ROADMAP EXTENSIONS (Phân hệ Đã thiết kế - Chờ cài đặt)
    ├── F011: Đăng ký / Đăng nhập / Quản lý Hồ sơ Khách hàng
    ├── F012: Phân hệ Quản trị Admin (CRUD Bánh, Chuyển trạng thái Đơn)
    └── F013: Đánh giá & Bình luận sản phẩm (Reviews 1-5 sao)
```
