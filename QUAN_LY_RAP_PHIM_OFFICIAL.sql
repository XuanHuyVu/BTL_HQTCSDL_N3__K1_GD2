CREATE DATABASE QUAN_LY_RAP_PHIM_OFFICIAL
ON PRIMARY
(
    NAME = 'QUAN_LY_RAP_PHIM_OFFICIAL',
    FILENAME = 'E:\HQTCSDL\THUCHANH\BTL_HQTCSDL_N3__K1_GD2\QUAN_LY_RAP_PHIM_OFFICIAL.mdf',
    SIZE = 10MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 2MB
)
LOG ON
(
    NAME = 'QUAN_LY_RAP_PHIM_OFFICIAL_Log',
    FILENAME = 'E:\HQTCSDL\THUCHANH\BTL_HQTCSDL_N3__K1_GD2\QUAN_LY_RAP_PHIM_OFFICIAL.ldf',
    SIZE = 5MB,
    MAXSIZE = 20MB,
    FILEGROWTH = 1MB
)
USE QUAN_LY_RAP_PHIM_OFFICIAL;
-- Create THELOAIPHIM table
CREATE TABLE THELOAIPHIM (
    MaTheLoai VARCHAR(10) PRIMARY KEY,
    TenTheLoai NVARCHAR(50),
    TrangThaiPhim NVARCHAR(20)
);

-- Create NHACUNGCAP table
CREATE TABLE NHACUNGCAP (
    MaNCC VARCHAR(10) PRIMARY KEY,
    MaQuanLy VARCHAR(10),
    TenNCC NVARCHAR(100),
    DiaChi NVARCHAR(200),
    TinhTrang NVARCHAR(50),
    SDT VARCHAR(15),
    Email VARCHAR(100)
);

-- Create TAIKHOAN table
CREATE TABLE TAIKHOAN (
    TenTaiKhoan VARCHAR(50) PRIMARY KEY,
    MatKhau VARCHAR(100),
    VaiTro NVARCHAR(20)
);

-- Create NHANVIEN table
CREATE TABLE NHANVIEN (
    MaNhanVien VARCHAR(10) PRIMARY KEY,
    TenTaiKhoan VARCHAR(50),
    TenNhanVien NVARCHAR(100),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    DiaChi NVARCHAR(200),
    NgayVaoLam DATE,
    ViTri NVARCHAR(50),
    SoDienThoai VARCHAR(15),
    Gmail VARCHAR(100),
    NgayRa DATE,
    FOREIGN KEY (TenTaiKhoan) REFERENCES TAIKHOAN(TenTaiKhoan)
);

-- Add column MaQuanLy
ALTER TABLE NHANVIEN
ADD MaQuanLy VARCHAR(10);
-- Add foreign key to NHANVIEN after QUANLY creation
ALTER TABLE NHANVIEN
ADD FOREIGN KEY (MaQuanLy) REFERENCES QUANLY(MaQuanLy);

-- Create QUANLY table
CREATE TABLE QUANLY (
    MaQuanLy VARCHAR(10) PRIMARY KEY,
    TenTaiKhoan VARCHAR(50),
    TenQuanLy NVARCHAR(100),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    DiaChi NVARCHAR(200),
    NgayVaoLam DATE,
    ViTri NVARCHAR(50),
    SoDienThoai VARCHAR(15),
    Gmail VARCHAR(100),
    NgayRa DATE,
    FOREIGN KEY (TenTaiKhoan) REFERENCES TAIKHOAN(TenTaiKhoan)
);

-- Add foreign key to NHACUNGCAP after QUANLY creation
ALTER TABLE NHACUNGCAP
ADD FOREIGN KEY (MaQuanLy) REFERENCES QUANLY(MaQuanLy);

-- Create PHIM table
CREATE TABLE PHIM (
    MaPhim VARCHAR(10) PRIMARY KEY,
    TenPhim NVARCHAR(100),
    MaTheLoai VARCHAR(10),
    ThoiLuong INT,
    NgayCongChieu DATE,
    TrangThai NVARCHAR(20),
    MoTa NVARCHAR(MAX),
    DuongDan VARCHAR(200),
    MaNCC VARCHAR(10),
    FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC),
    FOREIGN KEY (MaTheLoai) REFERENCES THELOAIPHIM(MaTheLoai)
);

-- Create PHONGCHIEU table
CREATE TABLE PHONGCHIEU (
    MaPhongChieu VARCHAR(10) PRIMARY KEY,
    TenPhong NVARCHAR(50),
    SoGhe INT,
    LoaiPhong NVARCHAR(20),
    TrangThaiPhong NVARCHAR(20)
);

-- Create LOAIGHE table
CREATE TABLE LOAIGHE (
    MaLoaiGhe VARCHAR(10) PRIMARY KEY,
    TenLoaiGhe NVARCHAR(50),
    MoTa NVARCHAR(200),
    GiaGhe DECIMAL(10,2),
    MauGhe NVARCHAR(20)
);

-- Create GHENGOI table
CREATE TABLE GHENGOI (
    MaGhe VARCHAR(10) PRIMARY KEY,
    MaLoaiGhe VARCHAR(10),
    MaPhongChieu VARCHAR(10),
    HangGhe VARCHAR(5),
    SoGhe INT,
    TrangThai NVARCHAR(20),
    GiaGhe DECIMAL(10,2),
    NgayDat DATE,
    FOREIGN KEY (MaLoaiGhe) REFERENCES LOAIGHE(MaLoaiGhe),
    FOREIGN KEY (MaPhongChieu) REFERENCES PHONGCHIEU(MaPhongChieu)
);

