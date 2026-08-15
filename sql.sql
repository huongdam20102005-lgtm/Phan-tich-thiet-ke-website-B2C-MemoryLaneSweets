--------------------------------------------
----------------------------------------
-- Tạo Database mới---------------
CREATE DATABASE WebBanBanhDB;
GO
USE WebBanBanhDB;
GO
----------------------------------------------------------
-- 1. Bảng Users (Khách hàng / tài khoản người dùng)
----------------------------------------------------------
CREATE TABLE Users (
userID INT PRIMARY KEY IDENTITY(1,1),
fullName NVARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE, -- Email phải là duy nhất
password VARCHAR(100) NOT NULL,
phone VARCHAR(15) UNIQUE, -- Số điện thoại phải là duy nhất
address NVARCHAR(200),
role VARCHAR(20) NOT NULL CHECK (role IN ('admin', 'user')), -- Chỉ cho phép 2 vai trò
createdAt DATETIME DEFAULT GETDATE()
);
GO
----------------------------------------------------------
-- 2. Bảng CakeCategories (Danh mục bánh)
----------------------------------------------------------
CREATE TABLE CakeCategories (
categoryID INT PRIMARY KEY IDENTITY(1,1),
categoryName NVARCHAR(100) NOT NULL UNIQUE, -- Tên danh mục là duy nhất
description NVARCHAR(200)
);
GO
----------------------------------------------------------
-- 3. Bảng Cakes (Sản phẩm bánh)
----------------------------------------------------------
CREATE TABLE Cakes (
cakeID INT PRIMARY KEY IDENTITY(1,1),
cakeName NVARCHAR(100) NOT NULL,
categoryID INT NOT NULL,
price DECIMAL(18,0) NOT NULL CHECK (price >= 0),
quantity INT NOT NULL CHECK (quantity >= 0),
imageURL VARCHAR(255),
description NVARCHAR(MAX),
createdAt DATETIME DEFAULT GETDATE(),

-- Khóa ngoại liên kết với Bảng CakeCategories
FOREIGN KEY (categoryID) REFERENCES CakeCategories(categoryID)
);
GO
----------------------------------------------------------
-- 4. Bảng Orders (Đơn hàng)
----------------------------------------------------------
CREATE TABLE Orders (
orderID INT PRIMARY KEY IDENTITY(1,1),
userID INT NOT NULL,
orderDate DATETIME DEFAULT GETDATE(),
status NVARCHAR(50) NOT NULL, -- Trạng thái đơn hàng (Chờ xác nhận, Đang giao, Hoàn tất...)
totalAmount DECIMAL(18,0) NOT NULL CHECK (totalAmount >= 0),
address NVARCHAR(200) NOT NULL,
paymentMethod NVARCHAR(50) NOT NULL, -- Hình thức thanh toán (COD, Momo, Thẻ...)

-- Khóa ngoại liên kết với Bảng Users
FOREIGN KEY (userID) REFERENCES Users(userID)
);
GO
----------------------------------------------------------
-- 5. Bảng OrderDetails (Chi tiết đơn hàng)
----------------------------------------------------------
CREATE TABLE OrderDetails (
orderDetailID INT PRIMARY KEY IDENTITY(1,1),
orderID INT NOT NULL,
cakeID INT NOT NULL,
quantity INT NOT NULL CHECK (quantity > 0),
unitPrice DECIMAL(18,0) NOT NULL CHECK (unitPrice >= 0), -- Giá tại thời điểm mua

-- Khóa ngoại liên kết với Bảng Orders
FOREIGN KEY (orderID) REFERENCES Orders(orderID),
-- Khóa ngoại liên kết với Bảng Cakes
FOREIGN KEY (cakeID) REFERENCES Cakes(cakeID),
-- Ràng buộc: Mỗi bánh chỉ xuất hiện 1 lần trong 1 đơn hàng
UNIQUE (orderID, cakeID)
);
GO
----------------------------------------------------------
-- 6. Bảng Reviews (Đánh giá sản phẩm)
----------------------------------------------------------
CREATE TABLE Reviews (
reviewID INT PRIMARY KEY IDENTITY(1,1),
userID INT NOT NULL,
cakeID INT NOT NULL,
rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5), -- Ràng buộc 1-5 sao
comment NVARCHAR(500),
createdAt DATETIME DEFAULT GETDATE(),
status VARCHAR(20) NOT NULL CHECK (status IN ('active', 'pending', 'hidden')), -- Trạng thái hiển thị


