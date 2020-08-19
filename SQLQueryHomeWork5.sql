--use SEDCHome

--Create multi-statement table value function that for specific Teacher and Course will return list of students (FirstName, LastName)
--who passed the exam, together with Grade and CreatedDate

create function dbo.fn_Homework5 (@TecherId int, @CourseId int)
returns @result table (Id int, FirstName nvarchar(100), LastName nvarchar(100), Grade tinyint, [Date] datetime )
as
begin
insert into @result
select s.Id, s.FirstName, S.LastName, g.Grade, g.CreatedDate
from
dbo.Grade g 
inner join dbo.Student s on g.StudentID = s.ID
where g.TeacherID = @TecherId and g.CourseID = @CourseId 
group by s.Id, s.FirstName, S.LastName, g.Grade, g.CreatedDate
return
end

go

select * from dbo.fn_Homework5 (1, 1)