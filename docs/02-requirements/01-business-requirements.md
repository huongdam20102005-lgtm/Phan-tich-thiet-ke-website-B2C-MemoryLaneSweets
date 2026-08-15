# YÊU CẦU NGHIỆP VỤ (BUSINESS REQUIREMENTS)

> **Mã tài liệu**: `DOC-REQ-01`  
> **Dự án**: Website Bán Bánh Ngọt B2C (Memory Lane Sweets)  

---

## DANH SÁCH YÊU CẦU NGHIỆP VỤ (BR-001 ĐẾN BR-005)

### BR-001: Cung cấp Kênh Bán Hàng Trực Tuyến 24/7
* **Mã yêu cầu**: `BR-001`
* **Phát biểu yêu cầu**: Hệ thống phải cung cấp một nền tảng thương mại điện tử trực tuyến hoạt động liên tục 24/7, cho phép khách hàng duyệt thực đơn, phân loại danh mục, tìm kiếm và xem thông tin chi tiết các loại bánh từ bất kỳ đâu.
* **Mục tiêu nghiệp vụ**: Mở rộng tệp khách hàng ngoài phạm vi quầy bán hàng trực tiếp, chuyển đổi số quy trình trưng bày thực đơn bánh tươi.
* **Tác nhân hưởng lợi**: Khách hàng cá nhân, Chủ cửa hàng bánh.
* **Mức độ ưu tiên**: `High` (Cao)
* **Nguồn gốc (Source)**: `Documented` (Chương 1 Báo cáo đồ án)
* **Quy trình liên quan**: `BP-01` (Khám phá & Tìm kiếm Sản phẩm)
* **Trạng thái thực thi**: **Implemented** (Đã triển khai đầy đủ trên Frontend Storefront)

---

### BR-002: Kiểm Soát & Quản Lý Tồn Kho Theo Thời Gian Thực
* **Mã yêu cầu**: `BR-002`
* **Phát biểu yêu cầu**: Hệ thống phải kiểm soát chặt chẽ số lượng bánh có sẵn trong ngày; ngăn chặn việc người mua thêm vào giỏ hoặc đặt hàng vượt quá số lượng tồn kho khả dụng; tự động khấu trừ số lượng bánh trong CSDL ngay khi đơn hàng được xác lập.
* **Mục tiêu nghiệp vụ**: Loại bỏ hoàn toàn rủi ro bán vượt tồn kho (overselling) đối với ngành bánh tươi có hạn sử dụng ngắn và sản xuất theo mẻ giới hạn.
* **Tác nhân hưởng lợi**: Khách hàng, Bộ phận Làm bánh & Quản lý kho.
* **Mức độ ưu tiên**: `High` (Cao)
* **Nguồn gốc (Source)**: `Documented` `[Derived from implementation]`
* **Quy trình liên quan**: `BP-02` (Quản lý Giỏ hàng), `BP-03` (Đặt hàng & Thanh toán)
* **Trạng thái thực thi**: **Implemented** (Đã triển khai trong `CartServlet` và `PaymentServlet`)

---

### BR-003: Tự Động Hóa Quy Trình Đặt Hàng & Thanh Toán COD
* **Mã yêu cầu**: `BR-003`
* **Phát biểu yêu cầu**: Hệ thống phải tiếp nhận thông tin người nhận, tự động tính tổng tiền (gồm tiền bánh và phí vận chuyển), ghi nhận đơn hàng vào CSDL và gửi phản hồi xác nhận đơn hàng thành công cho khách hàng theo hình thức thanh toán khi nhận hàng (COD).
* **Mục tiêu nghiệp vụ**: Tối giản hóa quy trình mua hàng, nâng cao tỷ lệ chuyển đổi đơn hàng và giảm thiểu thời gian xử lý đơn thủ công.
* **Tác nhân hưởng lợi**: Khách hàng vãng lai, Nhân viên đóng gói và giao hàng.
* **Mức độ ưu tiên**: `High` (Cao)
* **Nguồn gốc (Source)**: `Documented` (Mục 3.1.1, 4.1.5 Báo cáo)
* **Quy trình liên quan**: `BP-03` (Đặt hàng & Thanh toán)
* **Trạng thái thực thi**: **Implemented** (Đã triển khai trong `CheckoutServlet`, `PaymentServlet`, `OrderDAO`)

---

### BR-004: Quản Trị Danh Mục Sản Phẩm & Xử Lý Đơn Hàng Tập Trung
* **Mã yêu cầu**: `BR-004`
* **Phát biểu yêu cầu**: Cung cấp phân hệ quản trị tập trung dành cho Quản trị viên (Admin) để cập nhật thực đơn bánh (thêm, sửa, xóa bánh, điều chỉnh giá), quản lý trạng thái đơn hàng (Chờ xác nhận, Đang giao, Hoàn tất, Hủy) và quản lý người dùng.
* **Mục tiêu nghiệp vụ**: Đảm bảo cửa hàng chủ động điều phối hoạt động kinh doanh, kiểm soát dòng tiền và cập nhật menu linh hoạt theo ngày.
* **Tác nhân hưởng lợi**: Chủ cửa hàng / Quản trị viên (Store Admin).
* **Mức độ ưu tiên**: `Medium` (Trung bình)
* **Nguồn gốc (Source)**: `Documented` (Mục 3.1.1, 3.2.2 Báo cáo, Sheet Admin `test case.xlsx`)
* **Quy trình liên quan**: `BP-04` (Admin Quản lý Bánh), `BP-05` (Admin Xử lý Đơn)
* **Trạng thái thực thi**: **Not Implemented** *(Khoảng trống - Chưa có mã nguồn Servlet/JSP quản trị)*

---

### BR-005: Thu Thập Đánh Giá & Phản Hồi Chất Lượng Sản Phẩm
* **Mã yêu cầu**: `BR-005`
* **Phát biểu yêu cầu**: Cho phép khách hàng gửi điểm đánh giá (1-5 sao) và nhận xét về hương vị bánh sau khi trải nghiệm, giúp cửa hàng nâng cao chất lượng sản phẩm và dịch vụ.
* **Mục tiêu nghiệp vụ**: Tạo dựng niềm tin thương hiệu và thu thập dữ liệu phản hồi thực tế từ người tiêu dùng.
* **Tác nhân hưởng lợi**: Khách hàng, Chủ tiệm bánh.
* **Mức độ ưu tiên**: `Low` (Thấp)
* **Nguồn gốc (Source)**: `Documented` (Mục 3.2.2.7 Báo cáo, bảng `Reviews` trong `sql.sql`)
* **Quy trình liên quan**: `BP-06` (Đánh giá Sản phẩm)
* **Trạng thái thực thi**: **Not Implemented** *(Khoảng trống - Mới có cấu trúc CSDL, chưa có giao diện/controller)*
