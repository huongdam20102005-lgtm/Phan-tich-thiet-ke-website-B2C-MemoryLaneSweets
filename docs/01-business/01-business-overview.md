# TỔNG QUAN DỰ ÁN & BỐI CẢNH KINH DOANH (BUSINESS OVERVIEW)

> **Mã tài liệu**: `DOC-BUS-01`  
> **Dự án**: Hệ thống Website Bán Bánh Ngọt Trực Tuyến B2C (**Memory Lane Sweets**)  
> **Tổ chức thực hiện**: Học viện Công nghệ Bưu chính Viễn thông (PTIT) - Bộ môn Lập trình Web (Fintech)  
> **Giảng viên hướng dẫn**: PGS. TS. Đỗ Quang Hưng  
> **Nhóm thực hiện**: Nhóm 06 (Lớp 02)  
> **Thành viên**: Đàm Thị Mai Hương (B23DCTC046 - Nhóm trưởng), Nguyễn Đỗ Sơn Trà (B23DCTC104), Nguyễn Hương Ngân (B23DCTC074), Trần Vân Anh (B23DCTC011)  
> **Năm thực hiện**: 2025  

---

## 1. THÔNG TIN CHUNG (PROJECT METADATA)

* **Project Name**: Xây dựng Website Bán Bánh - Memory Lane Sweets `[Documented]`
* **Business Domain**: Thương mại điện tử B2C (Business-to-Consumer) ngành Thực phẩm / Bánh tươi & Bánh ngọt thủ công (Bakery & Pastry). `[Documented]`
* **Business Problem**:
  * Các cửa hàng bánh ngọt truyền thống phụ thuộc chủ yếu vào việc bán hàng trực tiếp tại quầy vật lý, dẫn đến phạm vi tiếp cận khách hàng bị giới hạn trong khu vực địa lý hẹp và khung giờ mở cửa cố định. `[Documented]`
  * Quy trình tiếp nhận đơn hàng, tư vấn thực đơn và kiểm tra tồn kho theo phương thức thủ công (qua điện thoại, tin nhắn) dễ gây sai sót về số lượng bánh còn lại trong ngày – đặc thù ngành bánh là thời hạn sử dụng ngắn (short shelf-life) và tiêu thụ theo ngày. `[Documented]`
  * Thiếu kênh tập trung để phân loại và trưng bày trực quan các nhóm sản phẩm bánh kem, bánh sinh nhật, bánh mặn và bánh quy kèm bảng giá minh bạch. `[Documented]`
* **Business Objectives**:
  * **Chuyển đổi số kênh bán lẻ**: Thiết lập một website thương mại điện tử hoạt động 24/7 giúp khách hàng chủ động tìm kiếm, duyệt thực đơn và đặt bánh trực tuyến. `[Documented]`
  * **Tự động hóa xử lý đơn hàng & tồn kho**: Tự động tính toán tổng giá trị đơn hàng (bao gồm phí vận chuyển), lưu vết hóa đơn vào CSDL và tự động khấu trừ số lượng tồn kho ngay khi đơn hàng được thiết lập thành công để loại bỏ nguy cơ bán vượt tồn kho (overselling). `[Documented]` `[Implemented]`
  * **Tối ưu trải nghiệm khách hàng**: Cung cấp giao diện trực quan, hỗ trợ xem bánh mới, bánh bán chạy, tìm kiếm theo từ khóa, lọc theo mức giá và quy trình thanh toán COD tinh gọn trong 3 bước. `[Documented]` `[Implemented]`
* **Target Users**:
  * **Khách hàng cá nhân (End Consumers)**: Người tiêu dùng có nhu cầu đặt mua bánh ngọt, bánh sinh nhật tiệc tùng hoặc bánh ăn nhẹ hàng ngày. `[Documented]`
  * **Khách hàng vãng lai (Guest Users)**: Khách mua hàng nhanh không bắt buộc tạo tài khoản định danh. `[Implemented]` `[Derived from implementation]`
  * **Quản trị viên / Nhân viên tiệm bánh (Store Admins)**: Người quản lý danh mục, cập nhật sản phẩm, theo dõi và xử lý đơn hàng. `[Documented]`
* **Scope (Phạm vi dự án)**:
  * **Phân hệ Khách hàng (Storefront & Purchasing)**: Xem trang chủ (Bánh mới, Bánh bán chạy), duyệt danh mục (4 phân nhóm chính), xem chi tiết sản phẩm & sản phẩm liên quan, tìm kiếm theo tên, lọc theo khoảng giá, quản lý giỏ hàng (thêm, sửa, xóa, kiểm soát tồn kho), nhập thông tin người nhận, chọn phương thức COD, tạo đơn hàng và trừ tồn kho tự động. `[Documented]` `[Implemented]`
  * **Cơ sở dữ liệu trung tâm**: CSDL SQL Server gồm các bảng Users, CakeCategories, Cakes, Orders, OrderDetails, Reviews. `[Documented]` `[Implemented]`
* **Out of Scope (Ngoài phạm vi hiện tại)**:
  * Tích hợp cổng thanh toán trực tuyến bên thứ ba (VNPay, MoMo, ZaloPay, Thẻ quốc tế). `[Documented]`
  * Tự động tính phí vận chuyển theo tọa độ GIS / Tích hợp API đơn vị vận chuyển bên ngoài (GHTK, GHN). `[Documented]`
  * Phân hệ Đăng nhập/Đăng ký Client và Quản trị Admin trên giao diện Web *(chưa cài đặt Servlet/JSP tương ứng)*. `[Gap]`
* **Business Value**:
  * **Tăng trưởng doanh số**: Mở rộng tệp khách hàng ngoài phạm vi bán kính cửa hàng vật lý.
  * **Tiết kiệm chi phí vận hành**: Giảm thiểu 80% thời gian nhân viên phải tư vấn menu và kiểm tra tồn kho thủ công.
  * **Bảo toàn chất lượng dịch vụ**: Kiểm soát tồn kho thời gian thực ngăn chặn triệt để tình trạng khách đặt phải bánh đã hết hàng.

---

## 2. ĐẶC THÙ NGHIỆP VỤ NGÀNH BÁNH (INDUSTRY DOMAIN SPECIFICS)

Dựa trên khảo sát thực tế (tham khảo mô hình Nguyễn Sơn Bakery, ShopeeFood), hệ thống áp dụng các đặc thù nghiệp vụ sau:
1. **Kiểm soát tồn kho thời gian thực (Real-time Inventory Control)**: Bánh tươi có số lượng sản xuất theo mẻ trong ngày. Hệ thống kiểm tra số lượng tồn (`quantity`) ở cả 2 bước: khi thêm/sửa giỏ hàng và khi bấm đặt hàng. `[Documented]` `[Implemented]`
2. **Quy trình đặt hàng tinh gọn (Streamlined 3-Step Checkout)**: Tối giản hóa quy trình mua hàng để khách hàng có thể chốt đơn trong dưới 5 lượt click chuột (Giỏ hàng $\rightarrow$ Giao hàng $\rightarrow$ Thanh toán $\rightarrow$ Thành công). `[Documented]` `[Implemented]`
3. **Phân loại danh mục 4 tầng rõ ràng**: Bánh Ngọt (Pastry), Bánh Sinh Nhật (Birthday Cakes), Bánh Mặn (Savory/Bread), Cookie & Minicakes. `[Documented]` `[Implemented]`
