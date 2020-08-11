--TASK 01

--Find all Students with FirstName = Antonio
Select * from dbo.Student where FirstName = 'Antonio'

--Find all Students with DateOfBirth greater than ‘01.01.1999’
Select * from dbo.Student where DateOfBirth	> '1999-01-01'

--Find all Male students
Select * from dbo.Student where Gender = 'M'

--Find all Students with LastName starting With ‘T’
Select * from dbo.Student where LastName like 'T%'

--Find all Students Enrolled in January/1998
--Select * from dbo.Student where EnrolledDate > '1997-12-31' and EnrolledDate < '1998-02-01'
Select * from dbo.Student where EnrolledDate between '1998-01-01' and '1998-01-31'

--Find all Students with LastName starting With ‘J’ enrolled in January/1998
Select * from dbo.Student where LastName like 'J%' and EnrolledDate > '1997-12-31' and EnrolledDate < '1998-02-01'

--TASK 02

--Find all Students with FirstName = Antonio ordered by Last Name
Select * from dbo.Student where FirstName = 'Antonio' order by LastName asc

--List all Students ordered by FirstName
Select * from dbo.Student order by FirstName asc

--Find all Male students ordered by EnrolledDate, starting from the last enrolled
Select * from dbo.Student where Gender = 'M' order by EnrolledDate desc

--TASK 03

--List all Teacher First Names and Student First Names in single result set with duplicates
Select FirstName from dbo.Teacher union all select FirstName from dbo.Student

--List all Teacher Last Names and Student Last Names in single result set. Remove duplicates
Select LastName from dbo.Teacher union select LastName from dbo.Student

--List all common First Names for Teachers and Students
Select FirstName from dbo.Teacher intersect select FirstName from dbo.Student

--TASK 04

--Change GradeDetails table always to insert value 100 in AchievementMaxPoints column if no value is provided on insert

--select * from dbo.GradeDetails order by AchievementMaxPoints asc
alter table dbo.GradeDetails add constraint [DFK_GradeDetails_AchievementMaxPoints] default 100 for AchievementMaxPoints

--Change GradeDetails table to prevent inserting AchievementPoints that will more than AchievementMaxPoints

alter table dbo.GradeDetails add constraint [CHK_GradeDetails_AchievementPoints] check (AchievementPoints<=AchievementMaxPoints)

--Change AchievementType table to guarantee unique names across the Achievement types
--Select* from dbo.AchievementType
alter table dbo.AchievementType add constraint [UNQ_GradeDetails_AchievementType] unique (Name)

--TASK 05
--DIAGRAM

--TASK 06
--List all possible combinations of Courses names and AchievementType names that can be passed by student
 
Select cn.Name as CourseName, an.Name as AchievementTypeName from dbo.Course cn 
cross join dbo.AchievementType an

--List all Teachers that has any exam Grade
Select distinct t.FirstName as Teacher from Grade g 
inner join dbo.Teacher t on g.TeacherID = t.ID

--List all Teachers without exam Grade
Select distinct t.FirstName as Teacher from dbo.Teacher t
left join dbo.Grade g on t.ID = g.TeacherID
where g.StudentID is null

--List all Students without exam Grade (using Right Join)

Select distinct s.FirstName as Student from Grade g
right join dbo.Student s on s.ID = g.StudentID
where g.StudentID is null