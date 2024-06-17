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
    "HoTenSV" character varying(100) ,
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

    CONSTRAINT "DangKi_pkey" PRIMARY KEY ("MaSV","MaHP","MaLopHoc"),

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
    "XepLoai" character(50) ,
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
    "Diem" integer NOT NULL,
 
    CONSTRAINT "ChungChi_pkey" PRIMARY KEY ("MaSV","Ten"),
 	
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
CREATE TABLE public."CtdtVietNhat"
(
    "TenHP" character(100)  NOT NULL,
    "MaHP" character(100)  NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
	"TrongSo" float not NULL,
    "Ky" integer,

    CONSTRAINT "CtdtVietNhat_pkey" PRIMARY KEY ("MaHP")
);

CREATE TABLE public."CtdtVietPhap"
(
    "TenHP" character(100)  NOT NULL,
    "MaHP" character(100)  NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
	"TrongSo" float not NULL,
    "Ky" integer,

    CONSTRAINT "CtdtVietPhap_pkey" PRIMARY KEY ("MaHP")
);

CREATE TABLE public."CtdtICT"
(
    "TenHP" character(100)  NOT NULL,
    "MaHP" character(100)  NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
	"TrongSo" float not NULL,
    "Ky" integer,

    CONSTRAINT "CtdtICT_pkey" PRIMARY KEY ("MaHP")
);

CREATE TABLE public."CtdtIT1"
(
    "TenHP" character(100)  NOT NULL,
    "MaHP" character(100)  NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
	"TrongSo" float not NULL,
    "Ky" integer,

    CONSTRAINT "CtdtIT1_pkey" PRIMARY KEY ("MaHP")
);

CREATE TABLE public."CtdtIT2"
(
    "TenHP" character(100)  NOT NULL,
    "MaHP" character(100)  NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
	"TrongSo" float not NULL,
    "Ky" integer,

    CONSTRAINT "CtdtIT2_pkey" PRIMARY KEY ("MaHP")
);

CREATE TABLE public."CtdtDSAI"
(
    "TenHP" character(100)  NOT NULL,
    "MaHP" character(100)  NOT NULL,
    "SoTinHocPhan" integer NOT NULL,
    "SoTinHocPhi" float NOT NULL,
	"TrongSo" float not NULL,
    "Ky" integer,

    CONSTRAINT "CtdtDSAI_pkey" PRIMARY KEY ("MaHP")
);
-------------------------------------------------------------------------------------


--TAO DATA 


INSERT INTO public."HeDaoTao" ("TenHDT", "MaHDT", "TienTinChi")
VALUES 
    ('Chương trình đào tạo chuẩn', 'C',500),
    ('Chương trình đào tạo đặc biệt Elitech 1', 'E1',680),
    ('Chương trình đào tạo đặc biệt Elitech 2', 'E2',1020)
;


INSERT INTO public."Lop" ("TenLop", "MaLop", "MaHDT", "Nganh", "Khoa", "SiSo", "MaLopTruong")
VALUES 
    ('Việt Nhật 02 K66', 'VN02-66', 'E1', 'Công nghệ thông tin Việt-Nhật', 'Trường Công nghệ thông tin và Truyền thông', 50, 20210020),
    ('Việt Nhật 07 K67', 'VN07-67', 'E1', 'Công nghệ thông tin Việt-Nhật', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220035),
    ('Việt Pháp 01 K67', 'VP01-67', 'E1', 'Công nghệ thông tin Việt-Pháp', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220075),
    ('Công nghệ thông tin 01 K67', 'ICT01-67', 'E1', 'Công nghệ thông tin', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220109),
    ('Khoa học máy tính 03 K67', 'IT103-67', 'C', 'Khoa học máy tính', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220169),
    ('Kỹ thuật máy tính 01 K67', 'IT201-67', 'C', 'Kỹ thuật máy tính', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220225),
    ('Khoa học dữ liệu và trí tuệ nhân tạo 01 K67', 'DSAI01-67', 'E2', 'Khoa học dữ liệu và trí tuệ nhân tạo', 'Trường Công nghệ thông tin và Truyền thông', 50, 20220287)
    ;



