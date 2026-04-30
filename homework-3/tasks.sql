USE AvengaAcademyDB

--Declare scalar variable FirstName = 'Antonio'
--Find all Students with that FirstName

Declare @FirstName NVARCHAR(50) = 'Antonio';
SELECT * FROM Student
WHERE FirstName = @FirstName;

--Create table variable with StudentId, StudentName, DateOfBirth
--Fill with Female students
DECLARE @FemaleStudents TABLE
(
StudentID INT,
StudentName NVARCHAR(100),
DateOfBirth DATE
);
INSERT INTO @FemaleStudents(StudentID, StudentName, DateOfBirth)
VALUES(570, 'bob', '1999-01-01')
SELECT
    ID,
    FirstName + ' ' + LastName,
    DateOfBirth
FROM Student
WHERE Gender = 'F';
--ova dole e pisano za da vidam dali rab zoso ne gi pokazuva koga se vo variabila nemase errori bi trebalo i so variabila da e pominato
CREATE TABLE #FemaleStudents
(
StudentID INT,
StudentName NVARCHAR(100),
DateOfBirth DATE
)
INSERT INTO #FemaleStudents(StudentID, StudentName, DateOfBirth)
VALUES(566, 'bobski', '1990-01-01')

SELECT * FROM #FemaleStudents

--Create temp table with LastName and EnrolledDate
--Fill with Male students starting with 'A'
CREATE TABLE #MaleStudent
(
LastName NVARCHAR(50),
EnrolledDate DATE,
)
INSERT INTO #MaleStudent (LastName, EnrolledDate)
SELECT
LastName,
EnrolledDate,
FROM Student
WHERE Gender = 'M'
AND FirstName LIKE 'A%';

SELECT * FROM #MaleStudent

--Find students with LastName length = 7
SELECT * FROM Student
WHERE LEN(LastName) = 7;

--Find teachers with FirstName length < 5 and same first 3 letters in First/Last name
SELECT * FROM Teacher
WHERE LEN(FirstName) < 5
AND LEFT(FirstName, 3) = LEFT(FirstName, 3) 