-- Create LICHCHIEU table
CREATE TABLE LICHCHIEU (
    MaLichChieu VARCHAR(10) PRIMARY KEY,
    MaPhim VARCHAR(10),
    NgayChieu DATE,
    GioBatDau TIME,
    GioKetThuc TIME,
    DinhDangPhim NVARCHAR(20),
    NgonNgu NVARCHAR(20),
    TrangThai NVARCHAR(20),
    SoVeConLai INT,
    FOREIGN KEY (MaPhim) REFERENCES PHIM(MaPhim)
);

-- Create KHACHHANG table
CREATE TABLE KHACHHANG (
    MaKhachHang VARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100),
    SDT VARCHAR(15),
    Email VARCHAR(100),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    DiaChi NVARCHAR(200),
    LoaiKhachHang NVARCHAR(20),
    LichSuGiaoDich NVARCHAR(MAX),
    DiemTichLuy INT
);

-- Create HOADON table
CREATE TABLE HOADON (
    MaHoaDon VARCHAR(10) PRIMARY KEY,
    MaKhachHang VARCHAR(10),
    MaNhanVien VARCHAR(10),
    MaDoAn VARCHAR(10),
    NgayLapHoaDon DATETIME,
    TongTien DECIMAL(10,2),
    KieuThanhToan NVARCHAR(50),
    TrangThaiThanhToan NVARCHAR(20),
    ChiTiet NVARCHAR(MAX),
    MaVoucher VARCHAR(10),
    ThueVAT DECIMAL(5,2),
    GhiChu NVARCHAR(200),
    FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang),
    FOREIGN KEY (MaNhanVien) REFERENCES NHANVIEN(MaNhanVien)
);

-- Create MAGIAMGIA table
CREATE TABLE MAGIAMGIA (
    MaVoucher VARCHAR(10) PRIMARY KEY,
    GiaTriVoucher DECIMAL(10,2),
    NgayHetHan DATE,
    TrangThaiVoucher NVARCHAR(20),
    MaKhachHang VARCHAR(10),
    SoLuongSuDung INT,
    MoTa NVARCHAR(200),
    MaHoaDon VARCHAR(10),
    FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang),
    FOREIGN KEY (MaHoaDon) REFERENCES HOADON(MaHoaDon)
);

-- Add foreign key to HOADON after MAGIAMGIA creation
ALTER TABLE HOADON
ADD FOREIGN KEY (MaVoucher) REFERENCES MAGIAMGIA(MaVoucher);

-- Create DOAN table
CREATE TABLE DOAN (
    MaDoAn VARCHAR(10) PRIMARY KEY,
    TenDoAn NVARCHAR(100),
    Gia DECIMAL(10,2),
    TrangThai NVARCHAR(20),
    NgayNhap DATE,
    MaHoaDon VARCHAR(10),
    FOREIGN KEY (MaHoaDon) REFERENCES HOADON(MaHoaDon)
);

-- Add foreign key to HOADON after DOAN creation
ALTER TABLE HOADON
ADD FOREIGN KEY (MaDoAn) REFERENCES DOAN(MaDoAn);

-- Create TINTUC table
CREATE TABLE TINTUC (
    MaTinTuc VARCHAR(10) PRIMARY KEY,
    MaPhim VARCHAR(10),
    MaNhanVien VARCHAR(10),
    TieuDe NVARCHAR(200),
    NoiDung NVARCHAR(MAX),
    HinhAnh VARCHAR(200),
    TrangThaiTin NVARCHAR(20),
    SoLuotXem INT,
    BinhLuan NVARCHAR(MAX),
    FOREIGN KEY (MaPhim) REFERENCES PHIM(MaPhim),
    FOREIGN KEY (MaNhanVien) REFERENCES NHANVIEN(MaNhanVien)
);

-- Create VE table
CREATE TABLE VE (
    MaVe VARCHAR(10) PRIMARY KEY,
    MaPhim VARCHAR(10),
    TenPhim NVARCHAR(100),
    NgayChieu DATE,
    DonGia DECIMAL(10,2),
    LoaiVe NVARCHAR(20),
    SoLuong INT,
    TrangThaiVe NVARCHAR(20),
    MaGhe VARCHAR(10),
    NgayBan DATE,
    ThanhToan DECIMAL(10,2),
    MaKhachHang VARCHAR(10),
    MaLichChieu VARCHAR(10),
    MaHoaDon VARCHAR(10),
    FOREIGN KEY (MaPhim) REFERENCES PHIM(MaPhim),
    FOREIGN KEY (MaGhe) REFERENCES GHENGOI(MaGhe),
    FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang),
    FOREIGN KEY (MaLichChieu) REFERENCES LICHCHIEU(MaLichChieu),
    FOREIGN KEY (MaHoaDon) REFERENCES HOADON(MaHoaDon)
);

-- Create PHIM_THELOAIPHIM junction table
CREATE TABLE PHIM_THELOAIPHIM (
    MaPhim VARCHAR(10),
    MaTheLoai VARCHAR(10),
    PRIMARY KEY (MaPhim, MaTheLoai),
    FOREIGN KEY (MaPhim) REFERENCES PHIM(MaPhim),
    FOREIGN KEY (MaTheLoai) REFERENCES THELOAIPHIM(MaTheLoai)
);

