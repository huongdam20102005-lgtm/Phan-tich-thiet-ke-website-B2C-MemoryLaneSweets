# ĐẶC TẢ USER STORIES & USE CASES (USER STORIES & USE CASE SPECIFICATIONS)

> **Mã tài liệu**: `DOC-REQ-04`  
> **Dự án**: Website Bán Bánh Ngọt B2C (Memory Lane Sweets)  

---

## 1. USER STORY 01 (US-01): DUYỆT BÁNH THEO DANH MỤC & LỌC GIÁ

* **User Story Statement**:
  * **As a** Khách hàng trực tuyến,
  * **I want** xem danh sách các loại bánh theo từng danh mục và lọc theo các khoảng giá tiền,
  * **So that** tôi có thể dễ dàng tìm thấy mẫu bánh phù hợp với khẩu vị và ngân sách của mình.
* **Tác nhân (Actor)**: Khách hàng (Guest / Registered User).
* **Tiền điều kiện (Preconditions)**: Hệ thống có dữ liệu bánh hoạt động trong bảng `Cakes` với `quantity > 0`.
* **Tiêu chí chấp nhận (Acceptance Criteria)**:
  1. Khi bấm vào danh mục (Bánh Ngọt, Bánh Sinh Nhật, Bánh Mặn, Cookie), hệ thống tải đúng danh sách bánh thuộc nhóm đó.
  2. Khi chọn một khoảng giá trong sidebar (Dưới 100k, 100k-200k, 200k-300k, trên 300k) và bấm "Lọc", hệ thống chỉ trả về các sản phẩm thỏa mãn điều kiện giá.
  3. Mỗi thẻ sản phẩm hiển thị đủ: Ảnh đại diện, Tên bánh, Đơn giá định dạng tiền tệ VNĐ, Nút "THÊM VÀO GIỎ".
* **Luồng chính (Main Flow)**:
  1. Người dùng chọn mục "SẢN PHẨM" (`/menu`) $\rightarrow$ Chọn một danh mục cụ thể (`/category?id=X`).
  2. Hệ thống truy vấn CSDL lấy danh sách bánh và tên danh mục hiển thị lên `product-category.jsp`.
  3. Người dùng chọn radio button khoảng giá (ví dụ: `100000-200000`) và bấm nút "Lọc".
  4. Hệ thống gửi yêu cầu `GET /category?id=X&priceFilter=100000-200000` $\rightarrow$ `CakeDAO` thực thi truy vấn lọc $\rightarrow$ Trả về kết quả phù hợp.
* **Luồng ngoại lệ (Exception Flow)**:
  * Nếu không có bánh nào trong khoảng giá đã chọn: Hệ thống hiển thị thông báo rỗng: *"Không tìm thấy sản phẩm nào trong danh mục này hoặc với tiêu chí lọc đã chọn."*
* **Quy tắc nghiệp vụ liên quan**: `BR-CAT-01`, `BR-PRC-01`.
* **Nguồn gốc (Source)**: `Documented` `[Implemented]`

---

## 2. USER STORY 02 (US-02): QUẢN LÝ GIỎ HÀNG & KIỂM SOÁT TỒN KHO

* **User Story Statement**:
  * **As a** Khách mua hàng,
  * **I want** thêm bánh vào giỏ hàng, tùy chỉnh tăng/giảm số lượng hoặc xóa món không mua,
  * **So that** tôi có thể gom nhiều món bánh và kiểm tra tổng chi phí trước khi đặt hàng.
* **Tác nhân (Actor)**: Khách hàng.
* **Tiền điều kiện (Preconditions)**: Sản phẩm chọn mua đang tồn tại trong hệ thống.
* **Tiêu chí chấp nhận (Acceptance Criteria)**:
  1. Khi thêm bánh hoặc cập nhật số lượng, nếu tổng số lượng trong giỏ vượt quá tồn kho khả dụng của bánh, hệ thống chặn thao tác và hiển thị cảnh báo: *"Số lượng cập nhật vượt quá tồn kho. Chỉ còn [X] sản phẩm."*
  2. Bấm nút (+) tăng số lượng lên 1; bấm nút (-) giảm số lượng đi 1; nếu giảm về 0 hoặc bấm "Xóa", sản phẩm tự động bị xóa khỏi giỏ.
  3. Tổng tiền hàng được tự động tính toán lại tức thì bằng tổng `(đơn giá * số lượng)`.
* **Luồng chính (Main Flow)**:
  1. Khách hàng bấm "THÊM VÀO GIỎ" từ trang chủ/danh mục/chi tiết bánh $\rightarrow$ Gửi `POST /cart` với `action=add`.
  2. Hệ thống kiểm tra số lượng tồn kho `available`. Nếu hợp lệ $\rightarrow$ cộng dồn vào đối tượng `Cart` trong Session.
  3. Hệ thống chuyển hướng về trang Giỏ hàng (`GET /cart`).
  4. Khách hàng chỉnh sửa số lượng $\rightarrow$ Gửi `POST /cart` với `action=update` $\rightarrow$ Hệ thống kiểm tra lại tồn kho và cập nhật tổng tiền.
* **Luồng ngoại lệ (Exception Flow)**:
  * Nếu số lượng vượt quá tồn kho: Giữ nguyên số lượng cũ, lưu thông báo lỗi vào Session và hiển thị khung cảnh báo màu đỏ trên giao diện.
* **Quy tắc nghiệp vụ liên quan**: `BR-STK-01`, `BR-CRT-01`, `BR-CRT-02`.
* **Nguồn gốc (Source)**: `Documented` `[Implemented]`

