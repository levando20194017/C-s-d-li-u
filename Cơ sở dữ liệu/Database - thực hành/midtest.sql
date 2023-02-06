create table NHANVIEN_DoLV
(
MANV_4017 varchar(10) primary key,
HOTEN_NV_4017 nvarchar(30),
NHIEMVU_4017 nvarchar(30),
LUONG_GIO int 
)
create table MAYBAY_DoLV
(
MAMB_4017 varchar(10) primary key,
TENMB_4017 nvarchar(30),
SOKHACH_4017 int
)
create table CHUYENBAY_DoLV
(
MACB_4017 varchar(10) primary key,
MAMB_4017 varchar(10),
NOIXP_4017 nvarchar(30),
NOIDEN_4017 nvarchar(30),
NGAYBAY_4017 date,
SOKHACH_4017 int,
SOGIOBAY_4017 real
)

create table CHITIETCHUYENBAY_DoLV
(
MACB_4017 varchar(10),
MANV_4017 varchar(10)
constraint ctcb_primarykey primary key (MACB_4017,MANV_4017)
)

--tạo check lương_giờ >= 100
alter table NHANVIEN_DoLV
add constraint chk_salary
check (NHIEMVU_4017 in (N'Cơ trưởng', N'Phó Cơ Trưởng', N'Tiếp Viên') and LUONG_GIO >= 100)

alter table MAYBAY_DoLV
add constraint chk_sokhach CHECK (SOKHACH_4017 >= 350 )

--Chuyến bay : Nơi xuất phát phải khác nơi đến
alter table CHUYENBAY_DoLV
add constraint chk_diemden CHECK (NOIXP_4017 != NOIDEN_4017)


alter table CHITIETCHUYENBAY_DoLV
	add foreign key(MANV_4017)
	references NHANVIEN_DoLV(MANV_4017)

alter table CHUYENBAY_DoLV
	add foreign key(MAMB_4017)
	references MAYBAY_DoLV(MAMB_4017)
	
alter table CHITIETCHUYENBAY_DoLV
	add foreign key(MACB_4017)
	references CHUYENBAY_DoLV(MACB_4017)

--Nhập dữ liệu cho bảng chuyển bay
insert into NHANVIEN_DoLV
VALUES('NV0001', N'Hoàng Long', N'Cơ trưởng', 150)
insert into NHANVIEN_DoLV
VALUES('NV0002', N'Trần Nam Anh', N'Phó cơ trưởng', 125)
insert into NHANVIEN_DoLV
VALUES('NV0003', N'LÊ TIẾN ĐẠT', N'Tiếp viên', 100)
insert into NHANVIEN_DoLV
VALUES('NV0004', N'Nguyễn Bình AN', N'Cơ Trưởng', 150)
insert into NHANVIEN_DoLV
VALUES('NV0005', N'Đinh Văn Minh', N'Phó cơ trưởng', 125)
insert into NHANVIEN_DoLV
VALUES('NV0006', N'Ngô Lệ Bình', N'Tiếp viên', 100)
insert into NHANVIEN_DoLV
VALUES('NV0007', N'Vũ Tuấn Anh', N'Tiếp viên', 100)

--Nhập bảng máy bay
insert into MAYBAY_DoLV
values ('BL750', 'Airbus A320', 450)
insert into MAYBAY_DoLV
values ('QH228', 'Airbus 321', 350)
insert into MAYBAY_DoLV
values ('VJ144', 'Boing A320', 450)
insert into MAYBAY_DoLV
values ('VJ146', 'Boing 146', 540)
insert into MAYBAY_DoLV
values ('VN216', 'Airbus A350', 500)
insert into MAYBAY_DoLV
values ('VN238', 'Boing A321', 450)

-- Chuyến Bay

insert into CHUYENBAY_DoLV
values ('CB0001', 'BL750', 'TP HCM', N'HÀ NỘI', '2021-10-10', 340, 5.5)
insert into CHUYENBAY_DoLV
values ('CB0002', 'QH228', N'Hà Nội', 'NHA TRANG', '2021-12-10', 300, 4.5)
insert into CHUYENBAY_DoLV
values ('CB0003', 'VJ144', 'TP HCM', N'ĐÀ NẴNG', '2021-11-10', 400, 2)
insert into CHUYENBAY_DoLV
values ('CB0004', 'VN216', N'Hà Nội', N'Đà Nẵng', '2021-10-15', 350, 3.5)
insert into CHUYENBAY_DoLV
values ('CB0005', 'VN238', 'TP HCM', N'Hà Nội', '2021-10-20', 350, 5.5)

-- Chi Tiết Chuyến Bay
insert into CHITIETCHUYENBAY_DoLV
values ('CB0001', 'NV0001')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0001', 'NV0002')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0001', 'NV0003')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0001', 'NV0006')



insert into CHITIETCHUYENBAY_DoLV
values ('CB0002', 'NV0004')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0002', 'NV0005')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0002', 'NV0006')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0002', 'NV0007')



insert into CHITIETCHUYENBAY_DoLV
values ('CB0003', 'NV0001')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0003', 'NV0002')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0003', 'NV0003')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0003', 'NV0007')



insert into CHITIETCHUYENBAY_DoLV
values ('CB0004', 'NV0001')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0004', 'NV0002')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0004', 'NV0006')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0004', 'NV0007')



insert into CHITIETCHUYENBAY_DoLV
values ('CB0005', 'NV0002')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0005', 'NV0003')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0005', 'NV0004')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0005', 'NV0005')
insert into CHITIETCHUYENBAY_DoLV
values ('CB0005', 'NV0006')