-- Create KHACHHANG_MAGIAMGIA junction table
CREATE TABLE KHACHHANG_MAGIAMGIA (
    MaKhachHang VARCHAR(10),
    MaVoucher VARCHAR(10),
    PRIMARY KEY (MaKhachHang, MaVoucher),
    FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang),
    FOREIGN KEY (MaVoucher) REFERENCES MAGIAMGIA(MaVoucher)
);

-- Insert data table THELOAIPHIM
INSERT INTO THELOAIPHIM (MaTheLoai, TenTheLoai, TrangThaiPhim) VALUES
('TL001', 'Phim hành động', 'Hoạt động'),
('TL002', 'Phim hài hước', 'Hoạt động'),
('TL003', 'Phim tâm lý', 'Hoạt động'),
('TL004', 'Phim cổ trang', 'Hoạt động'),
('TL005', 'Phim kinh dị', 'Hoạt động'),
('TL006', 'Phim hoạt hình', 'Hoạt động'),
('TL007', 'Phim chiến tranh', 'Ngừng hoạt động');

-- Insert data table TAIKHOAN
INSERT INTO TAIKHOAN (TenTaiKhoan, MatKhau, VaiTro) VALUES
('HienLuong', '27092004', 1),
('QuangHieu', '07112004', 1),
('XuanHuy', '25092004', 1),
('ThuyLien', '24012004', 1),
('NguyenDinh', '12042004', 1),
('LeThang', 'password6', 0),
('LeLuong', 'password7', 0),
('HongQuang', 'password8', 0),
('VietHien', 'password9', 0),
('NgocAnh', 'password10', 0),
('HongNgat', 'password11', 0);

-- Insert data table QUANLY
INSERT INTO QUANLY (MaQuanLy, TenTaiKhoan, TenQuanLy, NgaySinh, GioiTinh, DiaChi, NgayVaoLam, ViTri, SoDienThoai, Gmail, NgayRa) VALUES
('QL001', 'HienLuong', N'Đỗ Thị Hiền Lương', '2004-09-27', N'Nữ', N'Hải Phòng', '2010-02-20', N'Quản lý phòng chiếu', '0912345678', 'hienluong@gmail.com', NULL),
('QL002', 'QuangHieu', N'Nguyễn Quang Hiếu', '2004-11-07', N'Nam', N'Gia Lai', '2012-05-15', N'Quản lý vé', '0912345679', 'quanghieu@gmail.com', NULL),
('QL003', 'XuanHuy', N'Vũ Xuân Huy', '2004-09-25', N'Nam', N'Hải Dương', '2015-08-01', N'Quản lý nhân sự', '0912345680', 'xuanhuy@gmail.com', NULL),
('QL004', 'ThuyLien', N'Lương Thị Thùy Liên', '2004-01-24', N'Nữ', N'Thái Bình', '2016-03-10', N'Quản lý dịch vụ khách hàng', '0912345681', 'thuylien@gmail.com', NULL),
('QL005', 'NguyenDinh', N'Nguyễn Thị Dinh', '2004-04-12', N'Nữ', N'Hải Phòng', '2018-11-25', N'Quản lý tài chính', '0912345682', 'nguyendinh@gmail.com', NULL);

-- Insert data table NHANVIEN
INSERT INTO NHANVIEN (MaNhanVien, MaQuanLy, TenTaiKhoan, TenNhanVien, NgaySinh, GioiTinh, DiaChi, NgayVaoLam, ViTri, SoDienThoai, Gmail, NgayRa)
VALUES
('NV001', 'QL001', N'LeThang', N'Lê Thắng', '1992-01-15', N'Nam', N'Thái Bình', '2015-05-10', N'Nhân viên', '0912345672', N'lethang@gmail.com', NULL),
('NV002', 'QL002', N'LeLuong', N'Lê Lương', '1993-02-25', N'Nữ', N'Hà Nội', '2016-06-22', N'Nhân viên', '0912345673', N'leluong@gmail.com', NULL),
('NV003', 'QL003', N'HongQuang', N'Hồng Quang', '1994-03-12', N'Nam', N'Gia Lai', '2017-07-15', N'Nhân viên', '0912345674', N'hongquang@gmail.com', NULL),
('NV004', 'QL004', N'VietHien', N'Viết Hiển', '1995-04-10', N'Nam', N'Hà Nội', '2018-08-01', N'Nhân viên', '0912345675', N'viethien@gmail.com', NULL),
('NV005', 'QL005', N'NgocAnh', N'Ngọc Ánh', '1996-05-18', N'Nữ', N'Bắc Giang', '2019-09-12', N'Nhân viên', '0912345676', N'ngocanh@gmail.com', NULL),
('NV006', 'QL001', N'HongNgat', N'Hồng Ngát', '1997-06-22', N'Nữ', N'Thái Bình', '2020-10-25', N'Nhân viên', '0912345677', N'hongngat@gmail.com', NULL);

-- Insert data table PHONGCHIEU
INSERT INTO PHONGCHIEU (MaPhongChieu, TenPhong, SoGhe, LoaiPhong, TrangThaiPhong) VALUES 
('1', N'Phòng 1', 216, N'Phòng thường', N'Đang hoạt động'),
('2', N'Phòng 2', 160, N'Phòng VIP', N'Đang bảo trì'),
('3', N'Phòng 3', 300, N'Phòng thường', N'Đang hoạt động'),
('4', N'Phòng 4', 192, N'Phòng thường', N'Đang hoạt động');

