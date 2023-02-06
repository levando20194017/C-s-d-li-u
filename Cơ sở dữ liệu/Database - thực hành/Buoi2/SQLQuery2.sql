/* Lê Văn Do 20194017
Bài thực hành số 2
b.  Các phép toán trên nhóm*/
--1.Thống kê sốlượng cầu thủcủa mỗi câu lạc bộ
select clb.TENCLB_4017, count (ct.MACT_4017) [Số Lượng]
from  CAULACBO_DoLV_20194017 clb
join CAUTHU_DoLV_20194017 ct on ct.MACLB_4017 = clb.MACLB_4017
group by clb.TENCLB_4017
--2. 





/*a, truy vấn cơ bản*/
/*8.Cho biết mã huấn luyện viên, họtên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm veiecj của các huấn luyện viên có quốc tịch “ViệtNam”
select hlvclb.MAHLV_4017, hlv.TENHLV_4017, hlv.NGAYSINH_4017, hlv.DIACHI_4017, hlvclb.VAITRO_4017, clb.TENCLB_4017 
from HUANLUYENVIEN_DoLV_20194017 hlv, CAULACBO_DoLV_20194017 clb, QUOCGIA_DoLV_20194017 qg, HLV_CLB_DoLV_20194017 hlvclb
where hlv.MAHLV_4017 = hlvclb.MAHLV_4017
	and hlv.MAQG_4017 = qg.MAQG_4017
	and hlvclb.MACLB_4017 = clb.MACLB_4017
	and qg.TENQG_4017 = N'Việt Nam'

	*/


/*7.Cho biết kết quả(MATRAN, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các trận đấu vòng 2 của mùa bóng năm 2009
select td.MATRAN_4017, td.NGAYTD_4017,  svd.TENSAN_4017, clb1.TENCLB_4017, clb2.TENCLB_4017, td.KETQUA_4017
from TRANDAU_DoLV_20194017 td, CAULACBO_DoLV_20194017 clb1, CAULACBO_DoLV_20194017 clb2, SANVD_DoLV_20194017 svd
where td.VONG_4017 = 2
and td.MASAN_4017 = svd.MASAN_4017
and td.MACLB1_4017 = clb1.MACLB_4017
and td.MACLB2_4017 = clb2.MACLB_4017
and td.NAM_4017 = 2009
*/







/*6.Hiển thịthông tin tất cảcác cầu thủđang thi đấu trong câu lạc bộcó sân nhà là “Long An”
select ct.* from CAUTHU_DoLV_20194017 ct, CAULACBO_DoLV_20194017 clb, SANVD_DoLV_20194017 svd
where svd.MASAN_4017 = clb.MASAN_4017
and ct.MACLB_4017 = clb.MACLB_4017
and svd.TENSAN_4017 = N'Long An'
*/




/*5, Cho biết mã số, họtên, ngày sinh, địa chỉvà vịtrí của các cầu thủthuộc đội bóng ‘SHB Đà Nẵng’ có quốc tịch “Bra-xin”

select ct.MACT_4017, HOTEN_4017, ct.NGAYSINH_4017, ct.DIACHI_4017, ct.VITRI_4017 
from CAUTHU_DoLV_20194017 ct, CAULACBO_DoLV_20194017 clb, QUOCGIA_DoLV_20194017 qg
where ct.MACLB_4017 = clb.MACLB_4017 
and ct.MAQG_4017 = qg.MAQG_4017 
and TENCLB_4017 = N'SHB Đà Nẵng' 
and qg.TENQG_4017 = N'Bra-xin'
*/

/*d, Hiển thi thông tin tất cảcác cầu thủcó quốc tịch Việt Nam thuộc câu lạc bộBecamex Bình Dương
select CT.* from CAUTHU_DoLV_20194017 ct, QUOCGIA_DoLV_20194017 qg, CAULACBO_DoLV_20194017 clb 
where ct.MAQG_4017 = qg.MAQG_4017 and ct.MACLB_4017 = clb.MACLB_4017 and	qg.TENQG_4017 = N'Việt Nam' and clb.TENCLB_4017 = N'Becamex Bình Dương'*/


/*c.Cho biết tên, ngày sinh, địa chỉ, điện thoại của tất cảcác huấn luyện viên.*/
/*select TENHLV_4017 , NGAYSINH_4017, DIACHI_4017, DIENTHOAI_4017 from HUANLUYENVIEN_DoLV_20194017*/




/*a, truy vấn cơ bản */
/*Cho biết thông tin (mã cầu thủ, họtên, sốáo, vịtrí, ngày sinh, địa chỉ) của tất cảcác cầu thủ’*/
/*b, Hiển thịthông tin tất cảcác cầu thủcó sốáo là 7 chơi ởvịtrí Tiền vệ.*/

/*select * from CAUTHU_DoLV_20194017 where SO_4017 = (7) and VITRI_4017 = N'Tiền vệ'8*/


/*select MACT_4017, HOTEN_4017, SO_4017, VITRI_4017, NGAYSINH_4017, DIACHI_4017 from CAUTHU_DoLV_20194017*/








/*b, Hiển thịthông tin tất cảcác cầu thủcó sốáo là 7 chơi ởvịtrí Tiền vệ.*/
/*select * from CAUTHU_DoLV_20194017 where SO_4017 = (7) and VITRI_4017 = N'Tiền vệ'*/