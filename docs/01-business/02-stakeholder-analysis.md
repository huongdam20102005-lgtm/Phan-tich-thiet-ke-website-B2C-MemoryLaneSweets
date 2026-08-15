# PHÂN TÍCH CÁC BÊN LIÊN QUAN (STAKEHOLDER ANALYSIS)

> **Mã tài liệu**: `DOC-BUS-02`  
> **Dự án**: Website Bán Bánh Ngọt B2C (Memory Lane Sweets)  

---

## 1. MA TRẬN PHÂN TÍCH BÊN LIÊN QUAN (STAKEHOLDER MATRIX)

| Stakeholder | Phân loại (Category) | Vai trò chính (Role) | Trách nhiệm chính (Responsibility) | Mối quan tâm cốt lõi (Interest) | Mức độ tương tác hệ thống (System Interaction) | Nguồn thông tin (Source) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Khách hàng vãng lai (Guest Customer)** | End User | Người mua hàng không đăng nhập | Duyệt xem sản phẩm, thêm bánh vào giỏ, nhập địa chỉ nhận hàng, xác nhận mua hàng qua COD. | Trải nghiệm mua sắm mượt mà, không bị ép đăng ký tài khoản, xem rõ giá và số lượng bánh còn lại. | Tương tác toàn bộ giao diện Storefront (`/home`, `/category`, `/cart`, `/checkout`, `/payment`). | `Documented` `[Implemented]` |
| **Khách hàng thành viên (Registered User)** | End User | Người mua hàng có tài khoản | Đăng ký, đăng nhập, quản lý thông tin địa chỉ cá nhân, theo dõi lịch sử đơn hàng, gửi đánh giá sản phẩm. | Lưu thông tin giao hàng cho các lần mua sau, kiểm tra tiến độ giao đơn hàng, nhận khuyến mại. | Đăng nhập định danh Session `loggedInUser`, quản lý hồ sơ và lịch sử *(Giao diện/Controller chưa triển khai đầy đủ)*. | `Documented` `[Gap]` |
| **Quản trị viên / Chủ cửa hàng (Admin / Store Owner)** | Admin / Internal Team | Quản lý kinh doanh & Vận hành | Cập nhật danh mục bánh, quản lý giá và tồn kho, tiếp nhận và chuyển trạng thái đơn hàng, khóa tài khoản vi phạm. | Kiểm soát số lượng hàng tồn theo ngày, hạn chế thất thoát, theo dõi doanh thu và tối ưu quy trình xử lý đơn. | Sử dụng các trang Dashboard quản trị *(Đã có trong thiết kế Use Case & Test Cases, chưa cài đặt Servlet)*. | `Documented` `[Gap]` |
| **Hệ quản trị CSDL (SQL Server Database Engine)** | System | Tầng lưu trữ dữ liệu trung tâm | Duy trì tính toàn vẹn dữ liệu quan hệ (ACID), thực thi các ràng buộc toàn vẹn (PK, FK, CHECK, UNIQUE), ghi nhận giao dịch. | Dữ liệu nhất quán, không xảy ra xung đột khi nhiều người cùng đặt hàng và trừ kho đồng thời. | Nhận kết nối JDBC từ `DBUtils`, thực thi các câu truy vấn từ `CakeDAO` và `OrderDAO`. | `Documented` `[Implemented]` |
| **Máy chủ Ứng dụng (Apache Tomcat / Jakarta EE)** | System | Tầng điều phối & Xử lý nghiệp vụ | Tiếp nhận HTTP Request, định tuyến qua Controller Servlets, duy trì Session giỏ hàng độc lập cho từng khách, render JSP. | Xử lý yêu cầu nhanh, ổn định, bảo mật session người dùng trong 30 phút. | Vận hành toàn bộ mã nguồn Java Web MVC 3 tầng. | `Documented` `[Implemented]` |
| **Đơn vị giao hàng (Shippers / Logistics)** | External System / Actor | Vận chuyển & Thu hộ | Nhận đơn hàng, vận chuyển bánh đến địa chỉ khách hàng và thu tiền mặt (COD). | Nhận đúng địa chỉ, số điện thoại người nhận và số tiền cần thu hộ. | Được tài liệu đề cập qua bảng `Shippers` *(Chưa triển khai API tích hợp)*. | `Documented` `[Gap]` |
| **Nhóm phát triển (Dev Team / Nhóm 6 PTIT)** | Internal Team | Đơn vị xây dựng & Triển khai | Phân tích yêu cầu, thiết kế kiến trúc hệ thống, lập trình MVC, thiết kế CSDL, thực hiện kiểm thử và bàn giao. | Hệ thống đáp ứng đúng yêu cầu bài toán thương mại điện tử, mã nguồn chuẩn mực, dễ bảo trì. | Toàn quyền thao tác trên mã nguồn, cấu hình Maven, triển khai Localhost. | `Documented` |

---

## 2. PHÂN TÍCH MỨC ĐỘ ẢNH HƯỞNG & QUYỀN HẠN (POWER - INTEREST GRID)

```
        Mức độ quan tâm (Interest)
                 Cao
                  ^
                  |   [QUẢN LÝ CHẶT CHẼ]          [HỢP TÁC CHIẾN LƯỢC]
                  |   - Chủ tiệm bánh (Admin)     - Khách hàng vãng lai & Thành viên
                  |   - Nhóm phát triển (Dev)
                  |
                  |   [THEO DÕI ĐỊNH KỲ]          [GIỮ HÀI LÒNG]
                  |   - Đơn vị giao nhận (Shipper)- Hệ thống Database / Server
                  |
                  +---------------------------------------------------->
                  Thấp                  Mức độ ảnh hưởng (Power)        Cao
```