-- Insert data table LOAIGHE
INSERT INTO LOAIGHE (MaLoaiGhe, TenLoaiGhe, MoTa, GiaGhe, MauGhe) VALUES
('LG005', N'Ghế Thường', N'Ghế tiêu chuẩn phổ thông', 45000, N'Xám'),
('LG006', N'Ghế VIP', N'Ghế cao cấp, vị trí trung tâm', 120000, N'Vàng'),
('LG007', N'Ghế Đôi', N'Ghế đôi có không gian riêng tư', 160000, N'Tím'),
('LG008', N'Ghế Deluxe', N'Ghế cao cấp với tính năng ngả lưng', 210000, N'Nâu'),
('LG009', N'Ghế Thường', N'Ghế tiêu chuẩn cho phòng nhỏ', 40000, N'Xanh Lá'),
('LG010', N'Ghế VIP', N'Ghế cao cấp cho rạp VIP', 125000, N'Bạc'),
('LG011', N'Ghế Đôi', N'Ghế đôi thiết kế sang trọng', 165000, N'Đỏ Thẫm'),
('LG012', N'Ghế Deluxe', N'Ghế cao cấp với thiết kế hiện đại', 220000, N'Trắng'),
('LG013', N'Ghế Thường', N'Ghế thường giá rẻ', 35000, N'Xanh Dương'),
('LG014', N'Ghế VIP', N'Ghế VIP có thêm gối tựa', 130000, N'Đen'),
('LG015', N'Ghế Đôi', N'Ghế đôi có bàn mini đi kèm', 175000, N'Vàng Gold'),
('LG016', N'Ghế Deluxe', N'Ghế Deluxe với sưởi ấm', 250000, N'Cam');

