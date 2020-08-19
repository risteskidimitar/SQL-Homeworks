--use SEDCHome

--Create new procedure called CreateGrade
--Procedure should create only Grade header info (not Grade Details) 
--Procedure should return the total number of grades in the system for the Student on input (from the CreateGrade)
--Procedure should return second resultset with the MAX Grade of all grades for the Student and Teacher on input (regardless the Course)


create procedure dbo.CreateGrade (@StudentId int, @CourseID smallint, @TeacherId smallint, @Grade tinyint, @Comment nvarchar (100), @CreatedDate datetime)
as
begin
insert into dbo.Grade ([StudentID],[CourseID],[TeacherID],[Grade],[Comment],[CreatedDate])
values (@StudentId, @CourseID, @TeacherId, @Grade, @Comment, @CreatedDate )
select count(Grade) as TotalNumberOfGrades
from dbo.Grade
where StudentID = @StudentId
select max (Grade) as MAXGrade
from dbo.Grade
where StudentID = @StudentId and TeacherID = @TeacherId
end

go


execute dbo.CreateGrade '1', '1', '1', '10', 'NoComment', '2020-08-19'

--select * from dbo.Grade where StudentID = 1 and TeacherID = 1


--Create new procedure called CreateGradeDetail
--Procedure should add details for specific Grade (new record for new AchievementTypeID, Points, MaxPoints, Date for specific Grade)
--Output from this procedure should be resultset with SUM of GradePoints calculated with formula AchievementPoints/AchievementMaxPoints*ParticipationRate for specific Grade
