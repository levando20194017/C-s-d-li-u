use QLBongDa_DoLV
/*a. Xử lý chuỗi, ngày giờ*/
/*1. Cho biết NGAYTD, TENCLB1, TENCLB2, KETQUA các trận đấu diễn ra vào tháng 3 trên sân 
nhà mà không bị thủng lưới.*/
select clb1.TENCLB_4017[clb1], clb2.TENCLB_4017[clb2], td.NGAYTD_4017, td.KETQUA_4017
from CAULACBO_DoLV_20194017 clb1, CAULACBO_DoLV_20194017 clb2, TRANDAU_DoLV_20194017 td
where MONTH(td.NGAYTD_4017) = '3'
	and clb1.MACLB_4017 = td.MACLB1_4017
	and clb2.MACLB_4017 = td.MACLB2_4017
	and RIGHT(td.KETQUA_4017,1) = '0'

--2. Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ lót là “Công”
select ct.MACT_4017, ct.HOTEN_4017, ct.NGAYSINH_4017
from CAUTHU_DoLV_20194017 ct
where SUBSTRING(ct.HOTEN_4017, CHARINDEX(' ', ct.HOTEN_4017)+1,4) = N'Công'
--3. Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ không phải là họ “Nguyễn “
select ct.MACT_4017, ct.HOTEN_4017, ct.NGAYSINH_4017
from CAUTHU_DoLV_20194017 ct
where ct.HOTEN_4017 not LIKE N'Nguyễn%'
--4. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ của những huấn luyện viên Việt 
--Nam có tuổi nằm trong khoảng 35-40
select hlv.MAHLV_4017, hlv.TENHLV_4017, hlv.NGAYSINH_4017, hlv.DIACHI_4017
from HUANLUYENVIEN_DoLV_20194017 hlv, QUOCGIA_DoLV_20194017 qg
where qg.TENQG_4017 = N'Việt Nam'
	and (YEAR(GETDATE()) - YEAR(hlv.NGAYSINH_4017)) <= 50
	and (YEAR(GETDATE()) - YEAR(hlv.NGAYSINH_4017)) >= 35
	and hlv.MAQG_4017 = qg.MAQG_4017

/*a. Xử lý chuỗi, ngày giờ*/
--5. Cho biết tên câu lạc bộ có huấn luyện viên trưởng sinh vào ngày 20 tháng 5
select clb.TENCLB_4017
from CAULACBO_DoLV_20194017 clb, HUANLUYENVIEN_DoLV_20194017 hlv, HLV_CLB_DoLV_20194017 hlvclb
where DAY(hlv.NGAYSINH_4017) = 20
	and	month(hlv.NGAYSINH_4017) = 5
	and hlvclb.MACLB_4017 = clb.MACLB_4017
	and hlvclb.MAHLV_4017 = hlv.MAHLV_4017

/*a. Xử lý chuỗi, ngày giờ*/
--6. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có số bàn thắng nhiều nhất tính đến 
--hết vòng 3 năm 2009
select top 1 clb.TENCLB_4017, t.TENTINH_4017
from BANGXH_DoLV_20194017 bxh, CAULACBO_DoLV_20194017 clb, TINH_DoLV_20194017 t
where clb.MACLB_4017 = bxh.MACLB_4017 and clb.MATINH_4017 = t.MATINH_4017
and bxh.VONG_4017 = 3
and bxh.NAM_4017 = 2009
order by convert(int, LEFT(bxh.HIEUSO_4017, CHARINDEX('-', bxh.HIEUSO_4017) - 1)) desc

/*b. Truy vấn con
1. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước 
ngoài (Có quốc tịch khác “Việt Nam”) tương ứng của các câu lạc bộ có nhiều hơn 2 cầu 
thủ nước ngoài.*/
select clb.MACLB_4017, clb.TENCLB_4017, svd.TENSAN_4017, svd.DIACHI_4017, COUNT(ct.MACT_4017) as Soluong
from CAULACBO_DoLV_20194017 clb, SANVD_DoLV_20194017 svd, CAUTHU_DoLV_20194017 ct, QUOCGIA_DoLV_20194017 qg
where clb.MASAN_4017 = svd.MASAN_4017
	and ct.MACLB_4017 = clb.MACLB_4017
	and ct.MAQG_4017 = qg.MAQG_4017
	and qg.TENQG_4017 != N'Việt Nam'
	group by clb.MACLB_4017, clb.TENCLB_4017, svd.TENSAN_4017, svd.DIACHI_4017
	having count(ct.MACT_4017) >= 2