---

## 3. USER STORY 03 (US-03): ĐẶT HÀNG NHANH & THANH TOÁN COD (GUEST CHECKOUT)

* **User Story Statement**:
  * **As a** Khách hàng vãng lai (Guest User),
  * **I want** nhập thông tin người nhận và hoàn tất đơn hàng với phương thức thanh toán tiền mặt (COD),
  * **So that** tôi có thể mua bánh nhanh chóng mà không bắt buộc phải tạo tài khoản trước.
* **Tác nhân (Actor)**: Khách hàng vãng lai, Hệ thống Backend.
* **Tiền điều kiện (Preconditions)**: Giỏ hàng trong Session có ít nhất 1 sản phẩm (`cart.items` không rỗng).
* **Tiêu chí chấp nhận (Acceptance Criteria)**:
  1. Form giao hàng yêu cầu bắt buộc điền: Họ tên, Số điện thoại, Địa chỉ giao hàng.
  2. Phí vận chuyển mặc định là 20.000 VNĐ; Tổng thanh toán = Tổng tiền hàng + 20.000 VNĐ.
  3. Bấm "Hoàn tất đơn hàng" tạo đơn thành công: lưu bảng `Orders` (trạng thái "Chờ xác nhận"), lưu bảng `OrderDetails`, tự động trừ tồn kho các loại bánh đã đặt trong bảng `Cakes`, xóa sạch giỏ hàng trong Session và hiển thị trang đặt hàng thành công.
* **Luồng chính (Main Flow)**:
  1. Khách hàng bấm "Đặt hàng" tại giỏ hàng $\rightarrow$ Hệ thống chuyển sang trang Checkout (`/checkout`).
  2. Khách hàng điền Họ tên, SĐT, Địa chỉ $\rightarrow$ Bấm "Tiếp tục đến phương thức thanh toán" $\rightarrow$ Lưu thông tin giao hàng vào Session và chuyển hướng sang `/payment`.
  3. Khách hàng kiểm tra tóm tắt đơn hàng tại Sidebar và bấm "Hoàn tất đơn hàng" (`POST /payment`).
  4. Hệ thống gọi `OrderDAO.saveOrder(order)` lưu đơn hàng và chi tiết đơn hàng $\rightarrow$ Gọi `CakeDAO.updateCakeQuantity` trừ kho $\rightarrow$ Xóa session giỏ hàng $\rightarrow$ Chuyển tiếp sang `order-success.jsp`.
* **Luồng ngoại lệ (Exception Flow)**:
  * Nếu giỏ hàng rỗng khi truy cập checkout/payment: Hệ thống chặn và hiển thị thông báo lỗi.
  * Nếu có lỗi ghi CSDL: Ghi log lỗi, hiển thị thông báo thử lại và không trừ giỏ hàng.
* **Quy tắc nghiệp vụ liên quan**: `BR-ORD-01`, `BR-ORD-02`, `BR-ORD-03`, `BR-STK-02`, `BR-SHP-01`, `BR-PAY-01`.
* **Nguồn gốc (Source)**: `Documented` `[Implemented]`

---

## 4. USER STORY 04 (US-04): TÌM KIẾM BÁNH THEO TỪ KHÓA

* **User Story Statement**:
  * **As a** Người dùng truy cập website,
  * **I want** nhập từ khóa tên loại bánh vào thanh tìm kiếm trên thanh điều hướng,
  * **So that** tôi có thể tìm thấy ngay chiếc bánh mình muốn mà không phải duyệt từng trang danh mục.
* **Tác nhân (Actor)**: Khách hàng.
* **Tiêu chí chấp nhận (Acceptance Criteria)**:
  1. Nhập từ khóa hợp lệ (VD: "Bánh", "Tiramisu", "Croissant") $\rightarrow$ Hệ thống hiển thị số lượng và danh sách bánh có tên khớp với từ khóa.
  2. Nhập từ khóa không có kết quả $\rightarrow$ Hiển thị thông báo không tìm thấy bánh và gợi ý tìm từ khóa khác.
* **Quy tắc nghiệp vụ liên quan**: `BR-VAL-01`.
* **Nguồn gốc (Source)**: `Documented` `[Implemented]`

---

## 5. USER STORY 05 (US-05): QUẢN TRỊ SẢN PHẨM & ĐƠN HÀNG (ADMIN ROADMAP)

* **User Story Statement**:
  * **As a** Quản trị viên cửa hàng (Store Admin),
  * **I want** thêm, sửa, xóa các loại bánh và cập nhật trạng thái đơn hàng trên hệ thống,
  * **So that** thực đơn trên website luôn chính xác và các đơn hàng được xử lý giao nhận kịp thời.
* **Tác nhân (Actor)**: Quản trị viên.
* **Tiêu chí chấp nhận (Acceptance Criteria)**: `Derived from documentation & test cases - Implementation Pending`
  1. Admin đăng nhập bằng tài khoản role `admin` $\rightarrow$ Truy cập được trang Dashboard.
  2. Admin thêm bánh mới với đầy đủ tên, danh mục, giá, tồn kho, ảnh $\rightarrow$ Bánh mới xuất hiện ngay trên trang người dùng.
  3. Admin chọn đơn hàng và đổi trạng thái (Đã xác nhận, Đang giao, Hoàn tất) $\rightarrow$ Trạng thái cập nhật tức thì trong CSDL.
* **Nguồn gốc (Source)**: `Documented but NOT Implemented`
