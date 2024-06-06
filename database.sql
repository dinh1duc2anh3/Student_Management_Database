CREATE TABLE IF NOT EXISTS public."HeDaoTao"
(
    "TenHDT" character(100)  NOT NULL,
    "MaHDT" character(100) NOT NULL,
	
    CONSTRAINT "HeDaoTao_pkey" PRIMARY KEY ("MaHDT")
);





CREATE TABLE IF NOT EXISTS public."Lop"
(
    "TenLop" character varying(100)  NOT NULL,	
    "MaLop" character(100)   NOT NULL,
	"TenHDT" character(100)   NOT NULL,
    "Nganh" character(100)  NOT NULL,
    "Khoa" character(100) NOT NULL,
    "SiSo" integer NOT NULL,	
    "LopTruong" character varying(100) NOT NULL,    
	
    CONSTRAINT "Lop_pkey" PRIMARY KEY ("MaLop"),
	
    CONSTRAINT "Lop_HeDT" FOREIGN KEY ("TenHDT")
        REFERENCES public."HeDaoTao" ("TenHDT") MATCH SIMPLE
);








CREATE TABLE IF NOT EXISTS public."SinhVien"
(
    "MaSV" character varying(10) NOT NULL,
    "TenSV" character(100)  NOT NULL,
    "MaLop" character(100)  NOT NULL,
    "NienKhoa" integer NOT NULL,

    CONSTRAINT "SinhVien_pkey" PRIMARY KEY ("MaSV"),
    CONSTRAINT "SinhVien_Lop" FOREIGN KEY ("MaLop")
        REFERENCES public."Lop" ("MaLop") MATCH SIMPLE
);




CREATE TABLE IF NOT EXISTS public."HocPhan"
(
    "MaHP" character(100)  NOT NULL,
    "TenHP" character(100)  NOT NULL,
    "SoTin" integer NOT NULL,
	"PhanTramGK" integer not NULL,

    CONSTRAINT "HocPhan_pkey" PRIMARY KEY ("MaHP")
);






CREATE TABLE IF NOT EXISTS public."LopHoc"
(
    "MaLopHoc" character(100)  NOT NULL,
    "DiaChi" character(100) NOT NULL,
    "MaHP" character(10)  NOT NULL,
    "TenLop" character varying(100) NOT NULL,
    "ThoiGian" date NOT NULL,
    "SiSo" integer NOT NULL,
    "GiaoVienDay" character(100)  NOT NULL,

    CONSTRAINT "LopHoc_pkey" PRIMARY KEY ("MaLopHoc"),
    CONSTRAINT "LopHoc_HocPhan" FOREIGN KEY ("MaHP")
        REFERENCES public."HocPhan" ("MaHP") MATCH SIMPLE
);



CREATE TABLE IF NOT EXISTS public."DangKi"
(
    "MaSV" character varying(10) NOT NULL,
    "MaHP" character(100)  NOT NULL,
    "MaLopHoc" character(100)  NOT NULL,

    CONSTRAINT "DangKi_HocPhan" FOREIGN KEY ("MaHP")
        REFERENCES public."HocPhan" ("MaHP") MATCH SIMPLE,

    CONSTRAINT "DangKi_LopHoc" FOREIGN KEY ("MaLopHoc")
        REFERENCES public."LopHoc" ("MaLopHoc") MATCH SIMPLE,

    CONSTRAINT "DangKi_SinhVien" FOREIGN KEY ("MaSV")
        REFERENCES public."SinhVien" ("MaSV") MATCH SIMPLE
);







CREATE TABLE IF NOT EXISTS public."DiemRenLuyen"
(
    "MaSV" character varying(10) NOT NULL,
    "XepLoai" character(50)  NOT NULL,
    "DiemHocTap" integer NOT NULL,
    "DiemNoiQuy" integer NOT NULL,
    "DiemYThucCongDan" integer NOT NULL,
    "DiemYThucHoatDong" integer NOT NULL,

    CONSTRAINT "DiemRenLuyen_pkey" PRIMARY KEY ("MaSV"),

    CONSTRAINT "DiemRL_SinhVien" FOREIGN KEY ("MaSV")
        REFERENCES public."SinhVien" ("MaSV") MATCH SIMPLE
);



CREATE TABLE IF NOT EXISTS public."CacChungChi"
(	"MaSV" character varying(10) NOT NULL,
    "Ten" character varying(10) NOT NULL, 
    "ThoiGian" date NOT NULL,
    "ThoiHan" date NOT NULL,
    "Diem" integer NOT NULL,
 
    CONSTRAINT "ChungChi_pkey" PRIMARY KEY ("MaSV")
 	
 	CONSTRAINT "DangKi_SinhVien" FOREIGN KEY ("MaSV")
        REFERENCES public."SinhVien" ("MaSV") MATCH SIMPLE
);


CREATE TABLE IF NOT EXISTS public."Diem"
(
    "MaSV" character varying(10) NOT NULL,
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



CREATE TABLE IF NOT EXISTS public."LyLichSV"
(
    "MaSV" character varying(10) NOT NULL,
    "NgaySinh" date NOT NULL,
    "DiaChi" character(100) NOT NULL,
    "GioiTinh" character(100)  NOT NULL,
    "CCCD" integer NOT NULL,
    "Email" character(100) NOT NULL,
    "SDT" integer NOT NULL,
    
    CONSTRAINT "LyLichSV_pkey" PRIMARY KEY ("MaSV"),
    CONSTRAINT "LyLichSV_SinhVien" FOREIGN KEY ("MaSV")
        REFERENCES public."SinhVien" ("MaSV") MATCH SIMPLE
);

