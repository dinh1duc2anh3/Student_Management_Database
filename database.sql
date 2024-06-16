-------------------------------------------------------------------------------------
--Create tables

CREATE TABLE public."HeDaoTao"
(
    "TenHDT" character(100)  NOT NULL,
    "MaHDT" character(100) NOT NULL,
	"TienTinChi" integer NOT NULL,
    CONSTRAINT "HeDaoTao_pkey" PRIMARY KEY ("MaHDT")
);

CREATE TABLE public."Lop"
(
    "TenLop" character varying(100)  NOT NULL,	
    "MaLop" character(10)   NOT NULL,
	"MaHDT" character(100)   NOT NULL,
    "Nganh" character(100)  NOT NULL,
    "Khoa" character(100) NOT NULL,
    "SiSo" integer NOT NULL,	
    "MaLopTruong" integer NOT NULL,    
	
    CONSTRAINT "Lop_pkey" PRIMARY KEY ("MaLop"), 
    CONSTRAINT "Lop_HeDT" FOREIGN KEY ("MaHDT")
        REFERENCES public."HeDaoTao" ("MaHDT") MATCH SIMPLE
);

CREATE TABLE public."SinhVien"
(
    "MaSV" integer NOT NULL,
    "HoTenSV" character varying(100)  NOT NULL,
    "MaLop" character(10)  NOT NULL,
    "NienKhoa" integer NOT NULL,

    CONSTRAINT "SinhVien_pkey" PRIMARY KEY ("MaSV"),
    CONSTRAINT "SinhVien_Lop" FOREIGN KEY ("MaLop")
        REFERENCES public."Lop" ("MaLop") MATCH SIMPLE
);


CREATE TABLE public."HocPhan"
(
    "TenHP" character(100)  NOT NULL,
    "MaHP" character(100)  NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
	"TrongSo" float not NULL,

    CONSTRAINT "HocPhan_pkey" PRIMARY KEY ("MaHP")
);

CREATE TABLE public."GiangVien"
(
    "MaGV" character(10) NOT NULL,
    "TenGV" character varying(100)  NOT NULL,
    "GioiTinh" character(10)  NOT NULL,
    "DiaDiem" character(100) NOT NULL,
    "Email" character(100) NOT NULL,
    "SDT" integer NOT NULL, 

    CONSTRAINT "GiangVien_pkey" PRIMARY KEY ("MaGV")
);

CREATE TABLE public."LopHoc"
(
    "MaLopHoc" character(6)  NOT NULL,
    "Ky" character(10)  NOT NULL,
    "DiaDiem" character(100) NOT NULL,
    "MaHP" character(10)  NOT NULL,
    "ThoiGian" date NOT NULL,
    "SiSo" integer NOT NULL,
    "MaGV" character(100)  NOT NULL,

    CONSTRAINT "LopHoc_pkey" PRIMARY KEY ("MaLopHoc"),
    CONSTRAINT "LopHoc_HocPhan" FOREIGN KEY ("MaHP")
        REFERENCES public."HocPhan" ("MaHP") MATCH SIMPLE,
    CONSTRAINT "LopHoc_GiangVien" FOREIGN KEY ("MaGV") 
        REFERENCES public."GiangVien" ("MaGV") MATCH SIMPLE 
);

CREATE TABLE public."LopThi"
(
    "MaLopHoc" character(6)  NOT NULL,
    "MaLopThi" character(6)  NOT NULL,
    "ThoiGian" date NOT NULL,
    "DiaDiem" character(100) NOT NULL, 

    CONSTRAINT "LopThi_pkey" PRIMARY KEY ("MaLopThi"),
    CONSTRAINT "LopThi_LopHoc" FOREIGN KEY ("MaLopHoc")  
        REFERENCES public."LopHoc" ("MaLopHoc") MATCH SIMPLE
);

CREATE TABLE public."DangKi"
(
    "MaSV" integer NOT NULL,
    "MaHP" character(100)  NOT NULL,
    "MaLopHoc" character(6)  NOT NULL,
    "MaLopThi" character(6)  NOT NULL,

    CONSTRAINT "DangKi_HocPhan" FOREIGN KEY ("MaHP")
        REFERENCES public."HocPhan" ("MaHP") MATCH SIMPLE,

    CONSTRAINT "DangKi_LopHoc" FOREIGN KEY ("MaLopHoc")
        REFERENCES public."LopHoc" ("MaLopHoc") MATCH SIMPLE,

    CONSTRAINT "DangKi_SinhVien" FOREIGN KEY ("MaSV")
        REFERENCES public."SinhVien" ("MaSV") MATCH SIMPLE
);

