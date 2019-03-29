USE QL_SanPham;
GO
-- 1. Lấy danh sách các sản phẩm của hãng Lamaze
SELECT s.MaSanPham, s.TenSanPham, s.GiaSanPham, h.TenHangSanXuat
FROM SanPham s, HangSanXuat h
WHERE h.MaHangSanXuat = s.MaHangSanXuat AND h.TenHangSanXuat = 'Lamaze'

-- 2. Lấy danh sách các sản phẩm của hãng có tên bắt đầu bằng chữ 'L'
SELECT s.MaSanPham, s.TenSanPham, s.GiaSanPham, h.TenHangSanXuat
FROM SanPham s, HangSanXuat h
WHERE h.MaHangSanXuat = s.MaHangSanXuat AND h.TenHangSanXuat LIKE 'L%'

-- 3. Lấy danh sách (MaSanPham, TenSanPham, Gia) các sản phẩm có tên tồn tại chữ "a"
SELECT MaSanPham, TenSanPham, GiaSanPham
FROM SanPham
WHERE TenSanPham LIKE '%a%'

-- 4. Lấy danh sách (MaSanPham, TenSanPham, Gia) có giá bán lớn hơn 500000
SELECT MaSanPham, TenSanPham, GiaSanPham
FROM SanPham
WHERE GiaSanPham > 500000

-- 5. Lấy danh sách (MaSanPham, TenSanPham, Gia) có giá bán nhỏ hơn hơn 500k
SELECT MaSanPham, TenSanPham, GiaSanPham
FROM SanPham
WHERE GiaSanPham < 500000

-- 6. Lấy danh sách (MaSanPham, TenSanPham, Gia) có giá bán nhỏ hơn 1tr và lớn hơn hoặc bằng 500k
SELECT MaSanPham, TenSanPham, GiaSanPham
FROM SanPham
WHERE 500000 <= GiaSanPham AND GiaSanPham < 1000000

-- 7. Lấy danh sách (MaSanPham, TenSanPham, Gia) Có giá khác 600000
SELECT MaSanPham, TenSanPham, GiaSanPham
FROM SanPham
WHERE GiaSanPham <> 600000

-- 8. Lấy danh sách (MaSanPham, TenSanPham, Gia) có giá trong khoản 300k đến 600k
SELECT MaSanPham, TenSanPham, GiaSanPham
FROM SanPham
WHERE GiaSanPham BETWEEN 300000 AND 600000

-- 9. Lấy danh sách (MaSanPham, TenSanPham, Gia) có giá thuộc các giá trị sau: 300k, 480k, 600k
SELECT MaSanPham, TenSanPham, GiaSanPham
FROM SanPham
WHERE GiaSanPham IN (300000, 480000, 600000)

-- 10. Lấy danh sách (MaSanPham, TenSanPham, Gia, TenHangSanXuat) không thuộc hãng 'Lamaze' 
SELECT s.MaSanPham, s.TenSanPham, s.GiaSanPham, h.TenHangSanXuat
FROM SanPham s, HangSanXuat h
WHERE s.MaHangSanXuat = h.MaHangSanXuat AND h.TenHangSanXuat <> 'Lamaze'

-- 11. Lấy danh sách (MaSanPham, TenSanPham, Gia, TenHangSanXuat) Thuộc hãng 'Lamaze' và 'Revell'
SELECT s.MaSanPham, s.TenSanPham, s.GiaSanPham, h.TenHangSanXuat
FROM SanPham s, HangSanXuat h
WHERE s.MaHangSanXuat = h.MaHangSanXuat AND (h.TenHangSanXuat = 'Lamaze' OR h.TenHangSanXuat = 'Revell')

SELECT s.MaSanPham, s.TenSanPham, s.GiaSanPham, h.TenHangSanXuat
FROM SanPham s, HangSanXuat h
WHERE s.MaHangSanXuat = h.MaHangSanXuat AND (h.TenHangSanXuat IN ('Lamaze', 'Revell'))

-- 12. Lấy danh sách (MaSanPham, TenSanPham, Gia, TenHangSanXuat) Thuộc hãng 'Lamaze' và có giá bán trên 300k
SELECT s.MaSanPham, s.TenSanPham, s.GiaSanPham, h.TenHangSanXuat
FROM SanPham s, HangSanXuat h
WHERE s.MaHangSanXuat = h.MaHangSanXuat AND h.TenHangSanXuat = 'Lamaze' AND s.GiaSanPham > 300000