-- Insert data table KHACHHANG
INSERT INTO KHACHHANG (MaKhachHang, HoTen, SDT, Email, NgaySinh, GioiTinh, DiaChi, LoaiKhachHang, LichSuGiaoDich, DiemTichLuy) VALUES
('KH001', N'NGUYEN THI HUYEN TRANG', '09123456789', 'huyentrang01@gmail.com', '1990-05-12', N'Nữ', N'123 Lê Lợi, Hà Nội', N'VIP', NULL, 500),
('KH002', N'CHAU GIA MINH', '09123456780', 'gia.minh@gmail.com', '1985-03-15', N'Nam', N'456 Đường Nguyễn Trãi, Hà Nội', N'VIP', NULL, 300),
('KH003', N'NGUYEN VAN DA', '09123456781', 'nguyendav@gmail.com', '1992-07-20', N'Nam', N'789 Phố Bà Triệu, Hà Nội', N'Thường', NULL, 200),
('KH004', N'LE ANH PHUOC', '09123456782', 'anhphuoc@gmail.com', '1989-09-10', N'Nam', N'123/3 Nguyễn Chí Thanh, Hà Nội', N'Thường', NULL, 150),
('KH005', N'NGUYEN TRUNG KIEN', '09123456783', 'trungkien@gmail.com', '1990-02-02', N'Nam', N'456A Láng Hạ, Hà Nội', N'VIP', NULL, 700),
('KH006', N'NGUYEN CONG HIEU', '09123456784', 'conghieu@gmail.com', '1993-06-16', N'Nam', N'789B Đội Cấn, Hà Nội', N'Thường', NULL, 250),
('KH007', N'TRAN QUAN VINH', '09123456785', 'quanvinh@gmail.com', '1991-01-25', N'Nam', N'101 Lê Duẩn, Hà Nội', N'VIP', NULL, 500),
('KH008', N'NGUYEN THI NGHIA', '09123456786', 'nghianguyen@gmail.com', '1994-08-19', N'Nữ', N'102 Hoàng Hoa Thám, Hà Nội', N'Thường', NULL, 300),
('KH009', N'TRAN THI THAO HIEN', '09123456787', 'thaohien@gmail.com', '1995-11-12', N'Nữ', N'103 Phố Xã Đàn, Hà Nội', N'Thường', NULL, 200),
('KH010', N'NGUYEN THI THUY', '09123456788', 'thuynguyen@gmail.com', '1992-04-18', N'Nữ', N'104 Phố Hàng Gai, Hà Nội', N'VIP', NULL, 600),
('KH011', N'DANG KHAC VY', '09123456789', 'khacvy@gmail.com', '1988-12-30', N'Nữ', N'105 Trần Duy Hưng, Hà Nội', N'Thường', NULL, 400),
('KH012', N'NGUYEN NGOC THUY', '09123456790', 'ngocthuy@gmail.com', '1991-07-14', N'Nữ', N'106 Bạch Mai, Hà Nội', N'VIP', NULL, 550),
('KH013', N'NGUYEN THI BICH HANH', '09123456791', 'bichhanh@gmail.com', '1992-05-22', N'Nữ', N'107 Phố Cầu Giấy, Hà Nội', N'Thường', NULL, 300),
('KH014', N'LY CHUNG LUONG', '09123456792', 'chungluong@gmail.com', '1993-09-06', N'Nam', N'108 Tràng Tiền, Hà Nội', N'Thường', NULL, 200),
('KH015', N'NGUYEN THI TUYET', '09123456793', 'tuyetnguyen@gmail.com', '1987-06-10', N'Nữ', N'109 Phố Mê Linh, Hà Nội', N'VIP', NULL, 700),
('KH016', N'DUONG LE HUONG', '09123456794', 'lehuong@gmail.com', '1994-10-14', N'Nữ', N'110 Hoàng Mai, Hà Nội', N'Thường', NULL, 350),
('KH017', N'NGUYEN THI THOM', '09123456795', 'thomnguyen@gmail.com', '1990-11-02', N'Nữ', N'111 Bến Xe Mỹ Đình, Hà Nội', N'Thường', NULL, 250),
('KH018', N'NGUYEN HOAI PHUONG', '09123456796', 'hoai.phuong@gmail.com', '1988-03-08', N'Nữ', N'112 Nguyễn Lương Bằng, Hà Nội', N'VIP', NULL, 500),
('KH019', N'TRAN DANG KHOA', '09123456797', 'dangkhoa@gmail.com', '1995-12-25', N'Nam', N'113 Đội Cấn, Hà Nội', N'Thường', NULL, 200),
('KH020', N'HOANG NAM LONG', '09123456798', 'namlong@gmail.com', '1991-02-15', N'Nam', N'114 Nguyễn Công Trứ, Hà Nội', N'VIP', NULL, 650),
('KH021', N'NGUYEN THI CAM VAN', '09123456799', 'camvan@gmail.com', '1985-07-01', N'Nữ', N'115 Lê Trọng Tấn, Hà Nội', N'Thường', NULL, 300),
('KH022', N'NGUYEN THI LUU', '09123456700', 'thi.luu@gmail.com', '1993-05-18', N'Nữ', N'116 Chùa Láng, Hà Nội', N'VIP', NULL, 700),
('KH023', N'NGUYEN THI LANG', '09123456701', 'nguyenlang@gmail.com', '1994-10-22', N'Nữ', N'117 Đại Cổ Việt, Hà Nội', N'Thường', NULL, 200),
('KH024', N'HOANG HAI YEN', '09123456702', 'haiyen@gmail.com', '1987-03-12', N'Nữ', N'118 Tôn Thất Thuyết, Hà Nội', N'VIP', NULL, 600),
('KH025', N'NGUYEN HOANG LONG', '09123456703', 'hoanglong@gmail.com', '1991-12-19', N'Nam', N'119 Đường Láng, Hà Nội', N'Thường', NULL, 400),
('KH026', N'TRAN THI THUY DUNG', '09123456704', 'thuydung@gmail.com', '1992-06-01', N'Nữ', N'120 Lý Thường Kiệt, Hà Nội', N'VIP', NULL, 550),
('KH027', N'DAO VAN TUNG', '09123456705', 'vantung@gmail.com', '1995-03-20', N'Nam', N'121 Lê Đức Thọ, Hà Nội', N'Thường', NULL, 250),
('KH028', N'NGUYEN THI KIM CHI', '09123456706', 'kimchi@gmail.com', '1990-12-10', N'Nữ', N'122 Láng, Hà Nội', N'VIP', NULL, 600),
('KH029', N'NGUYEN THI NGUYEN', '09123456707', 'thinguye@gmail.com', '1989-04-05', N'Nữ', N'123 Mai Dịch, Hà Nội', N'Thường', NULL, 350),
('KH030', N'DANG NHU QUYNH', '09123456708', 'nhuquynh@gmail.com', '1991-11-13', N'Nữ', N'124 Ngọc Hà, Hà Nội', N'VIP', NULL, 500),
('KH031', N'TRAN QUOC TAM', '09123456709', 'quoctam@gmail.com', '1992-02-20', N'Nam', N'125 Hòa Mã, Hà Nội', N'Thường', NULL, 150),
('KH032', N'TRAN HAI DUONG', '09123456710', 'haiduong@gmail.com', '1993-08-08', N'Nam', N'126 Cát Linh, Hà Nội', N'VIP', NULL, 450),
('KH033', N'NGUYEN THI NGAN', '09123456711', 'ngannguyen@gmail.com', '1990-03-03', N'Nữ', N'127 Kim Mã, Hà Nội', N'Thường', NULL, 200),
('KH034', N'BUI THI DIU', '09123456712', 'thidiu@gmail.com', '1989-05-17', N'Nữ', N'128 Nguyễn Thái Học, Hà Nội', N'VIP', NULL, 700),
('KH035', N'BUI DANG MY DUYEN', '09123456713', 'myduyen@gmail.com', '1994-09-29', N'Nữ', N'129 Nguyễn Văn Cừ, Hà Nội', N'Thường', NULL, 250),
('KH036', N'HOANG VAN LUONG', '09123456714', 'vanluong@gmail.com', '1992-11-11', N'Nam', N'130 Thanh Xuân, Hà Nội', N'VIP', NULL, 600),
('KH037', N'HUYNH THI NGOC TUYEN', '09123456715', 'ngoctuyen@gmail.com', '1990-04-05', N'Nữ', N'131 Chợ Dừa, Hà Nội', N'Thường', NULL, 150),
('KH038', N'CHAU THI TRANG', '09123456716', 'chautrang@gmail.com', '1991-07-21', N'Nữ', N'132 Phố Hàng Cót, Hà Nội', N'VIP', NULL, 500),
('KH039', N'TRAN MINH NGOC', '09123456717', 'minhngoc@gmail.com', '1993-01-19', N'Nam', N'133 Trần Quốc Toản, Hà Nội', N'Thường', NULL, 200),
('KH040', N'NGUYEN THI MUA', '09123456718', 'mua.nguyen@gmail.com', '1990-06-12', N'Nữ', N'134 Nguyễn Khang, Hà Nội', N'VIP', NULL, 650),
('KH041', N'TRAN THI LAN', '09123456719', 'thilan@gmail.com', '1995-05-14', N'Nữ', N'135 Láng Hạ, Hà Nội', N'Thường', NULL, 300),
('KH042', N'NGUYEN DUY HOANG', '09123456720', 'duyhoang@gmail.com', '1987-09-22', N'Nam', N'136 Đại La, Hà Nội', N'VIP', NULL, 700),
('KH043', N'BUI THI MAI', '09123456721', 'buimail@gmail.com', '1990-07-08', N'Nữ', N'137 Phố Láng Hạ, Hà Nội', N'Thường', NULL, 400),
('KH044', N'LE THANH NGOC', '09123456722', 'thanhngoc@gmail.com', '1989-10-19', N'Nam', N'138 Trần Đại Nghĩa, Hà Nội', N'VIP', NULL, 500),
('KH045', N'NGUYEN THI MINH', '09123456723', 'minhnguyen@gmail.com', '1991-05-01', N'Nữ', N'139 Trần Quang Khải, Hà Nội', N'Thường', NULL, 350),
('KH046', N'PHAM TUAN KHAI', '09123456724', 'tuankhaik@gmail.com', '1994-06-30', N'Nam', N'140 Nguyễn Khang, Hà Nội', N'VIP', NULL, 600),
('KH047', N'NGUYEN PHUONG TIEN', '09123456725', 'phuongtien@gmail.com', '1990-10-15', N'Nữ', N'141 Trần Bình, Hà Nội', N'Thường', NULL, 200),
('KH048', N'TRINH THI CUC', '09123456726', 'cuc.trinh@gmail.com', '1991-02-08', N'Nữ', N'142 Hàng Đào, Hà Nội', N'VIP', NULL, 700),
('KH049', N'VAN QUOC TUAN', '09123456727', 'vanquoc@gmail.com', '1988-01-22', N'Nam', N'143 Quận Hoàn Kiếm, Hà Nội', N'Thường', NULL, 300),
('KH050', N'NGUYEN THI LAM', '09123456728', 'lam.nguyen@gmail.com', '1992-09-17', N'Nữ', N'144 Thanh Xuân, Hà Nội', N'VIP', NULL, 650),
('KH051', N'NGUYEN DANG TAM', '09123456701', 'nguyendangtam@gmail.com', '1990-01-01', N'Nữ', N'123 Lê Lợi, Hà Nội', N'VIP', NULL, 500),
('KH052', N'NGUYEN DUC HANH', '09123456702', 'nguyenduchanh@gmail.com', '1989-02-02', N'Nam', N'456 Hai Bà Trưng, Hà Nội', N'VIP', NULL, 500),
('KH053', N'NGUYEN HOANG', '09123456703', 'nguyenhoang@gmail.com', '1988-03-03', N'Nữ', N'789 Nguyễn Trãi, Hà Nội', N'Thường', NULL, 300),
('KH054', N'NGUYEN HOANG YEN', '09123456704', 'nguyenhoangyen@gmail.com', '1991-04-04', N'Nữ', N'101 Lê Đức Thọ, Hà Nội', N'VIP', NULL, 700),
('KH055', N'NGUYEN HONG VAN', '09123456705', 'nguyenhongvan@gmail.com', '1992-05-05', N'Nam', N'202 Hoàng Mai, Hà Nội', N'Thường', NULL, 200),
('KH056', N'NGUYEN HUYEN SON', '09123456706', 'nguyenhuyenson@gmail.com', '1993-06-06', N'Nữ', N'303 Bạch Mai, Hà Nội', N'VIP', NULL, 800),
('KH057', N'NGUYEN LA MINH TAM', '09123456707', 'nguyenlaminhtam@gmail.com', '1994-07-07', N'Nam', N'404 Minh Khai, Hà Nội', N'Thường', NULL, 250),
('KH058', N'NGUYEN LAN ANH', '09123456708', 'nguyenlananh@gmail.com', '1995-08-08', N'Nữ', N'505 Phan Đình Phùng, Hà Nội', N'VIP', NULL, 600),
('KH059', N'NGUYEN MAI BAO TRAM', '09123456709', 'nguyenmaibaotram@gmail.com', '1996-09-09', N'Nữ', N'606 Láng Hạ, Hà Nội', N'Thường', NULL, 350),
('KH060', N'NGUYEN MINH SON', '09123456710', 'nguyenminhson@gmail.com', '1997-10-10', N'Nam', N'707 Nguyễn Lương Bằng, Hà Nội', N'VIP', NULL, 900),
('KH061', N'NGUYEN MINH VU', '09123456711', 'nguyenminhvu@gmail.com', '1998-11-11', N'Nữ', N'808 Đại Cồ Việt, Hà Nội', N'Thường', NULL, 400),
('KH062', N'NGUYEN NGHIA HIEP', '09123456712', 'nguyengnhiahiep@gmail.com', '1999-12-12', N'Nam', N'909 Trần Duy Hưng, Hà Nội', N'VIP', NULL, 1000),
('KH063', N'NGUYEN PHAN MINH KHOI', '09123456713', 'nguyenphanminhkhoi@gmail.com', '2000-01-13', N'Nữ', N'1010 Đường Láng, Hà Nội', N'Thường', NULL, 150),
('KH064', N'NGUYEN PHUONG DUNG', '09123456714', 'nguyenphuongdung@gmail.com', '2001-02-14', N'Nam', N'1111 Nguyễn Thị Minh Khai, Hà Nội', N'VIP', NULL, 1200),
('KH065', N'NGUYEN TAN DUC', '09123456715', 'nguyentanduc@gmail.com', '2002-03-15', N'Nữ', N'1212 Hoàng Văn Thụ, Hà Nội', N'Thường', NULL, 180),
('KH066', N'NGUYEN THAI HIEP', '09123456716', 'nguyenthaihiep@gmail.com', '2003-04-16', N'Nữ', N'1313 Cầu Giấy, Hà Nội', N'Thường', NULL, 200),
('KH067', N'NGUYEN THANH CHUONG', '09123456717', 'nguyenthanhchuong@gmail.com', '2004-05-17', N'Nam', N'1414 Lê Văn Sỹ, Hà Nội', N'VIP', NULL, 250),
('KH068', N'NGUYEN THI DOAN TRANG', '09123456718', 'nguyenthidoantrang@gmail.com', '2005-06-18', N'Nữ', N'1515 Hàng Bông, Hà Nội', N'Thường', NULL, 150),
('KH069', N'NGUYEN THI HONG DUC', '09123456719', 'nguyenthihongduc@gmail.com', '2006-07-19', N'Nam', N'1616 Trường Chinh, Hà Nội', N'VIP', NULL, 500),
('KH070', N'NGUYEN THI MAI HUONG', '09123456720', 'nguyenthimaihuong@gmail.com', '2007-08-20', N'Nữ', N'1717 Nguyễn Trãi, Hà Nội', N'Thường', NULL, 300),
('KH071', N'NGUYEN THI PHUOC', '09123456721', 'nguyenthiphuc@gmail.com', '2008-09-21', N'Nam', N'1818 Hoàng Hoa Thám, Hà Nội', N'VIP', NULL, 600),
('KH072', N'NGUYEN THI PHUONG TH', '09123456722', 'nguyenthiphuongth@gmail.com', '2009-10-22', N'Nữ', N'1919 Minh Khai, Hà Nội', N'Thường', NULL, 450),
('KH073', N'NGUYEN THI THU HA', '09123456723', 'nguyenthithuha@gmail.com', '2010-11-23', N'Nam', N'2020 Nguyễn Thị Minh Khai, Hà Nội', N'VIP', NULL, 700),
('KH074', N'NGUYEN THI THU HUONG', '09123456724', 'nguyenthithuhuong@gmail.com', '2011-12-24', N'Nữ', N'2121 Trần Duy Hưng, Hà Nội', N'Thường', NULL, 500),
('KH075', N'NGUYEN THI THUY HANG', '09123456725', 'nguyenthithuyhang@gmail.com', '2012-01-25', N'Nam', N'2222 Phạm Văn Đồng, Hà Nội', N'VIP', NULL, 800),
('KH076', N'NGUYEN THUY PHUONG', '09123456726', 'nguyenthuyphuong@gmail.com', '2013-02-26', N'Nữ', N'2323 Cầu Giấy, Hà Nội', N'Thường', NULL, 400),
('KH077', N'NGUYEN TIEN THANH', '09123456727', 'nguyentienthanh@gmail.com', '2014-03-27', N'Nam', N'2424 Nguyễn Văn Cừ, Hà Nội', N'VIP', NULL, 1000),
('KH078', N'NGUYEN TUYET MAI', '09123456728', 'nguyentuyetmai@gmail.com', '2015-04-28', N'Nữ', N'2525 Hoàng Mai, Hà Nội', N'Thường', NULL, 350),
('KH079', N'NGUYEN VAN KHANH', '09123456729', 'nguyenvankhanh@gmail.com', '2016-05-29', N'Nam', N'2626 Bạch Mai, Hà Nội', N'VIP', NULL, 550),
('KH080', N'NGUYEN VAN LAP', '09123456730', 'nguyenvanlap@gmail.com', '2017-06-30', N'Nữ', N'2727 Giải Phóng, Hà Nội', N'Thường', NULL, 450),
('KH081', N'NGUYEN VAN SON', '09123456731', 'nguyenvanson@gmail.com', '2018-07-01', N'Nam', N'2828 Nguyễn Trãi, Hà Nội', N'VIP', NULL, 900),
('KH082', N'NGUYEN VAN TUAT', '09123456732', 'nguyenvantuat@gmail.com', '2019-08-02', N'Nam', N'2929 Láng Hạ, Hà Nội', N'Thường', NULL, 200),
('KH083', N'NGUYEN VIET HUNG', '09123456733', 'nguyenviethung@gmail.com', '2020-09-03', N'Nam', N'3030 Kim Mã, Hà Nội', N'VIP', NULL, 850),
('KH084', N'NGUYEN VIET NHAM', '09123456734', 'nguyenvietnham@gmail.com', '2021-10-04', N'Nữ', N'3131 Đường Láng, Hà Nội', N'Thường', NULL, 450),
('KH085', N'NGUYEN XUAN THUY', '09123456735', 'nguyenxuanthuy@gmail.com', '2022-11-05', N'Nam', N'3232 Thái Hà, Hà Nội', N'VIP', NULL, 1000),
('KH086', N'PHAM MAI LONG', '09123456736', 'phammailong@gmail.com', '2023-12-06', N'Nữ', N'3333 Phố Huế, Hà Nội', N'Thường', NULL, 300),
('KH087', N'PHAM QUOC HUNG', '09123456737', 'phamquochung@gmail.com', '2024-01-07', N'Nam', N'3434 Thanh Xuân, Hà Nội', N'VIP', NULL, 700),
('KH088', N'PHAM THANH HA', '09123456738', 'phamthanha@gmail.com', '2024-02-08', N'Nữ', N'3535 Bến Thành, Hà Nội', N'Thường', NULL, 550),
('KH089', N'PHAM THI PHUONG MINH', '09123456739', 'phamthiphuongminh@gmail.com', '2024-03-09', N'Nam', N'3636 Nguyễn Hoàng, Hà Nội', N'VIP', NULL, 950),
('KH090', N'PHAM THI PHUONG THAO', '09123456740', 'phamthiphuongthao@gmail.com', '2024-04-10', N'Nữ', N'3737 Hải Bối, Hà Nội', N'Thường', NULL, 400),
('KH091', N'PHAM TRUNG KIEN', '09123456741', 'phamtrungkien@gmail.com', '2024-05-11', N'Nam', N'3838 Dịch Vọng, Hà Nội', N'VIP', NULL, 600),
('KH092', N'PHAM TRUNG THAI', '09123456742', 'phamtrungthai@gmail.com', '2024-06-12', N'Nữ', N'3939 Tôn Đức Thắng, Hà Nội', N'Thường', NULL, 300),
('KH093', N'PHAM VAN HIEN', '09123456743', 'phamvanhien@gmail.com', '2024-07-13', N'Nam', N'4040 Minh Khai, Hà Nội', N'VIP', NULL, 750),
('KH094', N'PHAM VIET ANH', '09123456744', 'phamvietanh@gmail.com', '2024-08-14', N'Nữ', N'4141 Lương Định Của, Hà Nội', N'Thường', NULL, 400),
('KH095', N'PHAM VIET DUNG', '09123456745', 'phamvietdung@gmail.com', '2024-09-15', N'Nam', N'4242 Đê La Thành, Hà Nội', N'VIP', NULL, 500),
('KH096', N'PHAN TUAN ANH', '09123456746', 'phantuananh@gmail.com', '2024-10-16', N'Nữ', N'4343 Lý Thường Kiệt, Hà Nội', N'Thường', NULL, 350),
('KH097', N'PHUNG NGUYEN HAI YEN', '09123456747', 'phungnguyenhaiyen@gmail.com', '2024-11-17', N'Nam', N'4444 Nguyễn Văn Cừ, Hà Nội', N'VIP', NULL, 850),
('KH098', N'PHUNG QUANG HIEP', '09123456748', 'phungquanghiep@gmail.com', '2024-12-18', N'Nữ', N'4545 Chùa Bộc, Hà Nội', N'Thường', NULL, 200),
('KH099', N'QUACH KIM ANH', '09123456749', 'quachkimanh@gmail.com', '2025-01-19', N'Nam', N'4646 Nguyễn Trãi, Hà Nội', N'VIP', NULL, 600),
('KH100', N'TANG KHAC HIEN', '09123456750', 'tangkachien@gmail.com', '2025-02-20', N'Nữ', N'4747 Lê Văn Sỹ, Hà Nội', N'Thường', NULL, 350);

