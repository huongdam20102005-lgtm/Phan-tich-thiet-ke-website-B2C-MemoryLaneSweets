# KIẾN TRÚC HỆ THỐNG & MÔ HÌNH NGỮ CẢNH (SYSTEM ARCHITECTURE & CONTEXT)

> **Mã tài liệu**: `DOC-INT-01`  
> **Dự án**: Website Bán Bánh Ngọt B2C (Memory Lane Sweets)  

Tài liệu này mô tả chi tiết kiến trúc phân tầng (Three-tier Architecture), mô hình điều phối MVC (Model - View - Controller), sơ đồ ngữ cảnh hệ thống (System Context) và các giao thức kết nối dữ liệu.

---

## 1. MÔ HÌNH NGỮ CẢNH HỆ THỐNG (SYSTEM CONTEXT DIAGRAM)

```mermaid
graph TD
    subgraph Users ["NGƯỜI DÙNG HỆ THỐNG"]
        Guest["Khách hàng vãng lai (Guest)"]
        Member["Khách hàng thành viên (Member)"]
        Admin["Quản trị viên cửa hàng (Admin)"]
    end

    subgraph MemoryLaneApp ["HỆ THỐNG WEBSITE B2C MEMORY LANE SWEETS"]
        WebUI["Tầng Trình Diễn (JSP, CSS3, JS)"]
        Backend["Tầng Ứng Dụng (Jakarta Servlets, Session Logic)"]
        DAL["Tầng Truy Xuất Dữ Liệu (DAO, JDBC DBUtils)"]
    end

    subgraph Storage ["TẦNG LƯU TRỮ DỮ LIỆU"]
        DB[(Microsoft SQL Server 2019+)]
    end

    subgraph ExternalServices ["DỊCH VỤ & TÀI NGUYÊN BÊN NGOÀI"]
        CDN_FA["Font Awesome 6.5.2 CDN"]
        GoogleFonts["Google Fonts API (Dancing Script)"]
        PaymentGateway["Cổng thanh toán MoMo/VNPay (Future)"]
        LogisticsAPI["Đơn vị vận chuyển GHTK/GHN (Future)"]
    end

    Guest -->|HTTP / HTTPS| WebUI
    Member -->|HTTP / HTTPS| WebUI
    Admin -->|HTTP / HTTPS| WebUI

    WebUI -->|Request / Session Forward| Backend
    Backend -->|Data Queries & Updates| DAL
    DAL -->|JDBC Driver Port 1433| DB

    WebUI -.->|Load Styles & Icons| CDN_FA
    WebUI -.->|Load Web Fonts| GoogleFonts
    Backend -.->|Tích hợp tương lai| PaymentGateway
    Backend -.->|Tích hợp tương lai| LogisticsAPI
```

---

## 2. KIẾN TRÚC 3 TẦNG (THREE-TIER ARCHITECTURE)

Hệ thống được thiết kế phân tầng nghiêm ngặt theo chuẩn Enterprise Java Web:

```
+-------------------------------------------------------------------------+
|                  1. PRESENTATION LAYER (TẦNG TRÌNH DIỄN)                 |
|  - Trình duyệt Web (Chrome, Edge, Firefox, Safari)                      |
|  - Giao diện JSP (JavaServer Pages), CSS3 (checkout_payment.css...),    |
|    JavaScript client-side validation, JSTL Core & Formatting Tags        |
+-------------------------------------------------------------------------+
                                    |  HTTP Request / Response
                                    v
+-------------------------------------------------------------------------+
|             2. APPLICATION / LOGIC LAYER (TẦNG NGHIỆP VỤ & ĐIỀU PHỐI)   |
|  - Web Server: Apache Tomcat 10+                                         |
|  - Controller Servlets: HomeServlet, CategoryServlet, ProductDetailServlet|
|    SearchServlet, CartServlet, CheckoutServlet, PaymentServlet          |
|  - Session-based Memory Caching: Cart, CartItem, User Session State      |
|  - Business Validation: Stock Reservation, Flat-rate Shipping Calculator |
+-------------------------------------------------------------------------+
                                    |  Java Method Calls
                                    v
+-------------------------------------------------------------------------+
|             3. DATA ACCESS LAYER & DATABASE (TẦNG DỮ LIỆU)              |
|  - Data Access Objects: CakeDAO.java, OrderDAO.java                      |
|  - Connection Manager: DBUtils.java (JDBC Connection Pool)              |
|  - RDBMS: Microsoft SQL Server (WebBanBanhDB)                           |
+-------------------------------------------------------------------------+
```

---

## 3. DÒNG CHẢY ĐIỀU PHỐI MVC (MVC INTERACTION LIFECYCLE)

```mermaid
sequenceDiagram
    autonumber
    actor Client as Trình duyệt (Client)
    participant View as JSP View Layer
    participant Controller as Servlet Controller
    participant DAO as Data Access Object (DAO)
    participant DB as SQL Server DB

    Client->>Controller: Gửi HTTP Request (VD: GET /category?id=1)
    Note over Controller: 1. Tiếp nhận tham số URL<br/>2. Kiểm tra tính hợp lệ dữ liệu
    Controller->>DAO: Gọi phương thức truy vấn (getCakesByCategoryId)
    DAO->>DB: Thực thi PreparedStatement SQL
    DB-->>DAO: ResultSet
    DAO-->>Controller: Đóng gói đối tượng Java (List<Cake>)
    Note over Controller: 3. Đưa dữ liệu vào requestScope<br/>(request.setAttribute("cakeList", list))
    Controller->>View: RequestDispatcher.forward(viewPath)
    Note over View: 4. Trộn dữ liệu với mã HTML<br/>thông qua JSTL (<c:forEach>)
    View-->>Client: Trả về trang HTML hoàn chỉnh cho người dùng
```

---

## 4. QUẢN LÝ KẾT NỐI VÀ TÍCH HỢP HỆ THỐNG

* **JDBC Driver Configuration (`DBUtils.java`)**:
  * Driver Class: `com.microsoft.sqlserver.jdbc.SQLServerDriver`
  * Connection String: `jdbc:sqlserver://localhost:1433;databaseName=WebBanBanhDB;encrypt=false;trustServerCertificate=true;`
  * Quản lý kết nối tự động đóng qua cấu trúc `try-with-resources`.
* **Cơ chế quản lý phiên (Session Management)**:
  * Được cấu hình trong `web.xml` với thời gian sống 30 phút (`<session-timeout>30</session-timeout>`).
  * Đối tượng `Cart` được gắn vào `sessionScope.cart` giúp khách hàng duyệt nhiều trang mà không bị mất giỏ hàng.
