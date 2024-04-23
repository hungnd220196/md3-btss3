
create database quanlyBH;

use quanlyBH;


create table KhachHang
(
    MaKH     varchar(4) PRIMARY KEY,
    TenKH    varchar(30) not null,
    DiaChi   varchar(50),
    NgaySinh datetime,
    SoDT     varchar(15) unique
);

insert into KhachHang (MaKH, TenKH, DiaChi, NgaySinh, SoDT)
VALUES ('KH1', 'a', 'tn', '1990-01-01', '123456789'),
       ('KH2', 'b', 'hn', '1995-05-15', '987654321'),
       ('KH3', 'c', 'nd', '1988-08-08', '456123789'),
       ('KH4', 'd', 'kt', '1985-12-25', '789456123'),
       ('KH5', 'e', 'hcm', '1992-03-10', '654789321');

create table NhanVien
(
    MaNV       varchar(4) PRIMARY KEY,
    HoTen      varchar(30) not null,
    GioiTinh   bit         not null,
    DiaChi     varchar(50) not null,
    NgaySinh   datetime    not null,
    DienThoai  varchar(15),
    Email      text,
    NoiSinh    varchar(20) not null,
    NgayVaoLam datetime,
    MaNQL      varchar(4)

);
INSERT INTO NhanVien (MaNV, HoTen, GioiTinh, DiaChi, NgaySinh, DienThoai, Email, NoiSinh, NgayVaoLam, MaNQL)
VALUES ('1', 'John Doe', 1, '123 Main Street, City, Country', '1990-01-01', '123456789', 'john.doe@example.com', 'City',
        '2020-01-01', NULL),
       ('2', 'Jane Smith', 0, '456 Elm Street, City, Country', '1995-05-15', '987654321', 'jane.smith@example.com',
        'City', '2019-06-01', '1'),
       ('3', 'Alice Johnson', 0, '789 Oak Street, City, Country', '1988-08-08', '456123789',
        'alice.johnson@example.com', 'City', '2021-03-15', '1'),
       ('4', 'Bob Brown', 1, '321 Pine Street, City, Country', '1985-12-25', '789456123', 'bob.brown@example.com',
        'City', '2022-02-20', '2');
create table NhaCungCap
(
    MaNCC     varchar(5) PRIMARY KEY,
    TenNCC    varchar(50) not null,
    DiaChi    varchar(50) not null,
    DienThoai varchar(15) not null,
    Email     varchar(30) not null,
    Website   varchar(30)
);

insert into NhaCungCap (MaNCC, TenNCC, DiaChi, DienThoai, Email, Website)
values ('1', 'ABC Company', '123 Main Street, City, Country', '123456789', 'abc@example.com', 'www.abc.com'),
       ('2', 'XYZ Corporation', '456 Elm Street, City, Country', '987654321', 'xyz@example.com', 'www.xyz.com'),
       ('3', 'LMN Enterprises', '789 Oak Street, City, Country', '456123789', 'lmn@example.com', NULL),
       ('4', 'PQR Ltd.', '321 Pine Street, City, Country', '789456123', 'pqr@example.com', 'www.pqr.com');


create table LoaiSP
(
    MaLoaiSP  varchar(4) PRIMARY KEY,
    TenloaiSP varchar(30)  not null,
    GhiChu    varchar(100) not null
);

insert into LoaiSP (MaLoaiSP, TenloaiSP, GhiChu)
values ('1', 'loaisp1', 'ghi chu'),
       ('2', 'loaisp2', 'ghi chu'),
       ('3', 'loaisp3', 'ghi chu');

create table SanPham
(
    MaSP      varchar(4) PRIMARY KEY,
    MaloaiSP  varchar(4)  not null,
    TenSP     varchar(4)  not null,
    DonViTinh varchar(10) not null,
    GhiChu    varchar(100)
);

insert into SanPham (MaSP, MaloaiSP, TenSP, DonViTinh, GhiChu)
values ('1', '1', 'Java', '10', 'note'),
       ('2', '2', 'Java', '10', 'note'),
       ('3', '3', 'Java', '10', 'note'),
       ('4', '3', 'Java', '10', 'note');

