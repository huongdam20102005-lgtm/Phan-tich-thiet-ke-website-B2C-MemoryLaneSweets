# TÀI LIỆU KIỂM THỬ & KỊCH BẢN CHẤP NHẬN (TEST CASES & UAT SCENARIOS)

> **Mã tài liệu**: `DOC-TST-01`  
> **Dự án**: Website Bán Bánh Ngọt B2C (Memory Lane Sweets)  
> **Nguồn bằng chứng**: Trích xuất nguyên bản từ file `test case.xlsx` và Mục 4.3 Báo cáo đồ án  

Tài liệu này tổng hợp toàn bộ 27 kịch bản kiểm thử (Test Cases / UAT Scenarios) được phân chia theo 2 tác nhân người dùng chính: **Khách hàng** (16 kịch bản) và **Quản trị viên (Admin)** (11 kịch bản).

---

## 1. BẢNG KIỂM THỬ PHÂN HỆ KHÁCH HÀNG (CUSTOMER TEST SUITE - 16 TEST CASES)

| STT | Chức năng kiểm thử | Mô tả kịch bản kiểm thử (Test Case Description) | Dữ liệu đầu vào (Test Data) | Các bước thực hiện (Execution Steps) | Kết quả mong đợi (Expected Result) | Trạng thái (Status) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **TC-C01** | Đăng nhập | Đăng nhập đúng thông tin | `sdt: 0901234567`, `password: 123456` | 1. Truy cập trang đăng nhập<br/>2. Nhập SĐT & Mật khẩu<br/>3. Bấm 'Đăng nhập' | Chuyển đến trang Dashboard / Trang cá nhân | `Pending Execution` |
| **TC-C02** | Đăng nhập | Đăng nhập sai số điện thoại | `sdt: 0901234577`, `password: 123456` | 1. Truy cập trang đăng nhập<br/>2. Nhập thông tin<br/>3. Bấm 'Đăng nhập' | Hiển thị thông báo lỗi: "Sai số điện thoại" | `Pending Execution` |
| **TC-C03** | Đăng nhập | Đăng nhập sai mật khẩu | `sdt: 0901234567`, `password: 12345` | 1. Truy cập trang đăng nhập<br/>2. Nhập thông tin<br/>3. Bấm 'Đăng nhập' | Hiển thị thông báo lỗi: "Sai mật khẩu" | `Pending Execution` |
| **TC-C04** | Quản lý giỏ hàng | Thêm sản phẩm vào giỏ hàng lớn hơn số lượng tồn kho | Thêm từ trang chi tiết sản phẩm | 1. Chọn sản phẩm<br/>2. Nhập số lượng vượt tồn kho<br/>3. Bấm "Thêm giỏ hàng" | 1. Chuyển đến trang "Giỏ hàng"<br/>2. Hiển thị thông báo: "Số lượng cập nhật vượt quá tồn kho. Chỉ còn...sản phẩm."<br/>3. Hiển thị đúng tổng tiền | **PASS** |
| **TC-C05** | Quản lý giỏ hàng | Thêm sản phẩm vào giỏ hàng nhỏ hoặc bằng số lượng tồn | Thêm từ trang chi tiết sản phẩm | 1. Chọn sản phẩm<br/>2. Nhập số lượng hợp lệ<br/>3. Bấm "Thêm giỏ hàng" | 1. Chuyển đến trang "Giỏ hàng"<br/>2. Hiển thị tổng tiền sản phẩm chính xác | **PASS** |
| **TC-C06** | Quản lý giỏ hàng | Thêm sản phẩm vào giỏ từ trang chủ / danh mục / tìm kiếm | Thêm từ trang chủ / danh mục | 1. Duyệt trang chủ/danh mục<br/>2. Bấm "THÊM VÀO GIỎ" | 1. Chuyển đến trang "Giỏ hàng"<br/>2. Cảnh báo nếu vượt tồn kho<br/>3. Cập nhật tổng tiền hàng | **PASS** |
| **TC-C07** | Quản lý giỏ hàng | Xóa sản phẩm khỏi giỏ hàng | Sản phẩm đã có trong giỏ | 1. Truy cập trang "Giỏ hàng"<br/>2. Nhấn nút "Xóa" | Sản phẩm được xóa hoàn toàn khỏi giỏ hàng, tổng tiền cập nhật lại | **PASS** |
| **TC-C08** | Đặt hàng | Đặt hàng khi có sản phẩm và điền đầy đủ thông tin | Giỏ có hàng, nhập đủ Họ tên, SĐT, Địa chỉ | 1. Vào giỏ $\rightarrow$ Nhấn "Đặt hàng"<br/>2. Điền form giao hàng<br/>3. Chọn COD $\rightarrow$ Bấm "Hoàn tất đơn hàng" | 1. Thông báo đặt hàng thành công<br/>2. Đơn hàng lưu vào CSDL, giỏ hàng về 0, trừ tồn kho bánh | **PASS** |
| **TC-C09** | Đặt hàng | Đặt hàng khi bỏ trống trường bắt buộc | Bỏ trống Họ tên / SĐT / Địa chỉ | 1. Vào giỏ $\rightarrow$ Nhấn "Đặt hàng"<br/>2. Bỏ trống thông tin $\rightarrow$ Bấm tiếp tục | Trình duyệt kích hoạt validation yêu cầu nhập đủ thông tin đặt hàng | **PASS** |
| **TC-C10** | Tìm kiếm sản phẩm | Tìm kiếm bánh với từ khóa hợp lệ | Nhập keyword (VD: "Tiramisu") | 1. Nhập từ khóa lên ô tìm kiếm<br/>2. Nhấn "Enter" hoặc nút icon tìm kiếm | Hiển thị số lượng và danh sách các sản phẩm bánh phù hợp | **PASS** |
| **TC-C11** | Tìm kiếm sản phẩm | Tìm kiếm sản phẩm với từ khóa rỗng | Không nhập gì trên thanh tìm kiếm | 1. Để trống ô tìm kiếm<br/>2. Nhấn "Enter" hoặc nút tìm kiếm | Trả về kết quả rỗng, không báo lỗi hệ thống | **PASS** |
| **TC-C12** | Lọc sản phẩm | Lọc sản phẩm theo khoảng giá | Chọn mức giá trong trang danh mục | 1. Truy cập trang danh mục<br/>2. Chọn khoảng giá (VD: 100k-200k)<br/>3. Nhấn "Lọc" | Hiển thị danh sách bánh có giá trong khoảng đã chọn | **PASS** |
| **TC-C13** | Xem chi tiết sản phẩm | Xem chi tiết thông tin bánh | Chọn sản phẩm muốn xem | 1. Bấm vào ảnh/tên bánh tại bất kỳ trang nào | Hiển thị trang chi tiết: ảnh, giá, mô tả, tồn kho và bánh liên quan | **PASS** |
| **TC-C14** | Bình luận & Đánh giá | Gửi đánh giá cho sản phẩm đã mua | Đánh giá sao & nhận xét | 1. Vào lịch sử mua hàng $\rightarrow$ Chọn đơn $\rightarrow$ Nhập đánh giá $\rightarrow$ Gửi | Thông báo gửi đánh giá thành công | `Pending Execution` |
| **TC-C15** | Quản lý hồ sơ cá nhân | Cập nhật thông tin cá nhân | Thay đổi thông tin cần sửa | 1. Vào hồ sơ cá nhân $\rightarrow$ Nhấn "Sửa"<br/>2. Nhập thông tin mới $\rightarrow$ Lưu | Thông tin cá nhân được cập nhật thành công | `Pending Execution` |
| **TC-C16** | Quản lý hồ sơ cá nhân | Đổi mật khẩu tài khoản | Mật khẩu cũ và mật khẩu mới | 1. Vào hồ sơ $\rightarrow$ Nhấn "Đổi mật khẩu"<br/>2. Nhập mật khẩu cũ & mới $\rightarrow$ Lưu | Mật khẩu được thay đổi thành công | `Pending Execution` |

