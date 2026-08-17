# ĐÁNH GIÁ NĂNG LỰC & ĐIỂM NHẤN PORTFOLIO BA (BA PORTFOLIO HIGHLIGHTS)

> **Mã tài liệu**: `DOC-ANA-02`  
> **Dự án**: Website Bán Bánh Ngọt B2C (Memory Lane Sweets)  

Tài liệu này tổng hợp và đánh giá khách quan các hoạt động phân tích nghiệp vụ (BA Activities) có **bằng chứng thực tế (Evidence)** trong toàn bộ dự án, khẳng định giá trị của dự án như một **Hồ sơ Năng lực (BA Portfolio)** chuyên nghiệp.

---

## BẢNG ĐÁNH GIÁ NĂNG LỰC PHÂN TÍCH NGHIỆP VỤ (BA COMPETENCY MATRIX)

| STT | Nhóm năng lực BA (BA Competency) | Trạng thái Bằng chứng (Evidence Status) | Minh chứng Cụ thể Trong Dự án (Evidence Details & Artifacts) |
| :--- | :--- | :--- | :--- |
| 1 | **Requirement Elicitation (Khai thác & Khảo sát Yêu cầu)** | `Evidence found` | Đã tiến hành khảo sát quy trình bán bánh thực tế, nghiên cứu các mô hình đối thủ cạnh tranh (Nguyễn Sơn Bakery, ShopeeFood) để bóc tách nhu cầu đặc thù của ngành bánh: hạn sử dụng ngắn trong ngày, kiểm soát tồn kho theo thời gian thực, đặt ghi chú trên bánh. *(Minh chứng: Mục 1.2, 2.3 Báo cáo)*. |
| 2 | **Requirement Analysis & Classification (Phân tích & Phân loại Yêu cầu)** | `Evidence found` | Phân loại rõ ràng giữa Yêu cầu Nghiệp vụ (BR-001 đến BR-005), Yêu cầu Chức năng (FR-001 đến FR-016), và Yêu cầu Phi chức năng (Usability 5-click, Performance sub-2s, Data Integrity, Scalability, Architecture MVC). *(Minh chứng: Mục 3.1 Báo cáo, `docs/02-requirements/`)*. |
| 3 | **Process Modeling & UML (Mô hình hóa Quy trình Nghiệp vụ)** | `Evidence found` | Khai thác 14 sơ đồ hoạt động (Activity Diagrams) và 7 sơ đồ Use Case từ tài liệu thiết kế hệ thống gốc, kết hợp xây dựng 8 sơ đồ trực quan hóa Mermaid (Sequence, Flowchart, ERD, State Diagram) trong `docs/` mô tả rạch ròi ranh giới tương tác giữa Actor và System. *(Minh chứng: Mục 3.2 Báo cáo, `docs/03-process/`)*. |
| 4 | **Stakeholder Analysis (Phân tích Các bên Liên quan)** | `Evidence found` | Nhận diện và phân loại chi tiết các nhóm Stakeholder: Khách vãng lai, Khách thành viên, Quản trị viên, Đơn vị vận chuyển, Database Engine, Web Server và Nhóm phát triển. *(Minh chứng: `docs/01-business/02-stakeholder-analysis.md`)*. |
| 5 | **Business Rules Definition (Thiết lập Quy tắc Nghiệp vụ)** | `Evidence found` | Định nghĩa và đặc tả chặt chẽ các quy tắc nghiệp vụ quan trọng: Kiểm soát vượt tồn kho (`BR-STK-01`), Tự động trừ kho khi đặt hàng (`BR-STK-02`), Phí vận chuyển 20.000đ (`BR-SHP-01`), Phân khúc giá bộ lọc (`BR-PRC-01`). *(Minh chứng: `docs/01-business/03-business-rules.md`)*. |
| 6 | **Functional Specification (Đặc tả Chi tiết Chức năng)** | `Evidence found` | Xây dựng Bản đồ tính năng (Feature Map F001 - F013) liên kết từ mục tiêu kinh doanh đến giao diện và controller xử lý. *(Minh chứng: `docs/04-functional/01-feature-module-map.md`)*. |
| 7 | **User Stories & Acceptance Criteria (Đặc tả Agile & Tiêu chí Chấp nhận)** | `Evidence found (Derived)` | Xây dựng bộ User Story chuẩn Agile kèm bộ Tiêu chí Chấp nhận (Acceptance Criteria) được kiểm chứng qua bộ 27 test case và mã nguồn kiểm tra điều kiện. *(Minh chứng: `docs/02-requirements/04-user-stories-and-use-cases.md`)*. |
| 8 | **Data Analysis & Modeling (Phân tích & Thiết kế Dữ liệu)** | `Evidence found` | Thiết kế CSDL quan hệ chuẩn hóa 3NF gồm 6 bảng liên kết, sử dụng kiểu `DECIMAL(18,0)` cho tiền tệ, ràng buộc `CHECK`, `UNIQUE`, xây dựng Từ điển Dữ liệu (Data Dictionary) và Sơ đồ ERD. *(Minh chứng: `docs/05-data/`, `sql.sql`)*. |
| 9 | **API & System Context Analysis (Phân tích Kiến trúc & Tích hợp)** | `Evidence found` | Thiết kế mô hình kiến trúc 3 tầng (Three-tier Architecture), luồng điều phối MVC, URL Patterns có cấu trúc và sơ đồ ngữ cảnh hệ thống (System Context Diagram). *(Minh chứng: `docs/06-integration/01-system-context-and-architecture.md`)*. |
| 10 | **UAT & Test Case Design (Thiết kế Kịch bản Kiểm thử & UAT)** | `Evidence found` | Thiết kế bộ 27 test cases chi tiết gồm 2 phân hệ (Khách hàng: 16 test cases, Admin: 11 test cases) với đầy đủ Preconditions, Test Data, Steps, Expected & Actual Results. *(Minh chứng: `test case.xlsx`, `docs/07-testing/`)*. |
| 11 | **Requirement Traceability Matrix (Ma trận Truy vết Yêu cầu)** | `Evidence newly constructed` | Xây dựng chuỗi ma trận truy vết 10 cấp độ (10-level requirements-to-implementation traceability chain) từ BR $\rightarrow$ UR $\rightarrow$ FR $\rightarrow$ US/UC $\rightarrow$ Rule $\rightarrow$ Feature $\rightarrow$ UI $\rightarrow$ Servlet $\rightarrow$ Code $\rightarrow$ Status, đánh dấu rõ ràng các điểm Complete và Gap. *(Minh chứng: `docs/08-traceability/`)*. |
| 12 | **Gap Analysis & Critical Thinking (Phân tích Khoảng trống & Tư duy Phản biện)** | `Evidence newly constructed` | Bóc tách chính xác 4 nhóm chênh lệch (A, B, C, D), phát hiện mâu thuẫn kỹ thuật giữa ràng buộc NOT NULL của CSDL và luồng mua hàng vãng lai (Guest Checkout). *(Minh chứng: `docs/09-analysis/01-gap-analysis.md`)*. |

---

## TỔNG KẾT GIÁ TRỊ PORTFOLIO

Demonstrates end-to-end Business Analysis and System Analysis capabilities through requirements analysis, business rules, functional requirements, user stories, use cases, acceptance criteria, process modeling, system analysis, traceability, and testing artifacts:
* Khả năng **chuyển hóa bài toán kinh doanh thành đặc tả hệ thống** chính xác và khả thi.
* Tư duy **kiểm soát quy tắc nghiệp vụ và toàn vẹn dữ liệu** chặt chẽ.
* Năng lực **mô hình hóa trực quan bằng chuẩn quốc tế** (UML, Mermaid, BPMN, ERD, RTM).
* Kỹ năng **đối soát, phản biện và phân tích khoảng trống (Gap Analysis)** giữa tài liệu thiết kế và mã nguồn thực tế.