-- Khóa ngoại liên kết với Bảng Users
FOREIGN KEY (userID) REFERENCES Users(userID),
-- Khóa ngoại liên kết với Bảng Cakes
FOREIGN KEY (cakeID) REFERENCES Cakes(cakeID),
-- Ràng buộc: Mỗi người dùng chỉ đánh giá 1 bánh 1 lần (tùy chọn)
UNIQUE (userID, cakeID)
);
GO
-----------------------------------------------------------------------------------------
-----------------------Dữ Liệu -------------------------------------------------------------

USE WebBanBanhDB;

-- 1. Thêm Danh mục
INSERT INTO CakeCategories (categoryName, description) VALUES 
(N'Bánh Ngọt', N'Các loại bánh ngọt truyền thống và hiện đại'),
(N'Bánh Sinh Nhật', N'Các mẫu bánh kem cho tiệc sinh nhật'),
(N'Bánh Mặn', N'Các loại bánh mỳ, bánh cuộn mặn'),
(N'Cookie & Minicakes', N'Các loại bánh quy và bánh nhỏ');


-- 2. Thêm Sản phẩm (Giả định ID Danh mục 1: Ngọt, 2: Sinh Nhật, 3: Mặn)
INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description) VALUES
(N'Chocolate Christmas log', 2, 340000.00, 15, 'chocolate_log.jpg', N'Bánh khúc cây sô cô la đậm đà.'),
(N'Tiramisu Cake', 1, 295000.00, 20, 'tiramisu.jpg', N'Bánh Tiramisu Ý truyền thống.'),
(N'Hawaii Mouse', 1, 280000.00, 10, 'hawaii_mouse.jpg', N'Bánh mousse vị nhiệt đới.'),
(N'Bánh Hamburger', 3, 50000.00, 100, 'hamburger.jpg', N'Hamburger nhân thịt bò, phô mai.'),
(N'Bánh Croissant đông lạnh', 3, 15000.00, 200, 'croissant.jpg', N'Bánh sừng bò Pháp, đóng gói đông lạnh.'),
(N'Bánh Khoai Lang', 3, 17000.00, 80, 'banh_khoai_lang.jpg', N'Bánh khoai lang nướng thơm ngon.');


-- 3. Thêm User mẫu (Dùng để tạo đơn hàng)
INSERT INTO Users (fullName, email, password, phone, address, role) 
VALUES (N'Khách Hàng Mẫu', 'test@example.com', '123456', '0901234567', N'123 Đường ABC', 'user');

-- Giả sử UserID của Khách Hàng Mẫu là 1 (Nếu ID tự tăng)
DECLARE @UserID INT = 1;
-- Giả sử CakeID của Tiramisu là 2, Bánh Khoai Lang là 6

-- Lấy OrderID vừa tạo
DECLARE @OrderID INT = SCOPE_IDENTITY(); 

----------------------------------------------------------------------------------------

-- Thêm tài khoản Admin
INSERT INTO Users (fullName, email, password, phone, address, role)
VALUES (N'Quản Trị Viên', 'admin@dino.com', 'admin123', '0901234568', N'123 Đường Admin, Hà Nội', 'admin');

-- Thêm tài khoản Khách hàng
INSERT INTO Users (fullName, email, password, phone, address, role)
VALUES (N'Nguyễn Văn A', 'khachhang@email.com', 'user123', '0912345679', N'456 Đường Khách, HCM', 'user');
GO


-- Bánh Sinh Nhật (categoryID = 2)
INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description)
VALUES (N'Bánh Kem Dâu Tây', 2, 450000.00, 15, 'banh_kem_dau.jpg', N'Bánh kem tươi vị dâu tây ngọt ngào, trang trí sang trọng.');

INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description)
VALUES (N'Bánh Mousse Chocolate', 2, 380000.00, 10, 'mousse_chocolate.jpg', N'Mousse chocolate đen đậm vị, mềm mịn tan chảy.');

-- Bánh Ngọt (categoryID = 1)
INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description)
VALUES (N'Tiramisu Truyền Thống', 1, 120000.00, 25, 'tiramisu.jpg', N'Bánh Tiramisu cổ điển với hương cà phê và phô mai Mascarpone.');

INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description)
VALUES (N'Croissant Bơ', 1, 35000.00, 50, 'croissant_bo.jpg', N'Bánh sừng bò Pháp làm từ bơ nhập khẩu, thơm giòn.');

-- Bánh Mặn (categoryID = 3)
INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description)
VALUES (N'Bánh Mì Kẹp Thịt', 3, 55000.00, 30, 'banh_mi_thit.jpg', N'Bánh mì mềm nhân thịt heo quay và rau củ tươi.');

-- Cookie & Minicakes (categoryID = 4)
INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description)
VALUES (N'Cookie Yến Mạch', 4, 25000.00, 80, 'cookie_yen_mach.jpg', N'Bánh cookie yến mạch nguyên hạt, tốt cho sức khỏe.');

INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description)
VALUES (N'Red Velvet Cupcake', 4, 45000.00, 40, 'red_velvet.jpg', N'Cupcake Red Velvet phủ kem phô mai.');
GO

-- Khách hàng thường
INSERT INTO Users (fullName, email, password, phone, address, role) VALUES 
(N'Lê Thị B', 'lethib@email.com', 'pass123', '0919123456', N'20 Trần Hưng Đạo, Hà Nội', 'user'),
(N'Trần Văn C', 'tranvanc@email.com', 'pass123', '0908765432', N'88 Phạm Văn Đồng, TP.HCM', 'user'),
(N'Phạm Gia D', 'phamd@email.com', 'pass123', '0977654321', N'Lô 10 Nguyễn Trãi, Đà Nẵng', 'user'),
(N'Hoàng Mai E', 'hoangmai.e@email.com', 'pass123', '0888999111', N'7K Khu Phố 4, Cần Thơ', 'user');


-- Dữ liệu mới cho BÁNH NGỌT (Category ID 1)
INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description, createdAt) VALUES 
(N'Bánh Tart Trái Cây', 1, 95000.00, 35, 'tart_trai_cay.jpg', N'Bánh tart giòn, nhân kem phô mai và trái cây tươi.', GETDATE()),
(N'Bánh Chuối Nướng', 1, 70000.00, 20, 'banh_chuoi.jpg', N'Bánh chuối nướng mềm ẩm, vị quế ấm áp.', DATEADD(day, -2, GETDATE())),
(N'Bánh Flan Caramel', 1, 40000.00, 75, 'flan_caramel.jpg', N'Bánh flan truyền thống với caramel đậm đà.', DATEADD(hour, -10, GETDATE())),
(N'Bánh Táo Cinnamon', 1, 85000.00, 22, 'banh_tao.jpg', N'Bánh táo nướng kiểu Mỹ, thơm mùi quế.', DATEADD(day, -5, GETDATE())),
(N'Scones Truyền Thống', 1, 45000.00, 30, 'scones.jpg', N'Bánh scones ăn kèm kem clotted cream và mứt.', DATEADD(day, -6, GETDATE()));


-- Dữ liệu mới cho BÁNH SINH NHẬT (Category ID 2)
INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description, createdAt) VALUES 
(N'Bánh Kem Bắp', 2, 420000.00, 12, 'banh_kem_bap.jpg', N'Bánh kem với nhân bắp ngọt, là best-seller của cửa hàng.', DATEADD(day, -1, GETDATE())),
(N'Bánh Phô Mai Chanh Leo', 2, 390000.00, 8, 'pho_mai_chanh_leo.jpg', N'Bánh phô mai nướng vị chanh leo chua ngọt hài hòa.', GETDATE()),
(N'Bánh Mousse Xoài', 2, 350000.00, 18, 'mousse_xoai.jpg', N'Mousse xoài tươi mát, hoàn hảo cho mùa hè.', DATEADD(day, -3, GETDATE())),
(N'Bánh Kem Tiệc 2 Tầng', 2, 850000.00, 5, 'banh_2_tang.jpg', N'Bánh kem 2 tầng cỡ lớn, thích hợp cho sự kiện.', GETDATE());


-- Dữ liệu mới cho BÁNH MẶN (Category ID 3)
INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description, createdAt) VALUES 
(N'Pizza Mini Rau Củ', 3, 60000.00, 45, 'pizza_mini.jpg', N'Pizza cỡ nhỏ với đế mỏng giòn và nhiều rau củ.', DATEADD(hour, -5, GETDATE())),
(N'Bánh Pâté Chaud', 3, 20000.00, 100, 'pate_chaud.jpg', N'Bánh Pâté Chaud ngàn lớp giòn rụm.', GETDATE()),
(N'Bánh Mì Sandwich Đen', 3, 40000.00, 50, 'sandwich_den.jpg', N'Bánh mì sandwich nguyên cám, giàu dinh dưỡng.', DATEADD(day, -4, GETDATE()));


