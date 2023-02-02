USE master
IF DB_ID('FISKdB') IS NOT NULL
BEGIN
ALTER DATABASE fiskDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE fiskDB
END

CREATE DATABASE fiskDB
GO
USE fiskDB
GO

DROP TABLE IF exists fisk
CREATE TABLE fisk(
id INT IDENTITY(1,1)primary key,
species NVARCHAR(100),
køn NVARCHAR(100),
længte DECIMAL,
vægt DECIMAL,
lokalition NVARCHAR(100),
watertype NVARCHAR(100)
)
INSERT INTO fisk(species, køn,længte,vægt,lokalition,watertype) VALUES('torsk','male',10,5,'river','ferskvand')
INSERT INTO fisk(species, køn,længte,vægt,lokalition,watertype) VALUES('laks','female',6,4,'lake','slatvand')
INSERT INTO fisk(species, køn,længte,vægt,lokalition,watertype) VALUES('merkral','male',8,6,'river','ferskvand')
INSERT INTO fisk(species, køn,længte,vægt,lokalition,watertype) VALUES('ål','female',15,7,'lake','saltvand')

DROP TABLE IF exists medical
CREATE TABLE medical(
id INT IDENTITY(1,1),
species NVARCHAR(100),
medical NVARCHAR(100),
lokalition NVARCHAR(100),
watertype NVARCHAR(100),
noter NVARCHAR(100)
)
INSERT INTO medical(species,medical,lokalition,watertype,noter) VALUES('torsk','worms','river','ferskvad','give proper medicen')
INSERT INTO medical(species, medical,lokalition,watertype,noter) VALUES('laks','???','lake','saltvand','unable to find Cause')
INSERT INTO medical(species, medical,lokalition,watertype,noter) VALUES('merkral','infarction','river','ferskvand','give antibiotic and Observe')
INSERT INTO medical(species, medical,lokalition,watertype,noter) VALUES('ål','pregnant','lake','saltvand','wait for them be born and Observe')

CREATE TABLE examination(
id INT IDENTITY(1,1),
species NVARCHAR(100),
[time] DATETIME,
lokalitionid INT foreign key REFERENCES fisk(id)
)
INSERT INTO examination(species,[time],lokalitionid) VALUES('torsk','2023-01-05 10:00:00',1)
INSERT INTO examination(species,[time],lokalitionid) VALUES('laks','2032-01-10 12:00:00',2)
INSERT INTO examination(species,[time],lokalitionid) VALUES('merkral','2032-01-15 14:00:00',3)
INSERT INTO examination(species,[time],lokalitionid) VALUES('ål','2032-01-20 16:00:00',4)

SELECT * FROM fisk
SELECT * FROM medical
SELECT * FROM examination

SELECT * FROM examination
join fisk ON examination.id =examination.lokalitionid