update SanPham
set DonViTinh = 'chai'
where MaSP in ('2', '3');


alter table SanPham
    add CONSTRAINT fk_MaSP_MaloaiSP FOREIGN KEY (MaloaiSP) REFERENCES LoaiSP (MaLoaiSP);

CREATE TABLE PhieuNhap
(
    SoPN     VARCHAR(5) PRIMARY KEY,
    MaNV     VARCHAR(4) NOT NULL,
    MaNCC    VARCHAR(5) NOT NULL,
    NgayNhap DATETIME   NOT NULL DEFAULT now(),
    GhiChu   VARCHAR(100)
);


insert into PhieuNhap (SoPN, MaNV, MaNCC, NgayNhap, GhiChu)
VALUES ('1', '3', '1', '2024-12-12', 'notes'),
       ('2', '3', '1', '2024-12-12', 'database'),
       ('3', '3', '1', '2024-12-12', 'sql'),
       ('4', '2', '2', '2024-12-24', 'java');
update PhieuNhap
set NgayNhap = '2024-05-20'
where SoPN = '1';
update PhieuNhap
set NgayNhap = '2024-08-22'
where SoPN = '2';

alter table PhieuNhap
    add CONSTRAINT fk_SoPN_MaNV FOREIGN KEY (MaNV) REFERENCES NhanVien (MaNV);
alter table PhieuNhap
    add CONSTRAINT fk_SoPN_MaNCC FOREIGN KEY (MaNCC)
        REFERENCES NhaCungCap (MaNCC);

create table CTPhieuNhap
(
    MaSp    varchar(4) not null,
    SoPN    varchar(5) not null,
    Soluong smallint   not null DEFAULT 0,
    GiaNhap REAL       not null check (GiaNhap >= 0)
);
insert into CTPhieuNhap (MaSp, SoPN, Soluong, GiaNhap)
VALUES ('2', '1', 2, 30000),
       ('3', '2', 4, 60000),
       ('4', '3', 6, 20000);


alter table CTPhieuNhap
    add CONSTRAINT fk_MaSP_CTPhieuNhap FOREIGN KEY (MaSp)
        REFERENCES SanPham (MaSP);

alter table CTPhieuNhap
    add CONSTRAINT fk_SoPN_CTPhieuNhap FOREIGN KEY (SoPN)
        REFERENCES PhieuNhap (SoPN);

create table PhieuXuat
(
    SoPX    varchar(5) PRIMARY KEY,
    MaNV    varchar(4) not null,
    MaKH    varchar(4) not null,
    NgayBan datetime   not null DEFAULT NOW(),
    GhiChu  text                default null
);

insert into PhieuXuat (SoPX, MaNV, MaKH, NgayBan, GhiChu)
VALUES ('1', '4', 'KH1', '2024-04-05', 'java'),
       ('2', '2', 'KH2', '2024-08-05', 'test'),
       ('3', '3', 'KH3', '2024-03-05', 'demo'),
       ('4', '2', 'KH4', '2024-01-09', 'demo');



alter table PhieuXuat
    add CONSTRAINT fk_SoPX_MaNV FOREIGN KEY (MaNV) REFERENCES NhanVien (MaNV);
alter table PhieuXuat
    add CONSTRAINT fk_SoPX_MaKH FOREIGN KEY (MaKH) REFERENCES
        KhachHang (MaKH);

create table CTPhieuXuat
(
    SoPX    varchar(5) not null,
    MaSP    varchar(4) not null,
    SoLuong SMALLINT   not null,
    GiaBan  real       not null
);

INSERT INTO CTPhieuXuat (SoPX, MaSP, SoLuong, GiaBan)
VALUES ('1', '2', 10, 5.99),
       ('1', '2', 5, 9.99),
       ('2', '3', 8, 5.99),
       ('3', '3', 15, 7.49),
       ('4', '4', 20, 6.99);