/*b. Truy vấn con
2. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có hiệu số bàn thắng bại cao nhất 
năm 2009.*/
select top 1 clb.TENCLB_4017, t.TENTINH_4017
from CAULACBO_DoLV_20194017 clb, TINH_DoLV_20194017 t, BANGXH_DoLV_20194017 bxh, 
	(select MAX(bxh.VONG_4017) as vongcuoi from BANGXH_DoLV_20194017 bxh) as temp
	where clb.MATINH_4017 = t.MATINH_4017
	and bxh.MACLB_4017 = clb.MACLB_4017
	and bxh.NAM_4017 = 2009
	and bxh.VONG_4017 = temp.vongcuoi
order by (CAST  (left (bxh.HIEUSO_4017, CHARINDEX( '-', bxh.HIEUSO_4017) -1) as int	)
	- CAST ( substring (bxh.HIEUSO_4017, CHARINDEX( '-', bxh.HIEUSO_4017)+1, len(bxh.HIEUSO_4017)) as int )) DESC

/*b. Truy vấn con
3. Cho biết danh sách các trận đấu ( NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của 
câu lạc bộ CLB có thứ hạng thấp nhất trong bảng xếp hạng vòng 3 năm 2009.*/
select td.NGAYTD_4017, svd.TENSAN_4017,clb1.TENCLB_4017, clb2.TENCLB_4017, td.KETQUA_4017
from TRANDAU_DoLV_20194017 td, CAULACBO_DoLV_20194017 clb1, CAULACBO_DoLV_20194017 clb2, SANVD_DoLV_20194017 svd,
	(select top 1 bxh.MACLB_4017 as HANG_THAP_NHAT
	from BANGXH_DoLV_20194017 bxh
	where bxh.VONG_4017 = 3
	and bxh.NAM_4017 = 2009
	order by bxh.HANG_4017 DESC) as HANG_VONG_3

where td.MACLB1_4017 = clb1.MACLB_4017
	and td.MACLB2_4017 = clb2.MACLB_4017
	and td.MASAN_4017 = svd.MASAN_4017
	and (clb1.MACLB_4017 = HANG_VONG_3.HANG_THAP_NHAT or clb2.MACLB_4017 = HANG_VONG_3.HANG_THAP_NHAT)

/*b. Truy vấn con
4. Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại 
(kể cả sân nhà và sân khách) trong mùa giải năm 2009.*/
select clb.MACLB_4017, clb.TENCLB_4017
from CAULACBO_DoLV_20194017 clb, BANGXH_DoLV_20194017 bxh
where bxh.MACLB_4017 = clb.MACLB_4017
-- vong cuoi la vong may?
and bxh.VONG_4017 >= all(select bxh.VONG_4017 from BANGXH_DoLV_20194017 bxh)
-- de thoa man dieu kien de bai, moi doi can da bao nhieu tran?
and bxh.SOTRAN_4017 = (select count(bxh.VONG_4017) - 1
from BANGXH_DoLV_20194017 bxh
where bxh.VONG_4017 = 1)

/*b. Truy vấn con
5. Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại 
(chỉ tính sân nhà) trong mùa giải năm 2009.*/
select clb.MACLB_4017, clb.TENCLB_4017
from (
	select td.MACLB1_4017, count(td.MACLB2_4017) as cnt
	from TRANDAU_DoLV_20194017 td
	group by td.MACLB1_4017
) as tab inner join CAULACBO_DoLV_20194017 clb on clb.MACLB_4017 = tab.MACLB1_4017
where tab.cnt = (select count(clb.MACLB_4017) - 3
				from CAULACBO_DoLV_20194017 clb)

/*c. Bài tập về Rule
1. Khi thêm cầu thủ mới, kiểm tra vị trí trên sân của cầu thủ chỉ thuộc một trong các vị trí 
sau: Thủ môn, tiền đạo, tiền vệ, trung vệ, hậu vệ
*/
alter table CAUTHU_DoLV_20194017
add constraint checkVITRI check(
	VITRI_4017 in (N'Thủ môn', N'Tiền đạo', N'Tiền vệ', N'Trung vệ', N'Hậu vệ'))
	select * from CAUTHU_DoLV_20194017