--DATA cho bảng DiemRenLuyen


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


-- Tạo dữ liệu ngẫu nhiên cho bảng SinhVien
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


--BANG LyLichSV

DO $$ 
DECLARE 
    sv_id integer := 20210000;
    ho varchar(20);
	tendem varchar(20);
	ten varchar(20);
    ngaysinh date;
    cccd bigint := 40204010000;
    sdt bigint := 12345000;
BEGIN 
    FOR i IN 1..50 LOOP
        ho := 
            (array['Nguyễn','Trần','Lê','Phạm','Hoàng','Huỳnh','Võ','Đặng','Bùi','Đỗ','Lý','Phan','Vũ','Hồ','Ngô','Dương','Lý','Đinh'])[floor(random()*18) + 1] ;
        tendem :=   
            (array['Văn','Bình','Thị','Duy','Thu','Hồng','Tâm','Minh','Lan','Thành','Hải','Đức','Quỳnh'])[floor(random()*13) + 1] ;
        ten :=
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
            'Đoan', 'Đài', 'Đào', 'Đông', 'Đăng', 'Đơn', 'Đức', 'Ấu'])[floor(random()*200) + 1];
		
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
            (array['Hà Nội','Hà Giang','Cao Bằng','Bắc Kạn','Tuyên Quang','Lào Cai','Điện Biên','Lai Châu',
            'Sơn La','Yên Bái','Hoà Bình','Thái Nguyên','Lạng Sơn','Quảng Ninh', 'Bắc Giang', 'Phú Thọ', 'Vĩnh Phúc', 'Bắc Ninh', 'Hải Dương',
            'Hải Phòng', 'Hưng Yên', 'Thái Bình', 'Hà Nam', 'Nam Định', 'Ninh Bình', 'Thanh Hóa', 'Nghệ An', 'Hà Tĩnh', 'Quảng Bình', 'Quảng Trị', 
            'Thừa Thiên Huế', 'Đà Nẵng', 'Quảng Nam', 'Quảng Ngãi', 'Bình Định', 'Phú Yên', 'Khánh Hòa', 'Ninh Thuận', 'Bình Thuận'])[floor(random()*39) + 1],
            (array['Nam','Nữ'])[floor(random()*2) + 1],
            cccd,
            NULL,
            sdt
        );
        
    END LOOP;
END $$;


DO $$ 
DECLARE 
    sv_id integer := 20220000;
    ho varchar(20);
	tendem varchar(20);
	ten varchar(20);
    ngaysinh date;
    cccd bigint := 40204010050;
    sdt bigint := 12345050;
BEGIN 
    FOR i IN 1..300 LOOP
        ho := 
            (array['Nguyễn','Trần','Lê','Phạm','Hoàng','Huỳnh','Võ','Đặng','Bùi','Đỗ','Lý','Phan','Vũ','Hồ','Ngô','Dương','Lý','Đinh'])[floor(random()*18) + 1] ;
        tendem :=   
            (array['Văn','Bình','Thị','Duy','Thu','Hồng','Tâm','Minh','Lan','Thành','Hải','Đức','Quỳnh'])[floor(random()*13) + 1] ;
        ten :=
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
            'Đoan', 'Đài', 'Đào', 'Đông', 'Đăng', 'Đơn', 'Đức', 'Ấu'])[floor(random()*200) + 1];
		
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
            (array['Hà Nội','Hà Giang','Cao Bằng','Bắc Kạn','Tuyên Quang','Lào Cai','Điện Biên','Lai Châu',
            'Sơn La','Yên Bái','Hoà Bình','Thái Nguyên','Lạng Sơn','Quảng Ninh', 'Bắc Giang', 'Phú Thọ', 'Vĩnh Phúc', 'Bắc Ninh', 'Hải Dương',
            'Hải Phòng', 'Hưng Yên', 'Thái Bình', 'Hà Nam', 'Nam Định', 'Ninh Bình', 'Thanh Hóa', 'Nghệ An', 'Hà Tĩnh', 'Quảng Bình', 'Quảng Trị', 
            'Thừa Thiên Huế', 'Đà Nẵng', 'Quảng Nam', 'Quảng Ngãi', 'Bình Định', 'Phú Yên', 'Khánh Hòa', 'Ninh Thuận', 'Bình Thuận'])[floor(random()*39) + 1],
            (array['Nam','Nữ'])[floor(random()*2) + 1],
            cccd,
            NULL,
            sdt
        );
        
    END LOOP;
