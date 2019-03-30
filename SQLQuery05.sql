USE QL_SanPham
GO
UPDATE DonDatHang SET MaTinhTrang = 3
GO
SELECT * FROM DonDatHang

-- 1. Liệt kê danh sách các sản phẩm của datmatrung đã từng mua
--		Thông tin danh sách: MaSanPham, TenSanPham, SoLuong
SELECT s.MaSanPham, s.TenSanPham, t.TenDangNhap, SUM(c.SoLuong) AS SoLuongDaBan
FROM TaiKhoan t, SanPham s, DonDatHang d, ChiTietDonDatHang c
WHERE t.MaTaiKhoan = d.MaTaiKhoan AND d.MaDonDatHang = c.MaDonDatHang
	AND c.MaSanPham = s.MaSanPham AND t.TenDangNhap = 'datmatrung'
	AND d.MaTinhTrang = 3
GROUP BY s.MaSanPham, s.TenSanPham, t.TenDangNhap

-- 2. Đếm số lượng đơn đặt hàng đã từng mua theo Sản phẩm
--		Thông tin danh sách: MaSanPham, TenSanPham, Tổng Số ĐĐH
SELECT s.MaSanPham, s.TenSanPham, COUNT(c.MaDonDatHang) AS TongSoDDH
FROM DonDatHang d, ChiTietDonDatHang c, SanPham s
WHERE d.MaDonDatHang = c.MaDonDatHang AND s.MaSanPham = c.MaSanPham AND d.MaTinhTrang = 3
GROUP BY s.MaSanPham, s.TenSanPham

-- 3. Tính tổng thành tiền theo từng User đã mua hàng
--		Thông tin danh sách: Họ tên đầy đủ, Tổng tiền đã mua
SELECT t.MaTaiKhoan, t.TenDangNhap, t.TenHienThi, SUM(d.TongThanhTien) AS TongTien
FROM TaiKhoan t, DonDatHang d
WHERE t.MaTaiKhoan = d.MaTaiKhoan AND d.MaTinhTrang = 3
GROUP BY t.MaTaiKhoan, t.TenDangNhap, t.TenHienThi

-- 4. Tính tổng đơn đặt hàng theo Loại sản phẩm
--		Thông tin danh sách: MaLoaiSanPham, TenLoaiSanPham, Tổng Số ĐĐH
SELECT l.MaLoaiSanPham, l.TenLoaiSanPham, COUNT(d.MaDonDatHang) AS TongSoDDH
FROM LoaiSanPham l, SanPham s, ChiTietDonDatHang c, DonDatHang d
WHERE l.MaLoaiSanPham = s.MaLoaiSanPham AND s.MaSanPham = c.MaSanPham
	AND c.MaDonDatHang = d.MaDonDatHang AND d.MaTinhTrang = 3
GROUP BY l.MaLoaiSanPham, l.TenLoaiSanPham

-- 5. Tính tổng đơn đặt hàng theo Hãng sản xuất
--	Thông tin danh sách: MaHangSanXuat, TenHangSanXuat, Tổng Số ĐĐH
SELECT h.MaHangSanXuat, h.TenHangSanXuat, COUNT(d.MaDonDatHang) AS TongSoDDH
FROM HangSanXuat h, SanPham s, ChiTietDonDatHang c, DonDatHang d
WHERE h.MaHangSanXuat = s.MaHangSanXuat AND s.MaSanPham = c.MaSanPham
	AND c.MaDonDatHang = d.MaDonDatHang AND d.MaTinhTrang = 3
GROUP BY h.MaHangSanXuat, h.TenHangSanXuat

-- 6. Tính tổng tiền đã bán theo Loại sản phẩm
--		Thông tin danh sách: MaLoaiSanPham, TenLoaiSanPham, Tổng Số tiền
SELECT l.MaLoaiSanPham, l.TenLoaiSanPham, SUM(c.SoLuong * c.GiaBan) AS TongSoTien
FROM LoaiSanPham l, SanPham s, ChiTietDonDatHang c, DonDatHang d
WHERE l.MaLoaiSanPham = s.MaLoaiSanPham AND s.MaSanPham = c.MaSanPham
	AND c.MaDonDatHang = d.MaDonDatHang AND d.MaTinhTrang = 3
GROUP BY l.MaLoaiSanPham, l.TenLoaiSanPham


-- 7. Tính tổng tiền theo Hãng sản xuất
--		Thông tin danh sách: MaHangSanXuat, TenHangSanXuat, Tổng Số tiền
SELECT h.MaHangSanXuat, h.TenHangSanXuat, SUM(c.SoLuong * c.GiaBan) AS TongSoTien
FROM HangSanXuat h, SanPham s, ChiTietDonDatHang c, DonDatHang d
WHERE h.MaHangSanXuat = s.MaHangSanXuat AND s.MaSanPham = c.MaSanPham
	AND c.MaDonDatHang = d.MaDonDatHang AND d.MaTinhTrang = 3
GROUP BY h.MaHangSanXuat, h.TenHangSanXuat


-- 8. Tính tổng doanh thu của toàn hệ thống
SELECT SUM(c.GiaBan * c.SoLuong) AS TongDoanhThu
FROM DonDatHang d, ChiTietDonDatHang c
WHERE d.MaDonDatHang = c.MaDonDatHang
