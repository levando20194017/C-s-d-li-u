/* Lê Văn Do 20194017
Ôn tập 2*/
--TẠO BẢNG NHÂN VIÊN
create database ONTAP2_DoLV
use ONTAP2_DoLV
create table NHANVIEN_DoLV
(
MANV_4017 varchar(5) primary key,
HOTEN_NV_4017 nvarchar(25),
NGAYSINH_4017 smalldatetime,
GIOITINH_4017 char(5),
MAPB_4017 varchar(5),
MACV_4017 varchar(5)
)
create table CHUCVU_DoLV
(
MACHUCVU_4017 varchar(5) primary key,
TENCHUCVU_4017 nvarchar(25),
LUONGCHUCVU_4017 int
)
create table PHONGBAN_DoLV
(
MAPHONGBAN_4017 varchar(5) primary key,
TENPHONGBAN_4017 nvarchar(25),
DIACHIPB_4017 nvarchar(25)
)
create table DUAN_DoLV
(
MADA_4017 varchar(5) primary key,
TENDUAN_4017 nvarchar(200),
KINHPHI_4017 int,
NGAY_BD_4017 smalldatetime,
NGAY_KT_4017 smalldatetime
)
create table PHANCONG_4017
(
MANV_4017 varchar(5), 
MADA_4017 varchar(5),
SONGAYCONG_4017 int,
constraint chk_primarykey primary key (MANV_4017,MADA_4017)
)


/* Lê Văn Do 20194017
Ôn tập 2*/
--TẠO CHECK NHÂN VIÊN CÓ TUỔI TỪ 25 TRỞ LÊN, GIỚI TÍNH GỒM NAM, NỮ
alter table NHANVIEN_DoLV 
add constraint chk_tuoi1 CHECK (getdate() - NGAYSINH_4017 > 25 )
alter table NHANVIEN_DoLV
add constraint chk_gioitinh1 CHECK (GIOITINH_4017 in ('Nam','Nu'))

/* Lê Văn Do 20194017
Ôn tập 2*/
--TẠO CHECK LƯƠNG CHỨC VỤ >= 500 VÀ <= 1500
alter table CHUCVU_DoLV
add constraint chk_luong CHECK (LUONGCHUCVU_4017 between 500 and 1500)


/* Lê Văn Do 20194017
Ôn tập 2*/
--TẠO CHECK NGÀY KẾT THÚC SAU NGÀY BẮT ĐẦU 2 NĂM
alter table DUAN_DoLV
add constraint chk_thoi_gian_du_an1 CHECK (NGAY_KT_4017-NGAY_BD_4017 >=  2)

--NỐI BẢNG NHÂN VIÊN VÀ BẢNG PHÒNG BAN
alter table NHANVIEN_DoLV
	add foreign key(MAPB_4017)
	references PHONGBAN_DoLV(MAPHONGBAN_4017)

--NỐI BẢNG NHÂN VIÊN VÀ BẢNG CHỨC VỤ
alter table NHANVIEN_DoLV
	add foreign key(MACV_4017)
	references CHUCVU_DoLV(MACHUCVU_4017)

--NỐI BẢNG NHÂN VIÊN VÀ BẢNG PHÂN CÔNG
alter table PHANCONG_DoLV
	add foreign key(MANV_4017)
	references NHANVIEN_DoLV(MANV_4017)

--NỐI BẢNG DỰ ÁN VÀ BẢNG PHÒNG BAN
alter table PHANCONG_DoLV
	add foreign key(MADA_4017)
	references DUAN_DoLV(MADA_4017)

/* Lê Văn Do 20194017
Ôn tập 2*/--NHẬP DỮ LIỆU CHO BẢNG CHỨC VỤ
insert into CHUCVU_DoLV
values('GD' , 'Giam Doc' , 1000)
insert into CHUCVU_DoLV
values ('GV' , 'Giao vu',500)
insert into CHUCVU_DoLV
values('GV-TS', 'Giang vien TS',900)
insert into CHUCVU_DoLV
values('GVthS','Giang vien ThS', 700)
insert into CHUCVU_DoLV
values('PTBM','Pho truong BM', 800)
insert into CHUCVU_DoLV
values('PV','Can bo ky thuat', 600)
insert into CHUCVU_DoLV
values('PVT','Vien pho', 1200)
insert into CHUCVU_DoLV
values('TBM','Truong BM', 1000)
insert into CHUCVU_DoLV
values('VT','Vien Truong', 1500)


/* Lê Văn Do 20194017
Ôn tập 2*/
--NHẬP DỮ LIỆU CHO BẢNG PHÒNG BAN
insert into PHONGBAN_DoLV
values('CNPM', 'CONG NGHE PHAN MEM','B1-601')
insert into PHONGBAN_DoLV
values('HTTT', 'HE THONG THONG TIN','B1-603')
insert into PHONGBAN_DoLV
values('KHMT','KHOA HOC MAY TINH','B1-602')
insert into PHONGBAN_DoLV
values('KTMT','KY THUAT MAY TINH','B1-502')
insert into PHONGBAN_DoLV
values('TTM','TRUYEN THONG MANG','B1-501')
insert into PHONGBAN_DoLV
values('TTMT','TRUNG TÂM MÁY TÍNH','B1-401')
insert into PHONGBAN_DoLV
values('VPV','VĂN PHÒNG VIỆN','B1-504')

