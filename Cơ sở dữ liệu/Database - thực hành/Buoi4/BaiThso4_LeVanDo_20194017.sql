CREATE PROCEDURE procedure_a1
/*các biến tham số vàora*/
AS
Begin print N'Lê Văn Do - 4017';
print N'Xin chào';
end 

exec procedure_a1

/*2a. In ra dòng chữ “ Xin chào” + @ten với @ten là tham số đầu vào là tên của 
bạn. Cho thực thi và in giá trị cảu các tham số này để kiểm tra*/
/*Lê Văn Do 20194017*/

create PROCEDURE procedure_a2a
@ten VARCHAR(10), @xau VARCHAR(30) out
AS
begin 
set @xau = N'Xin chào ' + @ten;
print N'Lê Văn Do - 4017'
end

declare @xau1 varchar(30)
exec procedure_a2a 'Lê Văn Do' , @xau1 out
print @xau1

/*3a  Nhập vào 2 số @s1,@s2. In ra câu “Tổng là : @tg’ với @tg = @s1+@s2
*/
CREATE PROCEDURE procedure_a3
@s1 int, @s2 int
as
begin
declare @tg int
set @tg = @s1 + @s2;
print N'Lê Văn Do - 4017';
print concat(N'Tổng là: ', @tg, N'với ', @tg, '=' , @s1, '+' , @s2)
end 

exec procedure_a3 1,2

/*4a Nhập vào 2 số @s1,@s2. Xuất min và max của chúng rat ham số
@max Cho thực thi và in giá trị của các tham số này để kiểm tra.*/
CREATE PROCEDURE procedure_a4
@s1 int, @s2 int
as begin
declare @min int, @max int
set @max = @s1
set @min = @s2
if @s1 < @s2 set @max = @s2
if @s1<@s2 set @min = @s1
print concat(N'max la: ', @max)
print concat(N'min la: ', @min)
end

exec procedure_a4 1, 2

/*5a Nhập vào số nguyên @n. In ra các số từ 1 đến @n. */
alter PROCEDURE procedure_a5
@n int
as begin
declare
@count int, @sum int
set @count = 1
set @sum = 0
print N'Lê Văn Do - 4017'
while(@count<=@n)
	begin
	print @count + ' '
	set @count = @count + 1 
	end
end

exec procedure_a5 5
-- 6a. Nhập vào số nguyên @n. In ra tổng các số chẵn từ 1 đến @n
--Lê Văn Do 20194017
create proc p6
@n int
as
begin
	declare @count int, @sum int
	set @count = 2
	set @sum = 0
	while (@count <= @n)
		begin
			set @sum = @sum + 2
			set @count = @count + 2
		end
	print concat('sum = ', @sum)
end
exec p6 7

/*7a. Viết store procedure tương ứng với các cầu ở phần View. Sau đó cho thể hiện kết quả*/
/*Lê Văn Do 20194017*/

create PROCEDURE procedure_a7
as
begin
	select ct.MACT_4017, ct.HOTEN_4017, ct.NGAYSINH_4017, ct.DIACHI_4017, ct.VITRI_4017
	from CAUTHU_DoLV_20194017 ct, CAULACBO_DoLV_20194017 clb, QUOCGIA_DoLV_20194017 qg
	where ct.MACLB_4017 = clb.MACLB_4017
	and ct.MAQG_4017 = qg.MAQG_4017
	and clb.TENCLB_4017 = N'SHB Đà Nẵng' and qg.TENQG_4017 = 'Bra-xin'
end

exec procedure_a7


create PROCEDURE procedure_a7_2
as begin
	SELECT MATRAN_4017, NGAYTD_4017, TENSAN_4017, C1.TENCLB_4017 AS TENCLB1, C2.TENCLB_4017 AS TENCLB2, KETQUA_4017
