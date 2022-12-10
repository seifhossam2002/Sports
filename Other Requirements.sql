GO;
CREATE PROCEDURE addAssociationManager
@name varchar(20),
@username varchar(20),
@password varchar(20)
AS
INSERT INTO dbo.systemUser VALUES(@username,@password)
INSERT INTO dbo.allAssocManagers VALUES(@name,@username);

-------------------
GO;
CREATE PROCEDURE addNewMatch
@clubname1 varchar(20),
@clubname2 varchar(20),
@hostname varchar(20),
@starttime datetime
AS
DECLARE @clubid1 int,@clubid2 int,@hostid int,@endtime datetime;
SELECT @clubid1=club.id from dbo.club where @clubname1=club.name;
SELECT @clubid2=club.id from dbo.club where @clubname2=club.name;
SELECT @hostid=stadium.id from dbo.stadium where @hostname=stadium.name;
SET @endtime= DATEADD(MINUTE,+90,@starttime);
INSERT INTO dbo.match (club1Id,club2Id,stadiumId,startTime,endTime) 
					  VALUES(@clubid1,@clubid2,@hostid,@starttime,@endtime);

----------------
GO;
create view clubsWithNoMatches with schemabinding as
select c.name from dbo.club c
except (select c1.name from dbo.club c1 inner join dbo.match M on c1.id = M.club1Id or c1.id=M.club2Id)

---------
go;
create procedure deleteMatch
@club1 varchar (20),
@club2 varchar (20),
@host varchar (20)
as 
delete from allMatches where firstTeam = @club1 and secondTeam = @club2 and host = @club1

----------
GO;
create procedure deleteMatchesOnStadium 
@stadiumname varchar(20)
as
DECLARE @stadiumid int;
SELECT @stadiumid=stadium.id from stadium where @stadiumname=stadium.name;
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
delete from allClubs where allClubs.name =@club
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
-----------------
GO;
CREATE PROCEDURE blockFan
@national_id int
AS
UPDATE Fan SET status=0 WHERE @national_id=nationalId;
------------------
GO;
CREATE PROCEDURE unblockFan
@national_id int
AS
UPDATE Fan SET status=1 WHERE @national_id=nationalId;
-----------------
GO;
CREATE PROCEDURE addRepresentative
AS
