-- ALU school database - Group 26
CREATE DATABASE IF NOT EXISTS alu_db;
USE alu_db;


-- Member B - Classroom
CREATE TABLE Classroom (
    classroom_id INT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL,
    building VARCHAR(50) NOT NULL,
    capacity INT
);

INSERT INTO Classroom (classroom_id, room_number, building, capacity)
VALUES
(1, '101', 'Main Hall', 30),
(2, '102', 'Main Hall', 25),
(3, '201', 'Science Block', 40),
(4, '202', 'Science Block', 35),
(5, '301', 'Arts Building', 20);

UPDATE Classroom
SET capacity = 45
WHERE classroom_id = 3;

DELETE FROM Classroom
WHERE classroom_id = 5;

SELECT *
FROM Classroom
WHERE building = 'Main Hall';


-- Member C - Faculty
CREATE TABLE Faculty (
    faculty_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    department VARCHAR(100)
);

INSERT INTO Faculty (faculty_id, name, email, department)
VALUES
(101, 'Dr. Alice Johnson', 'alice.johnson@aluedu.com', 'Software Engineering'),
(102, 'Dr. Brian Smith', 'brian.smith@aluedu.com', 'International Business and Trade'),
(103, 'Dr. Catherine Brown', 'catherine.brown@aluedu.com', 'Entrepreneurial Leadership'),
(104, 'Dr. David Wilson', 'david.wilson@aluedu.com', 'Entrepreneurial Leadership'),
(105, 'Dr. Emily Davis', 'emily.davis@aluedu.com', 'Software Engineering');

UPDATE Faculty
SET department = 'Software Engineering'
WHERE faculty_id = 103;

DELETE FROM Faculty
WHERE faculty_id = 105;

SELECT *
FROM Faculty
WHERE department = 'Software Engineering';


-- Member A - Students
-- has a FK to Classroom, that's why Classroom is created above this
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    classroom_id INT,
    enrollment_date DATE,
    FOREIGN KEY (classroom_id)
        REFERENCES Classroom(classroom_id)
);

INSERT INTO Students (student_id, name, email, classroom_id, enrollment_date)
VALUES
(1, 'Bruno Heart', 'bruno@alu.edu', 1, '2026-01-10'),
(2, 'Kotana Alan', 'kotana@alu.edu', 2, '2026-01-11'),
(3, 'Fiacre Dev', 'fiacre@alu.edu', 3, '2026-01-12'),
(4, 'Favour nziza', 'favour@alu.edu', 4, '2026-01-13'),
(5, 'Ishimwe Charles', 'i.charles@alu.edu', 2, '2026-01-14');

UPDATE Students
SET email = 'student4_updated@alu.edu'
WHERE student_id = 4;

DELETE FROM Students
WHERE student_id = 5;

SELECT *
FROM Students
WHERE classroom_id = 1;


-- Member D - Courses
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT,
    faculty_id INT,
    classroom_id INT,
    FOREIGN KEY (faculty_id)
        REFERENCES Faculty(faculty_id),
    FOREIGN KEY (classroom_id)
        REFERENCES Classroom(classroom_id)
);

INSERT INTO Courses (course_id, course_name, credits, faculty_id, classroom_id)
VALUES
(201, 'Database Systems', 3, 101, 1),
(202, 'Software Engineering', 4, 101, 2),
(203, 'Entrepreneurship', 3, 103, 3),
(204, 'Business Analytics', 3, 102, 4),
(205, 'Leadership', 2, 104, 1);

UPDATE Courses
SET credits = 4
WHERE course_id = 201;

DELETE FROM Courses
WHERE course_id = 205;

SELECT *
FROM Courses
WHERE credits = 3;


-- Member E - Extra_Curricular_Activities + the two junction tables
CREATE TABLE Extra_Curricular_Activities (
    activity_id INT PRIMARY KEY,
    activity_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    faculty_advisor_id INT,
    FOREIGN KEY (faculty_advisor_id)
        REFERENCES Faculty(faculty_id)
);

INSERT INTO Extra_Curricular_Activities
(activity_id, activity_name, category, faculty_advisor_id)
VALUES
(1, 'Football Club', 'Sports', 102),
(2, 'Basketball Club', 'Sports', 104),
(3, 'Drama Club', 'Arts', 103),
(4, 'Music Club', 'Arts', 101),
(5, 'Coding Club', 'Technology', 101);

UPDATE Extra_Curricular_Activities
SET faculty_advisor_id = 102
WHERE activity_id = 5;

DELETE FROM Extra_Curricular_Activities
WHERE activity_id = 4;

SELECT *
FROM Extra_Curricular_Activities
WHERE activity_name = 'Coding Club';


-- Student_Courses junction table (many-to-many between students and courses)
CREATE TABLE Student_Courses (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id)
        REFERENCES Students(student_id),
    FOREIGN KEY (course_id)
        REFERENCES Courses(course_id)
);

INSERT INTO Student_Courses
(student_id, course_id)
VALUES
(1, 201),
(1, 202),
(2, 201),
(3, 203),
(4, 204);


-- Student_Activities junction table (many-to-many between students and activities)
CREATE TABLE Student_Activities (
    student_id INT,
    activity_id INT,
    PRIMARY KEY (student_id, activity_id),
    FOREIGN KEY (student_id)
        REFERENCES Students(student_id),
    FOREIGN KEY (activity_id)
        REFERENCES Extra_Curricular_Activities(activity_id)
);

-- student 5 was deleted and activity 4 was deleted, so we avoid both here
INSERT INTO Student_Activities
(student_id, activity_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 5),
(3, 1);

-- Join 1: full sentence -> student, their course, the teacher and the room
SELECT CONCAT(s.name, ' is enrolled in ', c.course_name,
              ', taught by ', f.name, ', in ', cl.building) AS sentence
FROM Students s
JOIN Student_Courses sc ON s.student_id = sc.student_id
JOIN Courses c ON sc.course_id = c.course_id
JOIN Faculty f ON c.faculty_id = f.faculty_id
JOIN Classroom cl ON c.classroom_id = cl.classroom_id;

-- Join 2: student and the club they joined, plus the faculty advising it
SELECT CONCAT(s.name, ' participates in ', a.activity_name,
              ', advised by ', f.name) AS sentence
FROM Students s
JOIN Student_Activities sa ON s.student_id = sa.student_id
JOIN Extra_Curricular_Activities a ON sa.activity_id = a.activity_id
JOIN Faculty f ON a.faculty_advisor_id = f.faculty_id;

-- Join 3 (our own choice): which room each student is assigned to
SELECT CONCAT(s.name, ' is assigned to room ', cl.room_number,
              ' in ', cl.building) AS sentence
FROM Students s
JOIN Classroom cl ON s.classroom_id = cl.classroom_id;

-- Aggregate: how many students are enrolled in each course
SELECT c.course_name, COUNT(sc.student_id) AS number_of_students
FROM Courses c
JOIN Student_Courses sc ON c.course_id = sc.course_id
GROUP BY c.course_name;


/*
Normalization check (Group 26):

We think the database is in 3NF. Every table only keeps data about its own
thing - Classroom keeps room info, Faculty keeps staff info, Students keeps
student info and so on, so we are not repeating the same data in two places.
Where a table needs something from another one we just store the id (like
classroom_id, faculty_id, faculty_advisor_id) instead of copying the whole
name or building over, so if a value changes we only change it once.

The two many-to-many links (a student can take many courses, a course can have
many students, same idea for activities) are handled by the Student_Courses and
Student_Activities tables. Each of those uses both ids together as the primary
key, which stops the same pair being added twice and keeps the main tables clean.
*/