insert into CAUTHU_DoLV_20194017
	values(N'ronaldo', N'Tiền đạo', '1990-02-01', null, 'BBD', 'VN', 1)

/*c. Bài tập về Rule
2. Khi phân công huấn luyện viên, kiểm tra vai trò của huấn luyện viên chỉ thuộc một trong 
các vai trò sau: HLV chính, HLV phụ, HLV thể lực, HLV thủ môn
*/
alter table HLV_CLB_DoLV_20194017
add constraint checkVAITRO check(
	VAITRO_4017 like N'HLV Chính' or
	VAITRO_4017 like N'HLV phụ' or
	VAITRO_4017 like N'HLV thể lực' or
	VAITRO_4017 like N'HLV thủ môn')
	select * from HLV_CLB_DoLV_20194017

insert into HLV_CLB_DoLV_20194017
	values(N'HLV08', N'HAGL', N'HLV Phụ')
insert into HLV_CLB_DoLV_20194017
	values(N'HLV02', N'HAGL', N'HLV Phụ 2')
/*
Bài thực hành số 3
c. Bài tập về Rule
3. Khi thêm cầu thủ mới, kiểm tra cầu thủ đó có tuổi phải đủ 18 trở lên (chỉ tính năm sinh)
*/
alter table CAUTHU_DoLV_20194017
add constraint checkNGAYSINH check(
	year(getdate()) - year(convert(varchar, NGAYSINH_4017, 102)) >= 18)
	select * from CAUTHU_DoLV_20194017
insert into CAUTHU_DoLV_20194017
	values(N'ronaldo', N'Thủ môn', '1990-02-01', null, 'BBD', 'VN', 1)


/*
Bài thực hành số 3
c. Bài tập về Rule
4. Kiểm tra kết quả trận đấu có dạng số_bàn_thắng-số_bàn_thua
*/
alter table TRANDAU_DoLV_20194017
add constraint checkKETQUA check(
	KETQUA_4017 like '%-%')
	select * from TRANDAU_DoLV_20194017
insert into TRANDAU_DoLV_20194017
	values(2009, 5, '2009-05-12', 'BBD', 'SDN', 'GD', '3-3')

/*
Lê Văn Do 20194017
Bài thực hành số 3
d. Bài tập về View
1. Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ thuộc đội bón g “SHB 
Đà Nẵng” có quốc tịch “Bra-xin”
*/
create view view1d as
select	ct.MACT_4017, ct.HOTEN_4017, ct.NGAYSINH_4017, ct.DIACHI_4017, ct.VITRI_4017
from CAUTHU_DoLV_20194017 ct inner join CAULACBO_DoLV_20194017 clb on clb.MACLB_4017 = ct.MACLB_4017
	inner join QUOCGIA_DoLV_20194017 qg on qg.MAQG_4017 = ct.MAQG_4017
where clb.TENCLB_4017 like N'SHB Đà Nẵng' and qg.TENQG_4017 like N'Bra-xin'

/*
Lê Văn Do 20194017
Bài thực hành số 3
d. Bài tập về View
2. Cho biết kết quả (MATRAN, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các trận 
đấu vòng 3 của mùa bóng năm 2009
*/

CREATE VIEW view2d AS
SELECT MATRAN_4017, NGAYTD_4017, TENSAN_4017, C1.TENCLB_4017 AS TENCLB1, C2.TENCLB_4017 AS TENCLB2, KETQUA_4017
FROM TRANDAU_DoLV_20194017, CAULACBO_DoLV_20194017 AS C1, CAULACBO_DoLV_20194017 AS C2, SANVD_DoLV_20194017
WHERE VONG_4017 = 3
	  AND NAM_4017 = 2009
	  AND TRANDAU_DoLV_20194017.MACLB1_4017 = C1.MACLB_4017
	  AND TRANDAU_DoLV_20194017.MACLB2_4017 = C2.MACLB_4017
	  AND TRANDAU_DoLV_20194017.MASAN_4017 = SANVD_DoLV_20194017.MASAN_4017


/*
Lê Văn Do 20194017
Bài thực hành số 3
d. Bài tập về View
3. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc 
của các huấn luyện viên có quốc tịch “Việt Nam”
*/
create view view3d as
select hlv.MAHLV_4017, hlv.TENHLV_4017, hlv.NGAYSINH_4017, hlv.DIACHI_4017, hlvclb.VAITRO_4017,
	clb.TENCLB_4017
