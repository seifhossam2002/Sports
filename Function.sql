GO;
CREATE FUNCTION viewAvailableStadiumsOn
(@elyoom datetime)
returns @availablestadium TABLE(
	name varchar(20),
	location varchar(20),
	capacity int
)
AS
BEGIN
	INSERT INTO @availablestadium
	SELECT name ,location,capacity from (SELECT name,location,capacity,match.id from stadium
										LEFT OUTER JOIN match ON match.stadiumId=stadium.id
										WHERE stadium.status=1 and match<>@elyoom) --hya leeh 3'lt?
	return @availablestadium
END

-------------
GO;
CREATE FUNCTION allUnassignedMatches
(@nameClub varchar(20))
returns @unassignedMatchesTable TABLE(
	guestName varchar(20),
	startTime varchar(20)
)
AS
BEGIN
	DECLARE @hostId int,@matchid int;
	SELECT @hostId=host.id from club host where host.name=@nameClub;
	INSERT INTO @unassignedMatchesTable
	SELECT match.club2Id,match.startTime from match where match.stadiumId IS NULL;
	return
END