alter table CTPhieuXuat
    add CONSTRAINT fk_CTPhieuXuat_SoPX FOREIGN KEY (SoPX) REFERENCES PhieuXuat (SoPX);
alter table CTPhieuXuat
    add CONSTRAINT fk_CTPhieuXuat_MaSP FOREIGN KEY (MaSP) REFERENCES
        SanPham (MaSP);


# Bai 4

update KhachHang
set SoDT =123123123
where MaKH = 'KH1';
update NhanVien
set HoTen = 'update name'
where MaNV = '1';

#Bai 5
# delete
# from CTPhieuNhap
# where SoPN = '1';
# delete
# from PhieuNhap
# where MaNV = '1';
# delete
# from NhanVien
# where MaNV = '1';
#
# delete
# from SanPham
# where MaSp = '1';

#Bai 6.1
Select *
from nhanVien
order by now() - NgaySinh desc;

#Bai 6.2

#filter hóa đơn
select *
FROM PhieuNhap
WHERE MONTH(ngaynhap) = 8
  AND YEAR(ngaynhap) = 2018;

#Bai 6.3

select *
from SanPham
where DonViTinh = 'chai';

#Bai 6.4

select CTPN.SoPN,
       CTPN.MaSp,
       SP.TenSP,
       SP.TenSP,
       SP.DonViTinh,
       CTPN.Soluong,
       CTPN.GiaNhap,
       CTPN.GiaNhap * CTPN.Soluong as ThanhTien

from CTPhieuNhap as CTPN
         join SanPham as SP on SP.MaSP = CTPN.MaSp
where month(current_date());

#Bai 6.5

select PN.MaNCC,
       NCC.TenNCC,
       NCC.DiaChi,
       NCC.DienThoai,
       PN.SoPN,
       PN.NgayNhap

from PhieuNhap as PN
         join NhaCungCap as NCC on NCC.MaNCC = PN.MaNCC
where month(PN.NgayNhap) = 12
order by PN.NgayNhap desc;

#Bai 6.6

select CTPX.SoPX,
       NV.HoTen                   as NhanVienBanHang,
       PX.NgayBan,
       SP.MaSP,
       SP.TenSP,
       SP.DonViTinh,
       CTPX.GiaBan,
       CTPX.GiaBan * CTPX.SoLuong as DoanhThu

from CTPhieuXuat CTPX
         join PhieuXuat PX on PX.SoPX = CTPX.SoPX
         join NhanVien NV on NV.MaNV = PX.MaNV
         join SanPham SP on SP.MaSP = CTPX.MaSP
where MONTH(PX.NgayBan) between 01 and 06;

#Bai 6.7

select *
from NhanVien
where MONTH(NgaySinh) = current_date();

#Bai 6.8

SELECT PX.SoPX,
       NV.HoTen,
       PX.NgayBan,
       MIN(SP.MaSP)                    AS MaSP,
       MIN(SP.TenSP)                   AS TenSP,
       MIN(SP.DonViTinh)               AS DonViTinh,
       SUM(CTPX.SoLuong)               AS TongSoLuong,
       MIN(CTPX.GiaBan)                AS GiaBan,
       SUM(CTPX.SoLuong * CTPX.GiaBan) AS DoanhThu
FROM CTPhieuXuat CTPX
         JOIN PhieuXuat PX ON CTPX.SoPX = PX.SoPX
         JOIN SanPham SP ON CTPX.MaSP = SP.MaSP
         JOIN NhanVien NV ON PX.MaNV = NV.MaNV
WHERE PX.NgayBan BETWEEN '2024-02-14' AND '2024-05-16'
GROUP BY PX.SoPX, NV.HoTen, PX.NgayBan;

#Bai 6.9

SELECT PX.SoPX,
       PX.NgayBan,
       PX.MaKH,
       KH.TenKH,
       SUM(CPX.GiaBan * CPX.SoLuong) AS TriGia
