# MÔ HÌNH HÓA QUY TRÌNH NGHIỆP VỤ (BUSINESS PROCESS MODELS)

> **Mã tài liệu**: `DOC-PRO-01`  
> **Dự án**: Website Bán Bánh Ngọt B2C (Memory Lane Sweets)  

Tài liệu này mô hình hóa chi tiết các quy trình nghiệp vụ (Business Processes) của hệ thống bằng sơ đồ chuẩn **Mermaid Sequence Diagram** và **Mermaid Flowchart** có khả năng render trực quan trên GitHub.

---

## 1. SO SÁNH QUY TRÌNH HIỆN TẠI (AS-IS) VS QUY TRÌNH MỚI (TO-BE)

### 1.1. Quy trình AS-IS (Bán hàng truyền thống tại quầy)
* Khách hàng phải đến trực tiếp tiệm bánh hoặc liên hệ qua điện thoại để hỏi danh sách các loại bánh còn trong ngày.
* Nhân viên kiểm tra khay bánh thủ công, ghi hóa đơn giấy hoặc nhập phần mềm POS tại chỗ.
* Rủi ro sai lệch: Bánh đã bán hết nhưng nhân viên vẫn nhận đơn qua điện thoại; thời gian đối soát doanh thu và tồn kho cuối ngày mất nhiều công sức.

### 1.2. Quy trình TO-BE (Website Thương mại Điện tử B2C Memory Lane Sweets)
* Khách hàng truy cập website 24/7, xem hình ảnh thực tế, mô tả thành phần, giá tiền và số lượng tồn kho theo thời gian thực.
* Khách hàng tự tạo giỏ hàng, hệ thống tự động kiểm tra tồn kho và tính tổng tiền minh bạch.
* Đơn hàng được lưu tự động vào CSDL, hệ thống tức thì khấu trừ số lượng tồn kho của bánh, loại bỏ hoàn toàn nguy cơ bán vượt số lượng.

---

## 2. BP-01: QUY TRÌNH KHÁM PHÁ & TÌM KIẾM SẢN PHẨM

```mermaid
sequenceDiagram
    autonumber
    actor User as Khách hàng
    participant Browser as Web Browser (JSP View)
    participant Ctrl as Servlet Controller
    participant DAO as CakeDAO
    participant DB as SQL Server DB

    User->>Browser: Truy cập Trang chủ (/home)
    Browser->>Ctrl: GET /home (HomeServlet)
    Ctrl->>DAO: getNewCakes() & getBestSellers()
    DAO->>DB: SELECT TOP 6 (New) / SELECT TOP 3 (Best Sellers)
    DB-->>DAO: Trả về tập bản ghi Cake
    DAO-->>Ctrl: List<Cake> newCakes, bestSellers
    Ctrl->>Browser: Forward trangchu.jsp
    Browser-->>User: Hiển thị Banner, Bánh mới & Bánh bán chạy

    opt Khách hàng duyệt theo Danh mục & Lọc giá
        User->>Browser: Chọn Danh mục (/category?id=1) & chọn Lọc giá (100k-200k)
        Browser->>Ctrl: GET /category?id=1&priceFilter=100000-200000
        Ctrl->>DAO: getCakesByCategoryIdAndPrice(1, 100000, 200000)
        DAO->>DB: SELECT c.* WHERE categoryID=1 AND price BETWEEN 100000 AND 200000 AND quantity > 0
        DB-->>DAO: Danh sách bánh thỏa mãn
        DAO-->>Ctrl: List<Cake> cakeList
        Ctrl->>Browser: Forward product-category.jsp
        Browser-->>User: Hiển thị lưới bánh theo phân khúc giá
    end

    opt Khách hàng tìm kiếm theo tên bánh
        User->>Browser: Nhập từ khóa ("Tiramisu") vào ô tìm kiếm
        Browser->>Ctrl: GET /search?keyword=Tiramisu
        Ctrl->>DAO: searchCakesByName("Tiramisu")
        DAO->>DB: SELECT c.* WHERE cakeName LIKE '%Tiramisu%' AND quantity > 0
        DB-->>DAO: Danh sách kết quả
        DAO-->>Ctrl: List<Cake> searchResults
        Ctrl->>Browser: Forward search-results.jsp
        Browser-->>User: Hiển thị kết quả tìm kiếm
    end
```

---

## 3. BP-02: QUY TRÌNH QUẢN LÝ GIỎ HÀNG & KIỂM SOÁT TỒN KHO