-- Dữ liệu mới cho COOKIE & MINICAKES (Category ID 4)
INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description, createdAt) VALUES 
(N'Macaron Mix Vị', 4, 150000.00, 60, 'macaron_mix.jpg', N'Hộp 10 macaron nhiều màu sắc và hương vị.', GETDATE()),
(N'Bánh Trung Thu Hiện Đại', 4, 180000.00, 50, 'banh_trung_thu.jpg', N'Bánh trung thu nhân mới lạ (lava, trứng muối).', DATEADD(day, -7, GETDATE())),
(N'Brownie Hạt Óc Chó', 4, 50000.00, 40, 'brownie_oc_cho.jpg', N'Bánh brownie đậm đặc chocolate và hạt óc chó.', DATEADD(day, -1, GETDATE()));
GO

-- Dữ liệu bổ sung cho BÁNH NGỌT (Category ID 1)
INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description, createdAt) VALUES 
(N'Pancake Syrup Mật Ong', 1, 65000.00, 40, 'pancake_mat_ong.jpg', N'Bánh pancake mềm, ăn kèm mật ong tự nhiên.', DATEADD(day, -8, GETDATE())),
(N'Donut Phủ Đường', 1, 20000.00, 150, 'donut_duong.jpg', N'Donut cổ điển, rắc đường bột.', DATEADD(day, -9, GETDATE())),
(N'Éclair Chocolate', 1, 75000.00, 30, 'eclair_choco.jpg', N'Bánh Éclair nhân kem chocolate.', DATEADD(day, -10, GETDATE())),
(N'Muffin Việt Quất', 1, 40000.00, 60, 'muffin_viet_quat.jpg', N'Bánh muffin với nhân mứt việt quất.', DATEADD(day, -11, GETDATE()));


-- Dữ liệu bổ sung cho BÁNH SINH NHẬT (Category ID 2)
INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description, createdAt) VALUES 
(N'Bánh Black Forest', 2, 480000.00, 9, 'black_forest.jpg', N'Bánh kem Black Forest truyền thống.', DATEADD(day, -12, GETDATE())),
(N'Bánh Red Velvet Cao Cấp', 2, 520000.00, 7, 'red_velvet_cake.jpg', N'Bánh Red Velvet cỡ lớn, kem phô mai đặc biệt.', DATEADD(day, -13, GETDATE())),
(N'Bánh Mousse Trà Xanh', 2, 360000.00, 11, 'mousse_tra_xanh.jpg', N'Mousse vị trà xanh thanh mát, ít ngọt.', DATEADD(day, -14, GETDATE())),
(N'Bánh Sinh Nhật Cho Bé', 2, 300000.00, 15, 'banh_sn_be.jpg', N'Bánh kem với hình vẽ hoạt hình đáng yêu.', DATEADD(day, -15, GETDATE()));


-- Dữ liệu bổ sung cho BÁNH MẶN (Category ID 3)
INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description, createdAt) VALUES 
(N'Bánh Mì Bơ Tỏi Phô Mai', 3, 45000.00, 70, 'banh_bo_toi.jpg', N'Bánh mì nướng bơ tỏi và phô mai Mozzarella.', DATEADD(day, -16, GETDATE())),
(N'Bánh Hamburger Mini', 3, 30000.00, 120, 'hamburger_mini.jpg', N'Hamburger cỡ nhỏ, nhân bò và rau tươi.', DATEADD(day, -17, GETDATE())),
(N'Bánh Cuộn Xúc Xích', 3, 35000.00, 90, 'banh_cuon_xuc_xich.jpg', N'Bánh mì cuộn xúc xích nướng.', DATEADD(day, -18, GETDATE())),
(N'Focaccia Dầu Ô Liu', 3, 50000.00, 55, 'focaccia.jpg', N'Bánh Focaccia kiểu Ý với dầu ô liu và hương thảo.', DATEADD(day, -19, GETDATE()));


