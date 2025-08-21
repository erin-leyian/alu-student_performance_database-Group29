# alu-student_performance_database-Group29


# ALU Student Performance Database

## Overview
This project is a **MySQL-based student performance database** for ALU Rwanda.  
It is designed as a pre-class activity to practice SQL database creation, table management, data insertion, and running queries to analyze student grades in Linux and Python courses.

---

## Features
1. **Database Creation**  
   - Creates a database named `alu_student_performance`.

2. **Tables**  
   - `students`: Stores student IDs, names, and intake years.  
   - `linux_grades`: Stores Linux course grades for students.  
   - `python_grades`: Stores Python course grades for students.  
   - Foreign keys link grades tables to the `students` table for relational integrity.

3. **Sample Data**  
   - Inserts 15 students with intake years.  
   - Assigns grades for Linux and Python courses.  
   - Some students are in both courses; some in only one.

4. **Queries**  
   - **Q1:** Finds students who scored less than 50% in Linux.  
   - **Q2:** Finds students who took only one course (Linux OR Python, not both).  
   - **Q3:** Finds students who took both courses.  
   - **Q4:** Calculates the average grade per course.  
   - **Q5:** Identifies the top-performing student across both courses (average grade).

---

## How to Run

1. **Open your MySQL client** (CLI, Workbench, or Aiven).  
2. **Connect to the server**:

```bash
mysql -h <host> -u <username> -p
