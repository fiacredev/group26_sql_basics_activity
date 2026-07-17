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