FROM PhieuXuat PX
         JOIN CTPhieuXuat CPX ON PX.SoPX = CPX.SoPX
         JOIN KhachHang KH ON KH.MaKH = PX.MaKH
GROUP BY PX.SoPX, PX.NgayBan, PX.MaKH, KH.TenKH;


#Bai 6.10

select sum(CTPX.SoLuong) as Total

from CTPhieuXuat CTPX
         join SanPham SP on CTPX.MaSP = SP.MaSP
         join PhieuXuat PX on CTPX.SoPX = PX.SoPX
where MONTH(PX.NgayBan) between 1 and 6
  and SP.TenSP = 'Rice';

#Bai 6.11

select MONTH(PX.NgayBan)             as MoiThang,
       PX.MaKH,
       KH.TenKH,
       KH.DiaChi,
       sum(CPX.SoLuong * CPX.GiaBan) as TongTien

from KhachHang as KH
         join PhieuXuat PX on PX.MaKH = KH.MaKH
         join CTPhieuXuat CPX on PX.SoPX = CPX.SoPX
group by MONTH(PX.NgayBan), PX.MaKH, MONTH(PX.NgayBan), KH.TenKH, KH.DiaChi;

#Bai 6.12

select MONTH(PX.NgayBan) as months,
       YEAR(PX.NgayBan)  as years,
       SP.MaSP,
       SP.TenSP,
       SP.DonViTinh,
       CTPX.SoLuong      as TongSoLuong

from CTPhieuXuat as CTPX
         join PhieuXuat PX on CTPX.SoPX = PX.SoPX
         join SanPham SP on CTPX.MaSP = SP.MaSP
where MONTH(PX.NgayBan) between 1 and 12
order by MONTH(PX.NgayBan);

#Bai 6.13

SELECT MONTH(PX.NgayBan)               AS month,
       SUM(CTPX.GiaBan * CTPX.SoLuong) AS DoanhThu
FROM CTPhieuXuat AS CTPX
         JOIN PhieuXuat PX ON CTPX.SoPX = PX.SoPX
WHERE MONTH(PX.NgayBan) BETWEEN 1 AND 6
GROUP BY MONTH(PX.NgayBan)
ORDER BY MONTH(PX.NgayBan);


#Bai 6.14
SELECT CTPX.SoPX,
       NV.HoTen,
       KH.TenKH,
       SUM(CTPX.GiaBan * CTPX.SoLuong) AS TongTriGia
FROM CTPhieuXuat AS CTPX
         JOIN PhieuXuat PX ON CTPX.SoPX = PX.SoPX
         JOIN NhanVien NV ON PX.MaNV = NV.MaNV
         JOIN KhachHang KH ON PX.MaKH = KH.MaKH
WHERE MONTH(PX.NgayBan) BETWEEN 4 AND 6
GROUP BY CTPX.SoPX, NV.HoTen, KH.TenKH;


#Bai 6.15

SELECT PX.SoPX,
       KH.MaKH,
       KH.TenKH,
       NV.HoTen,
       PX.NgayBan,
       SUM(CPX.SoLuong * CPX.GiaBan) as TriGia
FROM PhieuXuat AS PX
         JOIN
     CTPhieuXuat CPX ON PX.SoPX = CPX.SoPX
         JOIN
     KhachHang KH ON PX.MaKH = KH.MaKH
         JOIN
     NhanVien NV ON PX.MaNV = NV.MaNV
WHERE MONTH(PX.NgayBan) = MONTH(CURRENT_DATE())
GROUP BY PX.SoPX, KH.MaKH, NV.HoTen, PX.NgayBan;


#Bai 6.16

SELECT PX.MaNV,
       NV.HoTen,
       SP.MaSP,
       SP.TenSP,
       SP.DonViTinh,
       SUM(CPX.SoLuong)
FROM PhieuXuat PX
         JOIN
     CTPhieuXuat CPX ON PX.SoPX = CPX.SoPX
         JOIN
     SanPham AS SP ON SP.MaSP = CPX.MaSP
         JOIN
     NhanVien NV ON PX.MaNV = NV.MaNV