CREATE TABLE public."DiemRenLuyen"
(
    "MaSV" integer NOT NULL,
    "Ky" character(10)  NOT NULL,
    "XepLoai" character(50)  NOT NULL,
    "DiemHocTap" integer NOT NULL,
    "DiemNoiQuy" integer NOT NULL,
    "DiemYThucCongDan" integer NOT NULL,
    "DiemYThucHoatDong" integer NOT NULL,

    CONSTRAINT "DiemRenLuyen_pkey" PRIMARY KEY ("MaSV"),

    CONSTRAINT "DiemRL_SinhVien" FOREIGN KEY ("MaSV")
        REFERENCES public."SinhVien" ("MaSV") MATCH SIMPLE
);

CREATE TABLE public."CacChungChi"
(	"MaSV" integer NOT NULL,
    "Ten" character varying(10) NOT NULL, 
    "ThoiGian" date NOT NULL,
    "ThoiHan" date NOT NULL,
    "Diem" integer NOT NULL,
 
    CONSTRAINT "ChungChi_pkey" PRIMARY KEY ("MaSV"),
 	
 	CONSTRAINT "DangKi_SinhVien" FOREIGN KEY ("MaSV")
        REFERENCES public."SinhVien" ("MaSV") MATCH SIMPLE
);

CREATE TABLE public."Diem"
(
    "MaSV" integer NOT NULL,
    "MaHP" character(100) NOT NULL,
    "Ky" character(10)  NOT NULL,
    "DiemGK" integer NOT NULL,

    "DiemQT" integer NOT NULL,
    "DiemCK" integer NOT NULL,
    "DiemKTHP" integer NOT NULL,

    CONSTRAINT "Diem_pkey" PRIMARY KEY ("MaSV"),

    CONSTRAINT "Diem_HocPhan" FOREIGN KEY ("MaHP")
        REFERENCES public."HocPhan" ("MaHP") MATCH SIMPLE,

    CONSTRAINT "Diem_SinhVien" FOREIGN KEY ("MaSV")
        REFERENCES public."SinhVien" ("MaSV") MATCH SIMPLE
);
 
CREATE TABLE public."LyLichSV"
(
    "MaSV" integer NOT NULL,
    "HoSV" character varying(10)  NOT NULL,
    "TenDemSV" character varying(10)  NOT NULL,
    "TenSV" character varying(10)  NOT NULL,
    "NgaySinh" date NOT NULL,
    "DiaDiem" character(100) NOT NULL,
    "GioiTinh" character(10)  NOT NULL,
    "CCCD" integer NOT NULL,
    "Email" character(100) NOT NULL,
    "SDT" integer NOT NULL,
    
    CONSTRAINT "LyLichSV_pkey" PRIMARY KEY ("MaSV"),
    CONSTRAINT "LyLichSV_SinhVien" FOREIGN KEY ("MaSV")
        REFERENCES public."SinhVien" ("MaSV") MATCH SIMPLE
);

-------------------------------------------------------------------------------------
-- TAO DATA

CREATE TABLE public."HeDaoTao"
(
    "TenHDT" character(100)  NOT NULL,
    "MaHDT" character(100) NOT NULL,
	
    CONSTRAINT "HeDaoTao_pkey" PRIMARY KEY ("MaHDT")
);

CREATE TABLE public."Lop"
(
    "TenLop" character varying(100)  NOT NULL,	
    "MaLop" character(10)   NOT NULL,
	"MaHDT" character(100)   NOT NULL,
    "Nganh" character(100)  NOT NULL,
    "Khoa" character(100) NOT NULL,
    "SiSo" integer NOT NULL,	
    "MaLopTruong" integer NOT NULL,    
	
    CONSTRAINT "Lop_pkey" PRIMARY KEY ("MaLop"), 
    CONSTRAINT "Lop_HeDT" FOREIGN KEY ("MaHDT")
        REFERENCES public."HeDaoTao" ("MaHDT") MATCH SIMPLE
);

