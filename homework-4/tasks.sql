--### Homework 02.1
--Create procedure CreateGrade
--Insert grade header
--Return total grades per student
--Return MAX grade per student and teacher
USE AvengaAcademyDB;
GO

CREATE PROCEDURE CreateGrade
(
@StudentID INT,
@CourseID INT,
@TeacherID INT,
@Grade TINYINT,
@Comment NVARCHAR(MAX),
@CreatedDate DATETIME
)
AS
BEGIN
PRINT 'Before insert';
INSERT INTO Grade(StudentID, CourseID, TeacherID, Grade, Comment, CreatedDate)
VALUES(@StudentID, @CourseID, @TeacherID, @Grade, @Comment, @CreatedDate);

SELECT
StudentID,
COUNT(*) AS TotalGrades
FROM Grade
WHERE StudentID = @StudentID
GROUP BY StudentID;

SELECT
StudentID,
TeacherID,
MAX(Grade) AS MaxGrade
FROM Grade
WHERE StudentID = @StudentID
AND TeacherID = @TeacherID
GROUP BY StudentID, TeacherID;
PRINT 'After insert';
END
GO

DECLARE @Now DATETIME = GETDATE();
EXEC dbo.CreateGrade 111, 17, 21, 9, N'Good', @Now;

--vaka nejkese da raboti 
-- EXEC CreateGrade 111, 17, 21, 9, N'Good', GETDATE(); morease vo promenliva da se stai 




--### Homework 02.2
--Create procedure CreateGradeDetail
--Insert grade details
--Return SUM of grade points based on formula

CREATE PROCEDURE CreateGradeDetail
(
    @GradeID INT,
    @AchievementTypeID INT,
    @AchievementPoints INT,
    @AchievementMaxPoints INT,
    @AchievementDate DATETIME
)
AS
BEGIN

    
    INSERT INTO GradeDetails 
    (GradeID, AchievementTypeID, AchievementPoints, AchievementMaxPoints, AchievementDate)
    VALUES 
    (@GradeID, @AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, @AchievementDate);

    
    SELECT 
        gd.GradeID,
        SUM(
            (gd.AchievementPoints * 1.0 / gd.AchievementMaxPoints) 
            * at.ParticipationRate
        ) AS TotalPoints
    FROM GradeDetails gd
    JOIN AchievementType at 
        ON gd.AchievementTypeID = at.ID
    WHERE gd.GradeID = @GradeID
    GROUP BY gd.GradeID;

END
GO
DECLARE @Now DATETIME = GETDATE();
EXEC dbo.CreateGradeDetail 3, 2, 75, 100, @Now;