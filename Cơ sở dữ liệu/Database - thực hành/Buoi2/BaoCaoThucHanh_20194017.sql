/*Lê Văn Do 20194017
Bài thực hành số 2	
c. Các toán tử nâng cao*/
--4. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA)  
--của câu lạc bộ (CLB) đang xếp hạng cao nhất tính đến hết vòng 3 năm 2009
select td.NGAYTD_4017, svd.TENSAN_4017, clb1.TENCLB_4017, clb2.TENCLB_4017, td.KETQUA_4017 
from TRANDAU_DoLV_20194017 td, CAULACBO_DoLV_20194017 clb1, CAULACBO_DoLV_20194017 clb2,
	SANVD_DoLV_20194017 svd, BANGXH_DoLV_20194017 bxh
where td.MASAN_4017 = svd.MASAN_4017
	and bxh.VONG_4017 = 3 and bxh.NAM_4017 = 2009 and bxh.HANG_4017 = 1
	and bxh.MACLB_4017 in (td.MACLB1_4017, td.MACLB2_4017) and td.VONG_4017 in (1,2,3)
	and td.MACLB1_4017 = clb1.MACLB_4017 and td.MACLB2_4017 = clb2.MACLB_4017


--3. Liệt kê các cầu thủ đang thi đấu trong các câu lạc bộ có thứ hạng 
--ở vòng 3 năm 2009  lớn hơn 6 hoặc nhỏ hơn 3
select ct.HOTEN_4017
from CAUTHU_DoLV_20194017 ct, CAULACBO_DoLV_20194017 clb, BANGXH_DoLV_20194017 bxh
where ct.MACLB_4017 = clb.MACLB_4017 and bxh.NAM_4017 = (2009) and bxh.VONG_4017 = (3)
	and clb.MACLB_4017 = bxh.MACLB_4017
	and (bxh.HANG_4017 > 6 or bxh.HANG_4017 < 3)
	group by ct.HOTEN_4017

--2. Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa 
--làm công tác huấn luyện  tại bất kỳ một câu lạc bộ nào
select hlv.TENHLV_4017
from HUANLUYENVIEN_DoLV_20194017 hlv, QUOCGIA_DoLV_20194017 qg
where hlv.MAQG_4017 = qg.MAQG_4017 
	and qg.TENQG_4017 = N'Việt Nam' and hlv.MAHLV_4017 not in 
	(select hlvclb.MAHLV_4017 from HLV_CLB_DoLV_20194017 hlvclb) 


--1. Cho biết tên huấn luyện viên đang nắm giữ một vị trí trong 
--một câu lạc bộ mà  chưa có số điện thoại
select hlv.TENHLV_4017
from HUANLUYENVIEN_DoLV_20194017 hlv, CAULACBO_DoLV_20194017 clb, HLV_CLB_DoLV_20194017 hlvclb
where hlv.DIENTHOAI_4017 is null and hlv.MAHLV_4017 = hlvclb.MAHLV_4017 and clb.MACLB_4017 = hlvclb.MACLB_4017


/*b. Các phép toán trên nhóm*/
--5. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng nằm ở vị trí cao nhất của bảng  xếp hạng vòng 3, năm 2009
select top 1 clb.TENCLB_4017, t.TENTINH_4017
from CAULACBO_DoLV_20194017 clb, TINH_DoLV_20194017 t, BANGXH_DoLV_20194017 bxh
where clb.MATINH_4017 = t.MATINH_4017 and bxh.MACLB_4017 = clb.MACLB_4017 
	and bxh.NAM_4017 = (2009) and bxh.VONG_4017 = (3)
order by bxh.DIEM_4017 desc


--4. Cho biết tên tỉnh, số lượng cầu thủ đang thi đấu ở vị trí tiền đạo trong các câu lạc  bộ thuộc địa bàn tỉnh đó quản lý
select t.TENTINH_4017, COUNT(ct.MACT_4017) as Number
from TINH_DoLV_20194017 t, CAUTHU_DoLV_20194017 ct, CAULACBO_DoLV_20194017 clb
where t.MATINH_4017 = clb.MATINH_4017 and ct.MACLB_4017 = clb.MACLB_4017 and ct.VITRI_4017 = N'Tiền đạo'
group by t.TENTINH_4017



--3. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài 
--(có quốc tịch khác Việt Nam) tương ứng của các câu lạc bộ có nhiều hơn 1 cầu thủ nước ngoài.
select clb.MACLB_4017, clb.TENCLB_4017, svd.TENSAN_4017, svd.DIACHI_4017, COUNT(ct.MACT_4017) as Number
from CAULACBO_DoLV_20194017 clb, CAUTHU_DoLV_20194017 ct, QUOCGIA_DoLV_20194017 qg, SANVD_DoLV_20194017 svd
where ct.MACLB_4017 = clb.MACLB_4017 and qg.MAQG_4017 = ct.MAQG_4017 and svd.MASAN_4017 = clb.MASAN_4017
	and qg.TENQG_4017 != N'Việt nam'
group by clb.MACLB_4017, clb.TENCLB_4017, svd.TENSAN_4017, svd.DIACHI_4017 having COUNT(ct.MACT_4017) > 1


--2. Thống kê số lượng cầu thủ (có quốc tịch Việt Nam) của mỗi câu lạc bộ
select clb.TENCLB_4017, count(ct.MACT_4017) as Number
from CAUTHU_DoLV_20194017 ct, CAULACBO_DoLV_20194017 clb, QUOCGIA_DoLV_20194017 qg
where ct.MACLB_4017 = clb.MACLB_4017 and qg.MAQG_4017 = ct.MAQG_4017 and qg.TENQG_4017 = N'Việt Nam'
group by clb.TENCLB_4017


