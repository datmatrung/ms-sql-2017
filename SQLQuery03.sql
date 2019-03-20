CREATE DATABASE QL_SanPham
GO
USE QL_SanPham
GO
CREATE TABLE LoaiTaiKhoan(
	MaLoaiTaiKhoan	INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
	TenLoaiTaiKhoan	NVARCHAR(30) NOT NULL
);
GO
CREATE TABLE LoaiSanPham(
	MaLoaiSanPham	INT PRIMARY KEY NOT NULL IDENTITY(1, 1), 
	TenLoaiSanPham	NVARCHAR(64) NOT NULL,
	BiXoa			BIT NOT NULL
);
GO
CREATE TABLE HangSanXuat(
	MaHangSanXuat	INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
	TenHangSanXuat	NVARCHAR(64) NOT NULL,
	BiXoa			BIT NOT NULL
);
GO
CREATE TABLE TinhTrang(
	MaTinhTrang		INT PRIMARY KEY NOT NULL IDENTITY(1, 1), 
	TenTinhTrang	NVARCHAR(45) NOT NULL
);
GO
CREATE TABLE TaiKhoan(
	MaTaiKhoan		INT PRIMARY KEY NOT NULL IDENTITY(1, 1), 
	TenDangNhap		VARCHAR(30) NOT NULL, 
	MatKhau			VARCHAR(30) NOT NULL, 
	TenHienThi		NVARCHAR(64) NOT NULL, 
	DiaChi			NVARCHAR(256),
	SoDienThoai		VARCHAR(11) NOT NULL,
	Email			VARCHAR(64) NOT NULL, 
	BiXoa			BIT NOT NULL, 
	MaLoaiTaiKhoan	INT NOT NULL,
	CONSTRAINT fk_TaiKhoan_LoaiTaiKhoan FOREIGN KEY (MaLoaiTaiKhoan) REFERENCES LoaiTaiKhoan (MaLoaiTaiKhoan)
);
GO
CREATE TABLE SanPham(
	MaSanPham		INT PRIMARY KEY NOT NULL IDENTITY(1, 1), 
	TenSanPham		NVARCHAR(256) NOT NULL, 
	HinhURL			VARCHAR(256) NOT NULL, 
	GiaSanPham		MONEY NOT NULL, 
	SoLuongTon		INT NOT NULL, 
	SoLuongBan		INT NOT NULL, 
	SoLuocXem		INT NOT NULL, 
	BiXoa			BIT NOT NULL, 
	MaLoaiSanPham	INT NOT NULL, 
	MaHangSanXuat	INT NOT NULL,
	CONSTRAINT fk_SanPham_LoaiSanPham FOREIGN KEY (MaLoaiSanPham) REFERENCES LoaiSanPham (MaLoaiSanPham),
	CONSTRAINT fk_SanPham_HangSanXuat FOREIGN KEY (MaHangSanXuat) REFERENCES HangSanXuat (MaHangSanXuat)
);
GO
CREATE TABLE DonDatHang(
	MaDonDatHang	VARCHAR(9) PRIMARY KEY NOT NULL, 
	NgayLapPhieu	DATETIME NOT NULL, 
	TongThanhTien	INT NOT NULL, 
	MaTaiKhoan		INT NOT NULL, 
	MaTinhTrang		INT NOT NULL,
	CONSTRAINT fk_DonDatHang_TinhTrang FOREIGN KEY (MaTinhTrang) REFERENCES TinhTrang (MaTinhTrang),
	CONSTRAINT fk_DonDatHang_TaiKhoan FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan (MaTaiKhoan)
);
GO
CREATE TABLE ChiTietDonDatHang(
	MaChiTietDonDatHang		VARCHAR(11) PRIMARY KEY NOT NULL, 
	SoLuong					INT NOT NULL, 
	GiaBan					INT NOT NULL, 
	MaDonDatHang			VARCHAR(9) NOT NULL, 
	MaSanPham				INT NOT NULL,
	CONSTRAINT fk_ChiTietDonDatHang_DonDatHang FOREIGN KEY (MaDonDatHang) REFERENCES DonDatHang (MaDonDatHang),
	CONSTRAINT fk_ChiTietDonDatHang_SanPham FOREIGN KEY (MaSanPham) REFERENCES SanPham (MaSanPham)
);
GO
INSERT HangSanXuat (TenHangSanXuat, BiXoa) VALUES
('Revell', 0), ('Lego', 0), ('Lamaze', 0), ('vTech', 0), ('Rastar', 0), ('Syma', 0);
GO
INSERT LoaiSanPham (TenLoaiSanPham, BiXoa) VALUES
(N'Thú nhồi bông', 0), (N'Đồ chơi nhựa', 0), (N'Đồ chơi điện tử', 0), (N'Điều khiển từ xa', 0),
(N'Đồ chơi trí tuệ', 0), (N'Đồ xịn', 0), (N'Đồ dỏm của CHINA', 0);
GO
INSERT LoaiTaiKhoan (TenLoaiTaiKhoan) VALUES ('Admin'), ('User'), ('Customer'), ('Shipper');
GO
INSERT TaiKhoan (TenDangNhap, MatKhau, TenHienThi, DiaChi, SoDienThoai, Email, BiXoa, MaLoaiTaiKhoan) VALUES
('datmatrung', '123456', N'Đạt Ma Trung', N'79 Nguyễn Phúc Chu', '0888888441', 'datmatrung@gmail.com', 0, 1),
('datmathuy', '123456', N'Đạt Ma Thủy', N'79 Nguyễn Phúc Chu', '0888888441', 'datmatrung@gmail.com', 0, 2),
('datmadang', '123456', N'Đạt Ma Đăng', N'79 Nguyễn Phúc Chu', '0888888441', 'datmatrung@gmail.com', 0, 3),
('datmabang', '123456', N'Đạt Ma Băng', N'79 Nguyễn Phúc Chu', '0888888441', 'datmatrung@gmail.com', 0, 4);
GO
INSERT TinhTrang (TenTinhTrang) VALUES (N'Đặt hàng'), (N'Đang giao hàng'), (N'Thanh toán'), (N'Hủy');
GO
INSERT DonDatHang (MaDonDatHang, NgayLapPhieu, TongThanhTien, MaTaiKhoan, MaTinhTrang) VALUES
('081012001', '2012-10-08', 380000, 1, 1),
('081012002', '2012-10-08', 380000, 1, 1),
('081012003', '2012-10-08', 440000, 1, 1),
('131212001', '2012-12-13', 640000, 1, 1),
('131212002', '2012-12-13', 700000, 1, 1);
GO
INSERT [SanPham] (TenSanPham, HinhURL, GiaSanPham, SoLuongTon, SoLuongBan, SoLuocXem, BiXoa, MaLoaiSanPham, MaHangSanXuat) VALUES
('Bill D. Beaver', 'Lamaze_Bill_D_Beaver.jpeg', 160000, 14, 9, 25, 0, 1, 3),
('Captain Calamari', 'Lamaze_Captain_Calamari.jpeg', 180000, 14, 6, 4, 0, 1, 3),
('Elephantunes', 'Lamaze_Elephantunes.jpeg', 480000, 25, 2, 9, 0, 1, 3),
('Freddie the Firefly', 'Lamaze_Freddie_Firefly.jpeg', 300000, 30, 0, 8, 0, 1, 3),
('Supper Mario', 'Lego_Supper_Mario.jpeg', 380000, 24, 6, 14, 0, 5, 2),
('Nasa Academy Space', 'Revell_Academy_Space.jpeg', 220000, 28, 7, 8, 0, 3, 1),
('Lamborghini Revention', 'Revell_Lamborghini_Revention.jpeg', 260000, 38, 3, 38, 0, 3, 1),
('Camaro SS', 'Revell_Camaro_SS.jpeg', 260000, 20, 0, 0, 0, 3, 1),
('Pond Motion Gym', 'Lamaze_Pond_Motion_Gym.jpg', 920000, 10, 2, 14, 0, 1, 3),
('Stacking Rings', 'Lamaze_Stacking_Rings.jpg', 240000, 5, 5, 1, 0, 1, 3),
('Octivity Time', 'Lamaze_Octivity_Time.jpg', 270000, 19, 3, 3, 0, 1, 3),
('Mittens the Kitten', 'Lamaze_Mittens_the_Kitten.jpg', 190000, 50, 3, 5, 0, 1, 3),
('Feel Me Fish', 'Lamaze_Feel_Me_Fish.jpg', 180000, 60, 3, 2, 0, 1, 3),
('Huey the Hedgehog', 'Lamaze_Huey_the_Hedgehog.jpg', 200000, 30, 30, 22, 0, 1, 3),
('Neat-Oh!', 'Lego_Neat_Oh.jpg', 110000, 19, 13, 24, 0, 5, 2),
('Ninjago 2172', 'Lego_Ninjago_2172.jpg', 160000, 20, 12, 13, 0, 5, 2),
('Mexican', 'Lego_Mexican.jpg', 140000, 35, 12, 12, 0, 5, 2),
('Star Wars', 'Lego_Star_Wars.jpg', 500000, 24, 28, 30, 0, 5, 2),
('City Park Cafe 3061', 'Lego_City_Park_Cafe_3061.jpg', 950000, 30, 2, 24, 0, 5, 2),
('Bright Lights Ball', 'Vtech_Bright_Lights_Ball.jpg', 150000, 39, 2, 6, 0, 2, 4),
('Baby''s Laptop', 'Vtech_Baby_Laptop.jpg', 240000, 38, 2, 4, 0, 2, 4),
('Toot Driver Garage', 'Vtech_Toot_Driver_Garage.jpg', 620000, 20, 12, 30, 0, 2, 4),
('Emergency Vehicles (3-Pack)', 'Vtech_Emergency_Vehicles.jpg', 223000, 20, 12, 3, 0, 2, 4),
('Lamborghini Murcielago', 'Rastar_Lamborghini_Murcielago.jpg', 300000, 10, 1, 2, 0, 4, 5),
('Rover Sport HSE', 'Rastar_Rover_Sport_HSE.jpg', 320000, 10, 3, 2, 0, 4, 5),
('Apache Helicopter', 'Syma_Apache_Helicopter.jpg', 625000, 4, 2, 1, 0, 4, 6),
('Micro Helicopter', 'Syma_Micro_Helicopter.jpg', 560000, 2, 6, 5, 0, 4, 6),
('Micro Chinook', 'Syma_ Micro_Chinook.jpg', 410000, 3, 0, 0, 0, 4, 6),
('X1 - 01', 'Syma_x1_01.jpg', 600000, 4, 0, 15, 0, 4, 6);
GO
INSERT ChiTietDonDatHang (MaChiTietDonDatHang, SoLuong, GiaBan, MaDonDatHang, MaSanPham) VALUES 
('08101200100', 4, 260000, '081012001', 11),
('08101200101', 3, 160000, '081012001', 4),
('08101200102', 30, 220000, '081012001', 10),
('08101200103', 1, 380000, '081012001', 9),
('08101200200', 1, 380000, '081012002', 9),
('08101200300', 2, 220000, '081012003', 10),
('13121200100', 4, 160000, '131212001', 4),
('13121200200', 1, 180000, '131212002', 5),
('13121200201', 2, 260000, '131212002', 11);