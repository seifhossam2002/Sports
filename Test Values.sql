INSERT INTO dbo.systemUser VALUES
('stadmanager1','stadmanager1'),
('stadmanager2','stadmanager2'),
('stadmanager3','stadmanager3'),
('clubrep1','clubrep1'),
('clubrep2','clubrep2'),
('clubrep3','clubrep3'),
('samanager1','samanager1'),
('sysadmn1','sysadmn1'),
('fan1','fan1'),
('fan2','fan2'),
('fan3','fan3'),
('clubrep4','clubrep4');
INSERT INTO dbo.Stadium (name,status,location,capacity) VALUES 
('Stadium1',1,'Qatar',720),
('Stadium2',0,'Brazil',1000),
('Stadium3',1,'Portugal',1500);
Insert INTO dbo.StadiumManager VALUES 
('StadManager 1','stadmanager1',1),
('StadManager 2','stadmanager2',2),
('StadManager 3','stadmanager3',3);
INSERT INTO dbo.CLUB VALUES 
('club1','Germany'),
('club2','Spain'),
('club3','Morocco'),
('club4','France')
--delete from club where location='france'

Insert INTO dbo.ClubRepresentative (name,username,clubId) Values
('clubRep 1','clubrep1',1),
('clubRep 2','clubrep2',2),
('clubRep 3','clubrep3',3),
('clubRep 4','clubrep4',4);

Insert Into dbo.SportsAsssociationManager Values
('SA Manager 1','samanager1');
Insert Into dbo.SystemAdmin Values
('sys Admin 1','sysadmn1');
Insert Into dbo.Fan (nationalId,name,username,birthDate,phoneNumber,address,status) Values 
('123456','Fan 1','fan1','1980/07/12',0100,'Pennsylvania',1),
('234567','Fan 2','fan2','1986/06/23',0177,'New York',0),
('345678','Fan 3','fan3','1996/09/23',0123,'LA',1);


INSERT INTO dbo.match (startTime,endTime,stadiumId,club1Id,club2Id) VALUES
('2018-11-11 13:00:00','2018-11-11 15:00:00',1,2,1),
('2020-01-13 17:00:00','2020-01-13 19:00:00',2,3,2),
('2021-07-21 12:00:00','2021-07-21 14:00:00',3,1,3),
('2022-03-11 13:00:00','2022-03-11 15:00:00',3,2,1),
('2022-11-19 14:00:00','2022-11-19 16:00:00',1,3,3);

Insert INTO dbo.hostRequest VALUES
('accepted',1,1,1),
('rejected',1,1,2),
('accepted',2,2,2),
('rejected',2,2,3),
('accepted',3,3,3),
('rejected',3,3,1),
('accepted',4,1,3),
('unhandled',4,1,2),
('accepted',5,3,3),
('unhandled',5,3,2);
INSERT INTO dbo.ticket (status,matchId) VALUES
(1,1),
(0,2),
(1,2),
(0,3),
(0,4),
(1,5);


select * from ticket
INSERT INTO ticket VALUES (1,5)
SELECT * from systemUser

insert into match (startTime,endTime,club1Id,club2Id) values('2024-11-19 14:00:00.000','2024-11-19 16:00:00.000',3,4)
SELECT * from stadium
SELECT * from hostRequest
--SELECT * FROM club
SELECT * FROM match
