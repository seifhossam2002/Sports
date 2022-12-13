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
--	INSERT INTO @availablestadium
--	SELECT name ,location,capacity from (SELECT name,location,capacity,match.id from stadium
--										LEFT OUTER JOIN match ON match.stadiumId=stadium.id
--										WHERE stadium.status=1 and match<>@elyoom) --hya leeh 3'lt?
--	return
	INSERT INTO @availablestadium
	SELECT name ,location,capacity from stadium
	WHERE NOT EXISTS(
		SELECT name ,location,capacity from stadium s1
		except (
			SELECT s2.name ,s2.location,s2.capacity from stadium s2
			INNER JOIN match ON match.stadiumId=s2.id
			WHERE (s2.status=0 or match.startTime <> @elyoom)
		)
	)
	return
END
SELECT * FROM stadium;
SELECT * FROM match;
SELECT * FROM viewAvailableStadiumsOn('2018-11-11 15:00:00.000')
DROP FUNCTION viewAvailableStadiumsOn
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

------------------
GO;
CREATE FUNCTION allPendingRequests
(@username varchar(20))
returns @pendingRequestsTable TABLE(
	clubRepresentitve varchar(20),
	gustClub varchar(20),
	startTime datetime
)
AS
BEGIN
	INSERT INTO @pendingRequestsTable
	SELECT clubRepresentative.clubId,match.club2Id,match.startTime from stadiumManager
	INNER JOIN hostRequest ON hostRequest.stadiumManagerID=stadiumManager.id
	INNER JOIN clubRepresentative ON clubRepresentative.id=hostRequest.clubRepresentativeId
	INNER JOIN match ON hostRequest.matchID=match.id
	WHERE stadiumManager.username=@username
	return
END