GROUP BY PX.MaNV, NV.HoTen, SP.MaSP, SP.TenSP, SP.DonViTinh;


#Bai 6.17

SELECT PX.SoPX,
       PX.NgayBan,
       SP.MaSP,
       SP.TenSP,
       CPX.SoLuong,
       SP.DonViTinh,
       SUM(CPX.SoLuong * CPX.GiaBan) as ThanhTien
FROM PhieuXuat PX
         JOIN
     CTPhieuXuat CPX ON PX.SoPX = CPX.SoPX
         JOIN
     SanPham SP ON CPX.MaSP = SP.MaSP
         JOIN
     KhachHang KH ON PX.MaKH = KH.MaKH
WHERE MONTH(PX.NgayBan) BETWEEN 4 AND 6
  AND KH.MaKH = 'KH1'
GROUP BY PX.SoPX, PX.NgayBan, SP.MaSP, SP.TenSP, CPX.SoLuong, SP.DonViTinh;


#Bai 6.18

SELECT SP.MaSP, SP.TenSP, LSP.TenloaiSP AS LoaiSP, SP.DonViTinh
FROM SanPham SP
         LEFT JOIN CTPhieuXuat CT ON SP.MaSP = CT.MaSP
         LEFT JOIN LoaiSP LSP ON SP.MaloaiSP = LSP.MaLoaiSP
         LEFT JOIN PhieuXuat PX ON CT.SoPX = PX.SoPX
WHERE PX.NgayBan IS NULL OR YEAR(PX.NgayBan) < 2018 OR MONTH(PX.NgayBan) > 6;



#Bai 6.19

SELECT NCC.MaNCC, NCC.TenNCC, NCC.DiaChi, NCC.DienThoai
FROM NhaCungCap NCC
         LEFT JOIN (SELECT DISTINCT MaNCC
                    FROM PhieuNhap
                    WHERE YEAR(NgayNhap) = 2018
                      AND MONTH(NgayNhap) BETWEEN 4 AND 6
                    UNION
                    SELECT DISTINCT MaKH
                    FROM PhieuXuat
                    WHERE YEAR(NgayBan) = 2018
                      AND MONTH(NgayBan) BETWEEN 4 AND 6) AS GD
                   ON NCC.MaNCC = GD.MaNCC
WHERE GD.MaNCC IS NULL;

#Bai 6.20

SELECT KH.MaKH,
       SUM(CTPX.GiaBan * CTPX.SoLuong) AS TongTriGia
FROM KhachHang KH
         JOIN
     PhieuXuat PX ON KH.MaKH = PX.MaKH
         JOIN
     CTPhieuXuat CTPX ON CTPX.SoPX = PX.SoPX
WHERE MONTH(PX.NgayBan) BETWEEN 1 AND 6
GROUP BY KH.MaKH
HAVING SUM(CTPX.GiaBan * CTPX.SoLuong) = (SELECT MAX(Total)
                                          FROM (SELECT SUM(CTPX.GiaBan * CTPX.SoLuong) AS Total
                                                FROM PhieuXuat PX
                                                         JOIN
                                                     CTPhieuXuat CTPX ON PX.SoPX = CTPX.SoPX
                                                WHERE MONTH(PX.NgayBan) BETWEEN 1 AND 6
                                                GROUP BY PX.MaKH) AS Subquery);

#Bonus
#Cho biết khách hàng có tổng trị giá đơn hàng lớn nhất trong 6 tháng đầu năm
SELECT KH.MaKH,
       KH.TenKH,
       SUM(CPX.GiaBan * CPX.SoLuong) AS TongTriGia
FROM KhachHang KH
         JOIN
     PhieuXuat PX ON KH.MaKH = PX.MaKH
         JOIN
     CTPhieuXuat CPX ON PX.SoPX = CPX.SoPX