END $$;
--

update public."SinhVien"
set "MaLop" = 'VN-08'
where "MaSV" < 201 and "MaSV" > 100;

------BANG CACCHUNGCHI
select * from "CacChungChi"

DO $$
DECLARE
    i INT;
    MaSV INT;
    ChungChi VARCHAR(10);
    ThoiGian DATE;
    ThoiHan INTEGER;
    Diem INTEGER;
BEGIN
    for i IN 1..50 LOOP  -- Tạo 50 bản ghi ví dụ (có thể điều chỉnh số lượng)
        MaSV := 20210000 + i;
        ChungChi := CASE floor(random() * 5)
                        WHEN 0 THEN 'IELTS'
                        WHEN 1 THEN 'SAT'
                        WHEN 2 THEN 'TOEIC'
                        WHEN 3 THEN 'FE'
                        ELSE 'JLPT'
                    END;

        IF ChungChi = 'IELTS' THEN
            Diem := FLOOR(random() * 13) + 3;  -- Random các band từ 3 đến 15 (tương ứng với 3.0 đến 9.0)
            ThoiHan := 2;  -- Ví dụ cho thời hạn 2 năm
        ELSIF ChungChi = 'SAT' THEN
            Diem := FLOOR(random() * 801) + 700;  -- Random từ 700 đến 1500
            ThoiHan := 2;  -- Ví dụ cho thời hạn 2 năm
        ELSIF ChungChi = 'FE' THEN
            Diem := FLOOR(random() * 901) + 100;  -- Random từ 100 đến 1000
            ThoiHan := 99;  -- Ví dụ cho thời hạn không xác định
        ELSE  
            -- ChungChi = 'JLPT'
            Diem := CASE floor(random() * 5)
                        WHEN 0 THEN 5  -- Đây là cấp độ N5
                        WHEN 1 THEN 4  -- Đây là cấp độ N4
                        WHEN 2 THEN 3  -- Đây là cấp độ N3
                        WHEN 3 THEN 2  -- Đây là cấp độ N2
                        ELSE 1  -- Đây là cấp độ N1
                    END;
            ThoiHan := 99;  -- Ví dụ cho thời hạn không xác định
        END IF;

        -- Tạo ngày tháng ngẫu nhiên
        ThoiGian := make_date(2021, floor(random() * 12 + 1)::int, floor(random() * 28 + 1)::int);  -- Ngày trong năm qua lại

        -- Insert vào bảng "CacChungChi"
        INSERT INTO public."CacChungChi" ("MaSV", "Ten", "ThoiGian", "ThoiHan", "Diem")
        VALUES (MaSV, ChungChi, ThoiGian, ThoiHan, Diem);
		i := i+13
    END loop;
END $$;



-------------------------------------------------------------------------------------
--TRIGGER + FUNCTION


--tự nhập 4 đầu điểm rèn luyện vào thì sẽ tự tính tổng drl và từ tổng điểm rl sẽ đưa ra xếp loại với 
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

--tự động tạo email từ các cột họ, tên đệm và tên của sinh viên trong bảng LyLichSV,
-- loại bỏ các dấu và lưu kết quả vào một cột Email mới khi có bất kỳ thay đổi nào trong các cột họ, tên đệm hoặc tên.


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

SELECT remove_accents_and_lower_char('Á');
SELECT remove_accents_and_lower_text('ÁNH');


CREATE OR REPLACE FUNCTION generate_email()
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

CREATE TRIGGER trg_generate_email
BEFORE INSERT OR UPDATE ON public."LyLichSV"
FOR EACH ROW
EXECUTE FUNCTION generate_email();