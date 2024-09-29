
----------------------------------------------------------------TRIGGER + FUNCTION------------------------------------------------------------------------------------- 

----------------Trigger: tự nhập 4 đầu điểm rèn luyện vào thì sẽ tự tính tổng drl và từ tổng điểm rl sẽ đưa ra xếp loại ---------------- 
--tiêu chí : trên 80 là giỏi , trên 50 dưới 80 là khá, dưới 50 là trung bình

CREATE OR REPLACE FUNCTION calculate_diem_ren_luyen()
RETURNS TRIGGER AS $$
BEGIN
    NEW."TongDiem" := NEW."DiemHocTap" + NEW."DiemNoiQuy" + NEW."DiemYThucCongDan" + NEW."DiemYThucHoatDong";
    
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

----------------Function: loại bỏ dấu + biến thành chữ thường trong các cột họ, tên đệm hoặc tên----------------

CREATE OR REPLACE FUNCTION remove_accents_and_lower_char(input_char CHAR)
RETURNS CHAR AS $$
DECLARE
    result_char CHAR;
BEGIN
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
    needed_letter CHAR; 
BEGIN
    FOR i IN 1..length(input_text) LOOP
        SELECT remove_accents_and_lower_char(substr(input_text, i, 1)) INTO needed_letter;
        result_text := result_text || needed_letter;
    END LOOP;

    RETURN result_text;
END;
$$ LANGUAGE plpgsql;

----------------Trigger: tự động tạo email từ các cột họ, tên đệm và tên của sinh viên trong bảng LyLichSV----------------

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

    NEW."Email" := email_text;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_generate_student_email
BEFORE INSERT OR UPDATE ON public."LyLichSV"
FOR EACH ROW
EXECUTE FUNCTION generate_email();


----------------Trigger: tự động tạo email từ các cột họ, tên đệm và tên của giảng viên trong bảng GiangVien----------------

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

----------------Trigger để kết hợp các trường họ, tên đệm và tên của bảng LyLichSV thành HoTenSV trong bảng SinhVien----------------
CREATE OR REPLACE FUNCTION update_ho_ten_sv()
RETURNS TRIGGER AS $$
BEGIN
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
	
----------------trigger:  tự động tính kết quả kthp từ điểm gk và ck , trọng số theo mã hp----------------
CREATE OR REPLACE FUNCTION calculate_kthp()
RETURNS TRIGGER AS $$
DECLARE
    trong_so double precision;
BEGIN
    SELECT "TrongSo" INTO trong_so
    FROM public."HocPhan"
    WHERE "MaHP" = NEW."MaHP";
    
    NEW."DiemKTHP" := ROUND(NEW."DiemGK" * (1 - trong_so) + NEW."DiemCK" * trong_so, 2);
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_calculate_kthp
BEFORE INSERT OR UPDATE ON public."Diem"
FOR EACH ROW
EXECUTE FUNCTION calculate_kthp();


----------------trigger:  tự động thêm lớp học vào bảng LopHoc sau khi một mã lớp được xếp ở bảng DangKi----------------

CREATE OR REPLACE FUNCTION add_to_lophoc()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public."LopHoc" ("MaLopHoc", "Ky", "MaHP")
    VALUES (
        NEW."MaLopHoc",
        NEW."Ky",
        NEW."MaHP"
    )
    ON CONFLICT ("MaLopHoc") DO NOTHING; -- Avoid duplicates
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_add_to_lophoc
AFTER INSERT ON public."DangKi"
FOR EACH ROW
WHEN (NEW."MaLopHoc" IS NOT NULL)
EXECUTE FUNCTION add_to_lophoc();

