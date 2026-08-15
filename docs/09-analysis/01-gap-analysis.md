# PHÂN TÍCH KHOẢNG TRỐNG TÀI LIỆU & TRIỂN KHAI (DOCUMENTATION GAP ANALYSIS)

> **Mã tài liệu**: `DOC-ANA-01`  
> **Dự án**: Website Bán Bánh Ngọt B2C (Memory Lane Sweets)  

Tài liệu này đối chiếu toàn diện giữa **Tài liệu phân tích thiết kế ban đầu** và **Mã nguồn triển khai thực tế**, phân loại thành 4 nhóm chênh lệch chuyên sâu theo chuẩn thực hành của Senior Business Analyst.

---

## 1. NHÓM A: DOCUMENTED + IMPLEMENTED (ĐÃ CÓ TÀI LIỆU & ĐÃ CÀI ĐẶT MÃ NGUỒN)

Các hạng mục nghiệp vụ đã hoàn thành đồng bộ xuyên suốt từ tài liệu đến mã nguồn:
1. **Hiển thị Trang chủ & Bánh nổi bật**: Mô tả trong Mục 4.1.1 Báo cáo $\rightarrow$ Đã cài đặt hoàn chỉnh tại `HomeServlet.java`, `trangchu.jsp`.
2. **Duyệt Danh mục 4 phân nhóm chính**: Mô tả trong Mục 4.1.1 Báo cáo $\rightarrow$ Đã cài đặt tại `MenuServlet.java`, `CategoryServlet.java`, `product-category.jsp`.
3. **Xem Chi tiết Sản phẩm & Bánh liên quan**: Mô tả trong Mục 4.1.2 Báo cáo $\rightarrow$ Đã cài đặt tại `ProductDetailServlet.java`, `product-detail.jsp`.
4. **Tìm kiếm Bánh theo Từ khóa**: Mô tả trong Mục 4.1.3 Báo cáo $\rightarrow$ Đã cài đặt tại `SearchServlet.java`, `search-results.jsp`.
5. **Quản lý Giỏ hàng & Kiểm soát Vượt tồn kho**: Mô tả trong Mục 4.1.4 Báo cáo $\rightarrow$ Đã cài đặt tại `CartServlet.java`, `Cart.java`, `CartItem.java`, `cart.jsp`.
6. **Đặt hàng & Lưu Hóa đơn COD**: Mô tả trong Mục 4.1.5 Báo cáo $\rightarrow$ Đã cài đặt tại `CheckoutServlet.java`, `PaymentServlet.java`, `OrderDAO.java`.
7. **Tự động Khấu trừ Tồn kho khi Đặt hàng**: Mô tả trong Quy trình Mục 3.2.3(5) Báo cáo $\rightarrow$ Đã cài đặt tại `PaymentServlet.java`, `CakeDAO.java` (`updateCakeQuantity`).
8. **Cơ sở dữ liệu quan hệ chuẩn hóa**: Mô tả trong Chương 3 Báo cáo $\rightarrow$ Đã cài đặt trong file script `sql.sql`.

---

## 2. NHÓM B: DOCUMENTED BUT NOT IMPLEMENTED (CÓ TRONG TÀI LIỆU NHƯNG CHƯA CÀI ĐẶT TRONG CODE)

Các hạng mục đã được phân tích, vẽ biểu đồ Use Case / Activity Diagram nhưng chưa tìm thấy mã nguồn thực thi:
1. **Toàn bộ Phân hệ Quản trị Admin (Admin Module)**:
   * *Tài liệu*: Mô tả biểu đồ Use Case Admin (Hình 3.1, 3.3, 3.4, 3.5, 3.6), 10 sơ đồ Activity Diagram quản trị (Mục 3.2.2) và 11 kịch bản kiểm thử Admin trong `test case.xlsx`.
   * *Mã nguồn*: Hoàn toàn không có Controller Admin (như `AdminProductServlet`, `AdminOrderServlet`), không có thư mục View Admin (JSP) để thực hiện CRUD sản phẩm hoặc chuyển trạng thái đơn hàng.
2. **Phân hệ Đăng ký / Đăng nhập / Quản lý Hồ sơ Khách hàng**:
   * *Tài liệu*: Mô tả Use Case Đăng ký, Đăng nhập, Quản lý hồ sơ cá nhân (Mục 3.1.1, Sơ đồ Hình 3.2, 3.8, 3.13) và Test Case 1, 2, 3 trong `test case.xlsx`.
   * *Mã nguồn*: `header.jsp` có gắn link `${pageContext.request.contextPath}/login.jsp`, `/profile`, `/logout` nhưng không tồn tại file `login.jsp`, không có `LoginServlet` hay `ProfileServlet`.
3. **Chức năng Đánh giá & Bình luận (Reviews & Ratings)**:
   * *Tài liệu*: Mô tả Sơ đồ hoạt động Bình luận và Đánh giá (Mục 3.2.2.7), thiết kế bảng `Reviews` (Mục 3.3.2.1).
   * *Mã nguồn*: Bảng `Reviews` có trong `sql.sql`, nhưng không có `ReviewDAO`, không có `ReviewServlet`, và `product-detail.jsp` không có form gửi review.
