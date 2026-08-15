# Nhật ký Thay đổi & Lịch sử Phiên bản (Changelog)

Toàn bộ các mốc phát triển và chuẩn hóa của dự án **Memory Lane Sweets** được ghi nhận dưới đây.

---

## [1.0.0] - 2026-08-15
### Đã hoàn thành (Initial Release & BA Audit Milestone)
* **Storefront Core**: Hoàn thành toàn bộ luồng mua sắm trực tuyến từ Trang chủ $\rightarrow$ Xem danh mục $\rightarrow$ Lọc 4 phân khúc giá $\rightarrow$ Xem chi tiết sản phẩm $\rightarrow$ Giỏ hàng Session có kiểm soát tồn kho $\rightarrow$ Đặt hàng COD $\rightarrow$ Tự động khấu trừ số lượng bánh trong CSDL.
* **CSDL SQL Server**: Thiết kế và triển khai CSDL quan hệ chuẩn hóa 3NF gồm 6 bảng liên kết (`Users`, `CakeCategories`, `Cakes`, `Orders`, `OrderDetails`, `Reviews`).
* **BA Documentation Set**: Số hóa và chuẩn hóa 17 tài liệu BA chuyên sâu trong thư mục `docs/` bao gồm: Business Overview, Stakeholders, Business Rules, Requirements (BR/FR/NFR/User Stories), Process Models (Mermaid), Feature Map, Data Dictionary, ERD, System Architecture, Test Cases & UAT, Traceability Matrix (RTM), Gap Analysis, Portfolio Highlights và Audit Report.
* **Master Documentation**: Phát hành `README.md`, `LICENSE` (MIT), `.gitignore`, `.env.example`, `CONTRIBUTING.md`.

---

## [Roadmap - Phase 2] - Sắp tới
* **Admin Module**: Xây dựng giao diện Quản trị Dashboard, CRUD sản phẩm bánh, quản lý phân loại danh mục, và cập nhật trạng thái đơn hàng.
* **User Authentication**: Xây dựng phân hệ Đăng ký, Đăng nhập, Quản lý Hồ sơ thành viên và Tra cứu Lịch sử đơn hàng.
* **Payment Integration**: Tích hợp cổng thanh toán trực tuyến MoMo / VNPay QR.
* **Reviews & Ratings**: Bổ sung giao diện đánh giá 1-5 sao và bình luận nhận xét trên trang chi tiết sản phẩm.
