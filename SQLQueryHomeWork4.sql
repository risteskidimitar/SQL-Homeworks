--Declare scalar variable for storing FirstName values
--Assign value ‘Antonio’ to the FirstName variable
--Find all Students having FirstName same as the variable

declare @FirstName nvarchar(100)
set @FirstName = 'Antonio'

select * from dbo.Student
where FirstName = @FirstName

go

--Declare table variable that will contain StudentId, StudentName and DateOfBirth
--Fill the table variable with all Female students

declare @MyTableVariable table 
(StudentId int, StudentName nvarchar(100), DateOfBirth date)
insert into @MyTableVariable
select Id, FirstName + N' - '+ LastName, DateOfBirth
from dbo.Student
where Gender = 'F'

select * from @MyTableVariable

go

--Declare temp table that will contain LastName and EnrolledDate columns
--Fill the temp table with all Male students having First Name starting with ‘A’
--Retrieve the students from the table which last name is with 7 characters

Create table #MyTempTable
(LastName nvarchar(100), EnrolledDate date)

insert into #MyTempTable
select LastName, EnrolledDate
from dbo.Student
where Gender = 'M' and FirstName like 'A%' 


select* from #MyTempTable
where len(LastName) = 7

--Find all teachers whose FirstName length is less than 5 and
--the first 3 characters of their FirstName and LastName are the same

select *
from dbo.Teacher
where len(FirstName) > 5 and substring (FirstName, 1, 3) = left (LastName,3)

go

--Declare scalar function (fn_FormatStudentName) for retrieving the Student description for specific StudentId in the following format:
--StudentCardNumber without “sc-”
--“ – “
--First character of student FirstName
--“.”
--Student LastName

create function dbo.fn_FormatStudentName (@StudentId int)
returns nvarchar(150)
as 
begin
declare @Result Nvarchar(150)
select @Result = SUBSTRING(StudentCardNumber, 4, 5) + ' - ' + left(FirstName,1) + '.' + LastName
from dbo.Student
where id = @StudentId
return @Result
end

go

select *, dbo.fn_FormatStudentName(ID) as NewStudentCode
from dbo.Student

select dbo.fn_FormatStudentName(0) as NewStudentCode
