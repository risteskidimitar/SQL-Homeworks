--use SEDCHome
--TASK 01
select * from dbo.Grade
--Calculate the count of all grades in the system
select count (Grade) as AllGrades 
from dbo.Grade

--Calculate the count of all grades per Teacher in the system


select TeacherID, count (Grade) as NumberOfGrades
from dbo.Grade 	
group by TeacherID

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)

select TeacherID, count (Grade) as NumberOfGrades
from dbo.Grade
where StudentID < 100
group by TeacherID

--Find the Maximal Grade, and the Average Grade per Student on all grades in the system
select StudentID, s.FirstName + N' '+ s.LastName as FullName,max (Grade) as MaxGrade, avg (Grade) as AverageGrade
from dbo.Grade g 
inner join dbo.Student s on s.ID = g.StudentID
group by StudentID, s.FirstName + N' '+ s.LastName

-- TASK 02 
--Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200

select TeacherID, t.FirstName + N' '+ t.LastName as FullName, count (Grade) as NumberOfGrades
from dbo.Grade g 
inner join dbo.Teacher t on t.ID = g.TeacherID
group by TeacherID, t.FirstName + N' '+ t.LastName
having count (Grade)> 200

--Calculate the count of all grades per Teacher in the system for first 100 Students 
--(ID < 100) and filter teachers with more than 50 Grade count

select TeacherID, t.FirstName + N' '+ t.LastName as FullName, count (Grade) as NumberOfGrades
from dbo.Grade g 
inner join dbo.Teacher t on t.ID = g.TeacherID
where g.StudentID < 100
group by TeacherID, t.FirstName + N' '+ t.LastName
having count (Grade)> 50

--Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. 
--Filter only records where Maximal Grade is equal to Average Grade

select StudentID, s.FirstName + N' '+ s.LastName as FullName, count (Grade) [Count], max (Grade) as MaxGrade, avg (Grade) as AverageGrade
from dbo.Grade g
inner join dbo.Student s on s.ID = g.StudentID
group by StudentID, s.FirstName + N' '+ s.LastName
having max (Grade) = avg (Grade)

--List Student First Name and Last Name next to the other details from previous query
select StudentID, s.FirstName  as FisrtName, s.LastName as LastName, count (Grade) [Count], max (Grade) as MaxGrade, avg (Grade) as AverageGrade
from dbo.Grade g
inner join dbo.Student s on s.ID = g.StudentID
group by StudentID, s.FirstName, s.LastName
having max (Grade) = avg (Grade)

--TASK 03
--Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student

CREATE VIEW vv_StudentGrades
AS
select StudentID, Count(Grade) as GradePerStudent
from dbo.Grade 
group by StudentID

select * from vv_StudentGrades

--Change the view to show Student First and Last Names instead of StudentID

ALTER VIEW vv_StudentGrades
AS
select s.FirstName as FirstName, s.LastName as LastName, count(g.Grade) as GradePerStudent
from dbo.Grade g
inner join dbo.Student s on s.ID = g.StudentID
group by StudentID, s.FirstName, s.LastName

--List all rows from view ordered by biggest Grade Count

select * from vv_StudentGrades order by GradePerStudent desc

--Create new view (vv_StudentGradeDetails) 
--that will List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit)

--drop view if exists vv_StudentGradeDetails;
CREATE VIEW vv_StudentGradeDetails
AS
select s.FirstName as FirstName, s.LastName as LastName, count (c.[Name]) as PassedCourses 
from dbo.Student s
inner join dbo.Grade g on g.StudentID = s.ID
inner join dbo.Course c on c.ID = g.CourseID
inner join dbo.GradeDetails gd on gd.GradeID = g.ID
inner join dbo.AchievementType a on gd.AchievementTypeID = a.ID
where a.[Name] = 'Ispit'
group by s.FirstName, s.LastName 


select * from vv_StudentGradeDetails
