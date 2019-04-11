USE QL_DeAn
-- PHẦN 03 - TRUY VẤN GOM NHÓM
-- 19. Cho biết số lượng đề án của công ty
SELECT COUNT(MADA) AS SoDeAn
FROM DEAN

-- 20. Cho biết số lượng đề án do phòng 'Nghiên Cứu' chủ trì
SELECT COUNT(MADA) AS SoDeAn
FROM DEAN D, PHONGBAN P
WHERE P.MAPHG = D.PHONG AND P.TENPHG = N'Nghiên Cứu'

-- 21. Cho biết lương trung bình của các nữ nhân viên
SELECT AVG(LUONG) AS LuongTrungBinh
FROM NHANVIEN
WHERE PHAI = N'Nữ'

-- 22. Cho biết số thân nhân của nhân viên 'Đinh Bá Tiến'
SELECT COUNT(T.TENTN) AS SoThanNhan
FROM NHANVIEN N, THANNHAN T
WHERE N.MANV = T.MA_NVIEN AND (N.HONV + ' ' + N.TENLOT + ' ' + N.TENNV) = N'Đinh Bá Tiên'

-- 23. Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của
--     tất cả các nhân viên tham dự đề án đó.
SELECT D.TENDA, SUM(P.THOIGIAN) AS TongThoiGian
FROM DEAN D, CONGVIEC C, PHANCONG P
WHERE D.MADA = C.MADA AND C.MADA = P.MADA AND C.STT = P.STT
GROUP BY D.TENDA

-- 24. Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia đề án đó
SELECT D.TENDA, COUNT(P.MA_NVIEN) AS SoLuongNhanVienThamGia
FROM DEAN D, CONGVIEC C, PHANCONG P
WHERE D.MADA = C.MADA AND C.MADA = P.MADA AND C.STT = P.STT
GROUP BY D.TENDA

-- 25. Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân
--     của nhân viên đó.
SELECT N.HONV, N.TENNV, COUNT(T.TENTN) AS SoThanNhan
FROM NHANVIEN N, THANNHAN T
WHERE N.MANV = MA_NVIEN
GROUP BY N.HONV, N.TENNV 


-- 26. Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà
-- nhân viên đó đã tham gia.
SELECT N.HONV, N.TENNV, COUNT(P.MADA) AS SoDeAn
FROM NHANVIEN N, PHANCONG P
WHERE N.MANV = P.MA_NVIEN
GROUP BY N.HONV, N.TENNV, N.MANV

-- 27. Với mỗi nhân viên, cho biết số lượng nhân viên mà nhân viên đó quản
-- lý trực tiếp.
SELECT Q.MANV, Q.HONV, Q.TENNV, COUNT(N.MANV) AS SoNhanVien
FROM NHANVIEN N, NHANVIEN Q
WHERE Q.MANV = N.MA_NQL
GROUP BY Q.MANV, Q.HONV, Q.TENNV


-- 28. Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của
--     những nhân viên làm việc cho phòng ban đó.
SELECT P.TENPHG, AVG(N.LUONG) AS LUONG_TB
FROM PHONGBAN P, NHANVIEN N
WHERE N.PHG = P.MAPHG
GROUP BY P.TENPHG

-- 29. Với các phòng ban có mức lương trung bình trên 33,000, liệt kê tên
--    phòng ban và số lượng nhân viên của phòng ban đó.
SELECT P.TENPHG, AVG(N.LUONG) AS LUONG_TB, COUNT(N.MANV) AS SOLUONGNV
FROM PHONGBAN P, NHANVIEN N
WHERE N.PHG = P.MAPHG
GROUP BY P.TENPHG
HAVING AVG(N.LUONG) > 33000

-- 30. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà
--     phòng ban đó chủ trì
SELECT P.TENPHG, COUNT(D.MADA) AS SOLUONGDA
FROM PHONGBAN P, DEAN D
WHERE P.MAPHG = D.PHONG
GROUP BY P.TENPHG

-- 31. Với mỗi phòng ban, cho biết tên phòng ban, họ tên người trưởng
--     phòng và số lượng đề án mà phòng ban đó chủ trì
SELECT P.TENPHG, N.HONV + '' + N.TENNV AS TRUONGPHONG, COUNT(D.MADA) AS SOLUONGDA
FROM PHONGBAN P, DEAN D, NHANVIEN N
WHERE P.MAPHG = D.PHONG AND N.MANV = P.TRPHG
GROUP BY P.TENPHG, N.HONV + '' + N.TENNV

-- 32. Với mỗi phòng ban có mức lương trung bình lớn hơn 40,000, cho biết
--     tên phòng ban và số lượng đề án mà phòng ban đó chủ trì.
SELECT P.TENPHG, COUNT(D.MADA) AS SOLUONGDA -- AVG(N.LUONG) AS LUONGTB
FROM PHONGBAN P, DEAN D, NHANVIEN N
WHERE P.MAPHG = D.PHONG AND N.PHG = P.MAPHG
GROUP BY P.TENPHG
HAVING AVG(N.LUONG) > 40000

-- 33. Cho biết số đề án diễn ra tại từng địa điểm
SELECT DDIEM_DA, COUNT(MADA) AS SODEAN
FROM DEAN
GROUP BY DDIEM_DA