from HUANLUYENVIEN_DoLV_20194017 hlv inner join HLV_CLB_DoLV_20194017 hlvclb on hlvclb.MAHLV_4017 = hlv.MAHLV_4017
	inner join QUOCGIA_DoLV_20194017 qg on qg.MAQG_4017 = hlv.MAQG_4017
	inner join CAULACBO_DoLV_20194017 clb on clb.MACLB_4017 = hlvclb.MACLB_4017
where qg.TENQG_4017 like N'Việt Nam'

/*
Lê Văn Do 20194017
Bài thực hành số 3
d. Bài tập về View
4. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ
nước ngoài (có quốc tịch khác “Việt Nam”) tương ứng của các câu lạc bộ nhiều hơn 2 
cầu thủ nước ngoài
*/
create view view4d as
select clb.MACLB_4017, clb.TENCLB_4017, svd.TENSAN_4017, svd.DIACHI_4017,
	count(ct.MACT_4017) as cnt
from CAULACBO_DoLV_20194017 clb inner join SANVD_DoLV_20194017 svd on svd.MASAN_4017 = clb.MASAN_4017
	inner join CAUTHU_DoLV_20194017 ct on ct.MACLB_4017 = clb.MACLB_4017
	inner join QUOCGIA_DoLV_20194017 qg on qg.MAQG_4017 = ct.MAQG_4017
where qg.TENQG_4017 not like N'Việt Nam'
group by clb.MACLB_4017, clb.TENCLB_4017, svd.TENSAN_4017, svd.DIACHI_4017
	having count(ct.MACT_4017) >= 2

/*
Lê Văn Do 20194017
Bài thực hành số 3
d. Bài tập về View
5. Cho biết tên tỉnh, số lượng câu thủ đang thi đấu ở vị trí tiền đạo trong các câu lạc bộ
thuộc địa bàn tỉnh đó quản lý.
*/
create view view5d as
select tinh.TENTINH_4017, count(ct.MACT_4017) as cnt
from CAULACBO_DoLV_20194017 clb inner join TINH_DoLV_20194017 tinh on tinh.MATINH_4017 = clb.MATINH_4017
	inner join CAUTHU_DoLV_20194017 ct on ct.MACLB_4017 = clb.MACLB_4017
where ct.VITRI_4017 like N'Tiền đạo'
group by tinh.TENTINH_4017

/*
Lê Văn Do 20194017
Bài thực hành số 3
d. Bài tập về View
6. Cho biết tên câu lạc bộ,tên tỉnh mà CLB đang đóng nằm ở vị trí cao nhất của bảng xếp 
hạng của vòng 3 năm 2009
*/
create view view6d as
select clb.TENCLB_4017, tinh.TENTINH_4017
from CAULACBO_DoLV_20194017 clb inner join TINH_DoLV_20194017 tinh on tinh.MATINH_4017 = clb.MATINH_4017
where clb.MACLB_4017 in (select top 1 bxh.MACLB_4017
						from BANGXH_DoLV_20194017 bxh
						where VONG_4017 = 3 and NAM_4017 = 2009 
						order by HANG_4017)

/*
Lê Văn Do 20194017
Bài thực hành số 3
d. Bài tập về View
7. Cho biết tên huấn luyện viên đang nắm giữ một vị trí trong 1 c âu lạc bộ mà chưa có số
điện thoại
*/
create view view7d as
select hlv.TENHLV_4017
from HUANLUYENVIEN_DoLV_20194017 hlv inner join HLV_CLB_DoLV_20194017 hlvclb on hlv.MAHLV_4017 = hlvclb.MAHLV_4017
where hlv.DIENTHOAI_4017 is null

/*
Lê Văn Do 20194017
Bài thực hành số 3
d. Bài tập về View
8. Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm công tác huấn luyện tại bất 
kỳ một câu lạc b ộ nào
*/
create view view8d as
select hlv.*
from HUANLUYENVIEN_DoLV_20194017 hlv inner join QUOCGIA_DoLV_20194017 qg on qg.MAQG_4017 = hlv.MAQG_4017
where hlv.MAHLV_4017 not in (select MAHLV_4017
							from HLV_CLB_DoLV_20194017)
	and qg.TENQG_4017 like N'Việt Nam'