CREATE TABLE public."SinhVien"
(
    "MaSV" integer NOT NULL,
    "HoSV" character varying(20)  NOT NULL,
    "HoTenSV" character varying(100)  NOT NULL,
    "MaLop" character(10)  NOT NULL,
    "NienKhoa" integer NOT NULL,

    CONSTRAINT "SinhVien_pkey" PRIMARY KEY ("MaSV"),
    CONSTRAINT "SinhVien_Lop" FOREIGN KEY ("MaLop")
        REFERENCES public."Lop" ("MaLop") MATCH SIMPLE
);



INSERT INTO public."HeDaoTao" ("TenHDT", "MaHDT")
VALUES ('Kỹ sư Công nghệ thông tin - Tiếng Nhật - Tích hợp', 'KSCLC-TN-TT-VN-ICT');


INSERT INTO public."Lop" ("TenLop", "MaLop", "MaHDT", "Nganh", "Khoa", "SiSo", "MaLopTruong")
VALUES 
    ('Việt Nhật 01-K67', 'VN-01', 'KSCLC-TN-TT-VN-ICT', 'Công nghệ thông tin Việt-Nhật 2022', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220001),
    ('Việt Nhật 02-K67', 'VN-02', 'KSCLC-TN-TT-VN-ICT', 'Công nghệ thông tin Việt-Nhật 2022', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220002),
    ('Việt Nhật 03-K67', 'VN-03', 'KSCLC-TN-TT-VN-ICT', 'Công nghệ thông tin Việt-Nhật 2022', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220003),
    ('Việt Nhật 04-K67', 'VN-04', 'KSCLC-TN-TT-VN-ICT', 'Công nghệ thông tin Việt-Nhật 2022', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220004),
    ('Việt Nhật 05-K67', 'VN-05', 'KSCLC-TN-TT-VN-ICT', 'Công nghệ thông tin Việt-Nhật 2022', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220005),
    ('Việt Nhật 06-K67', 'VN-06', 'KSCLC-TN-TT-VN-ICT', 'Công nghệ thông tin Việt-Nhật 2022', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220006),
    ('Việt Nhật 07-K67', 'VN-07', 'KSCLC-TN-TT-VN-ICT', 'Công nghệ thông tin Việt-Nhật 2022', 'Trường Công nghệ thông tin và Truyền thông', 50, 20225917),

    ('Việt Nhật 01-K67', 'VP-01', 'KSCLC-TN-TT-VN-ICT', 'Công nghệ thông tin Việt-Pháp 2022', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220007),
    ('Global ICT 01-K67', 'ICT-01', 'KSCLC-TN-TT-VN-ICT', 'Công nghệ thông tin 2022', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220008),
    ('Khoa học Dữ liệu và Trí tuệ Nhân tạo 01-K67', 'DSAI-06', 'KSCLC-TN-TT-VN-ICT', 'Công nghệ thông tin Việt-Nhật 2022', 'Trường Công nghệ thông tin và Truyền thông', 52, 20220006)
    ;




