-------------------------------------------------------------------------------------
--Create tables

CREATE TABLE public."HeDaoTao"
(
    "TenHDT" character varying(100)  NOT NULL,
    "MaHDT" character varying(100) NOT NULL,
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
	"MaHDT" character varying(100)   NOT NULL,
    "MaNganh" character varying(10)  NOT NULL,
    "Khoa" character(100) NOT NULL,
    "SiSo" integer NOT NULL,	
    "MaLopTruong" integer NOT NULL,    
	
    CONSTRAINT "Lop_pkey" PRIMARY KEY ("MaLop"), 
    CONSTRAINT "Lop_HeDT" FOREIGN KEY ("MaHDT")
        REFERENCES public."HeDaoTao" ("MaHDT") MATCH SIMPLE
    CONSTRAINT "Lop_HeDT" FOREIGN KEY ("MaNganh")
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

-------------------------------------------------------------------------------------


--------------------------------------------------------------------------TAO DATA------------------------------------------------------------------------------------- 

--------------------DATA cho bảng HeDaoTao------------------------

INSERT INTO public."HeDaoTao" ("TenHDT", "MaHDT", "TienTinChi")
VALUES 
    ('Chương trình đào tạo chuẩn', 'C',500),
    ('Chương trình đào tạo đặc biệt Elitech 1', 'E1',680),
    ('Chương trình đào tạo đặc biệt Elitech 2', 'E2',1020)
;

--------------------DATA cho bảng Lop------------------------

INSERT INTO public."Lop" ("TenLop", "MaLop", "MaHDT", "MaNganh", "Khoa", "SiSo", "MaLopTruong")
VALUES 
    ('Việt Nhật 02 K66', 'VN02-66', 'E1', 'VN', 'Trường Công nghệ thông tin và Truyền thông', 50, 20210020),
    ('Việt Nhật 07 K67', 'VN07-67', 'E1', 'VN', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220035),
    ('Việt Pháp 01 K67', 'VP01-67', 'E1', 'VP', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220075),
    ('Công nghệ thông tin 01 K67', 'ICT01-67', 'E1', 'ICT', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220109),
    ('Khoa học máy tính 03 K67', 'IT103-67', 'C', 'IT1', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220169),
    ('Kỹ thuật máy tính 01 K67', 'IT201-67', 'C', 'IT2', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220225),
    ('Khoa học dữ liệu và trí tuệ nhân tạo 01 K67', 'DSAI01-67', 'E2', 'DSAI', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220287)
    ;

--------------------DATA cho bảng DiemRenLuyen------------------------
--Kỳ 2023.1
DO $$
DECLARE
    i INT;
    MaSV INT;
    Ky VARCHAR(50) := '2023.1';
    XepLoai VARCHAR(50);
    DiemHocTap INT;
    DiemNoiQuy INT;
    DiemYThucCongDan INT;
    DiemYThucHoatDong INT;
    TongDiem INT;
    RandomGrade INT;
BEGIN
    -- Generate data for 50 students from 20210001 to 20210050
    FOR i IN 1..50 LOOP
        MaSV := 20210000 + i;

        -- Check if the record already exists
        IF NOT EXISTS (SELECT 1 FROM public."DiemRenLuyen" WHERE "MaSV" = MaSV AND "Ky" = Ky) THEN
            -- Randomly assign individual scores
            DiemHocTap := FLOOR(RANDOM() * 20+10);  
            DiemNoiQuy := FLOOR(RANDOM() * 15+10);  
            DiemYThucCongDan := FLOOR(RANDOM() * 15+10);  
            DiemYThucHoatDong := FLOOR(RANDOM() * 10+10);  

            -- Insert the record
            INSERT INTO public."DiemRenLuyen" ("MaSV", "Ky", "DiemHocTap", "DiemNoiQuy", "DiemYThucCongDan", "DiemYThucHoatDong")
            VALUES (MaSV, Ky, DiemHocTap, DiemNoiQuy, DiemYThucCongDan, DiemYThucHoatDong);
        END IF;
    END LOOP;

    -- Generate data for 300 students from 20220001 to 20220300
    FOR i IN 1..300 LOOP
        MaSV := 20220000 + i;

        -- Check if the record already exists
        IF NOT EXISTS (SELECT 1 FROM public."DiemRenLuyen" WHERE "MaSV" = MaSV AND "Ky" = Ky) THEN
            -- Randomly assign individual scores
           DiemHocTap := FLOOR(RANDOM() * 20+10);  
            DiemNoiQuy := FLOOR(RANDOM() * 15+10);  
            DiemYThucCongDan := FLOOR(RANDOM() * 15+10);  
            DiemYThucHoatDong := FLOOR(RANDOM() * 10+10);   

            -- Insert the record
            INSERT INTO public."DiemRenLuyen" ("MaSV", "Ky", "DiemHocTap", "DiemNoiQuy", "DiemYThucCongDan", "DiemYThucHoatDong")
            VALUES (MaSV, Ky, DiemHocTap, DiemNoiQuy, DiemYThucCongDan, DiemYThucHoatDong);
        END IF;
    END LOOP;
END $$;

--Kỳ 2023.2
DO $$
DECLARE
    i INT;
    MaSV INT;
    Ky VARCHAR(50) := '2023.2';
    XepLoai VARCHAR(50);
    DiemHocTap INT;
    DiemNoiQuy INT;
    DiemYThucCongDan INT;
    DiemYThucHoatDong INT;
    TongDiem INT;
    RandomGrade INT;
BEGIN
    -- Generate data for 50 students from 20210001 to 20210050
    FOR i IN 1..50 LOOP
        MaSV := 20210000 + i;

        -- Check if the record already exists
        IF NOT EXISTS (SELECT 1 FROM public."DiemRenLuyen" WHERE "MaSV" = MaSV AND "Ky" = Ky) THEN
            -- Randomly assign individual scores
            DiemHocTap := FLOOR(RANDOM() * 20+10);  
            DiemNoiQuy := FLOOR(RANDOM() * 15+10);  
            DiemYThucCongDan := FLOOR(RANDOM() * 15+10);  
            DiemYThucHoatDong := FLOOR(RANDOM() * 10+10);  

            -- Insert the record
            INSERT INTO public."DiemRenLuyen" ("MaSV", "Ky", "DiemHocTap", "DiemNoiQuy", "DiemYThucCongDan", "DiemYThucHoatDong")
            VALUES (MaSV, Ky, DiemHocTap, DiemNoiQuy, DiemYThucCongDan, DiemYThucHoatDong);
        END IF;
    END LOOP;

    -- Generate data for 300 students from 20220001 to 20220300
    FOR i IN 1..300 LOOP
        MaSV := 20220000 + i;

        -- Check if the record already exists
        IF NOT EXISTS (SELECT 1 FROM public."DiemRenLuyen" WHERE "MaSV" = MaSV AND "Ky" = Ky) THEN
            -- Randomly assign individual scores
           DiemHocTap := FLOOR(RANDOM() * 20+10);  
            DiemNoiQuy := FLOOR(RANDOM() * 15+10);  
            DiemYThucCongDan := FLOOR(RANDOM() * 15+10);  
            DiemYThucHoatDong := FLOOR(RANDOM() * 10+10);   

            -- Insert the record
            INSERT INTO public."DiemRenLuyen" ("MaSV", "Ky", "DiemHocTap", "DiemNoiQuy", "DiemYThucCongDan", "DiemYThucHoatDong")
            VALUES (MaSV, Ky, DiemHocTap, DiemNoiQuy, DiemYThucCongDan, DiemYThucHoatDong);
        END IF;
    END LOOP;
END $$;


--------------------DATA cho bảng SinhVien------------------------
-- SV lớp VN02-66 , tương tự với các lớp khác K67
DO $$
BEGIN
    FOR i IN 1..50 LOOP
        INSERT INTO public."SinhVien" ("MaSV", "MaLop", "NienKhoa")
        VALUES (20210000 + i, 'VN02-66', 66);
    END LOOP;
END $$;

-- SV lớp VN07-67
-- SV lớp VP01-67
-- SV lớp ICT01-67
-- SV lớp IT103-67 
-- SV lớp IT201-67
-- SV lớp DSAI01-67

--------------------DATA cho bảng LyLichSV------------------------

DO $$ 
DECLARE 
    sv_id integer ;
    ho varchar(20);
    tendem varchar(20);
    ten varchar(20);
    ngaysinh date;
    cccd bigint ;
    sdt bigint;

    ho_arr text[] := array['Nguyễn','Trần','Lê','Phạm','Hoàng','Huỳnh','Võ','Đặng','Bùi','Đỗ','Lý','Phan','Vũ','Hồ','Ngô','Dương','Lý','Đinh'];
    tendem_arr text[] := array['Văn','Bình','Thị','Duy','Thu','Hồng','Tâm','Minh','Lan','Thành','Hải','Đức','Quỳnh'];
    ten_arr text[] := array['An', 'Anh', 'Ban', 'Bình', 'Bích', 'Băng', 'Bạch', 'Bảo', 'Bằng', 'Bội', 'Ca', 'Cam', 'Chi', 'Chinh', 'Chiêu', 
        'Chung', 'Châu', 'Cát', 'Cúc', 'Cương', 'Cầm', 'Cẩm', 'Dao', 'Di', 'Diên', 'Diễm', 'Diệp', 'Diệu', 'Du', 'Dung', 'Duy', 'Duyên', 'Dân', 
        'Dã', 'Dương', 'Dạ', 'Gia', 'Giang', 'Giao', 'Giáng', 'Hiếu', 'Hiền', 'Hiểu', 'Hiệp', 'Hoa', 'Hoan', 'Hoài', 'Hoàn', 'Hoàng', 'Hoạ', 'Huyền', 
        'Huệ', 'Huỳnh', 'Hà', 'Hàm', 'Hân', 'Hòa', 'Hương', 'Hướng', 'Hường', 'Hưởng', 'Hạ', 'Hạc', 'Hạnh', 'Hải', 'Hảo', 'Hậu', 'Hằng', 'Họa', 'Hồ',
         'Hồng', 'Hợp', 'Khai', 'Khanh', 'Khiết', 'Khuyên', 'Khuê', 'Khánh', 'Khê', 'Khôi', 'Khúc', 'Khả', 'Khải', 'Kim', 'Kiết', 'Kiều', 'Kê', 'Kỳ', 
         'Lam', 'Lan', 'Linh', 'Liên', 'Liễu', 'Loan', 'Ly', 'Lâm', 'Lê', 'Lý', 'Lăng', 'Lưu', 'Lễ', 'Lệ', 'Lộc', 'Lợi', 'Lục', 'Mai', 'Mi', 'Minh', 
         'Miên', 'My', 'Mẫn', 'Mậu', 'Mộc', 'Mộng', 'Mỹ', 'Nga', 'Nghi', 'Nguyên', 'Nguyết', 'Nguyệt', 'Ngà', 'Ngân', 'Ngôn', 'Ngọc', 'Nhan', 'Nhi', 
         'Nhiên', 'Nhung', 'Nhàn', 'Nhân', 'Nhã', 'Nhơn', 'Như', 'Nhạn', 'Nhất', 'Nhật', 'Nương', 'Nữ', 'Oanh', 'Phi', 'Phong', 'Phúc', 'Phương', 'Phước',
          'Phượng', 'Phụng', 'Quyên', 'Quân', 'Quế', 'Quỳnh', 'Sa', 'San', 'Sao', 'Sinh', 'Song', 'Sông', 'Sơn', 'Sương', 'Thanh', 'Thi', 'Thiên', 'Thiếu', 
          'Thiều', 'Thiện', 'Thoa', 'Thoại', 'Thu', 'Thuần', 'Thuận', 'Thy', 'Thái', 'Thêu', 'Thông', 'Thùy', 'Thúy', 'Thơ', 'Thư', 'Thương', 'Thường', 
          'Thạch', 'Thảo', 'Thắm', 'Thục', 'Thụy', 'Thủy', 'Tinh', 'Tiên', 'Tiểu', 'Trang', 'Tranh', 'Trinh', 'Triều', 'Triệu', 'Trung', 'Trà', 'Trâm',
           'Trân', 'Trúc', 'Trầm', 'Tuyến', 'Tuyết', 'Tuyền', 'Tuệ', 'Ty', 'Tâm', 'Tùng', 'Tùy', 'Tú', 'Túy', 'Tường', 'Tịnh', 'Tố', 'Từ', 'Uyên', 'Uyển',
            'Vi', 'Vinh', 'Việt', 'Vy', 'Vàng', 'Vành', 'Vân', 'Vũ', 'Vọng', 'Vỹ', 'Xuyến', 'Xuân', 'Yên', 'Yến', 'xanh', 'Ái', 'Ánh', 'Ân', 'Ðan', 'Ðinh', 
            'Ðiệp', 'Ðoan', 'Ðài', 'Ðàn', 'Ðào', 'Ðình', 'Ðông', 'Ðường', 'Ðồng', 'Ý', 'Đan', 'Đinh', 'Đoan', 'Đài', 'Đào', 'Đông', 'Đăng', 'Đơn', 'Đức', 'Ấu'];
    dia_diem_arr text[] := array['Hà Nội','Hà Giang','Cao Bằng','Bắc Kạn','Tuyên Quang','Lào Cai','Điện Biên','Lai Châu','Sơn La','Yên Bái','Hoà Bình','Thái Nguyên','Lạng Sơn','Quảng Ninh', 'Bắc Giang', 'Phú Thọ', 'Vĩnh Phúc', 'Bắc Ninh', 'Hải Dương','Hải Phòng', 'Hưng Yên', 'Thái Bình', 'Hà Nam', 'Nam Định', 'Ninh Bình', 'Thanh Hóa', 'Nghệ An', 'Hà Tĩnh', 'Quảng Bình', 'Quảng Trị', 'Thừa Thiên Huế', 'Đà Nẵng', 'Quảng Nam', 'Quảng Ngãi', 'Bình Định', 'Phú Yên', 'Khánh Hòa', 'Ninh Thuận', 'Bình Thuận'];
    gioi_tinh_arr text[] := array['Nam','Nữ'];
BEGIN 
    sv_id := 20210000;
    cccd := 40204010000;
    sdt := 12345000;

    FOR i IN 1..50 LOOP
        ho := ho_arr[floor(random() * array_length(ho_arr, 1) + 1)];
        tendem := tendem_arr[floor(random() * array_length(tendem_arr, 1) + 1)];
        ten := ten_arr[floor(random() * array_length(ten_arr, 1) + 1)];
        ngaysinh := make_date(2003, floor(random() * 12 + 1)::int, floor(random() * 28 + 1)::int);
        sv_id := sv_id + 1;
        cccd := cccd + 1;
        sdt := sdt + 1;

        INSERT INTO public."LyLichSV" ("MaSV", "HoSV", "TenDemSV", "TenSV", "NgaySinh", "DiaDiem", "GioiTinh", "CCCD", "Email", "SDT")
        VALUES (
            sv_id,
            ho,
            tendem,
            ten,
            ngaysinh,
            dia_diem_arr[floor(random() * array_length(dia_diem_arr, 1) + 1)],
            gioi_tinh_arr[floor(random() * array_length(gioi_tinh_arr, 1) + 1)],
            cccd,
            NULL,
            sdt
        );
    END LOOP;
    

    sv_id := 20220000;
    cccd := 40204010050;
    sdt := 12345050;


    FOR i IN 1..300 LOOP
        ho := ho_arr[floor(random() * array_length(ho_arr, 1) + 1)];
        tendem := tendem_arr[floor(random() * array_length(tendem_arr, 1) + 1)];
        ten := ten_arr[floor(random() * array_length(ten_arr, 1) + 1)];
        ngaysinh := make_date(2003, floor(random() * 12 + 1)::int, floor(random() * 28 + 1)::int);
        sv_id := sv_id + 1;
        cccd := cccd + 1;
        sdt := sdt + 1;

        INSERT INTO public."LyLichSV" ("MaSV", "HoSV", "TenDemSV", "TenSV", "NgaySinh", "DiaDiem", "GioiTinh", "CCCD", "Email", "SDT")
        VALUES (
            sv_id,
            ho,
            tendem,
            ten,
            ngaysinh,
            dia_diem_arr[floor(random() * array_length(dia_diem_arr, 1) + 1)],
            gioi_tinh_arr[floor(random() * array_length(gioi_tinh_arr, 1) + 1)],
            cccd,
            NULL,
            sdt
        );
    END LOOP;
END $$;

--------------------DATA cho bảng CACCHUNGCHI------------------------

DO $$
DECLARE
    i INT;
    MaSV INT;
    ChungChi VARCHAR(10);
    ThoiGian DATE;
    ThoiHan INTEGER;
    Diem Double precision;

    ielts_arr double precision[] := array[ 3.0 , 3.5 , 4.0 , 4.5 , 5.0 , 5.5 , 6.0 , 6.5, 7.0, 7.5 , 8.0, 8.5, 9.0 ];
    jlpt_arr integer[] := array[5, 4, 3, 2, 1];
BEGIN

    MaSV := 20210000;
    FOR i IN 1..50 LOOP  -- Tạo 50 bản ghi ví dụ (có thể điều chỉnh số lượng)
        MaSV := MaSV + 1;
        IF MOD(MaSV,4) = 0 THEN
            ChungChi := CASE floor(random() * 4)
                            WHEN 0 THEN 'IELTS'
                            WHEN 1 THEN 'TOEIC'
                            WHEN 2 THEN 'FE'
                            ELSE 'JLPT'
                        END;

            IF ChungChi = 'IELTS' THEN
                Diem := ielts_arr[floor(random() * 13)];
                ThoiHan := 2;  -- Ví dụ cho thời hạn 2 năm
            ELSIF ChungChi = 'TOEIC' THEN
                Diem := FLOOR(random() * 891) + 100;  -- Random từ 100 đến 990
                ThoiHan := 2;  -- Ví dụ cho thời hạn 2 năm
            ELSIF ChungChi = 'FE' THEN
                Diem := NULL;  -- Điểm là NULL
                ThoiHan := 99;  -- Ví dụ cho thời hạn không xác định
            ELSE  -- ChungChi = 'JLPT'
                Diem := jlpt_arr[ floor(random() * 5)];
                ThoiHan := 99;  -- Ví dụ cho thời hạn không xác định
            END IF;

            ThoiGian := make_date(2021, floor(random() * 12 + 1)::int, floor(random() * 28 + 1)::int);  -- Ngày trong năm qua lại

            INSERT INTO public."CacChungChi" ("MaSV", "Ten", "ThoiGian", "ThoiHan", "Diem")
            VALUES (MaSV, ChungChi, ThoiGian, ThoiHan, Diem);
        END IF;
    END LOOP;

    
    MaSV := 20220000;
    FOR i IN 1..300 LOOP  -- Tạo 50 bản ghi ví dụ (có thể điều chỉnh số lượng)
        MaSV := MaSV + 1;
        IF MOD(MaSV,5) = 0 THEN
            ChungChi := CASE floor(random() * 4)
                            WHEN 0 THEN 'IELTS'
                            WHEN 1 THEN 'TOEIC'
                            WHEN 2 THEN 'FE'
                            ELSE 'JLPT'
                        END;

            IF ChungChi = 'IELTS' THEN
                Diem := ielts_arr[floor(random() * 13)];
                ThoiHan := 2;  -- Ví dụ cho thời hạn 2 năm
            ELSIF ChungChi = 'TOEIC' THEN
                Diem := FLOOR(random() * 891) + 100;  -- Random từ 100 đến 990
                ThoiHan := 2;  -- Ví dụ cho thời hạn 2 năm
            ELSIF ChungChi = 'FE' THEN
                Diem := NULL;  -- Điểm là NULL
                ThoiHan := 99;  -- Ví dụ cho thời hạn không xác định
            ELSE  -- ChungChi = 'JLPT'
                Diem := jlpt_arr[ floor(random() * 5)];
                ThoiHan := 99;  -- Ví dụ cho thời hạn không xác định
            END IF;

            ThoiGian := make_date(2021, floor(random() * 12 + 1)::int, floor(random() * 28 + 1)::int);  -- Ngày trong năm qua lại

            INSERT INTO public."CacChungChi" ("MaSV", "Ten", "ThoiGian", "ThoiHan", "Diem")
            VALUES (MaSV, ChungChi, ThoiGian, ThoiHan, Diem);
        END IF;
    END LOOP;
END $$;

--------------------DATA cho bảng GiangVien------------------------
DO $$ 
DECLARE 
    gv_id integer ;
    ho varchar(20);
    tendem varchar(20);
    ten varchar(20);
    sdt bigint;

    ho_arr text[] := array['Nguyễn','Trần','Lê','Phạm','Hoàng','Huỳnh','Võ','Đặng','Bùi','Đỗ','Lý','Phan','Vũ','Hồ','Ngô','Dương','Lý','Đinh'];
    tendem_arr text[] := array['Văn','Bình','Thị','Duy','Thu','Hồng','Tâm','Minh','Lan','Thành','Hải','Đức','Quỳnh'];
    ten_arr text[] := array['An', 'Anh', 'Ban', 'Bình', 'Bích', 'Băng', 'Bạch', 'Bảo', 'Bằng', 'Bội', 'Ca', 'Cam', 'Chi', 'Chinh', 'Chiêu', 
        'Chung', 'Châu', 'Cát', 'Cúc', 'Cương', 'Cầm', 'Cẩm', 'Dao', 'Di', 'Diên', 'Diễm', 'Diệp', 'Diệu', 'Du', 'Dung', 'Duy', 'Duyên', 'Dân', 
        'Dã', 'Dương', 'Dạ', 'Gia', 'Giang', 'Giao', 'Giáng', 'Hiếu', 'Hiền', 'Hiểu', 'Hiệp', 'Hoa', 'Hoan', 'Hoài', 'Hoàn', 'Hoàng', 'Hoạ', 'Huyền', 
        'Huệ', 'Huỳnh', 'Hà', 'Hàm', 'Hân', 'Hòa', 'Hương', 'Hướng', 'Hường', 'Hưởng', 'Hạ', 'Hạc', 'Hạnh', 'Hải', 'Hảo', 'Hậu', 'Hằng', 'Họa', 'Hồ',
         'Hồng', 'Hợp', 'Khai', 'Khanh', 'Khiết', 'Khuyên', 'Khuê', 'Khánh', 'Khê', 'Khôi', 'Khúc', 'Khả', 'Khải', 'Kim', 'Kiết', 'Kiều', 'Kê', 'Kỳ', 
         'Lam', 'Lan', 'Linh', 'Liên', 'Liễu', 'Loan', 'Ly', 'Lâm', 'Lê', 'Lý', 'Lăng', 'Lưu', 'Lễ', 'Lệ', 'Lộc', 'Lợi', 'Lục', 'Mai', 'Mi', 'Minh', 
         'Miên', 'My', 'Mẫn', 'Mậu', 'Mộc', 'Mộng', 'Mỹ', 'Nga', 'Nghi', 'Nguyên', 'Nguyết', 'Nguyệt', 'Ngà', 'Ngân', 'Ngôn', 'Ngọc', 'Nhan', 'Nhi', 
         'Nhiên', 'Nhung', 'Nhàn', 'Nhân', 'Nhã', 'Nhơn', 'Như', 'Nhạn', 'Nhất', 'Nhật', 'Nương', 'Nữ', 'Oanh', 'Phi', 'Phong', 'Phúc', 'Phương', 'Phước',
          'Phượng', 'Phụng', 'Quyên', 'Quân', 'Quế', 'Quỳnh', 'Sa', 'San', 'Sao', 'Sinh', 'Song', 'Sông', 'Sơn', 'Sương', 'Thanh', 'Thi', 'Thiên', 'Thiếu', 
          'Thiều', 'Thiện', 'Thoa', 'Thoại', 'Thu', 'Thuần', 'Thuận', 'Thy', 'Thái', 'Thêu', 'Thông', 'Thùy', 'Thúy', 'Thơ', 'Thư', 'Thương', 'Thường', 
          'Thạch', 'Thảo', 'Thắm', 'Thục', 'Thụy', 'Thủy', 'Tinh', 'Tiên', 'Tiểu', 'Trang', 'Tranh', 'Trinh', 'Triều', 'Triệu', 'Trung', 'Trà', 'Trâm',
           'Trân', 'Trúc', 'Trầm', 'Tuyến', 'Tuyết', 'Tuyền', 'Tuệ', 'Ty', 'Tâm', 'Tùng', 'Tùy', 'Tú', 'Túy', 'Tường', 'Tịnh', 'Tố', 'Từ', 'Uyên', 'Uyển',
            'Vi', 'Vinh', 'Việt', 'Vy', 'Vàng', 'Vành', 'Vân', 'Vũ', 'Vọng', 'Vỹ', 'Xuyến', 'Xuân', 'Yên', 'Yến', 'xanh', 'Ái', 'Ánh', 'Ân', 'Ðan', 'Ðinh', 
            'Ðiệp', 'Ðoan', 'Ðài', 'Ðàn', 'Ðào', 'Ðình', 'Ðông', 'Ðường', 'Ðồng', 'Ý', 'Đan', 'Đinh', 'Đoan', 'Đài', 'Đào', 'Đông', 'Đăng', 'Đơn', 'Đức', 'Ấu'];
    gioi_tinh_arr text[] := array['Nam','Nữ'];
BEGIN 
    gv_id := 12340000;
    sdt := 98765000;

    FOR i IN 1..100 LOOP
        ho := ho_arr[floor(random() * array_length(ho_arr, 1) + 1)];
        tendem := tendem_arr[floor(random() * array_length(tendem_arr, 1) + 1)];
        ten := ten_arr[floor(random() * array_length(ten_arr, 1) + 1)];
        gv_id := gv_id + 1;
        sdt := sdt + 1;

        INSERT INTO public."GiangVien" ("MaGV", "HoGV", "TenDemGV", "TenGV", "GioiTinh", "Email", "SDT")
        VALUES (
            gv_id,
            ho,
            tendem,
            ten,
            gioi_tinh_arr[floor(random() * array_length(gioi_tinh_arr, 1) + 1)],
            NULL,
            sdt
        );
    END LOOP;
END $$;

--------------------DATA cho bảng Diem------------------------

INSERT INTO public."Diem" ("MaSV", "MaHP", "Ky", "DiemGK", "DiemCK", "DiemKTHP")
SELECT
    dk."MaSV",
    dk."MaHP",
    dk."Ky",
    ROUND(RANDOM() * 9 + 1)::integer AS "DiemGK",  -- Random điểm từ 1 đến 10 cho Điểm GK
    ROUND(RANDOM() * 9 + 1)::integer AS "DiemCK",  -- Random điểm từ 1 đến 10 cho Điểm CK
    NULL AS "DiemKTHP"
FROM public."DangKi" dk

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------DATA cho bảng DangKi------------------------

DO
$$
DECLARE
    ma_lop_hoc character(10);
    ky character(10);
    dia_diem character(100);
    ma_hp character(10);
    thoi_gian date;
    si_so integer;
    ma_gv character(100);

    ky_hoc_list text[] := ARRAY['20221', '20222', '20231', '20232', '20233'];
    thoi_gian_list date[] := ARRAY['2022-09-05'::date, '2022-09-06'::date, '2022-09-07'::date, '2022-09-08'::date, '2022-09-09'::date];
    dia_diem_list text[] := ARRAY[
        'D9-101', 'D9-102', 'D9-103', 'D9-104', 'D9-105', 'D9-106',
        'D9-201', 'D9-202', 'D9-203', 'D9-204', 'D9-205', 'D9-206',
        'D9-301', 'D9-302', 'D9-303', 'D9-304', 'D9-305', 'D9-306',
        'D9-401', 'D9-402', 'D9-403', 'D9-404', 'D9-405', 'D9-406',
        'D9-501', 'D9-502', 'D9-503', 'D9-504', 'D9-505', 'D9-506',
        'D7-101', 'D7-102', 'D7-103', 'D7-104', 'D7-105', 'D7-106',
        'D7-201', 'D7-202', 'D7-203', 'D7-204', 'D7-205', 'D7-206',
        'D7-301', 'D7-302', 'D7-303', 'D7-304', 'D7-305', 'D7-306',
        'D7-401', 'D7-402', 'D7-403', 'D7-404', 'D7-405', 'D7-406',
        'D7-501', 'D7-502', 'D7-503', 'D7-504', 'D7-505', 'D7-506',
        'D5-101', 'D5-102', 'D5-103', 'D5-104', 'D5-105', 'D5-106',
        'D5-201', 'D5-202', 'D5-203', 'D5-204', 'D5-205', 'D5-206',
        'D5-301', 'D5-302', 'D5-303', 'D5-304', 'D5-305', 'D5-306',
        'D5-401', 'D5-402', 'D5-403', 'D5-404', 'D5-405', 'D5-406',
        'D5-501', 'D5-502', 'D5-503', 'D5-504', 'D5-505', 'D5-506',
        'C7-101', 'C7-102', 'C7-103', 'C7-104', 'C7-105', 'C7-106',
        'C7-201', 'C7-202', 'C7-203', 'C7-204', 'C7-205', 'C7-206',
        'C7-301', 'C7-302', 'C7-303', 'C7-304', 'C7-305', 'C7-306',
        'C7-401', 'C7-402', 'C7-403', 'C7-404', 'C7-405', 'C7-406',
        'C7-501', 'C7-502', 'C7-503', 'C7-504', 'C7-505', 'C7-506'
    ];
BEGIN
    FOR i IN 1..100 LOOP
        ma_lop_hoc := LPAD((123000 + i)::text, 6, '0');
        ky := ky_hoc_list[FLOOR(RANDOM() * 5) + 1];
        thoi_gian := thoi_gian_list[FLOOR(RANDOM() * 5) + 1];
        dia_diem := dia_diem_list[FLOOR(RANDOM() * 130) + 1];
        si_so := FLOOR(RANDOM() * 21) + 40;
        ma_gv := LPAD((20230000 + FLOOR(RANDOM() * 200) + 1)::text, 10, '0');
        ma_hp := LPAD((123000 + FLOOR(RANDOM() * 200) + 1)::text, 6, '0');

        INSERT INTO public."LopHoc" ("MaLopHoc", "Ky", "DiaDiem", "MaHP", "ThoiGian", "SiSo", "MaGV")
        VALUES (ma_lop_hoc, ky, dia_diem, ma_hp, thoi_gian, si_so, ma_gv);
    END LOOP;
END;
$$;

DO $$
DECLARE
    r RECORD;
    inserted_rows INT := 0;
BEGIN
    FOR r IN 
        SELECT 
            series.MaSV,
            MaHPs.MHP AS MaHP,
            LPAD((FLOOR(RANDOM() * (123100 - 123001 + 1))::BIGINT + 123001)::TEXT, 6, '0') AS MaLopHoc
        FROM
            generate_series(20220001, 20220300) AS series(MaSV)
        CROSS JOIN 
            (SELECT unnest(ARRAY[
               'JP2210',
 'JP2220',
 'JP3110',
 'JP3120',
 'MI1111',
 'MI1114',
 'MI1121',
 'MI1124',
 'MI1131',
 'MI1134',
 'MI1141',
 'MI1144',
 'MI2020',
 'MI2021',
 'MI3052',
 'MIL1110'  ,                                                                                            
 'MIL1120' ,                                                                                            
 'MIL1130',                                                                                              
 'PE1014',
 'PE1024',
 'PE2101',
 'PE2102',
 'PE2201',
 'PE2202',
 'PE2301',
 'PE2302',
 'PE2401',
 'PE2402',
 'PH1110',
 'PH1120',
 'QT0413',
 'QT0423',
 'QT0433',
 'QT0443',
 'QT3413',
 'QT3423',
 'SSH1111'   ,                                                                                           
 'SSH1121'  ,                                                                                            
 'SSH1131' ,                                                                                             
 'SSH1141',                                                                                              
 'SSH1151',                                                                                           
 'TEX3123'                   
            ]) AS MHP) AS MaHPs
        ORDER BY RANDOM()
        LIMIT 1000
    LOOP
        BEGIN
            INSERT INTO "DangKi" ("MaSV", "MaHP", "MaLopHoc")
            VALUES (r.MaSV, r.MaHP, r.MaLopHoc);
            inserted_rows := inserted_rows + 1;
        EXCEPTION WHEN unique_violation THEN
            -- Ignore duplicate rows
        END;
    END LOOP;
    RAISE NOTICE 'Inserted % rows', inserted_rows;
END $$;

--current




DO $$
DECLARE
    maSV INT;
    maHP RECORD;
    
BEGIN
    -- Giả sử MaLopHoc là một giá trị cố định hoặc bạn có logic để xác định MaLopHoc
     -- Bạn cần xác định giá trị thực tế của MaLopHoc dựa trên dữ liệu của bạn
    
    -- Lặp qua các sinh viên có MaSV từ 20210001 đến 20210050
    FOR maSV IN 20210001..20210050 LOOP
        -- Chọn các học phần thuộc kỳ 1 của chương trình đào tạo ngành Việt Nhật
        FOR maHP IN 
            SELECT "MaHP"
            FROM public."CtdtVietNhat"
            WHERE "MaNganh" = 'VN' AND "Ky" = 1
        LOOP
            -- Đăng ký từng học phần cho sinh viên
            INSERT INTO public."DangKi" ("MaSV", "MaHP", "MaLopHoc")
            VALUES (maSV, maHP."MaHP", maLopHoc);
        END LOOP;
    END LOOP;
END $$;


















--------------------------------------------------------------------------TRIGGER + FUNCTION------------------------------------------------------------------------------------- 

--Trigger: tự nhập 4 đầu điểm rèn luyện vào thì sẽ tự tính tổng drl và từ tổng điểm rl sẽ đưa ra xếp loại với 
--tiêu chí : trên 80 là giỏi , trên 50 dưới 80 là khá, dưới 50 là trung bình

CREATE OR REPLACE FUNCTION calculate_diem_ren_luyen()
RETURNS TRIGGER AS $$
BEGIN
    -- Calculate TongDiem
    NEW."TongDiem" := NEW."DiemHocTap" + NEW."DiemNoiQuy" + NEW."DiemYThucCongDan" + NEW."DiemYThucHoatDong";
    
    -- Determine XepLoai
    IF NEW."TongDiem" > 80 THEN
        NEW."XepLoai" := 'Giỏi';
    ELSIF NEW."TongDiem" > 50 THEN
        NEW."XepLoai" := 'Khá';
    ELSE
        NEW."XepLoai" := 'Trung bình';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_calculate_diem_ren_luyen
BEFORE INSERT OR UPDATE ON public."DiemRenLuyen"
FOR EACH ROW
EXECUTE FUNCTION calculate_diem_ren_luyen();


-- Trigger: loại bỏ các dấu và lưu kết quả vào một cột Email mới khi có bất kỳ thay đổi nào trong các cột họ, tên đệm hoặc tên.

CREATE OR REPLACE FUNCTION remove_accents_and_lower_char(input_char CHAR)
RETURNS CHAR AS $$
DECLARE
    result_char CHAR;
BEGIN
    -- Loại bỏ các dấu và chuyển đổi sang ký tự thường
    SELECT translate(LOWER(input_char),
                           'áàảãạâấầẩẫậăắằẳẵặéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵđ',
                           'aaaaaaaaaaaaaaaaaeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyd')
    INTO result_char;

    RETURN result_char;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION remove_accents_and_lower_text(input_text TEXT)
RETURNS TEXT AS $$
DECLARE
    result_text TEXT := '';
    needed_letter CHAR;  -- Sửa đổi thành CHAR để đảm bảo chỉ lưu trữ một ký tự
BEGIN
    -- Loại bỏ các dấu và chuyển đổi sang ký tự thường
    FOR i IN 1..length(input_text) LOOP
        SELECT remove_accents_and_lower_char(substr(input_text, i, 1)) INTO needed_letter;
        result_text := result_text || needed_letter;
    END LOOP;

    RETURN result_text;
END;
$$ LANGUAGE plpgsql;

--Trigger: tự động tạo email từ các cột họ, tên đệm và tên của sinh viên trong bảng LyLichSV,

CREATE OR REPLACE FUNCTION generate_student_email()
RETURNS TRIGGER AS $$
DECLARE
    email_text TEXT;
	TenKhongDau text;
	HoKhongDau text;
BEGIN
	SELECT remove_accents_and_lower_text(NEW."HoSV") into HoKhongDau;
	SELECT remove_accents_and_lower_text(NEW."TenSV") into TenKhongDau;
    email_text :=  TenKhongDau || '.' || HoKhongDau || (NEW."MaSV" - 20000000) || '@sis.hust.edu.vn';

    -- Cập nhật cột Email trong bảng LyLichSV
    NEW."Email" := email_text;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_generate_student_email
BEFORE INSERT OR UPDATE ON public."LyLichSV"
FOR EACH ROW
EXECUTE FUNCTION generate_email();


--Trigger: tự động tạo email từ các cột họ, tên đệm và tên của giảng viên trong bảng GiangVien,

CREATE OR REPLACE FUNCTION generate_teacher_email()
RETURNS TRIGGER AS $$
DECLARE
    email_text TEXT;
	TenKhongDau text;
	HoKhongDau text;
	TenDemKhongDau text;
BEGIN
	SELECT remove_accents_and_lower_text(NEW."HoGV") into HoKhongDau;
	SELECT remove_accents_and_lower_text(NEW."TenDemGV") into TenDemKhongDau;
	SELECT remove_accents_and_lower_text(NEW."TenGV") into TenKhongDau;
    email_text :=  TenKhongDau || '.' || HoKhongDau || TenDemKhongDau || '@hust.edu.vn';

    NEW."Email" := email_text;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_generate_teacher_email
BEFORE INSERT OR UPDATE ON public."GiangVien"
FOR EACH ROW
EXECUTE FUNCTION generate_teacher_email();

-- Trigger để kết hợp các trường họ, tên đệm và tên của bảng LyLichSV thành HoTenSV trong bảng SinhVien
CREATE OR REPLACE FUNCTION update_ho_ten_sv()
RETURNS TRIGGER AS $$
BEGIN
    -- Cập nhật bảng SinhVien
    UPDATE public."SinhVien"
    SET "HoTenSV" = NEW."HoSV" || ' ' || NEW."TenDemSV" || ' ' || NEW."TenSV"
    WHERE "MaSV" = NEW."MaSV";
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_ho_ten_sv
BEFORE INSERT OR UPDATE ON public."LyLichSV"
FOR EACH ROW
EXECUTE FUNCTION update_ho_ten_sv();
	
-- trigger:  tự động tính kết quả kthp từ điểm gk và ck , trọng số theo mã hp
CREATE OR REPLACE FUNCTION calculate_kthp()
RETURNS TRIGGER AS $$
DECLARE
    trong_so double precision;
BEGIN
    SELECT "TrongSo" INTO trong_so
    FROM public."HocPhan"
    WHERE "MaHP" = NEW."MaHP";
    
    NEW."DiemKTHP" := NEW."DiemGK" * (1 - trong_so) + NEW."DiemCK" * trong_so;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Tạo trigger
CREATE TRIGGER trg_calculate_kthp
BEFORE INSERT OR UPDATE ON public."Diem"
FOR EACH ROW
EXECUTE FUNCTION calculate_kthp();