-- 13. Lấy danh sách (MaSanPham, TenSanPham, Gia, TenHangSanXuat, TenLoaiSanPham) thuộc hãng 'Lamaze' hoặc thuộc loại 'Đồ chơi điện tử'
SELECT s.MaSanPham, s.TenSanPham, s.GiaSanPham, h.TenHangSanXuat, l.TenLoaiSanPham
FROM SanPham s, HangSanXuat h, LoaiSanPham l
WHERE s.MaHangSanXuat = h.MaHangSanXuat AND s.MaLoaiSanPham = l.MaLoaiSanPham AND (h.TenHangSanXuat = 'Lamaze' OR l.TenLoaiSanPham = N'Đồ chơi điện tử')

-- 14. Lấy danh sách (MaSanPham, TenSanPham, Gia, TenHangSanXuat, TenLoaiSanPham) thuộc loại 'Thú nhồi bông' hoặc có giá bán trên 400k
SELECT s.MaSanPham, s.TenSanPham, s.GiaSanPham, h.TenHangSanXuat, l.TenLoaiSanPham
FROM SanPham s, HangSanXuat h, LoaiSanPham l
WHERE s.MaHangSanXuat = h.MaHangSanXuat AND s.MaLoaiSanPham = l.MaLoaiSanPham AND (l.TenLoaiSanPham = N'Thú nhồi bông' OR s.GiaSanPham > 400000)

-- 15. Lấy danh sách (MaSanPham, TenSanPham, Gia, TenHangSanXuat, TenLoaiSanPham) không thuộc loại 'Thú nhồi bông' mà có giá bán trên 400k
SELECT s.MaSanPham, s.TenSanPham, s.GiaSanPham, h.TenHangSanXuat, l.TenLoaiSanPham
FROM SanPham s, HangSanXuat h, LoaiSanPham l
WHERE s.MaHangSanXuat = h.MaHangSanXuat AND s.MaLoaiSanPham = l.MaLoaiSanPham AND (l.TenLoaiSanPham <> N'Thú nhồi bông' AND s.GiaSanPham > 400000)

-- 16. Lấy danh sách (MaSanPham, TenSanPham, Gia) sắp tăng theo giá bán
SELECT MaSanPham, TenSanPham, GiaSanPham
FROM SanPham
ORDER BY GiaSanPham

-- 17. Lấy danh sách (MaSanPham, TenSanPham, Gia) sắp giảm theo số lượng tồn
SELECT MaSanPham, TenSanPham, GiaSanPham, SoLuongTon
FROM SanPham
ORDER BY SoLuongTon DESC

-- 18. Lấy danh sách (MaSanPham, TenSanPham, Gia) sắp tăng theo giá bán và sắp giảm 
--     theo số lượng tồn
SELECT MaSanPham, TenSanPham, GiaSanPham, SoLuongTon
FROM SanPham
ORDER BY GiaSanPham, SoLuongTon DESC

-- 19. Lấy danh sách (MaSanPham, TenSanPham, Gia) sắp giảm theo giá bán và sắp giảm 
--     theo số lượng bán
SELECT MaSanPham, TenSanPham, GiaSanPham, SoLuongBan
FROM SanPham
ORDER BY GiaSanPham DESC, SoLuongBan DESC

-- 20. Lấy danh sách (TenLoaiSanPham, TongSoLuongTon) 
--	   Tính tổng số lượng tồn của sản phẩm theo từng loại
SELECT l.TenLoaiSanPham, SUM(s.SoLuongTon) AS TongSoLuongTon
FROM SanPham s, LoaiSanPham l
WHERE s.MaLoaiSanPham = l.MaLoaiSanPham
GROUP BY l.TenLoaiSanPham

-- 21. Lấy danh sách (TenHangSanXuat, SoLuongBanTrungBinh)
--     Tính tổng số lượng bán trung bình theo từng hãng
SELECT h.TenHangSanXuat, AVG(s.SoLuongBan) AS TBSoLuongBan
FROM SanPham s, HangSanXuat h
WHERE s.MaHangSanXuat = h.MaHangSanXuat
GROUP BY h.TenHangSanXuat
ORDER BY AVG(s.SoLuongBan)

-- 22. Lấy danh sách (MaSanPham, TenSanPham, Gia) có số lượng bán cao cao nhất
SELECT TOP(1) MaSanPham, TenSanPham, GiaSanPham, SoLuongBan
FROm SanPham
ORDER BY SoLuongBan DESC

-- 21. Lấy danh sách (MaSanPham, TenSanPham, Gia) có số lượng bán chậm nhất
SELECT TOP(1) MaSanPham, TenSanPham, GiaSanPham, SoLuongBan
FROm SanPham
ORDER BY SoLuongBan