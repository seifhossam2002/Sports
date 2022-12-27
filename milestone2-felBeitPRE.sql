--TABLES--
drop database milestone2flbeit
create database milestone2flbeit;
GO;

CREATE PROCEDURE createAllTables
AS
CREATE TABLE systemUser(
username VARCHAR(20) NOT NULL,
password VARCHAR(20)
constraint Pk_systemUser PRIMARY KEY (username));

create table club(
name varchar(20),
id int identity,
location varchar(20),
constraint Pk_club PRIMARY KEY (id),
); 

CREATE TABLE clubRepresentative(
id int IDENTITY,
name varchar(20),
username varchar(20) NOT NULL,
clubId int,		--bos
constraint Pk_clubRepresentitive PRIMARY KEY (id),
constraint Fk_clubRepresentitive foreign key (username) references systemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
constraint FkClub_clubRepresentitive foreign key (clubId) references club(id) ON DELETE CASCADE ON UPDATE CASCADE 

);

CREATE TABLE Fan(
birthDate DATE,
nationalId varchar(20),
phoneNumber int,
name varchar(20),
address varchar(20),
status bit,
username varchar(20) NOT NULL,
constraint Pk_Fan PRIMARY KEY (nationalId),
constraint Fk_Fan foreign key (username) references systemUser(username) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SportsAsssociationManager(
id int identity,
name varchar (20),
username varchar(20) NOT NULL,
constraint Pk_SportsAsssociationManager PRIMARY KEY (id),
constraint Fk_SportsAsssociationManager foreign key (username) references systemUser(username) ON DELETE CASCADE ON UPDATE CASCADE
);

Create table SystemAdmin(
id int identity,
name varchar(20),
username varchar(20) NOT NULL,
constraint Pk_SystemAdmin PRIMARY KEY (id),
constraint Fk_SystemAdmin foreign key (username) references systemUser(username) ON DELETE CASCADE ON UPDATE CASCADE
);

create table stadium (
id int identity,
status bit ,
location varchar (20),
capacity int,
name varchar(20),
constraint Pk_stadium PRIMARY KEY (id),
);

CREATE TABLE stadiumManager(
id int IDENTITY ,
name VARCHAR(20) NOT NULL,
username varchar (20),
stadiumID int,
constraint Pk_stadiumManager PRIMARY KEY (id),
constraint Fk_stadiumManager foreign key (username) references systemUser(username) ,
constraint FKSID_stadiumManager foreign key (stadiumId) references stadium(id) ON DELETE CASCADE ON UPDATE CASCADE

);

create table match (
id int identity,
startTime datetime,
endTime datetime,
stadiumId int,
club1Id int,
club2Id int,
constraint Pk_match PRIMARY KEY (id),
constraint fkST_match foreign key (stadiumId) references stadium(id) ,
constraint fkCL1_match foreign key (club1Id) references club(id),
constraint fkCL2_match foreign key (club2Id) references club(id)
);

create table hostRequest(
id int identity,
status varchar(20),
matchID int,
stadiumManagerID int,
clubRepresentativeId int,
constraint Pk_hostRequest PRIMARY KEY (id),
constraint fkSM_hostRequest foreign key (stadiumManagerId) references stadiumManager(id) ON DELETE CASCADE ON UPDATE CASCADE,
constraint fkCR_hostRequest foreign key (clubRepresentativeId) references clubRepresentative(id) ON DELETE CASCADE ON UPDATE CASCADE,
	

);
create table ticket(
id int identity,
status bit,
matchId int,
constraint Pk_ticket PRIMARY KEY (id),
constraint fkM_ticket foreign key (matchId) references match(id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE ticketBuyingTransaction(
fanNationalId varchar(20),
ticketId int
constraint fkFID_ticketBuyingTransaction foreign key (fanNationalId) references fan(nationalId) ,
constraint fkTID_ticketBuyingTransaction foreign key (ticketId) references ticket(Id),
);
GO;

EXEC dbo.createAllTables

GO;


create procedure dropAllTables 
as 
drop table ticket
drop table hostRequest
drop table match
drop table stadiumManager
drop table stadium
drop table clubRepresentative
drop table club
drop table Fan
drop table SportsAsssociationManager
drop table SystemAdmin
drop table systemUser
drop table ticketBuyingTransaction

EXEC dropAllTables

--------------------
GO;
CREATE PROCEDURE dropAllProceduresFunctionsViews
AS
DROP VIEW allAssocManagers;
DROP VIEW allClubRepresentatives;
DROP VIEW allStadiumManagers;
DROP VIEW allFans;
DROP VIEW clubsNeverMatched
DROP VIEW allMatches;
DROP VIEW allTickets;
DROP VIEW allClubs;
DROP VIEW allStadiums;
DROP VIEW allRequests;
DROP VIEW clubsWithNoMatches;
DROP VIEW matchesPerTeam;

DROP PROCEDURE addAssociationManager;
DROP PROCEDURE addNewMatch;
DROP PROCEDURE deleteMatch;
DROP PROCEDURE deleteMatchesOnStadium;
DROP PROCEDURE addClub;
DROP PROCEDURE addTicket;
DROP PROCEDURE deleteClub;
DROP PROCEDURE addStadium;
DROP PROCEDURE deleteStadium;
DROP PROCEDURE blockFan;
DROP PROCEDURE unblockFan;
DROP PROCEDURE addRepresentative;
DROP PROCEDURE addHostRequest;
DROP PROCEDURE addStadiumManager;
DROP PROCEDURE acceptRequest;
DROP PROCEDURE rejectRequest
DROP PROCEDURE addFan;
DROP PROCEDURE purchaseTicket;
DROP PROCEDURE updateMatchHost


DROP FUNCTION viewAvailableStadiumsOn;
DROP FUNCTION allUnassignedMatches;
DROP FUNCTION allpendingRequests;
DROP FUNCTION upcomingMatchesOfClub;
DROP FUNCTION availableMatchesToAttend;
DROP FUNCTION clubsNeverPlayed
DROP FUNCTION matchWithHighestAttendance;
DROP FUNCTION matchesRankedByAttendance;
DROP FUNCTION requestsFromClub;

-------------

GO;
CREATE PROCEDURE clearAllTables
AS
DELETE FROM ticket
DELETE FROM hostRequest
DELETE FROM match
DELETE FROM stadiumManager
DELETE FROM stadium
DELETE FROM clubRepresentative
DELETE FROM club
DELETE FROM Fan
DELETE FROM SportsAsssociationManager
DELETE FROM SystemAdmin
DELETE FROM systemUser

------------------------------------------------------------------------------------
--VIEWS--
GO;
CREATE VIEW allAssocManagers WITH SCHEMABINDING AS
SELECT s.username,systemUser.password,s.name
FROM dbo.SportsAsssociationManager s
INNER JOIN dbo.systemUser ON s.username=systemUser.username
GO;
SELECT * from allAssocManagers

GO;
CREATE VIEW allClubRepresentatives WITH SCHEMABINDING AS
SELECT s.username 'username',s.password 'password', cr.name 'club representative name', c.name 'club name'
FROM dbo.systemUser s INNER JOIN dbo.clubRepresentative cr ON s.username=cr.username INNER JOIN dbo.club c ON cr.clubId=c.id 

GO;
CREATE VIEW allStadiumManagers WITH SCHEMABINDING AS
SELECT su.username, su.password, sm.name 'Stadium Manager name', s.name 'Stadium name' 
from dbo.stadiumManager sm
INNER JOIN dbo.stadium s ON s.id=sm.stadiumID
INNER JOIN dbo.systemUser su ON sm.username=su.username


GO;
CREATE VIEW allFans WITH SCHEMABINDING AS
SELECT su.username, su.password, f.name, f.nationalId, f.birthDate, f.status 
from dbo.Fan f
INNER JOIN dbo.systemUser su ON f.username=su.username

GO;
CREATE VIEW allMatches WITH SCHEMABINDING AS --not sure bsara7a
SELECT c1.name 'hostClub' ,c2.name 'guestClub', m.startTime 'startTime'
FROM dbo.club c1 INNER JOIN dbo.match m ON c1.id=m.club1Id INNER JOIN dbo.club c2 ON c2.id=m.club2Id

GO;
create view allTickets  with schemabinding as 
select  c1.name 'hots club',c2.name 'guest club',ST.name 'Stadium name',M.startTime
from dbo.club c1 
inner join dbo.match M on c1.id =M.club1Id 
inner join dbo.club c2 on M.club2Id=c2.id 
inner join dbo.stadium ST on M.stadiumId = ST.id 

GO;
CREATE VIEW allClubs WITH SCHEMABINDING AS
SELECT name,location FROM dbo.club;

GO;
CREATE VIEW allStadiums WITH SCHEMABINDING AS
SELECT name,capacity,location,status FROM dbo.stadium

GO;
CREATE VIEW allRequestsASP AS
SELECT SM.username,CR.name'CRname',c1.name'hostName',c2.name'guestName',m.startTime,m.endTime,h.status,h.id from clubRepresentative CR
INNER JOIN club c1 ON CR.clubId = c1.id
INNER JOIN match m ON m.club1Id = c1.id
INNER JOIN club c2 ON m.club2Id = c2.id
INNER JOIN hostRequest h ON h.matchID = m.id and h.clubRepresentativeId=CR.id
INNER JOIN stadiumManager SM ON SM.id=H.stadiumManagerID
GO;
SELECT * FROM allRequestsASP

GO;
CREATE VIEW allRequests WITH SCHEMABINDING AS
SELECT stadiumManager.username 'Stadium Manager username', clubRepresentative.username 'Club Representative name',hostRequest.status 
FROM dbo.clubRepresentative
INNER JOIN dbo.hostRequest ON hostRequest.clubRepresentativeId=clubRepresentative.id
INNER JOIN dbo.stadiumManager ON hostRequest.stadiumManagerID=stadiumManager.id;

GO;
create view clubsWithNoMatches with schemabinding as
select c.name from dbo.club c
except (select c1.name from dbo.club c1 inner join dbo.match M on c1.id = M.club1Id or c1.id=M.club2Id)
---------------------------------------------------------------
--PROCEDURES--
GO;
CREATE PROCEDURE addAssociationManager
@name varchar(20),
@username varchar(20),
@password varchar(20),
@success bit OUTPUT
AS
begin
if (@username = any (select SU.username from systemUser SU))
begin
SET @success = 0
end
else 
begin
SET @success = 1
INSERT INTO dbo.systemUser VALUES(@username,@password)
INSERT INTO SportsAsssociationManager VALUES(@name,@username);
end
end
GO;


CREATE PROCEDURE addNewMatch
@hostClubName varchar(20),
@guestClubName varchar(20),
@starttime datetime,
@endtime datetime,
@noExistingClubs bit output
AS
DECLARE @clubid1 int,@clubid2 int,@matchId int, @stadiumManagerId int, @stadiumid int
SELECT @clubid1=club.id from dbo.club where @hostClubName=club.name;
SELECT @clubid2=club.id from dbo.club where @guestClubName=club.name;
if @clubid1 is not null and @clubid2 is not null
begin
SET @noExistingClubs=0
INSERT INTO dbo.match (club1Id,club2Id,startTime,endTime) VALUES(@clubid1,@clubid2,@starttime,@endtime)
end
else
begin
SET @noExistingClubs=1
end



---------
go;
create procedure deleteMatch
@hostClubName varchar (20),
@guestClubName varchar (20),
@startTime datetime,
@endTime dateTime,
@noExistingMatch bit output
as
DECLARE @clubid1 int,@clubid2 int
SELECT @clubid1=club.id from club where @hostClubName=club.name
SELECT @clubid2=club.id from club where @guestClubName=club.name
if EXISTS(SELECT * FROM match m where m.club1Id=@clubid1 and m.club2Id=@clubid2 and m.startTime=@startTime and m.endTime=@endTime)
begin 
SET @noExistingMatch=0
DELETE FROM hostRequest where hostRequest.matchID  IN (SELECT m.id FROM match m WHERE m.club1Id=@clubid1 AND m.club2Id=@clubid2 AND m.startTime=@startTime AND m.endTime=@endTime)
DELETE FROM match WHERE match.club1Id=@clubid1 AND match.club2Id=@clubid2 AND match.startTime=@startTime AND match.endTime=@endTime
end 
else
SET @noExistingMatch=1


----------
GO;
create procedure deleteMatchesOnStadium 
@stadiumname varchar(20)
as
DECLARE @stadiumid int;
SELECT @stadiumid=stadium.id from stadium where @stadiumname=stadium.name;
DELETE FROM hostRequest WHERE hostRequest.matchID IN (SELECT match.id from match WHERE match.stadiumId=@stadiumid AND CURRENT_TIMESTAMP<match.startTime)
DELETE FROM match WHERE match.stadiumId = @stadiumid AND CURRENT_TIMESTAMP<match.startTime

-------------
SELECT * FROM CLUB
GO;
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
@guestclubname varchar(20),
@startTime datetime
AS 
DECLARE @matchId int,@hostclubid int,@guestclubid int;
SELECT @hostclubid=club.id from club where @hostclubname=club.name;
SELECT @guestclubid=club.id from club where @guestclubname=club.name;
SELECT @matchId=match.id from match WHERE  (@hostclubid=match.club1Id AND @guestclubid=match.club2Id AND @startTime=match.startTime)
INSERT INTO ticket (status,matchId) VALUES(1,@matchId)
---------------------
			
go;
create procedure deleteClub
@club varchar (20),
@noExistingClub bit Output
as
SET @noExistingClub=0
DECLARE @clubid int
SELECT @clubid=club.id from club where club.name=@club
if @clubid is null SET @noExistingClub=1
else
begin
DELETE FROM match WHERE match.club1Id=@clubid OR match.club2Id=@clubid 
DELETE FROM club WHERE club.id=@clubid
end

GO;
-----------------
create procedure addStadium 
@stadium_name varchar(20),
@stadium_location varchar (20),
@capacity int 
as 
insert into dbo.stadium(name,capacity,location,status) 
values (@stadium_name,@capacity,@stadium_location,1)

---------------------
go
create procedure deleteStadium
@stadium_name varchar (20),
@noExistingStadium bit Output
as
SET @noExistingStadium=0
DECLARE @stadiumId int
SELECT @stadiumId=stadium.id from stadium where stadium.name=@stadium_name
if @stadiumId is null SET @noExistingStadium=1
else
begin
DELETE FROM match WHERE match.stadiumId=@stadiumId
DELETE FROM stadium WHERE @stadiumId=stadium.id
end
-----------------
GO;
CREATE PROCEDURE blockFan
@national_id varchar(20),
@noExistingFan bit Output
AS
SET @noExistingFan=0
if exists (SELECT f.status FROM fan f WHERE f.nationalId=@national_id and f.status=1)
UPDATE Fan SET status=0 WHERE @national_id=nationalId;
else
SET @noExistingFan=1

------------------
GO;
CREATE PROCEDURE unblockFan
@national_id varchar(20)
AS
UPDATE Fan SET status=1 WHERE @national_id=nationalId;
-----------------
GO;
CREATE PROCEDURE addRepresentative
@name varchar(20),
@clubName varchar(20),
@username varchar(20),
@password varchar(20),
@success bit OUTPUT,
@noExistingClub bit Output
AS
begin
SET @noExistingClub = 0
if (@username = any (select SU.username from systemUser SU))
begin
SET @success = 0
end
else 
begin
SET @success = 1
DECLARE @clubId int
SELECT @clubId=club.id FROM club WHERE club.name=@clubName
if (@clubId IS NULL)
BEGIN
SET @noExistingClub = 1
END
ELSE
BEGIN
INSERT INTO dbo.systemUser VALUES(@username,@password)
INSERT INTO clubRepresentative(name,clubId,username) VALUES(@name,@clubId,@username);
END
end
end

-------------
GO;
CREATE FUNCTION viewAvailableStadiumsOn
(@date datetime)
returns TABLE
AS 
RETURN (
	SELECT stadium.name,stadium.location, stadium.capacity from stadium where stadium.status=1
	EXCEPT(
	SELECT stadium.name,stadium.location, stadium.capacity from stadium
	INNER JOIN match on match.stadiumId=stadium.id
	WHERE @date BETWEEN match.startTime and match.endTime
	)
)


-------------
GO;
CREATE PROCEDURE addHostRequest
@clubname varchar(20),
@stadiumname varchar(20),
@datetime datetime,
@success bit OUTPUT
AS
DECLARE @clubRepresentativeID int,@stadiumManagerID int,@matchID int
SET @success=0;
SET @matchID =-1
SET @stadiumManagerID = -1
SELECT @clubRepresentativeID=clubRepresentative.id from clubRepresentative
INNER JOIN club ON club.id=clubRepresentative.id
WHERE @clubname=club.name

SELECT @stadiumManagerID=stadiumManager.id from stadiumManager
INNER JOIN stadium ON stadium.id=stadiumManager.id
WHERE @stadiumname=stadium.name

SELECT @matchID=match.id FROM club
INNER JOIN match ON match.club1Id=club.id
WHERE match.startTime=@datetime AND club.name=@clubname
if(@matchID <> -1 and @stadiumManagerID <> -1)
BEGIN
INSERT INTO hostRequest(clubRepresentativeId,stadiumManagerID,matchID,status) VALUES (@clubRepresentativeID,@stadiumManagerID,@matchID,'unhandled')
SET @success = 1;
END
-------------
GO;
CREATE FUNCTION allUnassignedMatches
(@hostClubName varchar(20))
RETURNS TABLE 
AS
RETURN (
       SELECT c2.name, match.startTime   FROM club c1 
	   INNER JOIN match ON c1.id=match.club1Id 
	   INNER JOIN club c2 ON c2.id=match.club2Id
	   WHERE c1.name=@hostClubName AND match.stadiumId IS NULL  
)

------------------

GO;
CREATE PROCEDURE addStadiumManager
@name varchar(20),
@stadiumName varchar(20),
@username varchar(20),
@password varchar(20),
@success bit OUTPUT,
@noExistingStadium bit OUTPUT
AS
begin
SET @noExistingStadium = 0;
if (@username = any (select SU.username from systemUser SU))
begin
SET @success = 0
end
else 
begin
SET @success = 1
DECLARE @stadiumId int
SELECT @stadiumId=stadium.id FROM stadium WHERE stadium.name=@stadiumName
if @stadiumId IS NULL
BEGIN
SET @noExistingStadium = 1;
END
ELSE
BEGIN
INSERT INTO dbo.systemUser VALUES(@username,@password)
INSERT INTO stadiumManager(name,stadiumID,username) VALUES(@name,@stadiumId,@username);
END
end
end



GO;
-------------------------
CREATE FUNCTION allpendingRequests
(@stadmanagerUN VARCHAR(20)) 
RETURNS @allpendingRequests TABLE (
        clubrRepresentativeName VARCHAR(20),
        guestClubName VARCHAR(20),
        startTime datetime
    )
AS
BEGIN
    DECLARE @stadmanagerId int
    SELECT @stadmanagerId=stadiumManager.id from stadiumManager where @stadmanagerUN=stadiumManager.username
    INSERT INTO @allpendingRequests
	SELECT cr.name,c.name,m.startTime FROM clubRepresentative cr 
	INNER JOIN hostRequest hr ON cr.id=hr.clubRepresentativeId
	INNER JOIN match m ON hr.matchID=m.id
	INNER JOIN club c ON m.club2Id=c.id
	WHERE hr.status='unhandled' and hr.stadiumManagerID=@stadmanagerId
    RETURN;
END;
----------------------------------------------------------
GO;
create procedure acceptRequest 
@stadium_manager_username varchar(20),
@hosting_club varchar(20),
@competing_club varchar(20),
@start datetime,
@noExistingReq bit OUTPUT
as
begin
declare @i int
set @i =1;
declare @STM_ID int 
select @STM_ID= STM.id from stadiumManager STM where STM.username= @stadium_manager_username
declare @ST_ID int
select @ST_ID = STM2.stadiumID from stadiumManager STM2 where STM2.id = @STM_ID
declare @ST_Capacity int 
select @ST_Capacity = ST.capacity from stadium ST where ST.id= @ST_ID
declare @HC_ID int
set @HC_ID =-1
select @HC_ID = C1.id from club C1 where C1.name= @hosting_club
declare @AWAYC_ID int
set @AWAYC_ID=-1
select @AWAYC_ID= C2.id from club C2 where C2.name = @competing_club
declare @M_ID int 
set @M_ID=-1
select @M_id =m.id from match m where m.club1Id=@HC_ID and m.club2Id = @AWAYC_ID
and m.startTime = @start
if (@HC_ID=-1 OR @AWAYC_ID =-1 or @M_ID=-1)
begin
SET @noExistingReq = 1
end
ELSE
BEGIN
SET @noExistingReq = 0
update hostRequest
set hostRequest.status = 'accepted' from match M  where hostRequest.stadiumManagerID=@STM_ID 
and hostRequest.matchID=@M_ID 
while (@i <= @ST_Capacity) 
begin
EXEC addTicket @hosting_club,@competing_club,@start
SET @i  = @i  + 1
end
end
END

GO;
create proc rejectRequest 
@stadium_manager_username varchar(20),
@hosting_club varchar(20),
@competing_club varchar(20),
@start datetime,
@noExistingReq Bit output
as
declare @STM_ID int
select @STM_ID= STM.id from stadiumManager STM where STM.username= @stadium_manager_username
declare @HC_ID int
set @HC_ID=-1
select @HC_ID = C1.id from club C1 where C1.name= @hosting_club
declare @AWAYC_ID int
set @AWAYC_ID=-1
select @AWAYC_ID= C2.id from club C2 where C2.name = @competing_club
declare @M_ID int 
set @M_ID =-1
select @M_id =m.id from match m where m.club1Id=@HC_ID and m.club2Id = @AWAYC_ID
and m.startTime = @start
if (@HC_ID=-1 OR @AWAYC_ID =-1 or @M_ID=-1)
begin
SET @noExistingReq = 1
end
ELSE
BEGIN
SET @noExistingReq = 0
update hostRequest
set hostRequest.status = 'rejected' from match M  where hostRequest.stadiumManagerID=@STM_ID 
and hostRequest.matchID=@M_ID
END
GO;



GO;
create proc addFan
@name varchar(20),
@username varchar (20),
@password varchar (20),
@national_id varchar(20),
@birth_date datetime,
@address varchar(20),
@phone_number int,
@success bit output
as 
if (@username = any (select SysU.username from systemUser Sysu))
begin 
SET @success = 0
end
else
begin
SET @success=1
insert into systemUser values (@username,@password)
insert into Fan (name,nationalId,birthDate,address,phoneNumber,username,status) 
values (@name,@national_id,@birth_date,@address,@phone_number,@username,1)
end
GO;


------------------
CREATE FUNCTION upcomingMatchesOfClub
(@clubName varchar(20))
RETURNS TABLE
AS
RETURN(
	SELECT c1.name'host name',c2.name'guest name',match.startTime,match.endTime,stadium.name FROM match
	INNER JOIN club c1 ON match.club1Id=c1.id
	INNER JOIN club c2 ON match.club2Id=c2.id
	LEFT OUTER JOIN stadium ON stadium.id = match.stadiumId
	WHERE (c1.name=@clubName or c2.name=@clubName) AND CURRENT_TIMESTAMP<match.startTime
);
GO;
----------------------
GO;
CREATE FUNCTION upcomingMatchesSAM
()
RETURNS TABLE
AS
RETURN(
	SELECT c1.name'host name',c2.name'guest name',match.startTime,match.endTime FROM match
	INNER JOIN club c1 ON match.club1Id=c1.id
	INNER JOIN club c2 ON match.club2Id=c2.id
	WHERE CURRENT_TIMESTAMP<match.startTime
);

----------------------
GO;
CREATE FUNCTION pastMatches
()
RETURNS TABLE
AS
RETURN(
	SELECT c1.name'host name',c2.name'guest name',match.startTime,match.endTime FROM match
	INNER JOIN club c1 ON match.club1Id=c1.id
	INNER JOIN club c2 ON match.club2Id=c2.id
	WHERE CURRENT_TIMESTAMP>match.startTime
);

-----------------------
GO;
CREATE FUNCTION availableMatchesToAttend 
(@datetime datetime)
RETURNS TABLE
AS
RETURN(
	SELECT DISTINCT c1.name 'host club name',c2.name 'guest club name',s.name,s.location
	FROM club c1 
	INNER JOIN match m ON c1.id=m.club1Id 
	INNER JOIN club c2 ON c2.id=m.club2Id
	INNER JOIN stadium s ON s.id=m.stadiumId
	INNER JOIN ticket t ON t.matchId=m.id
	WHERE t.status=1 AND m.startTime>@datetime
);
go;

-------

GO;
CREATE PROCEDURE purchaseTicket
@nationalID varchar(20),@hostname varchar(20),@guestname varchar(20),@starttime datetime,@success bit OUTPUT
AS
BEGIN
DECLARE @matchID int,@ticketID int
SET @matchID = -1
if (0 = all(SELECT status from ticket
			INNER JOIN match ON match.id = ticket.matchId
			INNER JOIN club c1 ON c1.id = match.club1Id
			INNER JOIN club c2 ON c2.id = match.club2Id
			WHERE c1.name=@hostname AND c2.name=@guestname AND match.startTime = @starttime))
BEGIN
SET @success = 0
END
ELSE
BEGIN
	SET @success = 1
	SELECT @matchID=match.id from match
	INNER JOIN club c1 ON c1.id = match.club1Id
	INNER JOIN club c2 ON c2.id = match.club2Id
	WHERE c1.name=@hostname AND c2.name=@guestname AND match.startTime = @starttime
	if(@matchID = -1)
	BEGIN
		SET @success=0
	END
	ELSE
	BEGIN
		SELECT @ticketID = ticket.id from ticket where ticket.matchId=@matchID AND status=1
		INSERT INTO ticketBuyingTransaction (fanNationalId,ticketId) VALUES(@nationalID,@ticketID)
		UPDATE ticket SET status=0 where @ticketID=id;
	END
END
END
-----------------------
GO;

GO;
CREATE PROCEDURE updateMatchHost
@hostClubName varchar(20),@guestClubName varchar(20), @starttime datetime
AS
DECLARE @hostID int,@guestID int
SELECT @hostID=club.id from club where club.name=@hostClubName
SELECT @guestID=club.id from club where club.name=@guestClubName
UPDATE match SET club1Id=@guestID , club2ID=@hostID , stadiumId = NULL WHERE match.club1Id=@hostID AND match.club2Id=@guestID AND match.startTime = @starttime
GO;
-------
GO;
CREATE VIEW matchesPerTeam WITH SCHEMABINDING AS
SELECT dbo.club.name,COUNT(dbo.match.id) 'Number of matches' from dbo.club
INNER JOIN dbo.match ON match.club1Id = club.id or match.club2Id=club.id
WHERE CURRENT_TIMESTAMP>match.endTime
GROUP BY (club.name)
GO;

------------
GO;
CREATE VIEW clubsNeverMatched WITH SCHEMABINDING AS
SELECT distinct  c1.name 'club1 name',c2.name 'club2 name' FROM dbo.club c1 inner JOIN dbo.club c2 ON c1.id<c2.id
EXCEPT(SELECT distinct allMatches.hostClub 'club1 name',allMatches.guestClub 'club1 name' from dbo.allMatches
		UNION
		SELECT  distinct allMatches.guestClub 'club1 name',allMatches.hostClub 'club2 name' from dbo.allMatches
)

--------
GO;

GO;
CREATE FUNCTION clubsNeverPlayed
(@clubName VARCHAR(20)) 
RETURNS @clubsNeverPlayed TABLE (
        clubNames VARCHAR(20)
    )
AS
BEGIN
     INSERT INTO @clubsNeverPlayed
     SELECT club.name FROM club WHERE @clubName<>club.name
	 EXCEPT(
	 SELECT c4.name FROM club c2 INNER JOIN match m ON c2.id=m.club1Id INNER JOIN club c4 ON m.club2Id=c4.id WHERE c2.name=@clubName
	 UNION 
	 SELECT c5.name FROM club c3 INNER JOIN match m ON c3.id=m.club2Id INNER JOIN club c5 ON m.club1Id=c5.id WHERE c3.name=@clubName
	 )
    RETURN;
END;

go;
---------------------------

GO;
CREATE FUNCTION matchWithHighestAttendance
()
RETURNS @matchWithHighestAttendance TABLE(
	hostName varchar(20),
	guestName varchar(20)
)
AS
BEGIN 
INSERT INTO @matchWithHighestAttendance
SELECT c1.name 'hostName', c2.name 'guestName' FROM club c1
INNER JOIN match m on c1.id=m.club1Id
INNER JOIN club c2 on m.club2Id=c2.id
WHERE m.id in(
select t.matchId
from ticket t 
where t.status=0
group by t.matchId 
having count(t.id) >= all (select count (t2.id) from ticket t2 where t2.status=0 group by t2.matchId )
)
RETURN
END
GO;


--------------------
GO;
CREATE FUNCTION matchesRankedByAttendance ----HELP
()
RETURNS @matchRankedByAttendance TABLE(
	hostName varchar(20),
	guestName varchar(20)
)
AS
BEGIN
	INSERT INTO @matchRankedByAttendance
	SELECT c1.name 'Hosting Club', c2.name 'Guest Club' FROM club c1
	INNER JOIN match ON match.club1Id=c1.id
	INNER JOIN club c2 ON match.club2Id=c2.id
	INNER JOIN ticket ON ticket.matchId=match.id
	WHERE ticket.status = 0
	GROUP BY c1.name , c2.name
	ORDER BY COUNT(ticket.id) DESC OFFSET 0 ROW

RETURN
END
GO;


go;
create function requestsFromClub (
@stadium_name varchar(20),
@club_name varchar (20)
)
returns @requestsFromClub table (
hostName varchar(20),
guestName varchar(20)
)
AS
BEGIN
DECLARE @STM_ID int
select @STM_ID= stm.id from stadiumManager stm 
inner join Stadium ST on ST.id=stm.stadiumID
where ST.name=@stadium_name 

DECLARE @CR_ID int
select @CR_ID = cr.id from clubRepresentative cr
inner join club c on c.id =cr.clubId
where c.name=@club_name

DECLARE @hostID int
SELECT @hostID=club.id from club where club.name=@club_name

INSERT INTO @requestsFromClub
select c1.name ,c2.name from club c1 
inner join match m on c1.id = m.club1Id
inner join club c2 on m.club2Id= c2.id
where c1.id = @hostID and m.id in (
select HR.matchID  from hostRequest HR 
where @STM_ID = HR.stadiumManagerID 
and @CR_ID= HR.clubRepresentativeId
)
return
END

go;

CREATE PROCEDURE userLogin
@username varchar(20),
@password varchar(20),
@type varchar(25) output,
@id int output
AS
SET @id = -1
SET @type = 'lol'
if EXISTS(SELECT systemUser.username,systemUser.password from Fan 
		  INNER JOIN systemUser ON systemUser.username=fan.username
		  where @username=systemUser.username AND @password=systemUser.password)
BEGIN
	SET @type = 'Fan'
	SELECT @id=CAST(fan.nationalId AS INT) from Fan
		  INNER JOIN systemUser ON systemUser.username=fan.username
		  where @username=systemUser.username AND @password=systemUser.password
END
-----------
if EXISTS(SELECT systemUser.username,systemUser.password from SportsAsssociationManager 
		  INNER JOIN systemUser ON systemUser.username=SportsAsssociationManager.username
		  where @username=systemUser.username AND @password=systemUser.password)
BEGIN
	SET @type = 'SportsAsssociationManager'
	SELECT @id=SportsAsssociationManager.id from SportsAsssociationManager
		  INNER JOIN systemUser ON systemUser.username=SportsAsssociationManager.username
		  where @username=systemUser.username AND @password=systemUser.password
END 
------------
if EXISTS(SELECT systemUser.username,systemUser.password from clubRepresentative
		  INNER JOIN systemUser ON systemUser.username=clubRepresentative.username
		  where @username=systemUser.username AND @password=systemUser.password)
BEGIN
	SET @type = 'clubRepresentative'
	SELECT @id=clubRepresentative.id from clubRepresentative
		  INNER JOIN systemUser ON systemUser.username=clubRepresentative.username
		  where @username=systemUser.username AND @password=systemUser.password
END
--------------
if EXISTS(SELECT systemUser.username,systemUser.password from stadiumManager
		  INNER JOIN systemUser ON systemUser.username=stadiumManager.username
		  where @username=systemUser.username AND @password=systemUser.password)
BEGIN
	SET @type = 'stadiumManager'
	SELECT @id=stadiumManager.id from stadiumManager
		  INNER JOIN systemUser ON systemUser.username=stadiumManager.username
		  where @username=systemUser.username AND @password=systemUser.password
END
----------------
if EXISTS(SELECT systemUser.username,systemUser.password from SystemAdmin
		  INNER JOIN systemUser ON systemUser.username=SystemAdmin.username
		  where @username=systemUser.username AND @password=systemUser.password)
BEGIN
	SET @type = 'SystemAdmin'
	SELECT @id=SystemAdmin.id from SystemAdmin
		  INNER JOIN systemUser ON systemUser.username=SystemAdmin.username
		  where @username=systemUser.username AND @password=systemUser.password
END


------------------	
GO;
CREATE PROCEDURE getClubName
@clubrepID int,
@clubName varchar(20) OUTPUT
AS
SELECT @clubName=club.name from club
INNER JOIN clubRepresentative ON clubRepresentative.clubid=club.id
WHERE clubRepresentative.id = @clubrepID