USE AvengaAcademyDB

-- Calculate the count of all grades per Teacher in the system​
SELECT 
t.ID,
t.FirstName,
t.LastName,
COUNT(g.ID) as TotalGrades
FROM Teacher t
LEFT JOIN Grade g ON t.ID = g.TeacherID
GROUP BY t.ID, t.FirstName, t.LastName
ORDER BY TotalGrades DESC;

-- Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)​
SELECT
t.ID,
t.FirstName,
COUNT(g.ID) as GradesPerTeacher
FROM Teacher t
LEFT JOIN Grade g ON t.ID = g.TeacherID
LEFT JOIN Student s ON g.StudentID = s.ID
WHERE s.ID < 100
GROUP BY t.ID, t.FirstName;

-- Find the Maximal Grade, and the Average Grade per Student on all grades in the system​
SELECT
s.ID,
s.FirstName,
s.LastName,
MAX(g.Grade) AS MaxGrade,
AVG(g.Grade) AS AverageGrade
FROM Student s
JOIN Grade g
ON s.ID = g.StudentID
GROUP BY s.ID, s.FirstName, s.LastName;

-- Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200​
SELECT
t.ID,
t.FirstName,
t.LastName,
COUNT(g.ID) as GradesPerTeacher
FROM Teacher t
LEFT JOIN Grade g ON t.ID = g.TeacherID
GROUP BY t.ID, t.FirstName, t.LastName
HAVING COUNT(g.ID) >200;

-- Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade​
SELECT 
s.ID,
s.FirstName,
s.LastName,
COUNT(g.ID) AS GradeCount,
MAX(g.Grade) AS MaxGrade,
AVG(g.Grade) AS AvgGrade
FROM Student s
JOIN Grade g
ON s.ID = g.StudentID
GROUP BY s.ID, s.FirstName, s.LastName
HAVING MAX(g.Grade) = AVG(g.Grade);

-- List Student First Name and Last Name next to the other details from previous query​
SELECT
    s.FirstName,
    s.LastName,
    COUNT(g.ID) AS GradeCount,
    MAX(g.Grade) AS MaxGrade,
    AVG(g.Grade) AS AvgGrade
FROM Student s
JOIN Grade g 
    ON s.ID = g.StudentID
GROUP BY s.ID, s.FirstName, s.LastName
HAVING MAX(g.Grade) = AVG(g.Grade);

-- Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student​
CREATE VIEW vv_StudentGrades AS
SELECT
s.ID AS StudentID,
COUNT(g.ID) AS GradeCount
FROM Student s
LEFT JOIN Grade g
ON s.ID = g.StudentID
GROUP BY s.ID

SELECT * FROM vv_StudentGrades;

-- Change the view to show Student First and Last Names instead of StudentID​
AlTER VIEW vv_StudentGrades AS
SELECT
s.FirstName,
s.LastName,
COUNT(g.ID) AS GradeCount
FROM Student s
LEFT JOIN Grade g
ON s.ID = g.StudentID
GROUP BY s.FirstName, s.LastName;

-- List all rows from view ordered by biggest Grade Count​
SELECT *
FROM vv_StudentGrades
ORDER BY GradeCount DESC;