/*
Lê Văn Do 20194017
Bài thực hành số 3
d. Bài tập về View
9. Cho biết kết quả các trận đấu đã diễn ra (MACLB1, MACLB2, NAM, VONG,
SOBANTHANG,SOBANTHUA)
*/
create view view9d as
select MACLB1_4017, MACLB2_4017, NAM_4017, VONG_4017, 
	CAST(left(KETQUA_4017, 1) as int) + CAST(right(KETQUA_4017, 1) as int) as SOBANTHANG,
	CAST(left(KETQUA_4017, 1) as int) + CAST(right(KETQUA_4017, 1) as int) as SOBANTHUA
from TRANDAU_DoLV_20194017 td

/*
Lê Văn Do 20194017
Bài thực hành số 3
d. Bài tập về View
10. Cho biết kết quả các trận đấu trên sân nhà (MACLB, NAM, VONG, 
SOBANTHANG, SOBANTHUA)
*/
create view view10d as
select MACLB1_4017, NAM_4017, VONG_4017,
	LEFT(KETQUA_4017, 1) as SOBANTHANG,
	RIGHT(KETQUA_4017, 1) as SOBANTHUA
from TRANDAU_DoLV_20194017 td 

/*
Lê Văn Do 20194017
Bài thực hành số 3
d. Bài tập về View
11. Cho biết kết quả các trận đấu trên sân khách (MACLB, NAM, VONG,
SOBANTHANG,SOBANTHUA)
*/
create view view11d as
select MACLB2_4017, NAM_4017, VONG_4017,
	RIGHT(KETQUA_4017, 1) as SOBANTHANG,
	LEFT(KETQUA_4017, 1) as SOBANTHUA
from TRANDAU_DoLV_20194017 td 

/*
Lê Văn Do 20194017
Bài thực hành số 3
d. Bài tập về View
12. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) 
của câu lạc bộ CLB đang xếp hạng cao nhất tính đến hết vòng 3 năm 2009
*/

CREATE VIEW view12d AS
SELECT NGAYTD_4017, S.TENSAN_4017, CLB1.TENCLB_4017 AS TENCLB1, CLB2.TENCLB_4017 AS TENCLB2, TD.KETQUA_4017  
FROM TRANDAU_DoLV_20194017 TD, CAULACBO_DoLV_20194017 CLB1, CAULACBO_DoLV_20194017 CLB2, BANGXH_DoLV_20194017 B, SANVD_DoLV_20194017 S
WHERE CLB1.MACLB_4017 = TD.MACLB1_4017 
	  AND CLB2.MACLB_4017 = TD.MACLB2_4017 
	  AND S.MASAN_4017 = TD.MASAN_4017 
	  AND B.HANG_4017 = '1' 
	  AND (CLB1.MACLB_4017 = B.MACLB_4017 OR CLB2.MACLB_4017=B.MACLB_4017) 
	  AND TD.VONG_4017 <= '3' 
	  AND TD.NAM_4017 = '2009' 
	  AND B.VONG_4017 = '3'
/*
Lê Văn Do 20194017
Bài thực hành số 3
d. Bài tập về View
13. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) 
của câu lạc bộ CLB có thứ hạng thấp nhất trong bảng xếp hạng vòng 3 năm 2009
*/
CREATE VIEW view13d AS
SELECT NGAYTD_4017, S.TENSAN_4017, 
	   CLB1.TENCLB_4017 AS TENCLB1, 
	   CLB2.TENCLB_4017 AS TENCLB2, 
	   TD.KETQUA_4017  
FROM TRANDAU_DoLV_20194017 TD, CAULACBO_DoLV_20194017 CLB1, CAULACBO_DoLV_20194017 CLB2, BANGXH_DoLV_20194017 B, SANVD_DoLV_20194017 S
WHERE CLB1.MACLB_4017 = TD.MACLB1_4017  
	  AND CLB2.MACLB_4017 = TD.MACLB2_4017 
	  AND S.MASAN_4017 = TD.MASAN_4017  
	  AND (CLB1.MACLB_4017 = B.MACLB_4017 OR CLB2.MACLB_4017 = B.MACLB_4017) 
	  AND TD.VONG_4017 <= '3' AND TD.NAM_4017 = '2009' AND B.VONG_4017 = '3'
	  AND (B.HANG_4017 = (SELECT MAX(HANG_4017) FROM BANGXH_DoLV_20194017)) 