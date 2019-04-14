USE QL_DeAn

-- 34. Với mỗi đề án, cho biết tên đề án và số lượng công việc của đề án này.
SELECT D.TENDA, COUNT(C.TEN_CONG_VIEC) AS SoLuongCongViec
FROM DEAN D, CONGVIEC C
WHERE D.MADA = C.MADA
GROUP BY D.TENDA

-- 35. Với mỗi công việc trong đề án có mã đề án là 30, cho biết số lượng
--     nhân viên được phân công .
SELECT C.TEN_CONG_VIEC, COUNT(P.MA_NVIEN) AS SO_NVIEN
FROM CONGVIEC C, PHANCONG P
WHERE C.MADA = P.MADA AND C.STT = P.STT AND C.MADA = 30
GROUP BY C.TEN_CONG_VIEC

--36. Với mỗi công việc trong đề án có tên đề án là 'Dao Tao', cho biết số
--    lượng nhân viên được phân công.
SELECT C.TEN_CONG_VIEC, COUNT(P.MA_NVIEN) AS SO_NVIEN
FROM DEAN D, CONGVIEC C, PHANCONG P
WHERE D.MADA = C.MADA AND C.MADA = P.MADA AND C.STT = P.STT 
	  AND D.TENDA LIKE N'%Đào tạo%'
GROUP BY C.TEN_CONG_VIEC

-- PHẦN 04 - TRUY VẤN LỒNG VÀ GOM NHÓM
-- 37. Cho biết danh sách các đề án (MADA) có: nhân công với họ (HONV) là
--     'Nguyễn' hoặc có người trưởng phòng chủ trì đề án với họ (HONV) là 'Nguyễn'.
SELECT DE.MADA, DE.TENDA
FROM DEAN DE
WHERE DE.MADA IN (SELECT D.MADA
					FROM DEAN D, CONGVIEC C, PHANCONG P, NHANVIEN N
					WHERE D.MADA = C.MADA AND C.MADA = P.MADA AND C.STT = P.STT AND P.MA_NVIEN = N.MANV
					AND N.HONV = N'Nguyễn')
	  OR
	  DE.MADA IN (SELECT D.MADA
					FROM DEAN D, PHONGBAN PH, NHANVIEN N
					WHERE D.PHONG = PH.MAPHG AND PH.TRPHG = N.MANV AND N.HONV = N'Nguyễn')

-- 38. Danh sách những nhân viên (HONV, TENLOT, TENNV) có trên 2 thân nhân.
SELECT N.HONV, N.TENLOT, N.TENNV --COUNT(T.TENTN)
FROM NHANVIEN N, THANNHAN T
WHERE N.MANV = T.MA_NVIEN
GROUP BY N.HONV, N.TENLOT, N.TENNV
HAVING COUNT(T.TENTN) > 2

-- 39. Danh sách những nhân viên (HONV, TENLOT, TENNV) không có thân nhân nào.
SELECT NV.HONV, NV.TENLOT, NV.TENNV
FROM NHANVIEN NV
WHERE NV.MANV NOT IN (SELECT N.MANV
						FROM NHANVIEN N, THANNHAN T
						WHERE N.MANV = T.MA_NVIEN)

-- 40. Danh sách những trưởng phòng (HONV, TENLOT, TENNV) có tối thiểu một thân nhân.
SELECT N.HONV, N.TENLOT, N.TENNV
FROM PHONGBAN P, NHANVIEN N, THANNHAN T
WHERE P.TRPHG = N.MANV AND N.MANV = T.MA_NVIEN
GROUP BY N.HONV, N.TENLOT, N.TENNV

-- 41. Tìm họ (HONV) của những trưởng phòng chưa có gia đình.
SELECT NV.HONV, NV.TENLOT, NV.TENNV
FROM PHONGBAN PH, NHANVIEN NV
WHERE PH.TRPHG = NV.MANV AND NV.MANV NOT IN (SELECT N.MANV
												FROM PHONGBAN P, NHANVIEN N, THANNHAN T
												WHERE P.TRPHG = N.MANV AND N.MANV = T.MA_NVIEN
												GROUP BY N.MANV)

