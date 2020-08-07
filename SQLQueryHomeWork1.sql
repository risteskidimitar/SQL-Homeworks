use SEDC
drop table if EXISTS [dbo].Student
drop table if EXISTS [dbo].Teacher
drop table if EXISTS [dbo].Grade
drop table if EXISTS [dbo].Course
drop table if EXISTS [dbo].GradeDetails
drop table if EXISTS [dbo].AchievementType

create table [dbo].Student
(
Id int identity (1,1) not null,
FirstName nvarchar(50) not null,
LastName nvarchar(50) not null,
DateOFBirth date not null,
EnrolledDate date null,
Gender nvarchar(10) null,
NationalIDNumber int  not null,
StudentCardNumber int not null,
Constraint [PK_StudentID] primary key clustered ([Id] ASC)
)

--select * from Student

create table [dbo].Teacher
(
Id int identity (1,1) not null,
FirstName nvarchar(50) not null,
LastName nvarchar(50) not null,
DateOFBirth date not null,
AcademicRank nvarchar(50) not null,
HireDate date,
)

alter table Teacher
add constraint PK_TeacherId primary key clustered ([Id] ASC)

--select * from Teacher

create table [dbo].Grade
(
Id int identity (1,1) not null,
StudentId int not null,
CourseId int not null,
TeacherId int not null,
Grade tinyint not null,
Comment nvarchar(100) null,
CreatedDate datetime not null
Constraint [PK_GradeId] primary key clustered ([Id] ASC)
)

--select * from Grade

create table [dbo].Course
(
Id int identity (1,1) not null,
[Name] nvarchar(50) not null,
Credit int not null,
AcademicYear date not null,
Semestar tinyint not null,
Constraint [PK_CourseId] primary key clustered ([Id] ASC)
)

select*from Course	

create table [dbo].GradeDetails
(
Id int identity (1,1) not null,
GradeId int not null,
AchievementTypeID int not null,
AchievementPoints int not null,
AchievementMaxPoints int not null,
AchievementDate date,
Constraint [PK_GradeDetailsId] primary key clustered ([Id] ASC)
)
select*from GradeDetails	

create table [dbo].AchievementType
(
Id int identity (1,1) not null,
[Name] nvarchar(50) not null,
[Description] nvarchar(200) not null,
ParticipationRate int not null
Constraint [PK_AchievementTypeId] primary key clustered ([Id] ASC)
)

select*from AchievementType