FROM TRANDAU_DoLV_20194017, CAULACBO_DoLV_20194017 AS C1, CAULACBO_DoLV_20194017 AS C2, SANVD_DoLV_20194017
WHERE VONG_4017 = 3
	  AND NAM_4017 = 2009
	  AND TRANDAU_DoLV_20194017.MACLB1_4017 = C1.MACLB_4017
	  AND TRANDAU_DoLV_20194017.MACLB2_4017 = C2.MACLB_4017
	  AND TRANDAU_DoLV_20194017.MASAN_4017 = SANVD_DoLV_20194017.MASAN_4017
end
exec procedure_a7_2

create PROCEDURE procedure_a7_3
as begin
select hlv.MAHLV_4017, hlv.TENHLV_4017, hlv.NGAYSINH_4017, hlv.DIACHI_4017, hlvclb.VAITRO_4017,
	clb.TENCLB_4017
from HUANLUYENVIEN_DoLV_20194017 hlv inner join HLV_CLB_DoLV_20194017 hlvclb on hlvclb.MAHLV_4017 = hlv.MAHLV_4017
	inner join QUOCGIA_DoLV_20194017 qg on qg.MAQG_4017 = hlv.MAQG_4017
	inner join CAULACBO_DoLV_20194017 clb on clb.MACLB_4017 = hlvclb.MACLB_4017
where qg.TENQG_4017 like N'Việt Nam'
end

exec procedure_a7_3


create PROCEDURE procedure_a7_4
as begin
select clb.MACLB_4017, clb.TENCLB_4017, svd.TENSAN_4017, svd.DIACHI_4017,
	count(ct.MACT_4017) as cnt
from CAULACBO_DoLV_20194017 clb inner join SANVD_DoLV_20194017 svd on svd.MASAN_4017 = clb.MASAN_4017
	inner join CAUTHU_DoLV_20194017 ct on ct.MACLB_4017 = clb.MACLB_4017
	inner join QUOCGIA_DoLV_20194017 qg on qg.MAQG_4017 = ct.MAQG_4017
where qg.TENQG_4017 not like N'Việt Nam'
group by clb.MACLB_4017, clb.TENCLB_4017, svd.TENSAN_4017, svd.DIACHI_4017
	having count(ct.MACT_4017) >= 2
end

exec procedure_a7_4

create PROCEDURE procedure_a7_5
as begin
select tinh.TENTINH_4017, count(ct.MACT_4017) as cnt
from CAULACBO_DoLV_20194017 clb inner join TINH_DoLV_20194017 tinh on tinh.MATINH_4017 = clb.MATINH_4017
	inner join CAUTHU_DoLV_20194017 ct on ct.MACLB_4017 = clb.MACLB_4017
where ct.VITRI_4017 like N'Tiền đạo'
group by tinh.TENTINH_4017
end

exec procedure_a7_5


/*8. Ứng với mỗi bảng trong CSDL QLBongDa, bạn hãy viết 4 stored Procedure ứng với 4 công việc 
Insert/Update/Delete/Select. Trong đó Stored procedure update và delete lấy khóa chính 
làm tham số*/
create PROCEDURE cau_a8_insert
@tenct nvarchar(50),
@vitri nvarchar(30),
@ngaysinh date,
@diachi nvarchar(50),
@maclb nvarchar(5),
@maqg nvarchar(5),
@so int
as begin
	insert into CAUTHU_DoLV_20194017(HOTEN_4017, VITRI_4017, NGAYSINH_4017, DIACHI_4017, MACLB_4017, MAQG_4017, SO_4017)
	values (@tenct, @vitri,@ngaysinh, @diachi, @maclb, @maqg, @so)
end
exec cau_a8_insert @tenct = N'Lê Văn A', @vitri = N'Tiền đạo', @ngaysinh = '2001-08-07', @diachi = null, @maclb = N'GDT', @maqg = N'VN', @so = 20



