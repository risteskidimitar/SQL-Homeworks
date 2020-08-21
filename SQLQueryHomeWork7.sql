
--Create new procedure called CreateGradeDetail
--Procedure should add details for specific Grade (new record for new AchievementTypeID, Points, MaxPoints, Date for specific Grade)
--Output from this procedure should be resultset with SUM of GradePoints calculated with formula 
--AchievementPoints/AchievementMaxPoints*ParticipationRate for specific Grade

--Add error handling on CreateGradeDetail procedure
--Test the error handling by inserting not-existing values for AchievementTypeID


alter procedure dbo.CreateGradeDetail 
	(@GradeId int, @AchievementTypeID tinyint, @Points tinyint, @MaxPoints tinyint, @Date datetime)
as
begin

begin try
	insert into dbo.GradeDetails ([GradeID],[AchievementTypeID],[AchievementPoints],[AchievementMaxPoints],[AchievementDate])
	values (@GradeId, @AchievementTypeID, @Points, @MaxPoints, @Date)
	select a.[Name] as AchievementTypeName, sum(gd.AchievementPoints/gd.AchievementMaxPoints*a.ParticipationRate) as SUMofGradePoints
		from dbo.GradeDetails gd
		inner join dbo.AchievementType a on gd.AchievementTypeID = a.ID
	group by a.[Name]

end try

begin catch
	select
		 ERROR_NUMBER() AS ErrorNumber  
		,ERROR_SEVERITY() AS ErrorSeverity  
		,ERROR_STATE() AS ErrorState  
		,ERROR_PROCEDURE() AS ErrorProcedure  
		,ERROR_LINE() AS ErrorLine  
		,ERROR_MESSAGE() AS ErrorMessage;  
end catch;  

end


go


select * from dbo.AchievementType
exec dbo.CreateGradeDetail @GradeId = '1', @AchievementTypeID = '7', @Points = '99', @MaxPoints = '100', @Date = '2020-08-19'