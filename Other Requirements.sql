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