---

## 2. BẢNG KIỂM THỬ PHÂN HỆ QUẢN TRỊ VIÊN (ADMIN TEST SUITE - 11 TEST CASES)

| STT | Chức năng kiểm thử | Mô tả kịch bản kiểm thử | Dữ liệu đầu vào (Test Data) | Các bước thực hiện | Kết quả mong đợi (Expected Result) | Trạng thái (Status) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **TC-A01** | Đăng nhập Admin | Đăng nhập đúng thông tin Admin | `sdt: 0987654321`, `pass: admin_password_456` | 1. Vào trang đăng nhập<br/>2. Nhập thông tin<br/>3. Bấm 'Đăng nhập' | Chuyển đến trang Dashboard Quản trị | `Pending Execution` |
| **TC-A02** | Đăng nhập Admin | Đăng nhập sai số điện thoại | `sdt: 0987654322`, `pass: admin_password_456` | 1. Nhập thông tin<br/>2. Bấm 'Đăng nhập' | Hiển thị lỗi "Sai số điện thoại" | `Pending Execution` |
| **TC-A03** | Đăng nhập Admin | Đăng nhập sai mật khẩu | `sdt: 0987654321`, `pass: admin_password_457` | 1. Nhập thông tin<br/>2. Bấm 'Đăng nhập' | Hiển thị lỗi "Sai mật khẩu" | `Pending Execution` |
| **TC-A04** | Quản lý sản phẩm | Thêm sản phẩm bánh mới | Thông tin bánh cần thêm | 1. Vào "Quản lý sản phẩm" $\rightarrow$ Nhấn "Thêm sản phẩm"<br/>2. Nhập thông tin $\rightarrow$ Nhấn "Lưu" | Sản phẩm mới được thêm thành công vào CSDL | `Pending Execution` |
| **TC-A05** | Quản lý sản phẩm | Xóa sản phẩm bánh | Sản phẩm đang có trong menu | 1. Chọn sản phẩm muốn xóa $\rightarrow$ Nhấn "Xóa sản phẩm"<br/>2. Nhấn "Lưu" | Sản phẩm được xóa khỏi hệ thống | `Pending Execution` |
| **TC-A06** | Quản lý sản phẩm | Cập nhật thông tin bánh | Sản phẩm đang có | 1. Chọn sản phẩm $\rightarrow$ Nhấn "Cập nhật"<br/>2. Sửa giá/tồn kho $\rightarrow$ Nhấn "Lưu" | Thông tin sản phẩm được cập nhật thành công | `Pending Execution` |
| **TC-A07** | Quản lý đơn hàng | Cập nhật trạng thái đơn | Đơn hàng hiện có | 1. Vào "Quản lý đơn hàng" $\rightarrow$ Chọn đơn<br/>2. Cập nhật trạng thái $\rightarrow$ Nhấn "Lưu" | Trạng thái đơn hàng được cập nhật thành công | `Pending Execution` |
| **TC-A08** | Quản lý tài khoản | Mở / Khóa tài khoản khách | Tài khoản hiện có | 1. Vào "Quản lý tài khoản"<br/>2. Chọn tài khoản $\rightarrow$ Nhấn "Mở"/"Khóa" $\rightarrow$ Lưu | Trạng thái tài khoản được cập nhật khóa/mở | `Pending Execution` |
| **TC-A09** | Quản lý tài khoản | Xóa tài khoản khách | Tài khoản hiện có | 1. Chọn tài khoản cần xóa $\rightarrow$ Nhấn "Xóa" $\rightarrow$ Lưu | Tài khoản bị xóa và không thể đăng nhập lại | `Pending Execution` |
| **TC-A10** | Tìm kiếm sản phẩm | Tra cứu sản phẩm trong kho | Nhập từ khóa tên bánh | 1. Nhập keyword vào thanh tìm kiếm $\rightarrow$ Bấm Tìm kiếm | Hiển thị danh sách bánh và số lượng tồn kho tương ứng | `Pending Execution` |
| **TC-A11** | Xem chi tiết sản phẩm | Xem thông tin chi tiết bánh | Chọn sản phẩm muốn xem | 1. Bấm vào sản phẩm muốn xem trong danh sách | Hiển thị chi tiết thông số kỹ thuật của bánh | `Pending Execution` |