GROUP BY KH.MaKH, KH.TenKH
HAVING SUM(CPX.GiaBan * CPX.SoLuong) = (SELECT MAX(Total)
                                        FROM (SELECT SUM(CPX.GiaBan * CPX.SoLuong) AS Total
                                              FROM KhachHang KH
                                                       JOIN
                                                   PhieuXuat PX ON KH.MaKH = PX.MaKH
                                                       JOIN
                                                   CTPhieuXuat CPX ON PX.SoPX = CPX.SoPX
                                              WHERE MONTH(PX.NgayBan) BETWEEN 1 AND 6
                                              GROUP BY PX.MaKH) AS Subquery);

#Bai 6.21

select KH.MaKH, SUM(CPX.SoLuong)

from KhachHang KH
         join PhieuXuat PX on KH.MaKH = PX.MaKH
         join CTPhieuXuat CPX on PX.SoPX = CPX.SoPX
group by KH.MaKH;

#Bai 6.22
SELECT NV.MaNV, NV.HoTen AS TenNhanVien, PX.MaKH, KH.TenKH AS TenKhachHang
FROM NhanVien NV
         LEFT JOIN PhieuXuat PX ON NV.MaNV = PX.MaNV
         LEFT JOIN KhachHang KH ON PX.MaKH = KH.MaKH;


#Bai 6.23

select count(CASE when NV.GioiTinh = true then 1 end)  as NhanViennam,
       count(case when NV.GioiTinh = false then 0 end) as NhanVienNu
from NhanVien as NV;
#Bai 6.24

select nv.MaNQL,
       nv.HoTen,
       YEAR(CURRENT_DATE) - YEAR(nv.NgayVaoLam) as ThamNien

from NhanVien AS NV
;

#Bai 6.25
select nv.HoTen
from NhanVien as NV
where (YEAR(CURRENT_DATE()) - YEAR(NV.NgaySinh) > 60 AND NV.GioiTinh = true)
   or (YEAR(CURRENT_DATE()) - YEAR(NV.NgaySinh) > 55 AND NV.GioiTinh = false);

#Bai 6.26
select nv.HoTen,
       case
           when NV.GioiTinh = true then YEAR(NV.NgaySinh) + 60
           when NV.GioiTinh = false then YEAR(NV.NgaySinh) + 55
           end as NamVeHuu
from NhanVien as NV;

#Bai 6.27

select nv.HoTen,
       case
           when year(current_date) - year(nv.NgayVaoLam) < 1 then 200000
           when year(current_date) - year(nv.NgayVaoLam) >= 1 and
                year(current_date) - year(nv.NgayVaoLam) < 3 then 400000
           when year(current_date) - year(nv.NgayVaoLam) >= 3 and
                year(current_date) - year(nv.NgayVaoLam) < 5 then 600000
           when year(current_date) - year(nv.NgayVaoLam) >= 5 and
                year(current_date) - year(nv.NgayVaoLam) < 10 then 800000
           when year(current_date) - year(nv.NgayVaoLam) > 10 then 1000000
           end as TienThuong

from NhanVien as nv;

#Bai 6.28

select *

from SanPham sp
         join LoaiSP LSP on LSP.MaLoaiSP = sp.MaloaiSP
where LSP.TenloaiSP = 'Hoa My Pham';

#Bai 6.29

select *
from SanPham sp
         join LoaiSP LS on sp.MaloaiSP = ls.MaLoaiSP
where ls.TenloaiSP = 'Quan Ao';

#Bai 6.30

select count(*)
from SanPham sp
         join LoaiSP LS on sp.MaloaiSP = LS.MaLoaiSP
where ls.TenloaiSP = 'Quan Ao';

#Bai 6.31

select count(*)
from SanPham SP
         join LoaiSP LS on SP.MaloaiSP = LS.MaLoaiSP
where ls.TenloaiSP = 'Hoa My Pham';

#Bai 6.32

select count(MaSP) as SoLuong,
       LSP.TenloaiSP
from LoaiSP LSP
         join SanPham SP on SP.MaloaiSP = LSP.MaLoaiSP
group by LSP.TenloaiSP;