/*4.1Đưa ra mã nhân viên, tên nhân viên, nhiệm vụ, số chuyến bay, 
tổng số khách của những Cơ trưởng, điều hành máy bay có tên “Airbus...”có ngày bay trong tháng 10/2021.
*/
select nv.MANV_4017, nv.HOTEN_NV_4017, nv.NHIEMVU_4017, count(cb.MACB_4017) as SOCHUYENBAY, sum(cb.SOKHACH_4017) as SUM
from NHANVIEN_DoLV nv, CHUYENBAY_DoLV cb, MAYBAY_DoLV mb, CHITIETCHUYENBAY_DoLV ctcb
where mb.MAMB_4017 = cb.MAMB_4017
and nv.NHIEMVU_4017 = N'Cơ trưởng'
and nv.MANV_4017 = ctcb.MANV_4017
and ctcb.MACB_4017 = cb.MACB_4017
and month(cb.NGAYBAY_4017) = '10'
and year(cb.NGAYBAY_4017) = '2021'
and SUBSTRING(mb.TENMB_4017, 1, 6) = N'Airbus'
group by nv.MANV_4017, nv.HOTEN_NV_4017, nv.NHIEMVU_4017	

/*4.2Đưa ra máy bay có số tiền công cho nhân viên nhiều nhấtvới các thông tin: Mã máy bay, Tên máy bay, số khách chuẩn, 
tổng số nhân viên bay, số khách thựctế, Tiền công của máy baytrong tháng 10,11/2021. 
trong đó tiền công của máy bay bằng tổng tiềncủa cáccông nhân viên bay (Tiền công củanhân viên = số giờ bay * Lương theo giờ)*/
select top 1 mb.MAMB_4017, mb.TENMB_4017, sum(mb.SOKHACH_4017) as So_Khach_Chuan, 
count(nv.MANV_4017) as SoNV, sum(cb.SOKHACH_4017) as So_Khach_TT,
sum(cb.SOGIOBAY_4017 * nv.LUONG_GIO) as tien_cong
from MAYBAY_DoLV mb, NHANVIEN_DoLV nv, CHUYENBAY_DoLV cb, CHITIETCHUYENBAY_DoLV ctcb
where month(cb.NGAYBAY_4017) in (10,11)
and year(cb.NGAYBAY_4017) = '2021'
and nv.MANV_4017 = ctcb.MANV_4017
and ctcb.MACB_4017 = cb.MACB_4017
and mb.MAMB_4017 = cb.MAMB_4017
group by mb.MAMB_4017, mb.TENMB_4017
order by tien_cong desc
/*4.3. Đưa ra danh sách nhân viên có số chuyến bay >=3 với các thông tin: Mã nhân viên, họ tênnhân viên,
số chuyến bay, tổng số giờ bay, tổng tiền công trong năm 2021.*/
select nv.MANV_4017, nv.HOTEN_NV_4017,sum(cb.SOGIOBAY_4017), sum(cb.SOGIOBAY_4017 * nv.LUONG_GIO) as Luong
from NHANVIEN_DoLV nv, CHUYENBAY_DoLV cb, CHITIETCHUYENBAY_DoLV ctcb
where year(cb.NGAYBAY_4017) = 2021
and nv.MANV_4017 = ctcb.MANV_4017
and cb.MACB_4017 = ctcb.MACB_4017
group by nv.MANV_4017, nv.HOTEN_NV_4017
having count(nv.MANV_4017) >= 3

--5. Tạo Store procedure với các yêu cầu sau:
--5.1 Thao tác select các máy bay có tên “Airbus…”
create proc selectAir
as
select * from MAYBAY_DoLV mb where SUBSTRING(mb.TENMB_4017, 1, 6) = 'Airbus'
go
exec selectAir
--5.2 Thao tác insert bảng máy bay với các dữ liệu như sau:
--(Mã MB: VN12345, Tên MB: Vins 1236, số khách: 450)
create proc insertAir
@MAMB_4017 varchar(10), @TENMB_4017 varchar(30), @SOKHACH_4017 int
as
insert into MAYBAY_DoLV
values (@MAMB_4017, @TENMB_4017, @SOKHACH_4017)
go
exec insertAir 'VN12345', 'Vins 1236', 450
select * from MAYBAY_DoLV

--5.3 Thao tác select thông tin về Máy bay có tên “Airbus….” Với các thông tin danh sách phi
--hành đoàn ( mã nhân viên, họ tên, nhiệm, số giờ bay, tiền công).
create proc selectAir01
as
select nv.MANV_4017, nv.HOTEN_NV_4017, nv.NHIEMVU_4017,
sum(cb.SOGIOBAY_4017) as so_gio_bay,
sum(cb.SOGIOBAY_4017 * nv.LUONG_GIO) as tien_cong
from MAYBAY_DoLV mb, NHANVIEN_DoLV nv, CHITIETCHUYENBAY_DoLV detail, CHUYENBAY_DoLV cb
where SUBSTRING(mb.TENMB_4017, 1, 6) = 'Airbus'
and mb.MAMB_4017 = cb.MAMB_4017
and cb.MACB_4017 = detail.MACB_4017
and detail.MANV_4017 = nv.MANV_4017
group by nv.MANV_4017, nv.MANV_4017, nv.NHIEMVU_4017, nv.LUONG_GIO
go
exec selectAir01

