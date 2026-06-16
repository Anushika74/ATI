-- =====================================================================
--  ATI Badulla Web Portal - Database Script
--  Database: ati_badulla_db
--  Run this in the MySQL command line client:
--      mysql -u root -p < ati_badulla_db.sql
--  (or copy/paste the whole file into the MySQL console)
-- =====================================================================

DROP DATABASE IF EXISTS ati_badulla_db;
CREATE DATABASE ati_badulla_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ati_badulla_db;

-- ---------------------------------------------------------------------
-- 1. Users  (admin credentials, passwords stored as SHA-256 hashes)
-- ---------------------------------------------------------------------
CREATE TABLE users (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(50)  NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,          -- SHA-256 hash
    full_name   VARCHAR(100),
    role        VARCHAR(20)  DEFAULT 'ADMIN',
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- NOTE: The default admin (admin / admin123) is created automatically
-- by the application on first start (AppListener) using a hashed password.
-- You do NOT need to insert it manually.

-- ---------------------------------------------------------------------
-- 2. Notices  (scrolling newsline + notice board)
-- ---------------------------------------------------------------------
CREATE TABLE notices (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(200) NOT NULL,
    content     TEXT,
    priority    VARCHAR(20)  DEFAULT 'NORMAL',  -- NORMAL / HIGH / URGENT
    notice_date DATE         DEFAULT (CURRENT_DATE),
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------------------
-- 3. Gallery  (event images + carousel flag)
-- ---------------------------------------------------------------------
CREATE TABLE gallery (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(200),
    image_path  VARCHAR(255) NOT NULL,
    is_carousel TINYINT(1)   DEFAULT 0,         -- 1 = show in homepage slider
    upload_date TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------------------
-- 4. Courses  (diplomas & certificate programmes)
-- ---------------------------------------------------------------------
CREATE TABLE courses (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(200) NOT NULL,
    description TEXT,
    duration    VARCHAR(100),
    fee         VARCHAR(100),
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------------------
-- 5. Results  (student index + marks / grade)
-- ---------------------------------------------------------------------
CREATE TABLE results (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    student_index VARCHAR(50)  NOT NULL,
    student_name  VARCHAR(100),
    course_name   VARCHAR(200),
    marks         VARCHAR(20),
    grade         VARCHAR(10),
    result_file   VARCHAR(255),                 -- optional uploaded document
    uploaded_at   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------------------
-- 6. Site stats (visitor counter - single row)
-- ---------------------------------------------------------------------
CREATE TABLE site_stats (
    id      INT PRIMARY KEY,
    visits  BIGINT DEFAULT 0
);
INSERT INTO site_stats (id, visits) VALUES (1, 0);

-- =====================================================================
--  SAMPLE DATA (so the site is not empty on first run)
-- =====================================================================

INSERT INTO notices (title, content, priority, notice_date) VALUES
('Admissions Open 2026', 'Applications for new diploma programmes are now open. Apply before 30th July.', 'URGENT', CURRENT_DATE),
('Final Exam Timetable Released', 'The semester-end examination timetable has been published. Check the notice board.', 'HIGH', CURRENT_DATE),
('Independence Day Holiday', 'The institute will remain closed on the upcoming public holiday.', 'NORMAL', CURRENT_DATE);

INSERT INTO courses (name, description, duration, fee) VALUES
('HNDIT - Higher National Diploma in IT', 'A comprehensive programme covering software engineering, networking and databases.', '2.5 Years', 'Government Funded'),
('HNDA - Higher National Diploma in Accountancy', 'Diploma focusing on financial and management accounting.', '2.5 Years', 'Government Funded'),
('HNDE - Higher National Diploma in English', 'Diploma in English language and literature.', '2 Years', 'Government Funded'),
('Certificate in Web Design', 'Short certificate course on HTML, CSS, JavaScript and modern web tools.', '6 Months', 'Rs. 15,000');

INSERT INTO results (student_index, student_name, course_name, marks, grade) VALUES
('BAD/IT/2024/001', 'Nimal Perera', 'HNDIT', '78', 'A'),
('BAD/IT/2024/002', 'Kamala Silva', 'HNDIT', '65', 'B'),
('BAD/AC/2024/010', 'Sunil Fernando', 'HNDA', '82', 'A');

-- Gallery rows are added through the Admin Panel (image upload).
-- Example placeholder rows (image files must exist for them to display):
-- INSERT INTO gallery (title, image_path, is_carousel) VALUES ('Annual Sports Meet', 'uploads/sample1.jpg', 1);

SELECT 'Database ati_badulla_db created successfully.' AS message;