-- Insert table NHACUNGCAP
INSERT INTO NHACUNGCAP (MaNCC, MaQuanLy, TenNCC, DiaChi, TinhTrang, SDT, Email)
VALUES 
    ('NCC001', 'QL001', N'VSS Corp', N'Số 04 Ngõ 46 Phố Vĩnh Phúc, Ba Đình, Hà Nội', N'Hoạt động', '0896598986', 'info@vsscorp.vn'),
    ('NCC002', 'QL002', N'VSS Corp', N'Tầng 6, Số 156 Trần Quang Khải, Q.1, TP.HCM', N'Hoạt động', '0932351123', 'info@vsscorp.vn'),
    ('NCC003', 'QL003', N'Kool Media', N'34 Nguyễn Trọng Lội, Phường 4, Quận Tân Bình, TP.HCM', N'Hoạt động', '0932351123', 'Koolmedia.vn@gmail.com'),
    ('NCC004', 'QL004', N'Domino Film', N'Tòa nhà Green Office, 132 Hoàng Sâm, Phường Nghĩa Đô, Quận Cầu Giấy, Hà Nội', N'Hoạt động', '0976755590', 'info@dominofilm.vn'),
    ('NCC005', 'QL005', N'YCN Media', N'389 – 391 Trường Chinh, TP. Hà Nội', N'Hoạt động', '0927102666', 'media@ycn.vn'),
    ('NCC006', 'QL001', N'ColorMedia', N'P309, Tòa nhà Sunrise, 90 Trần Thái Tông, Phường Dịch Vọng, Quận Cầu Giấy, Hà Nội', N'Hoạt động', '02432595960', 'hd@colormedia.vn'),
    ('NCC007', 'QL002', N'Công Ty TNHH Thương Mại Dịch Vụ Sao Quang Minh', N'14 Phan Tôn, P.Đa Kao, Q.1, TP.HCM', N'Hoạt động', '039100125', NULL),
    ('NCC008', 'QL003', N'Công ty TNHH Quảng Cáo & Phim Ảnh Tiêu Điểm', N'Lầu 3, Star Building, Mạc Đĩnh Chi, P.Đa Kao, Q.1, TP.HCM', N'Hoạt động', '038221936', NULL),
    ('NCC009', 'QL004', N'Hãng phim truyện Việt Nam', N'Số 4 phố Thụy Khuê, phường Thụy Khuê, quận Tây Hồ, thành phố Hà Nội', N'Hoạt động', NULL, NULL),
    ('NCC010', 'QL005', N'Hãng Phim Việt Nam', N'139 Lò Đức, Hai Bà Trưng, Hà Nội', N'Hoạt động', '0916616612', 'hangphimvietnam@gmail.com');



