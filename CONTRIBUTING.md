# Quy chuẩn Đóng góp & Phát triển (Contribution Guidelines)

Cảm ơn bạn đã quan tâm đến dự án **Memory Lane Sweets - B2C Bakery E-Commerce System**. Dự án này được thiết kế và bảo trì dưới dạng một **Case Study / Portfolio Phân tích Thiết kế Hệ thống & Lập trình Web**.

---

## 1. QUY TRÌNH ĐÓNG GÓP (WORKFLOW)

1. **Fork** repository về tài khoản cá nhân của bạn.
2. Tạo branch tính năng mới theo quy ước:
   * `feat/feature-name` (Tính năng mới)
   * `fix/bug-fix` (Sửa lỗi logic/kỹ thuật)
   * `docs/ba-artifact` (Bổ sung/cập nhật tài liệu BA)
3. Tuân thủ **Quy chuẩn Định dạng & Nguyên tắc Nghiệp vụ**:
   * Mọi yêu cầu mới phải được đánh mã số theo chuẩn (`BR-xxx`, `FR-xxx`, `NFR-xxx`).
   * Không đưa thông tin mật khẩu hoặc bí mật nhạy cảm lên Git.
   * Tất cả sơ đồ mới phải sử dụng định dạng **Mermaid**.
4. Tạo **Pull Request (PR)** mô tả rõ ràng bài toán kinh doanh và các thay đổi kỹ thuật.

---

## 2. QUY CHUẨN COMMIT MESSAGE

Sử dụng định dạng Conventional Commits:
* `docs: update Business Data Dictionary with Nullable userID`
* `feat: implement AdminCakeServlet for product management`
* `fix: add shipping fee to totalAmount in PaymentServlet`
* `test: add unit test cases for inventory reservation`
