GO;
CREATE VIEW allAssocManagers WITH SCHEMABINDING AS
SELECT s.username,systemUser.password,s.name
FROM dbo.SportsAsssociationManager s
INNER JOIN systemUser ON s.username=systemUser.username

GO;
CREATE VIEW allClubRepresentatives WITH SCHEMABINDING AS
SELECT username,clubRepresentative.name 'Club Representatives',club.name 'Club Name' from dbo.clubRepresentative
INNER JOIN club ON club.id=clubRepresentative.clubId


GO;
CREATE VIEW allStadiumManagers WITH SCHEMABINDING AS
SELECT username,systemUser.password,stadiumManager.name 'Stadium Manager name',stadium.name 'Stadium name' from dbo.stadiumManager
INNER JOIN dbo.stadium ON stadium.stadiumManagerId=stadiumManager.id
INNER JOIN systemUser ON s.username=systemUser.username


GO;
CREATE VIEW allFans WITH SCHEMABINDING AS
SELECT username,systemUser.password,name,nationalId,birthDate,status from dbo.Fan
INNER JOIN systemUser ON s.username=systemUser.username

GO;
CREATE VIEW allMatches WITH SCHEMABINDING AS
SELECT c1.name as host,c2.name as GuestTeam, m.startTime as startTime
FROM dbo.club c1 INNER JOIN dbo.match m ON c1.id=m.club1Id INNER JOIN dbo.club c2 ON c2.id=m.club2Id

GO;
create view allTickets  
with schemabinding
as 
select  c1.name 'club 1',c2.name 'club 2',ST.name 'Stadium name',M.startTime
from dbo.club c1 
inner join dbo.match M on c1.id =M.club1Id 
inner join dbo.club c2 on M.club2Id=c2.id 
inner join dbo.stadium ST on M.stadiumId = ST.id 
where c1.id <c2.id

GO;
CREATE VIEW allClubs WITH SCHEMABINDING AS
SELECT name,location FROM dbo.club;

GO;
CREATE VIEW allStadiums WITH SCHEMABINDING AS
SELECT name,capacity,location,status FROM dbo.stadium

GO;
CREATE VIEW allRequests WITH SCHEMABINDING AS
SELECT stadiumManager.username 'Stadium Manager username', clubRepresentative.username 'Club Representative name',hostRequest.status FROM dbo.clubRepresentative
INNER JOIN dbo.hostRequest ON hostRequest.clubRepresentativeId=clubRepresentative.id
INNER JOIN dbo.stadiumManager ON hostRequest.stadiumManagerID=stadiumManager.id;

GO;
create view clubsWithNoMatches with schemabinding as
select c.name from dbo.club c
except (select c1.name from dbo.club c1 inner join dbo.match M on c1.id = M.club1Id or c1.id=M.club2Id)