----------------trigger:  tự cập nhật sĩ số của lớp học ở bảng dangki----------------
CREATE OR REPLACE FUNCTION update_si_so_lop_hoc()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE public."LopHoc"
    SET "SiSo" = (
        SELECT COUNT(*)
        FROM public."DangKi"
        WHERE "MaLopHoc" = NEW."MaLopHoc"
    )
    WHERE "MaLopHoc" = NEW."MaLopHoc";
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_si_so_lop_hoc_insert
AFTER INSERT ON public."DangKi"
FOR EACH ROW
WHEN (NEW."MaLopHoc" IS NOT NULL)
EXECUTE FUNCTION update_si_so_lop_hoc();

CREATE TRIGGER trg_update_si_so_lop_hoc_delete
AFTER delete ON public."DangKi"
FOR EACH ROW
WHEN (old."MaLopHoc" IS NOT NULL)
EXECUTE FUNCTION update_si_so_lop_hoc();

----------------------------------------------------------------TRUY VẤN------------------------------------------------------------------------------------- 

--cau1 : hiển thị thông tin chi tiết bằng cách join bảng SV vs LyLichSV vs Lop , ko cần index 
SELECT 
    sv."MaSV",
    sv."HoTenSV",
    ll."NgaySinh",
    ll."GioiTinh",
    lop."TenLop"
FROM 
    public."SinhVien" sv
JOIN 
    public."LyLichSV" ll ON sv."MaSV" = ll."MaSV"
JOIN 
    public."Lop" lop ON sv."MaLop" = lop."MaLop";

--cau2 : hiển thị top 3 sinh viên của lớp "Việt Pháp 01 K67" có điểm môn "Giải tích 1" lớn hơn hoặc bằng 7

CREATE INDEX idx_diem_diemkthp ON public."Diem" ("DiemKTHP");
CREATE INDEX idx_hocphan_tenhp ON public."HocPhan" ("TenHP");
CREATE INDEX idx_lop_tenlop ON public."Lop" ("TenLop");


EXPLAIN ANALYZE
SELECT
    sv."MaSV",
    sv."HoTenSV",
    d."DiemKTHP" AS "DiemGiaiTich1"
FROM
    public."SinhVien" sv
JOIN
    public."Lop" lop ON sv."MaLop" = lop."MaLop"
JOIN
    public."Diem" d ON sv."MaSV" = d."MaSV"
JOIN
    public."HocPhan" hp ON d."MaHP" = hp."MaHP"
WHERE
    lop."TenLop" = 'Việt Pháp 01 K67'
    AND hp."TenHP" = 'Giải tích 1'
    AND d."DiemKTHP" >= 7
ORDER BY
    d."DiemKTHP" DESC
LIMIT 3;

--cau3 : in ra thông tin chi tiết các sv tuổi > 19
EXPLAIN ANALYZE
SELECT 
    sv."MaSV",
    sv."HoTenSV",
    ll."NgaySinh",
    ll."DiaDiem" AS "QueQuan"
FROM 
    public."SinhVien" sv
JOIN 
    public."LyLichSV" ll ON sv."MaSV" = ll."MaSV"
WHERE 
     DATE_PART('year', AGE(ll."NgaySinh")) > 19;

     --tối ưu
        CREATE INDEX idx_ngaysinh ON public."LyLichSV" ("NgaySinh"); --tao chi mục trên cột ngày sinh, còn MaSV thì ko cần vì là khóa chính
        drop index idx_ngaysinh;

        EXPLAIN ANALYZE
        SELECT
            sv."MaSV",
            sv."HoTenSV",
            ll."NgaySinh",
            ll."DiaDiem" AS "QueQuan"
        FROM
            public."SinhVien" sv
        JOIN
            public."LyLichSV" ll ON sv."MaSV" = ll."MaSV"
        WHERE
            ll."NgaySinh" < CURRENT_DATE - INTERVAL '19 years'; -- Thay vì tính toán AGE(ll."NgaySinh") và so sánh với 19, dùng trực tiếp trên cột NgaySinh để  giảm bớt phần tính toán mỗi lần thực thi truy vấn.


