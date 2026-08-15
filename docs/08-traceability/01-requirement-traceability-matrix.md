# MA TRẬN TRUY VẾT YÊU CẦU (REQUIREMENT TRACEABILITY MATRIX - RTM)

> **Mã tài liệu**: `DOC-TRC-01`  
> **Dự án**: Website Bán Bánh Ngọt B2C (Memory Lane Sweets)  

Ma trận RTM dưới đây thiết lập chuỗi truy vết xuyên suốt hai chiều từ **Mục tiêu Nghiệp vụ (BR) $\rightarrow$ Nhu cầu Người dùng (UR) $\rightarrow$ Yêu cầu Chức năng (FR) $\rightarrow$ User Story / Use Case $\rightarrow$ Quy tắc Nghiệp vụ (BR-Rule) $\rightarrow$ Tính năng (Feature) $\rightarrow$ Giao diện (UI) $\rightarrow$ Điểm cuối Backend (API/Servlet) $\rightarrow$ Tệp Mã nguồn (Code) $\rightarrow$ Trạng thái Triển khai (Status)**.

---

## 1. BẢNG MA TRẬN TRUY VẾT YÊU CẦU ĐẦY ĐỦ (FULL RTM TABLE)

| Mã BR | Mã UR | Mã FR | User Story / Use Case | Quy tắc Nghiệp vụ | Mã Feature | Giao diện UI (JSP) | API / Endpoint Servlet | Tệp Mã nguồn Triển khai | Trạng thái Triển khai |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **BR-001** | UR-001 | FR-001 | `US-01` (Trang chủ & Bánh nổi bật) | `BR-CAT-01` | F001 | `trangchu.jsp` | `GET /home`, `GET /` | `HomeServlet.java`, `CakeDAO.java` | **Complete** |
| **BR-001** | UR-001 | FR-002 | `US-01` (Menu & Danh mục) | `BR-CAT-01`, `BR-PRC-01` | F002, F003 | `menu-page.jsp`, `product-category.jsp` | `GET /menu`, `GET /category` | `MenuServlet.java`, `CategoryServlet.java`, `CakeDAO.java` | **Complete** |
| **BR-001** | UR-002 | FR-003 | `US-04` (Tìm kiếm theo Tên) | `BR-VAL-01` | F005 | `header.jsp`, `search-results.jsp` | `GET /search` | `SearchServlet.java`, `CakeDAO.java` | **Complete** |
| **BR-001** | UR-003 | FR-004 | `US-01` (Chi tiết Sản phẩm) | `BR-VAL-02` | F004 | `product-detail.jsp` | `GET /product-detail` | `ProductDetailServlet.java`, `CakeDAO.java` | **Complete** |
| **BR-002** | UR-004 | FR-005 | `US-02` (Thêm vào Giỏ hàng) | `BR-STK-01`, `BR-CRT-01` | F006 | `cart.jsp`, `product-detail.jsp` | `POST /cart` | `CartServlet.java`, `Cart.java`, `CakeDAO.java` | **Complete** |
| **BR-002** | UR-004 | FR-006 | `US-02` (Cập nhật & Xóa Giỏ) | `BR-STK-01`, `BR-CRT-01` | F006 | `cart.jsp` | `POST /cart`, `GET /cart?action=remove` | `CartServlet.java`, `Cart.java` | **Complete** |
| **BR-003** | UR-005 | FR-007 | `US-03` (Tính Tổng tiền & Ship) | `BR-CRT-02`, `BR-SHP-01` | F006, F007 | `cart.jsp`, `sidebar-checkout.jsp` | `GET /cart`, `GET /checkout` | `Cart.java`, `CartItem.java` | **Complete** |
| **BR-003** | UR-005 | FR-008 | `US-03` (Thông tin Giao hàng) | `BR-ORD-01` | F007 | `checkout.jsp` | `POST /checkout` | `CheckoutServlet.java` | **Complete** |
| **BR-003** | UR-005 | FR-009 | `US-03` (Thanh toán COD & Lưu đơn) | `BR-PAY-01`, `BR-ORD-02`, `BR-ORD-03` | F008 | `payment.jsp`, `order-success.jsp` | `POST /payment`, `GET /order-success` | `PaymentServlet.java`, `OrderDAO.java`, `OrderSuccessServlet.java` | **Complete** |
| **BR-002** | UR-005 | FR-010 | `US-03` (Tự động Trừ Tồn kho) | `BR-STK-02` | F008 | `order-success.jsp` | `POST /payment` | `PaymentServlet.java`, `CakeDAO.java` | **Complete** |
| **BR-001** | `Gap` | FR-016 | `Gap` (Đăng ký Bản tin) | `Gap` | F013 | `trangchu.jsp`, `product-detail.jsp` | `POST /NewsletterServlet` | `Gap` *(Chưa có Servlet xử lý)* | **Gap** |
| **BR-001** | UR-006 | FR-011 | `Gap` (Đăng ký / Đăng nhập) | `BR-USR-01` | F009 | `header.jsp` *(link)*, *login.jsp* | `Gap` *(Thiếu /login, /logout)* | `User.java`, `sql.sql` *(Thiếu Controller & View)* | **Gap** |
| **BR-001** | UR-006 | FR-012 | `Gap` (Quản lý Hồ sơ) | `Gap` | F009 | `header.jsp` *(link)*, *profile.jsp* | `Gap` *(Thiếu /profile)* | `Gap` *(Thiếu Controller & View)* | **Gap** |
| **BR-004** | UR-007 | FR-013 | `US-05` (Admin Quản trị Bánh) | `Gap` | F010 | *Admin Product views (missing)* | `Gap` *(Thiếu AdminProductServlet)* | `sql.sql` *(Thiếu Controller & View)* | **Gap** |
| **BR-004** | UR-007 | FR-014 | `Gap` (Admin Quản trị Đơn hàng) | `Gap` | F011 | *Admin Order views (missing)* | `Gap` *(Thiếu AdminOrderServlet)* | `sql.sql` *(Thiếu Controller & View)* | **Gap** |
| **BR-005** | `Gap` | FR-015 | `Gap` (Đánh giá & Bình luận) | `BR-REV-01` | F012 | *Review Component (missing)* | `Gap` *(Thiếu ReviewServlet)* | `sql.sql` *(Bảng Reviews)* | **Gap** |

---

## 2. ĐÁNH GIÁ SỨC KHỎE TRUY VẾT HỆ THỐNG (TRACEABILITY HEALTH CHECK)

* **Tổng số Yêu cầu Chức năng (FRs)**: 16
* **Số yêu cầu truy vết hoàn chỉnh (Complete Traceability)**: 10 / 16 (**62.5%**)
  * *Bao phủ toàn bộ luồng mua sắm khách hàng*: Từ Xem trang chủ $\rightarrow$ Lọc danh mục $\rightarrow$ Tìm kiếm $\rightarrow$ Xem chi tiết $\rightarrow$ Giỏ hàng $\rightarrow$ Checkout $\rightarrow$ Thanh toán COD $\rightarrow$ Tự động trừ kho.
* **Số yêu cầu ghi nhận Khoảng trống (Traceability Gaps)**: 6 / 16 (**37.5%**)
  * *Các phân hệ chưa hoàn tất mã nguồn*: Xác thực tài khoản khách hàng (`FR-011`, `FR-012`), Quản trị Admin (`FR-013`, `FR-014`), Đánh giá sản phẩm (`FR-015`), Xử lý bản tin (`FR-016`).
