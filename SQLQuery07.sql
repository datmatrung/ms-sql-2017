USE QL_DeAn;
-- PHAN 01 - TRUY VẤN ĐƠN GIẢN
-- 1. Tìm các nhân viên làm việc ở phòng số 4
SELECT *
FROM NHANVIEN
WHERE PHG = 4;

-- 2. Tìm các nhân viên có mức lương trên 30000
SELECT *
FROM NHANVIEN
WHERE LUONG > 30000;

-- 3. Tìm các nhân viên có (mức lương trên 25,000 ở phòng 4) hoặc các nhân 
--	  viên có (mức lương trên 30,000 ở phòng 5)
SELECT *
FROM NHANVIEN
WHERE (LUONG > 25000 AND PHG = 4) OR (LUONG > 30000 AND PHG = 5);

-- 4. Cho biết họ tên đầy đủ của các nhân viên ở TP HCM
SELECT HONV + ' ' + TENLOT + ' ' + TENNV AS FULL_NAME, DCHI
FROM NHANVIEN
WHERE DCHI LIKE N'%Tp HCM'

-- 5. Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự 'N'
SELECT HONV + ' ' + TENLOT + ' ' + TENNV AS FULL_NAME
FROM NHANVIEN
WHERE HONV LIKE N'N%'

-- 6. Cho biết ngày sinh và địa chỉ của nhân viên Dinh Ba Tien
SELECT NGSINH, DCHI
FROM NHANVIEN
WHERE (HONV + ' ' + TENLOT + ' ' + TENNV) = N'Đinh Bá Tiên'

-- 7. Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965
SELECT *
FROM NHANVIEN
WHERE YEAR(NGSINH) BETWEEN 1960 AND 1965

-- 8. Cho biết các nhân viên và năm sinh của nhân viên
SELECT MANV, HONV + ' ' + TENLOT + ' ' + TENNV AS FULL_NAME, YEAR(NGSINH)
FROM NHANVIEN

-- 9. Cho biết các nhân viên và tuổi của nhân viên
SELECT MANV, HONV + ' ' + TENLOT + ' ' + TENNV AS FULL_NAME, YEAR(GETDATE()) - YEAR(NGSINH) AS TUOI
FROM NHANVIEN

-- PHAN 02 - TRUY VẤN CÓ SỬ DỤNG PHÉP KẾT
-- 10. Với mỗi phòng ban, cho biết tên phòng ban và địa điểm phòng
SELECT P.TENPHG, D.DIADIEM
FROM PHONGBAN P, DIADIEM_PHG D
WHERE P.MAPHG = D.MAPHG; 

-- 11. Tìm tên những người trưởng phòng của từng phòng ban
SELECT P.TENPHG, V.HONV + ' ' + V.TENLOT + ' ' + V.TENNV AS FULL_NAME 
FROM PHONGBAN P, NHANVIEN V
WHERE P.TRPHG = V.MANV

-- 12. Tìm tên và địa chỉ của tất cả các nhân viên của phòng "Nghiên cứu".
SELECT V.HONV + ' ' + V.TENLOT + ' ' + V.TENNV AS FULL_NAME, V.DCHI
FROM PHONGBAN P, NHANVIEN V
WHERE V.PHG = P.MAPHG AND P.TENPHG LIKE N'Nghiên cứu'

-- 13. Với mỗi đề án ở Hà Nội, cho biết tên đề án, tên phòng ban, họ tên và
--     ngày nhận chức của trưởng phòng của phòng ban chủ trì đề án đó.
SELECT D.TENDA, P.TENPHG, V.HONV + ' ' + V.TENLOT + ' ' + V.TENNV AS FULL_NAME, P.NG_NHANCHUC
FROM DEAN D, PHONGBAN P, NHANVIEN V
WHERE D.PHONG = P.MAPHG AND P.TRPHG = V.MANV AND D.DDIEM_DA = N'Hà Nội'

-- 14. Tìm tên những nữ nhân viên và tên người thân của họ
SELECT N.HONV + ' ' + N.TENLOT + ' ' + N.TENNV AS FULL_NAME, T.TENTN
FROM NHANVIEN N, THANNHAN T
WHERE N.MANV = T.MA_NVIEN AND N.PHAI = N'Nữ'

-- 15. Với mỗi nhân viên, cho biết họ tên nhân viên và họ tên người quản lý
--     trực tiếp của nhân viên đó
SELECT N.HONV + ' ' + N.TENLOT + ' ' + N.TENNV AS NHANVIEN, Q.HONV + ' ' + Q.TENLOT + ' ' + Q.TENNV AS NGQL
FROM NHANVIEN N, NHANVIEN Q
WHERE N.MA_NQL = Q.MANV

-- 16. Với mỗi nhân viên, cho biết họ tên của nhân viên đó, họ tên người
--     trưởng phòng và họ tên người quản lý trực tiếp của nhân viên đó.
SELECT N.HONV + ' ' + N.TENLOT + ' ' + N.TENNV AS NHANVIEN, 
	   Q.HONV + ' ' + Q.TENLOT + ' ' + Q.TENNV AS NGQL,
	   T.HONV + ' ' + T.TENLOT + ' ' + T.TENNV AS TRPHG
FROM NHANVIEN N, NHANVIEN Q, PHONGBAN P, NHANVIEN T
WHERE N.MA_NQL = Q.MANV AND N.PHG = P.MAPHG AND P.TRPHG = T.MANV

-- 17. Tên những nhân viên phòng số 5 có tham gia vào đề án "Sản phẩm X"
--     và nhân viên này do "Nguyễn Thanh Tùng" quản lý trực tiếp.
SELECT N.HONV + ' ' + N.TENLOT + ' ' + N.TENNV AS NHANVIEN
FROM NHANVIEN N, NHANVIEN Q, PHONGBAN P, DEAN D, PHANCONG PC
WHERE N.MA_NQL = Q.MANV AND N.PHG = P.MAPHG
	  AND N.MANV = PC.MA_NVIEN AND PC.MADA = D.MADA
	  AND P.MAPHG = 5 AND (Q.HONV + ' ' + Q.TENLOT + ' ' + Q.TENNV) = N'Nguyễn Thanh Tùng'
GROUP BY (N.HONV + ' ' + N.TENLOT + ' ' + N.TENNV)

-- 18. Cho biết tên các đề án mà nhân viên Đinh Bá Tiến đã tham gia.
SELECT D.TENDA
FROM NHANVIEN N, PHANCONG P, CONGVIEC C, DEAN D
WHERE N.MANV = P.MA_NVIEN AND P.MADA = C.MADA 
	  AND P.STT = C.STT AND C.MADA = D.MADA
	  AND (N.HONV + ' ' + N.TENLOT + ' ' + N.TENNV) = N'Đinh Bá Tiên'