---

## 3. MA TRẬN ÁNH XẠ YÊU CẦU $\rightarrow$ KỊCH BẢN KIỂM THỬ (REQUIREMENT TO TEST MAPPING)

| Mã Yêu cầu (FR ID) | Kịch bản kiểm thử tương ứng (Test Cases) | Tỷ lệ bao phủ kiểm thử (Coverage) |
| :--- | :--- | :--- |
| **FR-001** (Trang chủ) | TC-C06, TC-C13 | 100% Covered |
| **FR-002** (Danh mục & Lọc giá) | TC-C12 | 100% Covered |
| **FR-003** (Tìm kiếm bánh) | TC-C10, TC-C11, TC-A10 | 100% Covered |
| **FR-004** (Chi tiết sản phẩm) | TC-C13, TC-A11 | 100% Covered |
| **FR-005**, **FR-006** (Giỏ hàng & Tồn kho) | TC-C04, TC-C05, TC-C06, TC-C07 | 100% Covered |
| **FR-008**, **FR-009**, **FR-010** (Đặt hàng & Trừ kho) | TC-C08, TC-C09 | 100% Covered |
| **FR-011**, **FR-012** (Xác thực & Hồ sơ) | TC-C01, TC-C02, TC-C03, TC-C15, TC-C16, TC-A01, TC-A02, TC-A03 | Designed / Awaiting Code |
| **FR-013** (Admin Quản trị Bánh) | TC-A04, TC-A05, TC-A06 | Designed / Awaiting Code |
| **FR-014** (Admin Quản trị Đơn) | TC-A07 | Designed / Awaiting Code |
| **FR-015** (Đánh giá Bánh) | TC-C14 | Designed / Awaiting Code |