create PROCEDURE cau_a8_select
as begin
	select ct.HOTEN_4017, ct.VITRI_4017, ct.NGAYSINH_4017, ct.DIACHI_4017, ct.MACLB_4017, ct.SO_4017
	from CAUTHU_DoLV_20194017 ct, CAULACBO_DoLV_20194017 clb, QUOCGIA_DoLV_20194017 qg
	where ct.MACLB_4017 = clb.MACLB_4017
	and ct.MAQG_4017 = qg.MAQG_4017
end
exec cau_a8_select

create PROCEDURE cau_a8_update
	@mact int,
	@tenct nvarchar(50),
	@vitri nvarchar(30),
	@ngaysinh date,
	@diachi nvarchar(50),
	@maclb nvarchar(5),
	@maqg nvarchar(5),
	@so int
as begin
	update CAUTHU_DoLV_20194017
	set HOTEN_4017 = @tenct, VITRI_4017 = @vitri, NGAYSINH_4017 = @ngaysinh, DIACHI_4017 = @diachi, MACLB_4017 = @maclb,
	MAQG_4017 = @maqg, SO_4017 = @so
	where MACT_4017 = @mact
end

exec cau_a8_update 17, @tenct = N'Lê Văn Do', @vitri = N'Tiền đạo', @ngaysinh = '2001-08-07', @diachi = null, @maclb = N'SHB', @maqg = N'VN', @so = 17

--delete
create procedure deleteCauThu
@maCT varchar(5)
as 
	delete CAUTHU_DoLV_20194017
	where MACT_4017 = @maCT
go
exec deleteCauThu '17'
exec selectCauThu


-- 8.2 Bảng CAULACBO
-- select
create procedure selectCLB
as select * from CAULACBO_DoLV_20194017
go
exec selectCLB


-- insert
create procedure insertCLB
@maCLB varchar(5), @tenCLB nvarchar(100), @maSan varchar(5), @maTinh varchar(5)
as 
	insert into CAULACBO_DoLV_20194017
	values (@maCLB, @tenCLB, @maSan, @maTinh)
go

exec insertCLB 'HNFC', N'Hà Nội FC', 'LA', 'LA'
exec selectCLB

-- update
create procedure updateCLB
@maCLB varchar(5), @tenCLB nvarchar(100), @maSan varchar(5), @maTinh varchar(5)
as 
	update CAULACBO_DoLV_20194017
		set TENCLB_4017 = @tenCLB, MASAN_4017 = @maSan, MATINH_4017 = @maTinh
	where MACLB_4017 = @maCLB
go
exec updateCLB 'HNFC', N'CÂU LẠC BỘ HÀ NỘI', 'GD', 'BD'
exec selectCLB

-- delete
create procedure deleteCLB
@maCLB varchar(5)
as 
	delete CAULACBO_DoLV_20194017
	where MACLB_4017 = @maCLB
go
exec deleteCLB 'HNFC'
exec selectCLB

-- 8.3 Bảng HUANLUYENVIEN
-- select
create procedure selectHLV
as select * from HUANLUYENVIEN_DoLV_20194017
go
exec selectHLV

-- insert
create procedure insertHLV
@maHLV varchar(5), @tenHLV nvarchar(100), @ngaySinh datetime, @diaChi nvarchar(200), @dienthoai nvarchar(20), @maQG varchar(5)
as 
	insert into HUANLUYENVIEN_DoLV_20194017
	values (@maHLV, @tenHLV, @ngaySinh, @diaChi, @dienthoai, @maQG)
go
exec insertHLV N'HLV09', N'abc', '1997-02-20', NULL, '0123456789', 'VN'
exec selectHLV
-- update
create procedure updateHLV
@maHLV varchar(5), @tenHLV nvarchar(100), @ngaySinh datetime, @diaChi nvarchar(200), @dienthoai nvarchar(20), @maQG varchar(5)
as 
	update HUANLUYENVIEN_DoLV_20194017
		set MAHLV_4017 = @maHLV, TENHLV_4017 = @tenHLV, NGAYSINH_4017 = @ngaySinh, DIENTHOAI_4017 = @dienthoai,
		MAQG_4017 = @maQG
	where MAHLV_4017 = @maHLV