--1. Thống kê số lượng cầu thủ của mỗi câu lạc bộ
select clb.TENCLB_4017, count(ct.MACT_4017) as members
from CAULACBO_DoLV_20194017 clb inner join CAUTHU_DoLV_20194017 ct on ct.MACLB_4017 = clb.MACLB_4017
group by clb.TENCLB_4017






/*a. Tuy vấn cơ bản*/
--10. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, 
--vai trò và tên CLB đang làm việc mà câu lạc bộ đó đóng ở tỉnh Binh Dương.
select hlv.MAHLV_4017, hlv.TENHLV_4017, hlv.NGAYSINH_4017, hlv.DIACHI_4017, hlvclb.VAITRO_4017,clb.TENCLB_4017
from HUANLUYENVIEN_DoLV_20194017 hlv inner join HLV_CLB_DoLV_20194017 hlvclb
	on hlvclb.MAHLV_4017 = hlv.MAHLV_4017
	inner join CAULACBO_DoLV_20194017 clb on clb.MACLB_4017 = hlvclb.MACLB_4017
	inner join TINH_DoLV_20194017 t on t.MATINH_4017 = clb.MATINH_4017
where t.TENTINH_4017 = N'Bình Dương'



--9. Lấy tên 3 câu lạc bộ có điểm cao nhất sau vòng 3 năm 2009
select top 3 clb.TENCLB_4017
from CAULACBO_DoLV_20194017 clb, BANGXH_DoLV_20194017 bxh
where clb.MACLB_4017 = bxh.MACLB_4017
order by bxh.DIEM_4017 desc

--7. Cho biết kết quả (MATRAN, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các  trận đấu vòng 2 của mùa bóng năm 2009
--7.Cho biết kết quả (TRANDAU, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các trận đấu vòng 2 của mùa bóng năm 2009 
SELECT td.MATRAN_4017,td.NGAYTD_4017,SANVD.TENSAN_4017,clb1.TENCLB_4017,clb2.TENCLB_4017,td.KETQUA_4017
from TRANDAU_DoLV_20194017 td,SANVD_DoLV_20194017 SANVD,CAULACBO_DoLV_20194017 clb1,CAULACBO_DoLV_20194017 clb2
where td.VONG_4017=2 and td.NAM_4017=2009 and SANVD.MASAN_4017=td.MASAN_4017 and clb1.MACLB_4017=td.MACLB1_4017 and clb2.MACLB_4017=td.MACLB2_4017


--8.Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc của các huấn luyện viên có quốc tịch “ViệtNam”
SELECT hlv.MAHLV_4017,hlv.TENHLV_4017,hlv.NGAYSINH_4017,hlv.DIACHI_4017,hc.VAITRO_4017,clb.TENCLB_4017
from HUANLUYENVIEN_DoLV_20194017 hlv,HLV_CLB_DoLV_20194017 hc,QuocGia_DoLV_20194017 qg,CAULACBO_DoLV_20194017 clb
where qg.TENQG_4017=N'Việt Nam' and hlv.MAHLV_4017=hc.MAHLV_4017 and qg.MAQG_4017=hlv.MAQG_4017 and hc.MACLB_4017=clb.MACLB_4017




--6. Hiển thị thông tin tất cả các cầu thủ đang thi đấu trong câu lạc bộ có sân nhà là  “Long An”
--Nhập thêm 1 cầu thủ là tên của mình với mã câu lạc bộ là 'GDT' 
insert into CAUTHU_DoLV_20194017 values(N'Lê Văn Do', N'Tiền đạo mũi nhọn', '07/08/2001' , null, 'GDT', 'VN', 12)

select ct.* from CAUTHU_DoLV_20194017 ct, SANVD_DoLV_20194017 svd, CAULACBO_DoLV_20194017 clb
where clb.MASAN_4017 = svd.MASAN_4017 and ct.MACLB_4017 = clb.MACLB_4017 and svd.TENSAN_4017 = N'Long An'


--5. Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ thuộc đội bóng  ‘SHB Đà Nẵng’ có quốc tịch “Bra-xin”



--4. Hiển thi thông tin tất cả các cầu thủ có quốc tịch Việt Nam thuộc câu lạc bộ Becamex Bình Dương
select ct.* from CAUTHU_DoLV_20194017 ct, QUOCGIA_DoLV_20194017 qg, CAULACBO_DoLV_20194017 clb 
where qg.MAQG_4017 = ct.MAQG_4017 and clb.MACLB_4017 = ct.MACLB_4017 
	and clb.TENCLB_4017 = N'Becamex Bình Dương' and qg.TENQG_4017 = N'Việt Nam'


--3. Cho biết tên, ngày sinh, địa chỉ, điện thoại của tất cả các huấn luyện viên.
select hlv.TENHLV_4017, hlv.NGAYSINH_4017, hlv.DIACHI_4017, hlv.DIENTHOAI_4017
from HUANLUYENVIEN_DoLV_20194017 hlv

/*2. Hiển thị thông tin tất cả các cầu thủ có số áo là 7 chơi ở vị trí Tiền vệ.*/
select * from CAUTHU_DoLV_20194017 ct where ct.SO_4017 = (7) and ct.VITRI_4017 = N'tiền vệ'

/*1. Cho biết thông tin (mã cầu thủ, họ tên, số áo, vị trí, ngày sinh, địa chỉ) của tất cả các cầu thủ */
select ct.MACT_4017, ct.HOTEN_4017, ct.SO_4017, ct.VITRI_4017, ct.NGAYSINH_4017, ct.DIACHI_4017 from CAUTHU_DoLV_20194017 ct