--cau4 : Hien Thi Tat Ca Nhung Sinh Vien Khoa Trường Công nghệ thông tin và Truyền thông
SELECT 
    sv."MaSV",
    sv."HoTenSV",
    lop."TenLop",
    lop."MaNganh",
    lop."Khoa"
FROM 
    public."SinhVien" sv
JOIN 
    public."Lop" lop ON sv."MaLop" = lop."MaLop"
WHERE 
    lop."Khoa" = 'Trường Công nghệ thông tin và Truyền thông';


    --tối ưu: 
    CREATE INDEX idx_lop_khoa ON public."Lop" ("Khoa");

    drop index idx_lop_khoa;

--cau5 : Hien Thi Diem cua sinh vien lop viỆt nHẬT )& KHOA cntt
SELECT 
    sv."MaSV",
    sv."HoTenSV",
    d."MaHP",
    d."DiemGK",
    d."DiemCK",
    d."DiemKTHP"
FROM 
    public."SinhVien" sv
JOIN 
    public."Lop" lop ON sv."MaLop" = lop."MaLop"
JOIN 
    public."Diem" d ON sv."MaSV" = d."MaSV"
WHERE 
    lop."TenLop" = 'Việt Nhật 07 K67'
    AND lop."Khoa" = 'Trường Công nghệ thông tin và Truyền thông                                                          '
ORDER BY 
    d."DiemKTHP" DESC;

-- ko tối ưu : CREATE INDEX idx_sv_malop ON public."SinhVien" ("MaLop"); vì sau khi thêm index lại chạy lâu hơn?
    CREATE INDEX idx_lop_khoa ON public."Lop" ("Khoa");
    
--cau6 : tính trung bình điểm các môn học của các sinh viên trong lớp Công nghệ thông tin 01 K67
SELECT 
    sv."MaSV",
    sv."HoTenSV",
    AVG(d."DiemKTHP") AS "TrungBinhDiem"
FROM 
    public."SinhVien" sv
JOIN 
    public."Lop" lop ON sv."MaLop" = lop."MaLop"
JOIN 
    public."Diem" d ON sv."MaSV" = d."MaSV"
WHERE 
    lop."TenLop" = 'Công nghệ thông tin 01 K67'
GROUP BY 
    sv."MaSV", sv."HoTenSV";

    --toi uu : 
    
    CREATE INDEX idx_sv_malop ON public."SinhVien" ("MaLop");

--cau7 : hiển thị danh sách sinh viên phải học lại môn "Đường lối quân sự của Đảng" với điểm dưới 5

SELECT
	sv."MaSV",
	sv."HoTenSV",
	d."MaHP",
	d."DiemKTHP"
FROM
	public."SinhVien" sv
JOIN
	public."Diem" d ON sv."MaSV" = d."MaSV"
JOIN
	public."HocPhan" hp ON d."MaHP" = hp."MaHP"
WHERE
	hp."TenHP" = 'Đường lối quân sự của Đảng'
	AND d."DiemKTHP" < 5
ORDER BY
	d."DiemKTHP" ASC;

    --toi uu: 
    CREATE INDEX idx_diem_diemkthp ON public."Diem" ("DiemKTHP");
    CREATE INDEX idx_hocphan_tenhp ON public."HocPhan" ("TenHP");



--cau8 : đếm số lượng sinh viên của Trường Công nghệ thông tin và Truyền thông

SELECT
	COUNT(sv."MaSV") AS "SoLuongSinhVien"
FROM
	public."SinhVien" sv
JOIN
	public."Lop" lop ON sv."MaLop" = lop."MaLop"
WHERE
	lop."Khoa" = 'Trường Công nghệ thông tin và Truyền thông';

    --toi uu :
    CREATE INDEX idx_lop_khoa ON public."Lop" ("Khoa");


--cau9 : đếm số lượng sinh viên của từng khoa