4. **Bảng Đơn vị Vận chuyển (`Shippers`)**:
   * *Tài liệu*: Mô tả bảng `Shippers` tại Mục 3.3.2.1 và quan hệ `Orders - Shippers` tại Mục 3.3.2.2.
   * *Mã nguồn*: Bảng `Shippers` không được tạo trong `sql.sql` và không có Model/DAO tương ứng.
5. **Chức năng Xuất Báo cáo (Export Reports)**:
   * *Tài liệu*: Vẽ sơ đồ Activity Diagram "Xuất báo cáo đơn hàng" (Hình 3.10) và "Xuất danh sách tài khoản" (Hình 3.17).
   * *Mã nguồn*: Không có logic xuất file Excel/PDF trong mã nguồn.

---

## 3. NHÓM C: IMPLEMENTED BUT NOT DOCUMENTED (CÓ TRONG CODE NHƯNG TÀI LIỆU CHƯA MÔ TẢ)

Các quy tắc và chi tiết kỹ thuật đang chạy thực tế nhưng tài liệu báo cáo chưa đề cập:
1. **Phí vận chuyển cố định 20.000 VNĐ (`BR-SHP-01`)**: Trong code `sidebar-checkout.jsp` và `payment.jsp` tự động cộng thêm `20.000 VNĐ` vào tổng đơn hàng, tài liệu báo cáo không nhắc tới phí ship này.
2. **Cơ chế Khách vãng lai đặt hàng (Guest Checkout `BR-ORD-03`)**: Code `PaymentServlet` và `OrderDAO` cho phép người dùng không đăng nhập đặt hàng bình thường bằng cách gán `userID = 0` và chèn `NULL` vào `Orders.userID`. Tài liệu chỉ mô tả luồng khách hàng đã đăng nhập.
3. **Các ngưỡng phân khúc giá trong bộ lọc (`BR-PRC-01`)**: `CategoryServlet.java` và `product-category.jsp` ấn định 4 khoảng giá (Dưới 100k, 100k-200k, 200k-300k, trên 300k), tài liệu chỉ nêu chung chung là "Lọc theo giá".
4. **Mẫu Form Đăng ký Bản tin (`NewsletterServlet`)**: Tại `trangchu.jsp` và `product-detail.jsp` có form gửi email khuyến mãi tới `NewsletterServlet`, tài liệu không có Use Case này.
5. **Cấu hình kết nối DB tĩnh**: `DBUtils.java` hardcode tài khoản `sa` / `20102005` tại cổng 1433 với cờ `trustServerCertificate=true`.

---

## 4. NHÓM D: CONTRADICTIONS (MÂU THUẪN GIỮA TÀI LIỆU VÀ MÃ NGUỒN)

1. **Ràng buộc `NOT NULL` của CSDL vs Logic Code Guest Checkout**:
   * *Tài liệu & `sql.sql`*: Cột `Orders.userID` được định nghĩa là `INT NOT NULL FOREIGN KEY REFERENCES Users(userID)`.
   * *Trong Code (`OrderDAO.java` dòng 1120-1124)*: Khách vãng lai mua hàng (`userID == 0`), code thực thi `ps.setNull(1, java.sql.Types.INTEGER)`.
   * *Rủi ro*: Nếu CSDL chạy đúng DDL ban đầu, câu lệnh INSERT sẽ bị **Database ném lỗi ngoại lệ (Cannot insert the value NULL into column 'userID')**.
2. **Hệ quản trị CSDL sử dụng**:
   * *Tài liệu*: Mục 1.2(3) và 3.4.3.1 ghi "sử dụng MySQL/SQL Server".
   * *Thực tế Code*: Toàn bộ project sử dụng 100% cú pháp và Driver của **Microsoft SQL Server** (`com.microsoft.sqlserver.jdbc.SQLServerDriver`, hàm `GETDATE()`, từ khóa `TOP 6`, `IDENTITY(1,1)`, `NVARCHAR`). Không có driver MySQL.
3. **Phân quyền và Kiểm soát truy cập**:
   * *Tài liệu*: Báo cáo khẳng định hệ thống có phân quyền người dùng (`admin`, `user`) tại Mục 3.2.3(8).
   * *Thực tế Code*: Không có `Filter` bảo mật, không có kiểm tra quyền trong bất kỳ Servlet nào.

---

## 5. ĐÁNH GIÁ TÀI LIỆU BA CÒN THIẾU (MISSING BA ARTIFACTS INVENTORY)

| STT | Tài liệu BA | Trạng thái hiện tại | Đánh giá mức độ cần thiết | Hành động khắc phục |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **Detailed Use Case Specifications** | Thiếu bảng đặc tả chi tiết | `Rất cần thiết` | Đã biên soạn tại `docs/02-requirements/04-user-stories-and-use-cases.md`. |
| 2 | **Business Rules Catalog (BRC)** | Quy tắc nằm rải rác | `Rất cần thiết` | Đã tập hợp và chuẩn hóa tại `docs/01-business/03-business-rules.md`. |
| 3 | **Requirement Traceability Matrix (RTM)**| Chưa từng có trong dự án | `Tối quan trọng` | Đã xây dựng hoàn chỉnh tại `docs/08-traceability/01-requirement-traceability-matrix.md`. |
| 4 | **Business Data Dictionary** | Mới có bảng kiểu dữ liệu | `Rất cần thiết` | Đã nâng cấp toàn diện tại `docs/05-data/01-business-data-dictionary.md`. |
