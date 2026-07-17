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
