# DANH MỤC QUY TẮC NGHIỆP VỤ (BUSINESS RULES CATALOG)

> **Mã tài liệu**: `DOC-BUS-03`  
> **Dự án**: Website Bán Bánh Ngọt B2C (Memory Lane Sweets)  

Tài liệu này hệ thống hóa toàn bộ các quy tắc nghiệp vụ (Business Rules) chi phối hoạt động của hệ thống, bao gồm các quy tắc được mô tả trong tài liệu báo cáo và các quy tắc được khai phá trực tiếp từ mã nguồn thực thi.

---

## 1. BẢNG TỔNG HỢP QUY TẮC NGHIỆP VỤ

| Mã quy tắc (Rule ID) | Phân loại (Category) | Phát biểu Quy tắc Nghiệp vụ (Business Rule Statement) | Nguồn (Source) | Quy trình liên quan | Tính năng liên quan | Chi tiết triển khai kỹ thuật (Implementation) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **BR-STK-01** | **Validation / Stock** | **Kiểm soát vượt tồn kho khi chọn hàng**: Số lượng sản phẩm thêm vào giỏ hàng (`action=add`) hoặc cập nhật trong giỏ hàng (`action=update`) không được vượt quá số lượng tồn kho khả dụng hiện tại (`Cakes.quantity`). Nếu vượt quá, hệ thống từ chối thao tác và trả về thông báo lỗi: *"Số lượng cập nhật vượt quá tồn kho. Chỉ còn [available] sản phẩm."* | `Documented` `[Implemented]` | `BP-02` | `F005` | `CartServlet.java` (dòng 71-74, dòng 94-97) |
| **BR-STK-02** | **Workflow / Inventory Deduction** | **Tự động khấu trừ tồn kho**: Ngay khi giao dịch đặt hàng hoàn tất thành công (`PaymentServlet.doPost`), hệ thống phải tự động trừ số lượng tồn kho tương ứng của từng mặt hàng trong CSDL theo công thức `quantity = quantity - orderedQuantity`. | `Documented` `[Implemented]` | `BP-03` | `F008` | `PaymentServlet.java` (dòng 550-562), `CakeDAO.java` (dòng 796-798, 1044-1079) |
| **BR-CRT-01** | **Validation / Cart Min Quantity** | **Giới hạn số lượng tối thiểu trong giỏ**: Số lượng mỗi món trong giỏ hàng phải là số nguyên $\ge 1$. Nếu người dùng điều chỉnh số lượng $< 1$ (hoặc $= 0$), hệ thống tự động xóa sản phẩm đó ra khỏi giỏ hàng. | `Implemented` `[Derived]` | `BP-02` | `F005` | `CartServlet.java` (dòng 86-88), `cart.jsp` (hàm JS `changeQuantity`) |
| **BR-CRT-02** | **Calculation / Pricing** | **Tính toán giá trị giỏ hàng**: Thành tiền của từng mặt hàng = `đơn giá bánh * số lượng`. Tổng tiền hàng (`cartTotal`) = tổng thành tiền của toàn bộ mặt hàng trong giỏ. Sử dụng kiểu dữ liệu `BigDecimal` để đảm bảo độ chính xác tài chính. | `Implemented` `[Derived]` | `BP-02` | `F005` | `CartItem.java` (phương thức `getTotalPrice()`), `Cart.java` (`getTotalMoney()`) |
| **BR-SHP-01** | **Pricing / Shipping Fee** | **Phí vận chuyển cố định**: Áp dụng mức phí vận chuyển cố định là **20.000 VNĐ** cho hình thức "Giao hàng tận nơi". Tổng thanh toán của đơn hàng = `Tổng tiền hàng + 20.000 VNĐ`. | `Implemented` `[Derived]` | `BP-03` | `F006`, `F007` | `sidebar-checkout.jsp` (dòng 1275, 1281), `payment.jsp` (dòng 682) |
| **BR-PAY-01** | **Workflow / Payment Method** | **Phương thức thanh toán khả dụng**: Phương thức thanh toán mặc định và duy nhất đang hỗ trợ giao dịch thành công trên hệ thống là **Thanh toán khi nhận hàng (COD - Cash On Delivery)**. | `Documented` `[Implemented]` | `BP-03` | `F007` | `payment.jsp` (dòng 689-692), `PaymentServlet.java` |
| **BR-ORD-01** | **Mandatory Fields / Checkout** | **Thông tin giao hàng bắt buộc**: Khi tiến hành đặt hàng, khách hàng bắt buộc phải cung cấp đầy đủ 3 trường thông tin: Họ và tên người nhận (`name`), Số điện thoại (`phone`), và Địa chỉ nhận hàng (`address`). | `Documented` `[Implemented]` | `BP-03` | `F006` | `checkout.jsp` (thuộc tính `required` tại dòng 218, 221, 224) |
| **BR-ORD-02** | **Status Transition / Initial Order State** | **Trạng thái khởi tạo đơn hàng**: Mọi đơn đặt hàng mới được tạo thành công đều được gán trạng thái ban đầu là **"Chờ xác nhận"**. | `Documented` `[Implemented]` | `BP-03` | `F007` | `PaymentServlet.java` (dòng 520), `sql.sql` |
| **BR-ORD-03** | **Data Binding / Guest User Policy** | **Ràng buộc định danh khách vãng lai**: Đối với đơn hàng do khách vãng lai (chưa đăng nhập) thực hiện, hệ thống đặt `userID = 0` trong Model và chèn giá trị `NULL` vào cột `userID` của bảng `Orders` trong CSDL. | `Implemented` `[Derived]` | `BP-03` | `F007` | `OrderDAO.java` (dòng 1120-1124) |
| **BR-PRC-01** | **Conditional Logic / Price Filtering** | **Phân khúc khoảng giá bộ lọc**: Bộ lọc giá tại trang danh mục được phân thành 4 dải cố định: (1) Dưới 100.000đ (`0 - 100.000`), (2) 100.000đ - 200.000đ (`100.000 - 200.000`), (3) 200.000đ - 300.000đ (`200.000 - 300.000`), (4) Trên 300.000đ (`300.000 - 1.000.000.000`). | `Implemented` `[Derived]` | `BP-01` | `F003` | `CategoryServlet.java` (dòng 209-223), `product-category.jsp` |
| **BR-CAT-01** | **Data Integrity / Catalog Structure** | **Cấu trúc danh mục chuẩn**: Hệ thống định nghĩa 4 danh mục bánh chính: ID 1: Bánh Ngọt, ID 2: Bánh Sinh Nhật, ID 3: Bánh Mặn, ID 4: Cookie & Minicakes. Các truy vấn hiển thị danh mục chỉ lấy các bánh có `quantity > 0`. | `Documented` `[Implemented]` | `BP-01` | `F002`, `F003` | `sql.sql` (dòng 110-114), `menu-page.jsp`, `CakeDAO.java` |
| **BR-VAL-01** | **Validation / Search Keyword** | **Chuẩn hóa từ khóa tìm kiếm**: Chuỗi từ khóa tìm kiếm phải được tự động cắt tỉa khoảng trắng (`trim()`). Nếu từ khóa rỗng, hệ thống trả về danh sách rỗng (`Collections.emptyList()`) thay vì báo lỗi. | `Implemented` `[Derived]` | `BP-01` | `F004` | `SearchServlet.java` (dòng 693-700) |
| **BR-VAL-02** | **Validation / Product Detail ID** | **Tính hợp lệ của mã bánh**: Tham số `id` trên URL trang chi tiết phải là số nguyên $> 0$. Nếu thiếu hoặc sai định dạng số $\rightarrow$ trả lỗi HTTP 400; nếu không tìm thấy trong CSDL $\rightarrow$ trả lỗi HTTP 404. | `Implemented` `[Derived]` | `BP-01` | `F004` | `ProductDetailServlet.java` (dòng 616-654) |
| **BR-REV-01** | **Validation / Review (DB Constraint)** | **Ràng buộc đánh giá sản phẩm**: Điểm số đánh giá bắt buộc từ 1 đến 5 sao (`CHECK (rating BETWEEN 1 AND 5)`). Mỗi người dùng chỉ được đánh giá 1 lần duy nhất cho mỗi loại bánh (`UNIQUE (userID, cakeID)`). | `Documented` `[SQL]` | `BP-06` | `F011` | `sql.sql` (dòng 90, dòng 101) |
| **BR-USR-01** | **Permission / User Role Constraint** | **Ràng buộc vai trò tài khoản**: Hệ thống chỉ chấp nhận 2 vai trò người dùng: `'admin'` hoặc `'user'` (`CHECK (role IN ('admin', 'user'))`). Email và Số điện thoại là trường dữ liệu duy nhất toàn hệ thống (`UNIQUE`). | `Documented` `[SQL]` | `BP-07` | `F009` | `sql.sql` (dòng 15, 17, 19) |

---

## 2. QUY TẮC NGHIỆP VỤ CÓ TRONG CODE NHƯNG THIẾU TRONG TÀI LIỆU GỐC

Các quy tắc sau đây được phát hiện trực tiếp trong quá trình phân tích mã nguồn (Source Code Analysis) nhưng chưa từng được văn bản hóa trong tài liệu báo cáo của dự án:
1. **Phí vận chuyển 20.000 VNĐ (`BR-SHP-01`)**: Được hardcode trực tiếp tại View và tính vào tổng đơn hàng.
2. **Cơ chế Khách vãng lai (`BR-ORD-03`)**: Gán `userID = 0` và chèn `NULL` vào DB cho khách không đăng nhập.
3. **Phân khúc giá cố định 4 mức (`BR-PRC-01`)**: Logic bóc tách chuỗi `minPrice-maxPrice` trong `CategoryServlet.java`.
4. **Giới hạn số lượng hiển thị nổi bật**: Trang chủ giới hạn hiển thị chính xác Top 6 bánh mới nhất (`TOP 6 ... ORDER BY createdAt DESC`) và Top 3 bánh bán chạy nhất (`TOP 3 ... ORDER BY TotalSold DESC`).