-- Dữ liệu bổ sung cho COOKIE & MINICAKES (Category ID 4)
INSERT INTO Cakes (cakeName, categoryID, price, quantity, imageURL, description, createdAt) VALUES 
(N'Cookie Chocolate Chip', 4, 25000.00, 180, 'cookie_chip.jpg', N'Cookie giòn với chocolate chip.', DATEADD(day, -20, GETDATE())),
(N'Bánh Quy Bơ Dừa', 4, 30000.00, 100, 'banh_quy_dua.jpg', N'Bánh quy bơ với dừa sấy.', DATEADD(day, -21, GETDATE())),
(N'Mini Cheesecake', 4, 60000.00, 50, 'mini_cheesecake.jpg', N'Phô mai nướng cỡ nhỏ.', DATEADD(day, -22, GETDATE()));
GO

-- Thêm 5 đơn hàng mới
INSERT INTO Orders (userID, status, totalAmount, address, paymentMethod) VALUES 
(3, N'Hoàn tất', 320000.00, N'20 Trần Hưng Đạo, Hà Nội', N'Chuyển khoản'), -- Order 7
(4, N'Đã giao hàng', 455000.00, N'88 Phạm Văn Đồng, TP.HCM', N'COD'),         -- Order 8
(5, N'Hoàn tất', 1000000.00, N'Lô 10 Nguyễn Trãi, Đà Nẵng', N'Thẻ Tín dụng'), -- Order 9
(6, N'Đã giao hàng', 650000.00, N'7K Khu Phố 4, Cần Thơ', N'COD'),            -- Order 10
(2, N'Hoàn tất', 785000.00, N'456 Đường Khách, HCM', N'Chuyển khoản');       -- Order 11
GO

UPDATE CakeCategories
SET categoryName = 'BANH_NGOT'
WHERE categoryName = N'BÁNH NGỌT'; -- Giả sử tên cũ là có dấu và dùng N''

UPDATE CakeCategories
SET categoryName = 'BANH_SINH_NHAT'
WHERE categoryName = N'BÁNH SINH NHẬT';

UPDATE CakeCategories
SET categoryName = 'BANH_MAN'
WHERE categoryName = N'BÁNH MẶN';

-- Giữ nguyên tên này vì nó đã được encode tốt trong URL
UPDATE CakeCategories
SET categoryName = 'COOKIE_MINICAKES' -- Thay & bằng _
WHERE categoryName = N'COOKIE & MINICAKES'; 
GO

-- Có thể thêm một admin khác nữa
INSERT INTO Users (fullName, email, password, phone, address, role)
VALUES (N'Trần Thị B (Admin)', 'admin_b@example.com', 'admin_password_456', '0987654321', N'Số 456, Đường XYZ, Quận 3, TP. HCM', 'admin');

-- Thêm một người dùng thường (user) để kiểm tra thêm
INSERT INTO Users (fullName, email, password, phone, address, role)
VALUES (N'Lê Văn C (User)', 'user_c@example.com', 'user_password_789', '0912345678', N'Số 789, Đường DEF, TP. Hà Nội', 'user');

UPDATE CakeCategories SET categoryName = N'Bánh ngọt' WHERE categoryID = 1;
UPDATE CakeCategories SET categoryName = N'Bánh sinh nhật' WHERE categoryID = 2;
UPDATE CakeCategories SET categoryName = N'Bánh mặn' WHERE categoryID = 3;
UPDATE CakeCategories SET categoryName = N'Cookie & Minicakes' WHERE categoryID = 4;

------ Tìm mã 
SELECT name
FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('Orders');
SELECT fk.name AS constraint_name, 
       tp.name AS parent_table, 
       ref.name AS referenced_table
FROM sys.foreign_keys fk
JOIN sys.tables tp ON fk.parent_object_id = tp.object_id
JOIN sys.tables ref ON fk.referenced_object_id = ref.object_id
WHERE tp.name = 'Orders';

ALTER TABLE Orders DROP CONSTRAINT FK__Orders__userID__395884C4;----- mã này điền từ kết quả FK trước 
ALTER TABLE Orders ALTER COLUMN userID INT NULL;

-- Xoá dữ liệu chi tiết đơn hàng trước
DELETE FROM OrderDetails;

-- Sau đó xoá dữ liệu đơn hàng
DELETE FROM Orders;

select * from [dbo].[CakeCategories];
select * from[dbo].[Cakes];
select * from[dbo].[OrderDetails];
select * from[dbo].[Orders];
select * from[dbo].[Reviews];
select * from[dbo].[Users]