-- Tạo dữ liệu ngẫu nhiên cho bảng SinhVien
WITH random_data AS (
    SELECT 
        20220000 + row_number() OVER () AS "MaSV",
        (array['Nguyễn','Trần','Lê','Phạm','Hoàng','Huỳnh','Võ','Đặng','Bùi','Đỗ'])[floor(random()*10) + 1] ||
        ' ' ||
        (array['Văn','Bình','Thị','Duy','Thu','Hồng','Tâm','Minh','Lan','Thành','Hải'])[floor(random()*10) + 1] ||
        ' ' ||
        (array['An', 'Anh', 'Ban', 'Bình', 'Bích', 'Băng', 'Bạch', 'Bảo', 'Bằng', 'Bội', 'Ca', 'Cam', 'Chi',
				  'Chinh', 'Chiêu', 'Chung', 'Châu', 'Cát', 'Cúc', 'Cương', 'Cầm', 'Cẩm', 'Dao', 'Di', 'Diên', 'Diễm',
				  'Diệp', 'Diệu', 'Du', 'Dung', 'Duy', 'Duyên', 'Dân', 'Dã', 'Dương', 'Dạ', 'Gia', 'Giang', 'Giao', 'Giáng',
				  'Hiếu', 'Hiền', 'Hiểu', 'Hiệp', 'Hoa', 'Hoan', 'Hoài', 'Hoàn', 'Hoàng', 'Hoạ', 'Huyền', 'Huệ', 'Huỳnh', 'Hà',
				  'Hàm', 'Hân', 'Hòa', 'Hương', 'Hướng', 'Hường', 'Hưởng', 'Hạ', 'Hạc', 'Hạnh', 'Hải', 'Hảo', 'Hậu', 'Hằng', 'Họa',
				  'Hồ', 'Hồng', 'Hợp', 'Khai', 'Khanh', 'Khiết', 'Khuyên', 'Khuê', 'Khánh', 'Khê', 'Khôi', 'Khúc', 'Khả', 'Khải', 'Kim', 
				  'Kiết', 'Kiều', 'Kê', 'Kỳ', 'Lam', 'Lan', 'Linh', 'Liên', 'Liễu', 'Loan', 'Ly', 'Lâm', 'Lê', 'Lý', 'Lăng', 'Lưu', 'Lễ', 
				  'Lệ', 'Lộc', 'Lợi', 'Lục', 'Mai', 'Mi', 'Minh', 'Miên', 'My', 'Mẫn', 'Mậu', 'Mộc', 'Mộng', 'Mỹ', 'Nga', 'Nghi', 'Nguyên',
				  'Nguyết', 'Nguyệt', 'Ngà', 'Ngân', 'Ngôn', 'Ngọc', 'Nhan', 'Nhi', 'Nhiên', 'Nhung', 'Nhàn', 'Nhân', 'Nhã', 'Nhơn', 'Như', 
				  'Nhạn', 'Nhất', 'Nhật', 'Nương', 'Nữ', 'Oanh', 'Phi', 'Phong', 'Phúc', 'Phương', 'Phước', 'Phượng', 'Phụng', 'Quyên', 'Quân',
				  'Quế', 'Quỳnh', 'Sa', 'San', 'Sao', 'Sinh', 'Song', 'Sông', 'Sơn', 'Sương', 'Thanh', 'Thi', 'Thiên', 'Thiếu', 'Thiều', 'Thiện',
				  'Thoa', 'Thoại', 'Thu', 'Thuần', 'Thuận', 'Thy', 'Thái', 'Thêu', 'Thông', 'Thùy', 'Thúy', 'Thơ', 'Thư', 'Thương', 'Thường', 
				  'Thạch', 'Thảo', 'Thắm', 'Thục', 'Thụy', 'Thủy', 'Tinh', 'Tiên', 'Tiểu', 'Trang', 'Tranh', 'Trinh', 'Triều', 'Triệu', 'Trung',
				  'Trà', 'Trâm', 'Trân', 'Trúc', 'Trầm', 'Tuyến', 'Tuyết', 'Tuyền', 'Tuệ', 'Ty', 'Tâm', 'Tùng', 'Tùy', 'Tú', 'Túy', 'Tường', 'Tịnh', 
				  'Tố', 'Từ', 'Uyên', 'Uyển', 'Vi', 'Vinh', 'Việt', 'Vy', 'Vàng', 'Vành', 'Vân', 'Vũ', 'Vọng', 'Vỹ', 'Xuyến', 'Xuân', 'Yên', 'Yến', 
				  'xanh', 'Ái', 'Ánh', 'Ân', 'Ðan', 'Ðinh', 'Ðiệp', 'Ðoan', 'Ðài', 'Ðàn', 'Ðào', 'Ðình', 'Ðông', 'Ðường', 'Ðồng', 'Ý', 'Đan', 'Đinh', 
				  'Đoan', 'Đài', 'Đào', 'Đông', 'Đăng', 'Đơn', 'Đức', 'Ấu'])[floor(random()*10) + 1] AS "HoTenSV"
    FROM generate_series(1, 100)
)
INSERT INTO public."SinhVien" ("MaSV", "HoTenSV", "MaLop", "NienKhoa")
SELECT 
    rd."MaSV",
    rd."HoTenSV",
    'VN-07' AS "MaLop",
    67 AS "NienKhoa"
FROM random_data rd
LEFT JOIN public."SinhVien" sv ON rd."MaSV" = sv."MaSV"
WHERE sv."MaSV" IS NULL;


select * from public."SinhVien"

update public."SinhVien"
set "MaLop" = 'VN-08'
where "MaSV" < 201 and "MaSV" > 100;


-------------------------------------------------------------------------------------
