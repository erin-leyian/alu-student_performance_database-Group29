-- ##############################################################
-- Student Performance Database - ALU Rwanda
-- Pre-Class Activity (MySQL)

CREATE DATABASE alu_student_performance;
USE alu_student_performance;

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    intake_year INT NOT NULL
);

CREATE TABLE linux_grades (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50) DEFAULT 'Linux',
    student_id INT,
    grade_obtained INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE python_grades (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50) DEFAULT 'Python',
    student_id INT,
    grade_obtained INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);


INSERT INTO students (student_name, intake_year) VALUES
('Alice U.', 2023), ('Brian K.', 2023), ('Clara M.', 2022),
('David N.', 2024), ('Esther P.', 2022), ('Frank O.', 2023),
('Grace T.', 2024), ('Henry L.', 2022), ('Irene C.', 2023),
('James D.', 2022), ('Kevin R.', 2024), ('Linda S.', 2023),
('Michael J.', 2022), ('Nina V.', 2023), ('Oscar W.', 2024);

-- Some students only in Linux, some only in Python, some in both
INSERT INTO linux_grades (student_id, grade_obtained) VALUES
(1, 65), (2, 45), (3, 78), (5, 49), (6, 82),
(7, 90), (9, 35), (11, 70), (12, 55), (14, 88);

INSERT INTO python_grades (student_id, grade_obtained) VALUES
(1, 72), (3, 80), (4, 60), (6, 40), (7, 95),
(8, 50), (10, 67), (12, 84), (13, 73), (15, 92);


-- Q1: Find students who scored less than 50% in the Linux course
SELECT s.student_id, s.student_name, l.grade_obtained
FROM students s
JOIN linux_grades l ON s.student_id = l.student_id
WHERE l.grade_obtained < 50;

-- Q2: Find students who took only one course (Linux OR Python, not both)
SELECT s.student_id, s.student_name
FROM students s
WHERE s.student_id IN (SELECT student_id FROM linux_grades)
  XOR s.student_id IN (SELECT student_id FROM python_grades);

-- Q3: Find students who took both courses
SELECT s.student_id, s.student_name
FROM students s
WHERE s.student_id IN (SELECT student_id FROM linux_grades)
  AND s.student_id IN (SELECT student_id FROM python_grades);

-- Q4: Calculate the average grade per course (Linux and Python separately)
SELECT 'Linux' AS course, AVG(grade_obtained) AS avg_grade
FROM linux_grades
UNION
SELECT 'Python' AS course, AVG(grade_obtained) AS avg_grade
FROM python_grades;

-- Q5: Identify the top-performing student across both courses
-- (based on average of their grades)
SELECT s.student_id, s.student_name,
       AVG(g.grade_obtained) AS average_grade
FROM students s
JOIN (
    SELECT student_id, grade_obtained FROM linux_grades
    UNION ALL
    SELECT student_id, grade_obtained FROM python_grades
) g ON s.student_id = g.student_id
GROUP BY s.student_id, s.student_name
ORDER BY average_grade DESC
LIMIT 1;
