-- 2.1 NhanVien: với Hệ số lương: 2.34, 3.0,3.99, 4.44, 5.2, 6.5

alter table NhanVien_DoLV
add constraint chk_hes
check (heso_20194017 in (2.34, 3, 3.99, 4.44, 5.2, 6.5))

-- 2.2 PhongBan: Dia Chi gồm C1-101, C1-203, C1-303, B1-601, B1-701
alter table PhongBan_DoLV
add constraint chk_diachii
check (DiaChi_20194017 in ('C1-101', 'C1-203', 'C1-303', 'B1-601', 'B1-701'))

-- 2.3 ChitietBangLuong: số ngày công Từ 20 đến 26,
alter table ChiTietBangLuong_DoLV
add constraint chk_soNgayCong
check (SoNgayCong_20194017 between 20 and 26)

-- 2.4 BangLuong: Ngaylap vao 10 hàng tháng
alter table BangLuong_DoLV
add constraint chk_ngayLap
check (day(NgayLap_20194017) = 10)
/*4.1Đưa ra MaPB, tên Tên Pban, Lương  phòng ban, số tháng,tổng số ngày công,tổng lương phải trả, 
của các phòng bancó địa chỉ lchứa C1trong năm 2021.
(Lương của nhân viên = Lương phòng ban * Hệ số * số ngày công. )
Lê Văn Do 20194017
*/
select pb.MaPB_20194017, pb.TenPB_20194017, pb.LuongPB_20194017,
	count(distinct bl.MaBL_20194017) [số tháng],
	sum(ct.SoNgayCong_20194017) [tổng số ngày công],
	sum(nv.heso_20194017 * pb.LuongPB_20194017 * ct.SoNgayCong_20194017) [tổng lương phải trả]
from PhongBan_DoLV pb inner join BangLuong_DoLV bl 
	on pb.MaPB_20194017 = bl.MaPB_20194017
	inner join ChiTietBangLuong_DoLV ct 
	on ct.MaBL_20194017 = bl.MaBL_20194017
	inner join NhanVien_DoLV nv 
	on nv.MaNV_20194017 = ct.MaNV_20194017
where pb.DiaChi_20194017 like '%C1%' and 
	year(bl.NgayLap_20194017) = 2021
group by pb.MaPB_20194017, pb.TenPB_20194017, pb.LuongPB_20194017

--4.2Đưa ra Nhân viênnhận được lươngcao nhất với các thông tin: mã Nhân viên, Tên Nhân viên,hệ số, tổng số ngày công,Lương PB, tổng lươngtrong năm 2021.  
--trong đó tiền Lương của nhân viên = Lương phòng ban* Hệ số * số ngày công. 
select top 1 nv.MaNV_20194017,nv.HotenNV_20194017,nv.heso_20194017,sum(ctbl.SoNgayCong_20194017)[số ngay công],
pb.LuongPB_20194017,sum(nv.heso_20194017*ctbl.SoNgayCong_20194017*pb.LuongPB_20194017)[tổng lương]
from NhanVien_DoLV nv, PhongBan_DoLV pb, BangLuong_DoLV bl,ChiTietBangLuong_DoLV ctbl
where nv.MaNV_20194017=ctbl.MaNV_20194017
and ctbl.MaBL_20194017=bl.MaBL_20194017
and bl.MaPB_20194017=pb.MaPB_20194017
group by nv.MaNV_20194017,nv.HotenNV_20194017,nv.heso_20194017,pb.LuongPB_20194017
order by sum(nv.heso_20194017*ctbl.SoNgayCong_20194017*pb.LuongPB_20194017) desc



/*4.3. Đưa ra danh sáchPhòng Bancó Tổng lương >=500000, với các thông tin:
Mã Phòng Ban, tên Phòng ban, Tổng số tháng, tổng tiền Lươngtrong năm 2021.
Lê Văn Do 20194017
*/
select pb.MaPB_20194017, pb.TenPB_20194017,
	count(distinct bl.MaBL_20194017) [số tháng],
	sum(nv.heso_20194017 * pb.LuongPB_20194017 * ct.SoNgayCong_20194017) [tổng lương]
from PhongBan_DoLV pb inner join BangLuong_DoLV bl 
	on pb.MaPB_20194017 = bl.MaPB_20194017
	inner join ChiTietBangLuong_DoLV ct 
	on ct.MaBL_20194017 = bl.MaBL_20194017
	inner join NhanVien_DoLV nv 
	on nv.MaNV_20194017 = ct.MaNV_20194017
where year(bl.NgayLap_20194017) = 2021
group by pb.MaPB_20194017, pb.TenPB_20194017 
having sum(nv.heso_20194017 * pb.LuongPB_20194017 * ct.SoNgayCong_20194017) >= 500000


--5.1Thao tác select các Phòng bancó tên “....C...”
CREATE PROC PRO51
AS
BEGIN
SELECT *
FROM PhongBan_DoLV PB
WHERE SUBSTRING(PB.TenPB_20194017,1,1)='C'
END 
EXEC PRO51

--5.2Thao tác insert bảngPhòng ban với các dữ liệu như sau:(PB0006, Thanh tra pháp chế,C2-204, 550)
CREATE PROC PRO52	
@MAPB VARCHAR(10),@TENPB NVARCHAR(30),@DIACHI NVARCHAR(20),@LUONGPB INT
AS
INSERT INTO PhongBan_DoLV
VALUES (@MAPB,@TENPB,@DIACHI,@LUONGPB)
GO
EXEC PRO52 PB0006,N'Thanh tra pháp chế',N'C2-204',550

/*5.3 Thao tác select thông tin về Nhân Viên có địa chỉ ở Hà Nội hoặc Nam Định. Với các 
thông Mã Nhân viên, Tên Nhân viên, Địa chỉ, tổng số ngày công, tổng tiền Lương của
năm 2021.
Lê Văn Do 20194017
*/
create proc cau53
as
begin
	select nv.MaNV_20194017, nv.HotenNV_20194017, nv.DiaChi_20194017, 
		sum(ct.SoNgayCong_20194017) [tổng số ngày công],
		sum(nv.heso_20194017 * pb.LuongPB_20194017 * ct.SoNgayCong_20194017) [tổng lương]
	from PhongBan_DoLV pb inner join BangLuong_DoLV bl 
		on pb.MaPB_20194017 = bl.MaPB_20194017
		inner join ChiTietBangLuong_DoLV ct 
		on ct.MaBL_20194017 = bl.MaBL_20194017
		inner join NhanVien_DoLV nv 
		on nv.MaNV_20194017 = ct.MaNV_20194017
	where year(bl.NgayLap_20194017) = 2021 and
		nv.DiaChi_20194017 in (N'Hà Nội', N'Nam Định')
	group by nv.MaNV_20194017, nv.HotenNV_20194017, nv.DiaChi_20194017
end

exec cau53