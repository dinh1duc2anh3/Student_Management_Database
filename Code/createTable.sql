----------------------------------------------------------------TAO TABLE------------------------------------------------------------------------------------- 

CREATE TABLE public."HeDaoTao"
(
    "TenHDT" character varying(100)  NOT NULL,
    "MaHDT" character varying(2) NOT NULL,
	"TienTinChi" integer NOT NULL,
    CONSTRAINT "HeDaoTao_pkey" PRIMARY KEY ("MaHDT")
);

CREATE TABLE public."Nganh"
(
    "TenNganh" character(100)  NOT NULL,
    "MaNganh" character varying(10) NOT NULL,

    CONSTRAINT "Nganh_pkey" PRIMARY KEY ("MaNganh")
);

CREATE TABLE public."Lop"
(
    "TenLop" character varying(100)  NOT NULL,	
    "MaLop" character varying(10)   NOT NULL,
	"MaHDT" character varying(2)   NOT NULL,
    "MaNganh" character varying(10)  NOT NULL,
    "Khoa" character(100) NOT NULL,
    "SiSo" integer NOT NULL,	
    "MaLopTruong" integer NOT NULL,    
	
    CONSTRAINT "Lop_pkey" PRIMARY KEY ("MaLop"), 
    CONSTRAINT "Lop_HeDT" FOREIGN KEY ("MaHDT")
        REFERENCES public."HeDaoTao" ("MaHDT") MATCH SIMPLE,
    CONSTRAINT "Lop_Nganh" FOREIGN KEY ("MaNganh")
        REFERENCES public."Nganh" ("MaNganh") MATCH SIMPLE
);

CREATE TABLE public."SinhVien"
(
    "MaSV" integer NOT NULL,
    "HoTenSV" character varying(100) ,
    "MaLop" character varying(10)  NOT NULL,
    "NienKhoa" integer NOT NULL,

    CONSTRAINT "SinhVien_pkey" PRIMARY KEY ("MaSV"),
    CONSTRAINT "SinhVien_Lop" FOREIGN KEY ("MaLop")
        REFERENCES public."Lop" ("MaLop") MATCH SIMPLE
);

CREATE TABLE public."HocPhan"
(
    "TenHP" character varying(100)  NOT NULL,
    "MaHP" character varying(100)  NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
	"TrongSo" float not NULL,

    CONSTRAINT "HocPhan_pkey" PRIMARY KEY ("MaHP")
);

CREATE TABLE public."HocPhanChiTiet"
(   
    "MaNganh" character varying(10),
    "TenHP" character varying(100)  NOT NULL,
    "MaHP" character varying(100)  NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
	"TrongSo" float not NULL,
    "Ky" integer,

    CONSTRAINT "HocPhanChiTiet_pkey" PRIMARY KEY ("MaHP","MaNganh")
);


CREATE TABLE public."GiangVien"
(
    "MaGV" bigint NOT NULL,
    "HoGV" character varying(10) not NULL,
    "TenDemGV" character varying(10) not NULL,
    "TenGV" character varying(100)  NOT NULL,
    "GioiTinh" character(10)  NOT NULL,
    "Email" character(100) ,
    "SDT" bigint NOT NULL, 

    CONSTRAINT "GiangVien_pkey" PRIMARY KEY ("MaGV")
);

CREATE TABLE public."LopHoc"
(
    "MaLopHoc" character(6)  NOT NULL,
    "Ky" character(10)  NOT NULL,
    "DiaDiem" character varying(100) NOT NULL,
    "MaHP" character varying(10)  NOT NULL,
    "ThoiGian" date NOT NULL,
    "SiSo" integer NOT NULL,
    "MaGV" bigint  NOT NULL,

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
    "DiaDiem" character varying(100) NOT NULL, 

    CONSTRAINT "LopThi_pkey" PRIMARY KEY ("MaLopThi"),
    CONSTRAINT "LopThi_LopHoc" FOREIGN KEY ("MaLopHoc")  
        REFERENCES public."LopHoc" ("MaLopHoc") MATCH SIMPLE
);

CREATE TABLE public."DangKi"
(
    "MaSV" integer NOT NULL,
    "MaHP" character varying(100)  NOT NULL,
    "Ky" integer NOT NULL,
    "MaLopHoc" character(6),

    CONSTRAINT "DangKi_pkey" PRIMARY KEY ("MaSV","MaHP","Ky"),

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
    "XepLoai" character varying(50) ,
    "DiemHocTap" integer NOT NULL,
    "DiemNoiQuy" integer NOT NULL,
    "DiemYThucCongDan" integer NOT NULL,
    "DiemYThucHoatDong" integer NOT NULL,
    "TongDiem" integer,    

    CONSTRAINT "DiemRenLuyen_pkey" PRIMARY KEY ("MaSV","Ky"),

    CONSTRAINT "DiemRL_SinhVien" FOREIGN KEY ("MaSV")
        REFERENCES public."SinhVien" ("MaSV") MATCH SIMPLE
);