-- 42. Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên
--     mức lương trung bình của phòng "Nghiên cứu"
SELECT NV.HONV, NV.TENLOT, NV.TENNV
FROM NHANVIEN NV
WHERE NV.LUONG > (SELECT AVG(N.LUONG)
					FROM PHONGBAN P, NHANVIEN N
					WHERE P.MAPHG = N.PHG AND P.TENPHG = N'Nghiên cứu'
					GROUP BY P.MAPHG)

-- 43. Cho biết tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất.
SELECT TOP(1) P.MAPHG, TP.HONV, TP.TENLOT, TP.TENNV, COUNT(N.MANV) AS SO_NVIEN
FROM PHONGBAN P, NHANVIEN N, NHANVIEN TP
WHERE P.MAPHG = N.PHG AND TP.MANV = P.TRPHG
GROUP BY P.MAPHG, TP.HONV, TP.TENLOT, TP.TENNV
ORDER BY COUNT(N.MANV) DESC

-- 44. Cho biết danh sách các mã đề án mà nhân viên có mã là 009 chưa làm.
SELECT D.MADA
FROM DEAN D
WHERE D.MADA NOT IN (	SELECT P.MADA
						FROM PHANCONG P
						WHERE P.MA_NVIEN = N'009')

-- 45. Cho biết danh sách các công việc (tên công việc) trong đề án 'Sản
--     phẩm X' mà nhân viên có mã là 009 chưa làm.
SELECT C.TEN_CONG_VIEC
FROM DEAN D, CONGVIEC C
WHERE D.MADA = C.MADA AND D.TENDA = N'Sản phẩm X' 
		AND C.TEN_CONG_VIEC NOT IN ( SELECT C.TEN_CONG_VIEC
										FROM DEAN D, CONGVIEC C, PHANCONG P
										WHERE D.MADA = C.MADA AND C.MADA = P.MADA 
										AND C.STT = P.STT 
										AND D.TENDA = N'Sản phẩm X' 
										AND P.MA_NVIEN = '009')

-- 46. Tìm họ tên (HONV, TENLOT, TENNV) và địa chỉ (DCHI) của những
--     nhân viên làm việc cho một đề án ở 'TP HCM' nhưng phòng ban mà họ
--     trực thuộc lại không tọa lạc ở thành phố 'TP HCM' .
SELECT N.HONV, N.TENLOT, N.TENNV
FROM NHANVIEN N, PHANCONG P, CONGVIEC C, DEAN D
WHERE D.MADA = C.MADA AND C.MADA = P.MADA AND C.STT = P.STT AND P.MA_NVIEN = N.MANV
		AND D.DDIEM_DA = N'TP HCM' 
		AND N.MANV NOT IN (SELECT NV.MANV
							FROM PHONGBAN PH, DIADIEM_PHG DD, NHANVIEN NV
							WHERE NV.PHG = PH.MAPHG AND DD.MAPHG = PH.MAPHG 
							AND DD.DIADIEM = N'TP HCM')
GROUP BY N.HONV, N.TENLOT, N.TENNV



-- 47. Tổng quát câu 46, tìm họ tên và địa chỉ của các nhân viên làm việc cho
--     một đề án ở một thành phố nhưng phòng ban mà họ trực thuộc lại
--     không toạ lạc ở thành phố đó
SELECT N.HONV, N.TENLOT, N.TENNV, D.DDIEM_DA, DD.DIADIEM
FROM NHANVIEN N, PHANCONG P, CONGVIEC C, DEAN D, PHONGBAN PH, DIADIEM_PHG DD
WHERE D.MADA = C.MADA AND C.MADA = P.MADA AND C.STT = P.STT AND P.MA_NVIEN = N.MANV
	AND N.PHG = PH.MAPHG AND DD.MAPHG = PH.MAPHG AND DD.DIADIEM <> D.DDIEM_DA