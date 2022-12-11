drop database milestone
create database milestone;
GO;
CREATE PROCEDURE createAllTables
AS
CREATE TABLE systemUser(
username VARCHAR(20) NOT NULL,
password VARCHAR(20)
constraint Pk_systemUser PRIMARY KEY (username));

CREATE TABLE stadiumManager(
id int IDENTITY ,
name VARCHAR(20) NOT NULL,
username varchar (20),
constraint Pk_stadiumManager PRIMARY KEY (id),
constraint Fk_stadiumManager foreign key (username) references systemUser(username) ON DELETE CASCADE ON UPDATE CASCADE 
);
CREATE TABLE clubRepresentative(
id int IDENTITY,
name varchar(20),
username varchar(20) NOT NULL,
constraint Pk_clubRepresentitive PRIMARY KEY (id),
constraint Fk_clubRepresentitive foreign key (username) references systemUser(username) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Fan(
birthDate DATE,
nationalId varchar(20),
phoneNumber varchar(20),
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
stadiumManagerId int,
constraint Pk_stadium PRIMARY KEY (id),
constraint fk_stadium foreign key (stadiumManagerId) references stadiumManager(id) ON DELETE CASCADE ON UPDATE CASCADE 
);

create table club(
name varchar(20),
id int identity,
location varchar(20),
clubRepresentativeId int,
constraint Pk_club PRIMARY KEY (id),
constraint fk_club foreign key (clubRepresentativeId) references clubRepresentative(id) ON DELETE CASCADE ON UPDATE CASCADE 
); 

create table match (
id int identity,
startTime datetime,
endTime datetime,
stadiumId int,
club1Id int,
club2Id int,
constraint Pk_match PRIMARY KEY (id),
constraint fkST_match foreign key (stadiumId) references stadium(id) ON DELETE CASCADE ON UPDATE CASCADE ,
constraint fkCL1_match foreign key (club1Id) references club(id), --ON DELETE SET NULL ON UPDATE CASCADE 
constraint fkCL2_match foreign key (club2Id) references club(id) -- ON DELETE SET NULL ON UPDATE CASCADE 
);

create table hostRequest(
id int identity,
status varchar(20),
matchID int,
stadiumManagerID int,
clubRepresentativeId int,
constraint Pk_hostRequest PRIMARY KEY (id),
constraint fkSM_hostRequest foreign key (stadiumManagerId) references stadiumManager(id) ON DELETE CASCADE ON UPDATE CASCADE ,
constraint fkCR_hostRequest foreign key (clubRepresentativeId) references clubRepresentative(id) --ON DELETE SET NULL ON UPDATE CASCADE 

);
create table ticket(
id int identity,
status bit,
fanNationalId varchar(20),
matchId int,
constraint Pk_ticket PRIMARY KEY (id),
constraint fkF_ticket foreign key (fanNationalID) references fan(NationalId)ON DELETE CASCADE ON UPDATE CASCADE ,
constraint fkM_ticket foreign key (matchId) references match(id)  --ON DELETE SET NULL ON UPDATE CASCADE 
);

EXEC createAllTables;

--------------------------------------

GO;
create procedure dropAllTables 
as 
drop table ticket
drop table match
drop table hostRequest
drop table club
drop table stadium
drop table stadiumManager
drop table clubRepresentative
drop table Fan
drop table SportsAsssociationManager
drop table SystemAdmin
drop table systemUser

EXEC dropAllTables;


-------------------

GO;
CREATE PROCEDURE clearAllTables
AS
DELETE FROM ticket;
DELETE FROM match;
DELETE FROM hostRequest;
DELETE FROM club;
DELETE FROM stadium;
DELETE FROM stadiumManager;
DELETE FROM clubRepresentative;
DELETE FROM Fan;
DELETE FROM SportsAsssociationManager;
DELETE FROM SystemAdmin;
DELETE FROM systemUser;


DROP PROCEDURE clearAllTables;
EXEC clearAllTables;