go
exec updateHLV N'HLV07', N'Nguyễn Tuấn Anh', '1997-10-20', NULL, '0123456000', 'VN'
exec selectCauThu

-- delete
create procedure deleteHLV
@maHLV varchar(5)
as 
	delete HUANLUYENVIEN_DoLV_20194017
	where MAHLV_4017 = @maHLV
go
exec deleteHLV 'HLV09'
exec selectHLV


-- b. Bài tập về Trigger
-- 1. Khi thêm cầu thủ mới, kiểm tra vị trí trên sân của cầu thủ chỉ thuộc một trong các vị trí sau:
-- Thủ môn, Tiền đạo, Tiền vệ, Trung vệ, Hậu vệ.
--Lê Văn Do 20194017
create trigger trigger_b1 on CAUTHU_DoLV_20194017 for insert
as
begin 
	declare @vitri nvarchar(20)
	select @vitri = inserted.VITRI_4017 from inserted
	if (@vitri != N'Thủ môn' and @vitri != N'Tiền đạo' and @vitri != N'Tiền vệ' and @vitri != N'Trung vệ' and @vitri != N'Hậu vệ') 
	begin
		print N'Vị trí không hợp lệ!'
		rollback tran
	end
end
-- Thuc thi trigger
insert into CAUTHU_DoLV_20194017
values  (N'Trần Văn A', N'Tiền vệ', '2001-05-11', NULL, 'BBD', 'VN', 19)
insert into CAUTHU_DoLV_20194017 
values  (N'Tạ Quang', N'Tiền vệ Tung tâm', '2001-05-11', NULL, 'BBD', 'VN', 19)
select * from CAUTHU_DoLV_20194017

-- xoa trigger
drop trigger trigger_b1

-- 2. Khi thêm cầu thủ mới, kiểm tra số áo của cầu thủ thuộc cùng một câu lạc bộ phải khác nhau
--Lê Văn Do 20194017
create trigger trigger_b2 on CAUTHU_DoLV_20194017 for insert
as 
begin
	declare @soao int, @maclb varchar(5)
	select @soao = inserted.SO_4017 from inserted
	select @maclb = inserted.MACLB_4017 from inserted
	if (select count(*) from CAUTHU_DoLV_20194017 WHERE MACLB_4017 = @maclb and SO_4017 = @soao) > 1
	begin
		print N'Số áo đã được sử dụng!'
		rollback tran
	end
end

-- Thuc thi trigger
insert into CAUTHU_DoLV_20194017 
values  (N'Nguyễn Thị Hồng Thái', N'Tiền vệ', '2001-05-11', NULL, 'BBD', 'VN', 201)
insert into CAUTHU_DoLV_20194017 
values  (N'ABC', N'Tiền vệ', '2001-05-11', NULL, 'BBD', 'VN', 201)
select * from CAUTHU_DoLV_20194017

-- xoa trigger
drop trigger trigger_b2

-- 3. Khi thêm thông tin cầu thủ thì in ra câu thông báo bằng Tiếng Việt ‘Đã thêm cầu thủ mới’
--Lê Văn Do 20194017
create trigger trigger_b3 on CAUTHU_DoLV_20194017 for insert
as 
begin
	begin
		print N'Đã thêm cầu thủ mới'
	end
end

-- Thuc thi trigger
insert into CAUTHU_DoLV_20194017 
values  (N'Hai Nam', N'Tiền vệ', '2001-05-11', NULL, 'BBD', 'VN', 105)
select * from CAUTHU_DoLV_20194017
-- xoa trigger
drop trigger trigger_b3

