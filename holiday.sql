-- Student Performance Database at ALU Rwanda

-- creating students table
CREATE TABLE students (
    student_id INT ,
    student_name VARCHAR(50) NOT NULL,
    intake_year INT NOT NULL,
    PRIMARY KEY(student_id)
);


-- creating linux_grades table
CREATE TABLE linux_grades (
    course_id VARCHAR(10) ,
    course_name VARCHAR(50) NOT NULL,
    student_id INT,
    grade_obtained FLOAT NOT NULL,
    PRIMARY KEY(student_id)
);

-- creating python_grades table
CREATE TABLE python_grades (
    course_id VARCHAR(10),
    course_name VARCHAR(50) NOT NULL,
    student_id INT,
    grade_obtained FLOAT NOT NULL,
    PRIMARY KEY(student_id)
);

-- inserting data into students table
INSERT INTO students VALUES
(1, 'Mugisha John', 2022),
(2, 'Kwizera Bodgar', 2023),
(3, 'Mico Johnson', 2022),
(4, 'Nyirizina Wilson', 2023),
(5, 'David Brown', 2024),
(6, 'Gisa Davis', 2022),
(7, 'Thomas Muller', 2023),
(8, 'Gonzalo Garcia', 2024),
(9, 'Kanyarwand Bruce Lee', 2022),
(10, 'Keza Emma', 2023),
(11, 'Rwigamba Taylor', 2024),
(12, 'Girinka Moore', 2022),
(13, 'Kirrikou James Clark', 2023),
(14, 'Imanzi Lewis', 2024),
(15, 'Kamikazi Daniella', 2022),
(16, 'Munyaneza Alice', 2023),
(17, 'Niyonsaba Grace', 2024),
(18, 'Kamanzi Daniel', 2022);

-- inserting data into linux_grades table
INSERT INTO linux_grades VALUES
('LX01', 'Introduction to Linux and IT Tools', 3, 75.0),
('LX01', 'Introduction to Linux and IT Tools', 2, 45.0),
('LX01', 'Introduction to Linux and IT Tools', 7, 60.0),
('LX01', 'Introduction to Linux and IT Tools', 10, 50.0),
('LX01', 'Introduction to Linux and IT Tools', 16, 55.0),
('LX01', 'Introduction to Linux and IT Tools', 18, 90.0),
('LX01', 'Introduction to Linux and IT Tools', 1, 45.0),
('LX01', 'Introduction to Linux and IT Tools', 4, 80.0),
('LX01', 'Introduction to Linux and IT Tools', 5, 35.0),
('LX01', 'Introduction to Linux and IT Tools', 6, 90.0),
('LX01', 'Introduction to Linux and IT Tools', 8, 65.0),
('LX01', 'Introduction to Linux and IT Tools', 12, 40.0),
('LX01', 'Introduction to Linux and IT Tools', 14, 85.0),
('LX01', 'Introduction to Linux and IT Tools', 9, 70.0),
('LX01', 'Introduction to Linux and IT Tools', 11, 55.0);

-- inserting data into python_grades table
INSERT INTO python_grades VALUES
('PY03', 'Introduction to Python Programming and Databases', 3, 85.0),
('PY03', 'Introduction to Python Programming and Databases', 1, 40.0),
('PY03', 'Introduction to Python Programming and Databases', 6, 95.0),
('PY03', 'Introduction to Python Programming and Databases', 8, 70.0),
('PY03', 'Introduction to Python Programming and Databases', 10, 60.0),
('PY03', 'Introduction to Python Programming and Databases', 13, 80.0),
('PY03', 'Introduction to Python Programming and Databases', 4, 70.0),
('PY03', 'Introduction to Python Programming and Databases', 5, 95.0),
('PY03', 'Introduction to Python Programming and Databases', 7, 80.0),
('PY03', 'Introduction to Python Programming and Databases', 9, 75.0),
('PY03', 'Introduction to Python Programming and Databases', 11, 60.0),
('PY03', 'Introduction to Python Programming and Databases', 12, 50.0),
('PY03', 'Introduction to Python Programming and Databases', 2, 65.0),
('PY03', 'Introduction to Python Programming and Databases', 14, 88.0),
('PY03', 'Introduction to Python Programming and Databases', 15, 92.0);

-- finding students who dcored below 50
SELECT students.student_name, linux_grades.grade_obtained
FROM students
JOIN linux_grades ON students.student_id = linux_grades.student_id
WHERE linux_grades.grade_obtained < 50;

-- finding students who took one course but not both 
SELECT students.student_name
FROM students
JOIN linux_grades ON students.student_id = linux_grades.student_id
WHERE students.student_id NOT IN (SELECT student_id FROM python_grades)

UNION

SELECT students.student_name
FROM students  
JOIN python_grades ON students.student_id = python_grades.student_id
WHERE students.student_id NOT IN (SELECT student_id FROM linux_grades);

-- finding students who took both courses
SELECT students.student_name
FROM students
JOIN linux_grades ON students.student_id = linux_grades.student_id
WHERE students.student_id IN (SELECT student_id FROM python_grades)

UNION

SELECT students.student_name
FROM students  
JOIN python_grades ON students.student_id = python_grades.student_id
WHERE students.student_id IN (SELECT student_id FROM linux_grades);

-- calculating the average for each separate course
SELECT 'Linux' as course, 
ROUND(AVG(grade_obtained), 2) as average_grade
FROM linux_grades

UNION

SELECT 'Python' as course, 
ROUND(AVG(grade_obtained), 2) as average_grade  
FROM python_grades;

--  identifying the top performer basing on the average of their grades
SELECT students.student_name, 
       ROUND((linux_grades.grade_obtained + python_grades.grade_obtained) / 2, 2) as average_grade
FROM students
JOIN linux_grades ON students.student_id = linux_grades.student_id
JOIN python_grades ON students.student_id = python_grades.student_id
ORDER BY average_grade DESC
LIMIT 1;