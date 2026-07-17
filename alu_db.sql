--Extra_Curricular_Activities

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