-- 4. Khi thêm cầu thủ mới, kiểm tra số lượng cầu thủ nước ngoài ở mỗi câu lạc bộ chỉ được
-- phép đăng ký tối đa 8 cầu thủ
--Lê Văn Do 20194017
create trigger trigger_b4 on CAUTHU_DoLV_20194017 for insert
as 
begin
	declare @clb varchar(5)
	select @clb = inserted.MACLB_4017 from inserted
	if (select count(*) from CAUTHU_DoLV_20194017 where MACLB_4017 = @clb and MAQG_4017 != 'VN') > 8
	begin
		print N'Không được quá 8 cầu thủ nước ngoài!'
		rollback tran
	end
end

-- Thuc thi trigger
insert into CAUTHU_DoLV_20194017 
values  (N'Lê Văn D', N'Tiền vệ', '2001-05-11', NULL, 'BBD', 'BRA', 22)
select * from CAUTHU_DoLV_20194017

-- xoa trigger
drop trigger trigger_b4

-- 5. Khi thêm tên quốc gia, kiểm tra tên quốc gia không được trùng với tên quốc gia đã có
--Lê Văn Do 20194017
create trigger trigger_b5 on QUOCGIA_DoLV_20194017 for insert
as 
begin
	declare @ten nvarchar(60)
	select @ten = inserted.TENQG_4017 from inserted
	if (@ten in (select TENQG_4017 from QUOCGIA_DoLV_20194017))
	begin
		print N'Tên quốc gia đã tồn tại!'
		rollback tran
	end
end

-- Thuc thi trigger
insert into QUOCGIA_DoLV_20194017
values  ('LAO', N'Lào')
insert into QUOCGIA_DoLV_20194017
values  ('VN6', N'Việt Nam')
insert into QUOCGIA_DoLV_20194017
values  ('BRA1', N'Bra-xin')
select * from QUOCGIA_DoLV_20194017



DROP TRIGGER TRIGGER_B5
GO

alter TRIGGER TRIGGER_BB5 ON QUOCGIA_DoLV_20194017
FOR INSERT
AS
BEGIN
	DECLARE @TENQG NVARCHAR(20)
	SELECT @TENQG = i.TENQG_4017 FROM inserted i
		
	IF (SELECT COUNT(*) FROM QUOCGIA_DoLV_20194017 WHERE TENQG_4017 = @TENQG ) > 1
		print N'Tên quốc gia đã tồn tại!'
		ROLLBACK TRANSACTION
	ELSE 
		PRINT N'Đã thêm quốc gia mới'
END;

INSERT INTO QUOCGIA_DoLV_20194017
VALUES ('LAO', N'Lào')
insert into QUOCGIA_DoLV_20194017
values  ('VN6', N'Việt Nam')
SELECT TENQG_4017 FROM QUOCGIA_DoLV_20194017

-- 6. Khi thêm tên tỉnh thành, kiểm tra tên tỉnh thành không được trùng với tên tỉnh thành đã có
--Lê Văn Do 20194017
create trigger trigger_b6 on TINH_DoLV_20194017 for insert
as 
begin
	declare @ten nvarchar(100)
	select @ten = inserted.TENTINH_4017 from inserted
	if (select count(*) from TINH_DoLV_20194017 t where @ten = t.TENTINH_4017) > 1
	begin
		print N'Tên Tỉnh đã tồn tại!'
		rollback tran
	end
end

-- Thuc thi trigger
insert into TINH_DoLV_20194017
values ('NA', N'Nghệ An')
insert into TINH_DoLV_20194017
values ('NA2', N'Nghệ An')
select * from TINH_DoLV_20194017


-- 7. Không cho sửa kết quả của các trận đấu đã diễn ra
--Lê Văn Do 20194017
create trigger trigger_b7 on TRANDAU_DoLV_20194017 for update
as 
begin
	if UPDATE(KETQUA_4017)
	begin
		print N'Không được chỉnh sửa kết quả trận đấu!'
		rollback tran
	end
end


update TRANDAU_DoLV_20194017
set KETQUA_4017 = '2-0'
where MATRAN_4017 = 1

select * from TRANDAU_DoLV_20194017