CREATE TABLE public."CacChungChi"
(	"MaSV" integer NOT NULL,
    "Ten" character varying(10) NOT NULL, 
    "ThoiGian" date NOT NULL,
    "ThoiHan" integer NOT NULL,
    "Diem" double precision ,
 
    CONSTRAINT "ChungChi_pkey" PRIMARY KEY ("MaSV","Ten"),
 	
 	CONSTRAINT "DangKi_SinhVien" FOREIGN KEY ("MaSV")
        REFERENCES public."SinhVien" ("MaSV") MATCH SIMPLE
);

CREATE TABLE public."Diem"
(
    "MaSV" integer NOT NULL,
    "MaHP" character(100) NOT NULL,
    "Ky" character(10)  NOT NULL,
    "DiemGK" double precision NOT NULL,
    "DiemCK" double precision NOT NULL,
    "DiemKTHP" double precision ,
    "MaLopHoc" character varying(6) NOT NULL,

    CONSTRAINT "Diem_pkey" PRIMARY KEY ("MaSV","MaHP","Ky"),

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
    "CCCD" bigint NOT NULL,
    "Email" character(100) ,
    "SDT" bigint NOT NULL,
    
    CONSTRAINT "LyLichSV_pkey" PRIMARY KEY ("MaSV"),
    CONSTRAINT "LyLichSV_SinhVien" FOREIGN KEY ("MaSV")
        REFERENCES public."SinhVien" ("MaSV") MATCH SIMPLE
);

-------------------------------------------------------------------------------------
-- TAO ctdt của sinh viên các ngành, để các sv tiện đki theo kì
CREATE TABLE public."CtdtVN"
(   
    "MaNganh" character(10) 
    "TenHP" character(100)  NOT NULL,
    "MaHP" character(100)  NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
	"TrongSo" float not NULL,
    "Ky" integer,

    CONSTRAINT "CtdtVN_pkey" PRIMARY KEY ("MaHP"),
    CONSTRAINT "CtdtVN_Nganh" FOREIGN KEY ("MaNganh")
        REFERENCES public."Nganh" ("MaNganh") MATCH SIMPLE

);

CREATE TABLE public."CtdtVP"
(
    "MaNganh" character(10),
    "TenHP" character(100) NOT NULL,
    "MaHP" character(100) NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
    "TrongSo" float NOT NULL,
    "Ky" integer,

    CONSTRAINT "CtdtVP_pkey" PRIMARY KEY ("MaHP"),
    CONSTRAINT "CtdtVP_Nganh" FOREIGN KEY ("MaNganh")
        REFERENCES public."Nganh" ("MaNganh") MATCH SIMPLE
);

CREATE TABLE public."CtdtICT"
(
    "MaNganh" character(10),
    "TenHP" character(100) NOT NULL,
    "MaHP" character(100) NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
    "TrongSo" float NOT NULL,
    "Ky" integer,

    CONSTRAINT "CtdtICT_pkey" PRIMARY KEY ("MaHP"),
    CONSTRAINT "CtdtICT_Nganh" FOREIGN KEY ("MaNganh")
        REFERENCES public."Nganh" ("MaNganh") MATCH SIMPLE
);

CREATE TABLE public."CtdtIT1"
(
    "MaNganh" character(10),
    "TenHP" character(100) NOT NULL,
    "MaHP" character(100) NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
    "TrongSo" float NOT NULL,
    "Ky" integer,

    CONSTRAINT "CtdtIT1_pkey" PRIMARY KEY ("MaHP"),
    CONSTRAINT "CtdtIT1_Nganh" FOREIGN KEY ("MaNganh")
        REFERENCES public."Nganh" ("MaNganh") MATCH SIMPLE
);

CREATE TABLE public."CtdtIT2"
(
    "MaNganh" character(10),
    "TenHP" character(100) NOT NULL,
    "MaHP" character(100) NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
    "TrongSo" float NOT NULL,
    "Ky" integer,

    CONSTRAINT "CtdtIT2_pkey" PRIMARY KEY ("MaHP"),
    CONSTRAINT "CtdtIT2_Nganh" FOREIGN KEY ("MaNganh")
        REFERENCES public."Nganh" ("MaNganh") MATCH SIMPLE
);

CREATE TABLE public."CtdtDSAI"
(
    "MaNganh" character(10),
    "TenHP" character(100) NOT NULL,
    "MaHP" character(100) NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
    "TrongSo" float NOT NULL,
    "Ky" integer,

    CONSTRAINT "CtdtDSAI_pkey" PRIMARY KEY ("MaHP"),
    CONSTRAINT "CtdtDSAI_Nganh" FOREIGN KEY ("MaNganh")
        REFERENCES public."Nganh" ("MaNganh") MATCH SIMPLE
);