```mermaid
flowchart TD
    Start([Khách hàng bấm 'THÊM VÀO GIỎ']) --> Input[Nhận productID và quantity]
    Input --> Req[Gửi POST /cart action=add]
    Req --> CheckCart{Giỏ hàng đã có trong Session chưa?}
    CheckCart -- Chưa có --> CreateCart[Khởi tạo đối tượng Cart mới]
    CheckCart -- Đã có --> GetCart[Lấy Cart hiện tại từ Session]
    
    CreateCart --> QueryDB[Truy vấn CakeDAO.getCakeByID productID]
    GetCart --> QueryDB
    
    QueryDB --> CalcQty[Tính tổng số lượng dự kiến: totalQuantity = currentInCart + quantity]
    CalcQty --> CheckStock{totalQuantity > cake.quantity ?}
    
    CheckStock -- Vượt tồn kho --> SetError[Lưu Session errorMessage: 'Số lượng không đủ...']
    CheckStock -- Hợp lệ --> AddItem[Thêm / Cộng dồn CartItem vào Cart]
    
    SetError --> SaveSession[Lưu Cart vào Session]
    AddItem --> SaveSession
    SaveSession --> Redirect[PRG Pattern: Redirect GET /cart]
    Redirect --> RenderView[Render cart.jsp: Hiển thị danh sách & cảnh báo lỗi nếu có]
    RenderView --> End([Khách hàng xem giỏ hàng])
```

---

## 4. BP-03: QUY TRÌNH ĐẶT HÀNG, LƯU HÓA ĐƠN & TỰ ĐỘNG TRỪ TỒN KHO

```mermaid
sequenceDiagram
    autonumber
    actor Customer as Khách hàng
    participant CheckoutView as checkout.jsp
    participant CheckoutServlet as CheckoutServlet
    participant PaymentView as payment.jsp
    participant PaymentServlet as PaymentServlet
    participant OrderDAO as OrderDAO
    participant CakeDAO as CakeDAO
    participant DB as SQL Server Database

    Customer->>CheckoutView: Nhập Họ tên, SĐT, Địa chỉ
    Customer->>CheckoutView: Bấm 'Tiếp tục đến phương thức thanh toán'
    CheckoutView->>CheckoutServlet: POST /checkout (name, phone, address)
    CheckoutServlet->>CheckoutServlet: Lưu thông tin giao hàng vào Session
    CheckoutServlet-->>Customer: Redirect GET /payment

    Customer->>PaymentView: Kiểm tra tiền hàng + 20k ship & chọn COD
    Customer->>PaymentView: Bấm 'Hoàn tất đơn hàng'
    PaymentView->>PaymentServlet: POST /payment (method=COD)
    
    critical Bước 1: Lưu Đơn hàng & Chi tiết
        PaymentServlet->>OrderDAO: saveOrder(order)
        OrderDAO->>DB: INSERT INTO Orders(userID, status, totalAmount, address, paymentMethod)
        DB-->>OrderDAO: Trả về orderID vừa tạo
        loop Với từng CartItem trong giỏ
            OrderDAO->>DB: INSERT INTO OrderDetails(orderID, cakeID, quantity, unitPrice)
        end
    end

    critical Bước 2: Tự động Trừ Tồn Kho
        loop Với từng OrderDetail
            PaymentServlet->>CakeDAO: updateCakeQuantity(cakeId, orderedQuantity)
            CakeDAO->>DB: UPDATE Cakes SET quantity = quantity - ? WHERE cakeID = ?
            DB-->>CakeDAO: rowsAffected > 0 (Thành công)
        end
    end

    critical Bước 3: Dọn dẹp Session
        PaymentServlet->>PaymentServlet: session.removeAttribute('cart')
        PaymentServlet->>PaymentServlet: Xóa thông tin giao hàng tạm
    end

    PaymentServlet->>Customer: Forward order-success.jsp (Thông báo thành công)
```

---

## 5. CÁC QUY TRÌNH QUẢN TRỊ & MỞ RỘNG (ADMIN ROADMAP)

### 5.1. BP-04: Quy trình Quản trị Sản phẩm & Danh mục (Admin) `[Documented]`
* **Luồng hoạt động**: Admin đăng nhập $\rightarrow$ Truy cập danh sách Bánh $\rightarrow$ Chọn "Thêm mới bánh" hoặc "Sửa bánh" $\rightarrow$ Nhập Tên, Danh mục, Giá, Tồn kho, Ảnh, Mô tả $\rightarrow$ Hệ thống kiểm tra dữ liệu $\rightarrow$ Lưu vào bảng `Cakes` $\rightarrow$ Phản hồi thành công.

### 5.2. BP-05: Quy trình Xử lý Đơn hàng (Admin) `[Documented]`
* **Luồng hoạt động**: Admin vào mục Quản lý đơn hàng $\rightarrow$ Xem danh sách đơn "Chờ xác nhận" $\rightarrow$ Bấm cập nhật trạng thái sang "Đã xác nhận" / "Đang giao" / "Hoàn tất" $\rightarrow$ Hệ thống cập nhật cột `Orders.status` trong CSDL $\rightarrow$ Hỗ trợ in phiếu xuất kho / hóa đơn.

### 5.3. BP-06: Quy trình Đánh giá & Bình luận (Customer Review) `[Documented]`
* **Luồng hoạt động**: Khách hàng đăng nhập $\rightarrow$ Vào trang chi tiết bánh đã mua $\rightarrow$ Chọn số sao (1-5 sao) và viết nhận xét $\rightarrow$ Gửi đánh giá $\rightarrow$ Hệ thống ghi nhận vào bảng `Reviews` (trạng thái `pending` hoặc `active`).