SELECT
	lop."Khoa",
	COUNT(sv."MaSV") AS "SoLuongSinhVien"
FROM
	public."SinhVien" sv
JOIN
	public."Lop" lop ON sv."MaLop" = lop."MaLop"
GROUP BY
	lop."Khoa";
        -- tối wuu : 
        CREATE INDEX idx_sv_malop ON public."SinhVien" ("MaLop");
--cau10 : Cho biet diem thap nhat cua moi mon hoc
SELECT
	hp."MaHP",
	hp."TenHP" AS "MonHoc",
	MIN(d."DiemKTHP") AS "DiemThapNhat"
FROM
	public."Diem" d
JOIN
	public."HocPhan" hp ON d."MaHP" = hp."MaHP"
GROUP BY
	hp."MaHP", hp."TenHP";

--cau 11a : Hien Thi Chi Tiet Sinh Vien Va Diem
-- Creating the procedure
CREATE OR REPLACE PROCEDURE public."HienThiChiTietSV"	(IN p_MaSV integer)
LANGUAGE plpgsql
AS $$
DECLARE
    v_TenSV character varying(100);
    v_NgaySinh date;
    v_QueQuan character varying(100);
    v_DiemCursor CURSOR FOR
        SELECT
            hp."MaHP", hp."TenHP", d."DiemGK", d."DiemCK", d."DiemKTHP", hp."Ky"
        FROM
            public."Diem" d
        JOIN
            public."HocPhanChiTiet" hp ON d."MaHP" = hp."MaHP"
        WHERE
            d."MaSV" = p_MaSV;
    v_MaHP character varying(100);
    v_TenHP character varying(100);
    v_DiemGK integer;
    v_DiemCK integer;
    v_DiemKTHP integer;
	V_Ky integer;
BEGIN
    -- Get student basic information
    SELECT
        "TenSV", "NgaySinh", "DiaDiem"
    INTO
        v_TenSV, v_NgaySinh, v_QueQuan
    FROM
        public."LyLichSV"
    WHERE
        "MaSV" = p_MaSV;
    
    -- Print student details
    RAISE NOTICE 'Thong tin chi tiet cua sinh vien co MaSV = %:', p_MaSV;
    RAISE NOTICE 'Ho va ten: %', v_TenSV;
    RAISE NOTICE 'Ngay sinh: %', v_NgaySinh;
    RAISE NOTICE 'Que quan: %', v_QueQuan;
    RAISE NOTICE '-------------------------';
    
    OPEN v_DiemCursor;
    
    LOOP
        FETCH v_DiemCursor INTO v_MaHP, v_TenHP, v_DiemGK, v_DiemCK, v_DiemKTHP, v_Ky;
        EXIT WHEN NOT FOUND;
        
        RAISE NOTICE 'Mon hoc: % - %', v_MaHP, v_TenHP;
		RAISE NOTICE '  Ky: %', v_Ky::text;
        RAISE NOTICE '  Diem GK: %', COALESCE(v_DiemGK::text, 'Chua co');
        RAISE NOTICE '  Diem CK: %', COALESCE(v_DiemCK::text, 'Chua co');
        RAISE NOTICE '  Diem KTHP: %', COALESCE(v_DiemKTHP::text, 'Chua co');
        RAISE NOTICE '-------------------------';
    END LOOP;
    
    CLOSE v_DiemCursor;
END;
$$;

CALL public."HienThiChiTietSV"(20210001);


--cau 14: 

SELECT
    sv."MaSV",
    sv."HoTenSV",
    SUM(hp."SoTinHocPhan") AS "SoTinHocPhi"
FROM
    public."SinhVien" sv
JOIN
    public."Diem" d ON sv."MaSV" = d."MaSV"
JOIN
    public."HocPhan" hp ON d."MaHP" = hp."MaHP"
GROUP BY
    sv."MaSV", sv."HoTenSV"
ORDER BY
    sv."MaSV";

--cau 15

