GO;
CREATE PROCEDURE addAssociationManager
@name varchar(20),
@username varchar(20),
@password varchar(20)
AS
INSERT INTO dbo.systemUser VALUES(@username,@password)
INSERT INTO SportsAsssociationManager VALUES(@name,@username);

DROP PROCEDURE addAssociationManager
SELECT * FROM systemUser
SELECT * FROM SportsAsssociationManager
DELETE FROM systemUser where username='seifhossam2002'
EXEC addAssociationManager 'Seif','seifhossam2002','Great_Scott2002'
--------------------
GO;
CREATE PROCEDURE addNewMatch
@clubname1 varchar(20),
@clubname2 varchar(20),
@hostname varchar(20),
@starttime datetime
AS
DECLARE @clubid1 int,@clubid2 int,@hostid int,@endtime datetime,@stadiumid int;
SELECT @clubid1=club.id from dbo.club where @clubname1=club.name;
SELECT @clubid2=club.id from dbo.club where @clubname2=club.name;
--SELECT @hostid=stadium.id from dbo.stadium where @hostname=stadium.name;		bos
--msh 3lshan elhostid howa elawel
SELECT @hostid=club.id from dbo.club where @hostname=club.name;
SET @endtime= DATEADD(MINUTE,+90,@starttime);
if @hostid=@clubid1
BEGIN
	INSERT INTO dbo.match (club1Id,club2Id,stadiumId,startTime,endTime) 
   				    VALUES(@clubid1,@clubid2,@stadiumid,@starttime,@endtime);
END
ELSE
BEGIN
	INSERT INTO dbo.match (club1Id,club2Id,stadiumId,startTime,endTime) 
   				    VALUES(@clubid2,@clubid1,@stadiumid,@starttime,@endtime);
END

SELECT * from match
SELECT * FROM club;
DELETE FROM match where id=6
DROP PROCEDURE addNewMatch
EXEC addNewMatch 'club3','club2','club2','2021/09/26 8:00:00'
---------
go;
create procedure deleteMatch
@club1 varchar (20),
@club2 varchar (20),
@host varchar (20)
as
--delete from allMatches where firstTeam = @club1 and secondTeam = @club2 and (host = @club1 or host=@club2)	--bos is not updatable because the modification affects multiple base tables.
DECLARE @clubid1 int,@clubid2 int,@hostid int,@matchid int;
SELECT @clubid1=club.id from club where @club1=club.name
SELECT @clubid2=club.id from club where @club2=club.name
SELECT @hostid=club.id from club where @host=club.name
SELECT @matchid=match.id FROM match where (@hostid=match.club1Id AND @clubid2=match.club2Id AND @hostid=@clubid1) OR 
										  (@hostid=match.club2Id AND @clubid2=match.club1Id AND @hostid=@clubid2)
DELETE FROM ticket where matchId=@matchid;
DELETE FROM match WHERE match.id=@matchid


select * from club
DROP PROCEDURE deleteMatch
SELECT * from match
EXEC deleteMatch 'club2','club3','club3';
--The DELETE statement conflicted with the REFERENCE constraint "fkM_ticket". The conflict occurred in database "milestone", table "dbo.ticket", column 'matchId'.
--The statement has been terminated.

----------
GO;
create procedure deleteMatchesOnStadium 
@stadiumname varchar(20)
as
DECLARE @stadiumid int;
SELECT @stadiumid=stadium.id from stadium where @stadiumname=stadium.name;
--bos feeh 7aga 3'lt hna!!
delete from match where CURRENT_TIMESTAMP<startTime AND @stadiumid=match.stadiumId;
-------------
GO;
CREATE PROCEDURE addClub
@nameclub varchar(20),
@location varchar(20)
AS 
INSERT INTO allClubs VALUES(@nameclub,@location)
----------------
GO;
CREATE PROCEDURE addTicket
@hostclubname varchar(20),
@clubname varchar(20),
@startTime datetime
AS 
DECLARE @matchId int,@hostclubid int,@clubid int;
SELECT @hostclubid=club.id from club where @hostclubname=club.name;
SELECT @clubid=club.id from club where @clubname=club.name;
SELECT @matchId=match.id from match WHERE (@hostclubid=match.club1Id AND @clubid=match.club2Id) OR
										  (@hostclubid=match.club2Id AND @clubid=match.club1Id)
INSERT INTO ticket (matchId) VALUES(@matchId)
---------------------
go
create procedure deleteClub
@club varchar (20)
as
DECLARE @clubid int;
select @clubid=club.id from club where club.name=@club
DELETE FROM ticket where matchId IN (SELECT match.id from match where match.club1Id=@clubid or match.club2Id=@clubid);
delete from dbo.match where match.club1Id=@clubid or match.club2Id=@clubid
delete from allClubs where allClubs.name =@club

SELECT * FROM club;
SELECT * FROM match;
DROP PROCEDURE deleteClub
EXEC deleteClub 'club1'
-----------------
go
create procedure addStadium 
@stadium_name varchar(20),
@stadium_location varchar (20),
@capacity int 
as 
insert into dbo.allStadiums (name,capacity,location) 
values (@stadium_name,@capacity,@stadium_location)
---------------------
go
create procedure deleteStadium
@stadium_name varchar (20)
as 
delete from allStadiums where allStadiums.name=@stadium_name

SELECT * FROM stadium;
EXEC deleteStadium 'stadium3'
-----------------
GO;
CREATE PROCEDURE blockFan
@national_id int
AS
UPDATE Fan SET status=1 WHERE @national_id=nationalId;
------------------
GO;
CREATE PROCEDURE unblockFan
@national_id int
AS
UPDATE Fan SET status=0 WHERE @national_id=nationalId;
-----------------
GO;
CREATE PROCEDURE addRepresentative
@name varchar(20),
@clubname varchar(20),
@username varchar(20),
@password varchar(20)
AS
DECLARE @clubid int
SELECT @clubid=club.id from club where @clubname=club.name
INSERT INTO systemUser VALUES(@username,@password)
INSERT INTO clubRepresentative (name,username,clubId) VALUES(@name,@username,@clubid)

SELECT * FROM clubRepresentative
EXEC addRepresentative 'seif','club1','seifhossam262002','Seif-2609'

-------------

GO;
CREATE PROCEDURE addHostRequest
@clubname varchar(20),
@stadiumname varchar(20),
@datetime datetime
AS
DECLARE @clubRepresentativeID int,@stadiumManagerID int,@matchID int
SELECT @clubRepresentativeID=clubRepresentative.id from clubRepresentative
INNER JOIN club ON club.id=clubRepresentative.id
WHERE @clubname=club.name

SELECT @stadiumManagerID=stadiumManager.id from stadiumManager
INNER JOIN stadium ON stadium.id=stadiumManager.id
WHERE @stadiumname=stadium.name

SELECT @matchID = match.id FROM match
INNER JOIN stadium ON stadium.id=match.stadiumId
where stadium.name=@stadiumname and match.startTime=@datetime

-------------