/* Lê Văn Do 20194017
Ôn tập 2*/
--NHẬP DỮ LIỆU CHO BẢNG PHÂN CÔNG
INSERT into  PHANCONG_4017
values('NV001' , 'DA04' , 10)
INSERT into  PHANCONG_4017
values('NV001' , 'DA05' , 10)
INSERT into  PHANCONG_4017
values('NV002' , 'DA04' , 24)
INSERT into  PHANCONG_4017
values('NV002' , 'DA05' , 24)
INSERT into  PHANCONG_4017
values('NV003' , 'DA02' , 10)
INSERT into  PHANCONG_4017
values('NV003' , 'DA03' , 10)
INSERT into  PHANCONG_4017
values('NV004' , 'DA02' , 24)
INSERT into  PHANCONG_4017
values('NV004' , 'DA03' , 24)
INSERT into  PHANCONG_4017
values('NV005' , 'DA02' , 10)
INSERT into  PHANCONG_4017
values('NV005' , 'DA03' , 10)
INSERT into  PHANCONG_4017
values('NV005' , 'DA04' , 10)
INSERT into  PHANCONG_4017
values('NV005' , 'DA05' , 10)
INSERT into  PHANCONG_4017
values('NV006' , 'DA02' , 24)
INSERT into  PHANCONG_4017
values('NV007' , 'DA02' , 10)




/* Lê Văn Do 20194017
Ôn tập 2*/
--NHẬP DỮ LIỆU CHO BẢNG NHÂN VIÊN
insert into NHANVIEN_DoLV
values ('NV001','LE THANH LONG', '1990/01/10','Nam','CNPM','GV')
insert into NHANVIEN_DoLV
values('NV002','LE THANH TUAN','1990/01/10','Nam','CNPM','GV')
insert into NHANVIEN_DoLV
values('NV003','NGUYEN VAN NAM','1992/10/15','Nam','KHMT','GV-TS')
insert into NHANVIEN_DoLV
values('NV004','NGUYEN LAN HUONG','1992/01/01','Nu','KHMT','GD')
insert into NHANVIEN_DoLV
values('NV005','DINH THU HANG','1992/01/01','Nu','KHMT','TBM')
insert into NHANVIEN_DoLV
values('NV006','TRAN NAM ANH','1992/01/01','Nam','KHMT','PTBM')
insert into NHANVIEN_DoLV
values('NV007','LE VAN DONG','1992/01/01','Nam','TTM','GV')
insert into NHANVIEN_DoLV
values('NV008','NGUYEN THI THU','1992/01/01','Nu','TTM','PV')
insert into NHANVIEN_DoLV
values('NV009','VU HONG HANH','1992/01/01','Nu','KHMT','VT')
insert into NHANVIEN_DoLV
values('NV010','LE THANH TUNG','1990/01/10','Nam','CNPM','GV')

/* Lê Văn Do 20194017
Ôn tập 2*/
insert into DUAN_DoLV
values('DA02' , 'QUAN LY THONG TIN CSVC'  , 1500000 , '2019-01-01' , '2021-01-01')
insert into DUAN_DoLV
values('DA03' , 'QUAN LY THONG TIN PHONG THI NGHIEM'  , 2000000 , '2019-01-10' , '2021-01-10')
insert into DUAN_DoLV
values('DA04' , 'QUAN LY THONG TIN KHOA HOC CONG NGHE '  , 2400000 , '2019-01-10' , '2021-01-10')
insert into DUAN_DoLV
values('DA05' , 'QUAN LY THONG TIN DAOTAO'  , 2500000 , '2019-01-01' , '2021-01-01')
insert into DUAN_DoLV
values('DA06' , 'QUAN LY THONG TIN DAOTAO'  , 2600000 , '2019-09-01' , '2021-09-01')

/* Lê Văn Do 20194017
Ôn tập 2*/
--TÌM CÁC NHÂN VIÊN ĐANG THỰC HIỆN DỰ ÁN MÃ “DA05”
SELECT nv.HOTEN_NV_4017, pc.SONGAYCONG_4017*cv.LUONGCHUCVU_4017[LƯƠNG]
FROM NHANVIEN_DoLV nv, DUAN_DoLV da, PHANCONG_4017 pc,CHUCVU_DoLV cv
WHERE nv.MANV_4017=pc.MANV_4017 and da.MADA_4017=pc.MADA_4017 and nv.MACV_4017=cv.MACHUCVU_4017 and da.MADA_4017='DA05'

/* Lê Văn Do 20194017
Ôn tập 2*/
--TÌM MÃ, TÊN NHÂN VIÊN, SỐ DỰ ÁN THAM GIA VÀ TỔNG LƯƠNG CÁC DỰ ÁN CỦA MỖI NHÂN VIÊN
SELECT nv.MANV_4017,nv.HOTEN_NV_4017, count (pc.MADA_4017)[số dự án],sum(pc.SONGAYCONG_4017*cv.LUONGCHUCVU_4017)[Lương]
FROM NHANVIEN_DoLV nv, DUAN_DoLV da, PHANCONG_4017 pc,CHUCVU_DoLV cv
where da.MADA_4017=pc.MADA_4017 and nv.MANV_4017=pc.MANV_4017 and cv.MACHUCVU_4017=nv.MACV_4017
group by nv.MANV_4017,nv.HOTEN_NV_4017

/* Lê Văn Do 20194017
Ôn tập 2*/
--TÌM NHỮNG NHÂN VIÊN CÓ KHẢ NĂNG THỰC HIỆN TẤT CẢ CÁC DỰ ÁN ĐƯỢC PHÂN CÔNG
SELECT nv.MANV_4017,nv.HOTEN_NV_4017
FROM NHANVIEN_DoLV nv, DUAN_DoLV da, PHANCONG_4017 pc
where da.MADA_4017=pc.MADA_4017 and nv.MANV_4017=pc.MANV_4017 
group by nv.MANV_4017,nv.HOTEN_NV_4017
having count(da.MADA_4017)=5