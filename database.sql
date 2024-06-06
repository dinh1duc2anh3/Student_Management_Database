-------------------------------------------------------------------------------------
--Create tables

CREATE TABLE public."HeDaoTao"
(
    "TenHDT" character(100)  NOT NULL,
    "MaHDT" character(100) NOT NULL,
	
    CONSTRAINT "HeDaoTao_pkey" PRIMARY KEY ("MaHDT")
);

CREATE TABLE public."Lop"
(
    "TenLop" character varying(100)  NOT NULL,	
    "MaLop" character(100)   NOT NULL,
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
    "TenSV" character varying(100)  NOT NULL,
    "MaLop" character(100)  NOT NULL,
    "NienKhoa" integer NOT NULL,

    CONSTRAINT "SinhVien_pkey" PRIMARY KEY ("MaSV"),
    CONSTRAINT "SinhVien_Lop" FOREIGN KEY ("MaLop")
        REFERENCES public."Lop" ("MaLop") MATCH SIMPLE
);


CREATE TABLE public."HocPhan"
(
    "MaHP" character(100)  NOT NULL,
    "TenHP" character(100)  NOT NULL,
    "SoTin" integer NOT NULL,
	"PhanTramGK" integer not NULL,

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
    "MaLopHoc" character(10)  NOT NULL,
    "Ky" character(10)  NOT NULL,
    "DiaDiem" character(100) NOT NULL,
    "MaHP" character(10)  NOT NULL,
    "TenLop" character varying(100) NOT NULL,
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
    "MaLopHoc" character(10)  NOT NULL,
    "MaLopThi" character(10)  NOT NULL,
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
    "MaLopHoc" character(10)  NOT NULL,
    "MaLopThi" character(10)  NOT NULL,

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
-- PHAN NAY DANG TEST ĐỂ TẠO DATA

-- CREATE TABLE public."HeDaoTao"
-- (
--     "TenHDT" character(100)  NOT NULL,
--     "MaHDT" character(100) NOT NULL,
	
--     CONSTRAINT "HeDaoTao_pkey" PRIMARY KEY ("MaHDT")
-- );

-- CREATE TABLE public."Lop"
-- (
--     "TenLop" character varying(100)  NOT NULL,	
--     "MaLop" character(100)   NOT NULL,
-- 	"MaHDT" character(100)   NOT NULL,
--     "Nganh" character(100)  NOT NULL,
--     "Khoa" character(100) NOT NULL,
--     "SiSo" integer NOT NULL,	
--     "MaLopTruong" integer NOT NULL,    
	
--     CONSTRAINT "Lop_pkey" PRIMARY KEY ("MaLop"), 
--     CONSTRAINT "Lop_HeDT" FOREIGN KEY ("MaHDT")
--         REFERENCES public."HeDaoTao" ("MaHDT") MATCH SIMPLE
-- );

-- CREATE TABLE public."SinhVien"
-- (
--     "MaSV" integer NOT NULL,
--     "TenSV" character varying(100)  NOT NULL,
--     "MaLop" character(100)  NOT NULL,
--     "NienKhoa" integer NOT NULL,

--     CONSTRAINT "SinhVien_pkey" PRIMARY KEY ("MaSV"),
--     CONSTRAINT "SinhVien_Lop" FOREIGN KEY ("MaLop")
--         REFERENCES public."Lop" ("MaLop") MATCH SIMPLE
-- );



-- INSERT INTO public."HeDaoTao" ("TenHDT", "MaHDT")
-- VALUES ('Kỹ sư Công nghệ thông tin - Tiếng Nhật - Tích hợp', 'KSCLC-TN-TT-VN-ICT');



-- INSERT INTO public."Lop" ("TenLop", "MaLop", "MaHDT", "Nganh", "Khoa", "SiSo", "MaLopTruong")
-- VALUES ('Việt Nhật 07-K67', 'VN-07', 'KSCLC-TN-TT-VN-ICT', 'Công nghệ thông tin Việt-Nhật 2022', 'Trường Công nghệ thông tin và Truyền thông', 50, 20225917 );


-- -- Tạo dữ liệu ngẫu nhiên cho bảng SinhVien
-- WITH random_data AS (
--     SELECT 
--         20220000 + row_number() OVER () AS "MaSV",
--         (array['Nguyễn','Trần','Lê','Phạm','Hoàng','Huỳnh','Võ','Đặng','Bùi','Đỗ'])[floor(random()*10) + 1] ||
--         ' ' ||
--         (array['Văn','Bình','Thị','Duy','Thu','Hồng','Tâm','Minh','Lan','Thành','Hải'])[floor(random()*10) + 1] ||
--         ' ' ||
--         (array['An','Ánh','Anh','Bích','Hoa','Hùng','Hải','Tú','Nhung','Dũng','Trang','Long','Tâm'])[floor(random()*10) + 1] AS "TenSV"
--     FROM generate_series(1, 100)
-- )
-- INSERT INTO public."SinhVien" ("MaSV", "TenSV", "MaLop", "NienKhoa")
-- SELECT 
--     rd."MaSV",
--     rd."TenSV",
--     'VN-07' AS "MaLop",
--     67 AS "NienKhoa"
-- FROM random_data rd
-- LEFT JOIN public."SinhVien" sv ON rd."MaSV" = sv."MaSV"
-- WHERE sv."MaSV" IS NULL;

-------------------------------------------------------------------------------------
