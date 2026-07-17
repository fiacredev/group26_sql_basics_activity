
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
(5, 'Ishimwe Charles', 'i.charles@alu.edu', 6, '2026-01-14');

UPDATE Students
SET email = 'student4_updated@alu.edu'
WHERE student_id = 4;

DELETE FROM Students
WHERE student_id = 5;

SELECT *
FROM Students
WHERE classroom_id = 1;

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


-- My work as member E


CREATE TABLE Extra_Curricular_Activities (
    activity_id INT PRIMARY KEY,
    activity_name VARCHAR(100) NOT NULL,
    supervisor VARCHAR(100)
);

INSERT INTO Extra_Curricular_Activities
(activity_id, activity_name, supervisor)
VALUES
(1, 'Football Club', 'Coach John'),
(2, 'Basketball Club', 'Coach Mary'),
(3, 'Drama Club', 'Mr. James'),
(4, 'Music Club', 'Ms. Grace'),
(5, 'Coding Club', 'Dr. Alice');

UPDATE Extra_Curricular_Activities
SET supervisor = 'Dr. Brian Smith'
WHERE activity_id = 5;

DELETE FROM Extra_Curricular_Activities
WHERE activity_id = 4;

SELECT *
FROM Extra_Curricular_Activities
WHERE activity_name = 'Coding Club';


-- Student_Courses Junction Table

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
(1,201),
(1,202),
(2,201),
(3,203),
(4,204);


-- Student_Activities Junction Table

CREATE TABLE Student_Activities (
    student_id INT,
    activity_id INT,
    PRIMARY KEY (student_id, activity_id),
    FOREIGN KEY (student_id)
        REFERENCES Students(student_id),
    FOREIGN KEY (activity_id)
        REFERENCES Extra_Curricular_Activities(activity_id)
);

INSERT INTO Student_Activities
(student_id, activity_id)
VALUES
(1,1),
(2,2),
(3,3),
(4,5),
(5,1);

