USE Master
GO
IF DB_ID('Vaskeriopgave') IS NOT NULL
	BEGIN
		ALTER DATABASE Vaskeriopgave SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE Vaskeriopgave
	END
GO
CREATE DATABASE Vaskeriopgave
GO
USE Vaskeriopgave
GO

DROP TABLE IF EXISTS Vaskeri
DROP TABLE IF EXISTS Bruger
DROP TABLE IF EXISTS Maskine
DROP TABLE IF EXISTS Bookning

CREATE TABLE Vaskeri (
  id INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
  navn NVARCHAR(255),
  åbner Time,
  lukker Time
)

CREATE TABLE Bruger (
  id INT PRIMARY KEY IDENTITY (1,1),
  navn VARCHAR(255),
  email VARCHAR(255) UNIQUE,
  [password] NVARCHAR(255),
  konto Decimal(8,2),
  vaskri INT NOT NULL,
  oprettet Date,
  CONSTRAINT vaskri FOREIGN KEY (vaskri) REFERENCES Vaskeri(id),
  CONSTRAINT [password] CHECK (LEN([password]) >= 5)
)



CREATE TABLE Maskine (
  id INT PRIMARY KEY IDENTITY (1,1),
  navn NVARCHAR(255),
  prisprvask Decimal(8,2),
  vasketid NVARCHAR(255),
  vaskeri INT NOT NULL,
  CONSTRAINT maskine_vaskeri FOREIGN KEY (vaskeri) REFERENCES Vaskeri(id)
)

CREATE TABLE Bookning (
  id INT PRIMARY KEY IDENTITY (1,1),
  tidspunkt Datetime,
  bruger_id INT NOT NULL,
  maskine_id INT NOT NULL,
  CONSTRAINT bruger_id FOREIGN KEY (bruger_id) REFERENCES bruger(id),
  CONSTRAINT maskine_id FOREIGN KEY (maskine_id) REFERENCES Maskine(id)
)


INSERT INTO Vaskeri (navn,åbner,lukker) VALUES ('Whitewash Inc.', '08:00', '20:00')
INSERT INTO Vaskeri (navn,åbner,lukker) VALUES ('Double Bubble', '02:00', '22:00')
INSERT INTO Vaskeri (navn,åbner,lukker) VALUES ('Wash & Coffee', '12:00', '20:00')

SELECT * FROM Vaskeri


INSERT INTO Bruger (navn,email,[password],konto,vaskri,oprettet) 
VALUES ('John', 'john_doe66@gmail.com', 'password', 100, 2, '2021-02-15')
INSERT INTO Bruger (navn,email,[password],konto,vaskri,oprettet) 
VALUES ('Neil Armstrong', 'firstman@nasa.gov', 'eagleLander69', 1000, 1, '2021-02-10')
INSERT INTO Bruger (navn,email,[password],konto,vaskri,oprettet) 
VALUES ('Batman', 'noreply@thecave.com', 'Rob1n', 500, 3, '2020-03-10')
INSERT INTO Bruger (navn,email,[password],konto,vaskri,oprettet) 
VALUES ('Goldman Sachs', 'moneylaundering@gs.com', 'NotRecognized', 100000, 1, '2021-01-01')
INSERT INTO Bruger (navn,email,[password],konto,vaskri,oprettet) 
VALUES ('50 Cent', '50cent@gmail.com', 'ItsMyBirthday', 0.50, 3, '2020-07-06')

SELECT * FROM Bruger

INSERT INTO Maskine (navn,prisprvask,vasketid,vaskeri) VALUES ('Mielle 911 Turbo',5,60,2)
INSERT INTO Maskine (navn,prisprvask,vasketid,vaskeri) VALUES ('Siemons IClean',10000,30,1)
INSERT INTO Maskine (navn,prisprvask,vasketid,vaskeri) VALUES ('Electrolax FX-2',15,45,2)
INSERT INTO Maskine (navn,prisprvask,vasketid,vaskeri) VALUES ('NASA Spacewasher 8000',500,5,1)
INSERT INTO Maskine (navn,prisprvask,vasketid,vaskeri) VALUES ('The Lost Sock',3.5,90,3)
INSERT INTO Maskine (navn,prisprvask,vasketid,vaskeri) VALUES ('Yo Mama',0.5,120,3)

SELECT * FROM Maskine

INSERT INTO Bookning (tidspunkt,bruger_id,maskine_id) VALUES ('2021-02-26 12:00:00', 1, 1)
INSERT INTO Bookning (tidspunkt,bruger_id,maskine_id) VALUES ('2021-02-26 16:00:00', 1, 3)
INSERT INTO Bookning (tidspunkt,bruger_id,maskine_id) VALUES ('2021-02-26 08:00:00', 2, 4)
INSERT INTO Bookning (tidspunkt,bruger_id,maskine_id) VALUES ('2021-02-26 15:00:00', 3, 5)
INSERT INTO Bookning (tidspunkt,bruger_id,maskine_id) VALUES ('2021-02-26 20:00:00', 4, 2)
INSERT INTO Bookning (tidspunkt,bruger_id,maskine_id) VALUES ('2021-02-26 19:00:00', 4, 2)
INSERT INTO Bookning (tidspunkt,bruger_id,maskine_id) VALUES ('2021-02-26 10:00:00', 4, 2)
INSERT INTO Bookning (tidspunkt,bruger_id,maskine_id) VALUES ('2021-02-26 16:00:00', 5, 6)


BEGIN TRAN [Transaction]
INSERT INTO Bookning VALUES ('2022-09-15 12:00:00', 4, 2)
COMMIT TRAN [Transaction]

GO
create view Bookingview AS
SELECT Bookning.tidspunkt AS bookingtid,Bruger.navn AS bestilling,Maskine.navn AS maskinenavn,
Maskine.prisprvask AS vaskeprisv from Bookning
join Bruger ON Bookning.bruger_id = Bruger.id
join Maskine ON Bookning.maskine_id = Maskine.id
GO

SELECT * FROM Bookingview

SELECT * FROM Bruger
WHERE Bruger.email LIKE '%@gmail.com'

SELECT maskine.navn AS maskinenavn,prisprvask AS vaskepris,vasketid AS vasketidprmin,Vaskeri.navn AS vaskerrinavn,
Vaskeri.åbner AS vaskeriåbner,Vaskeri.lukker AS vaskerilukker FROM Maskine
join Vaskeri ON Maskine.vaskeri = vaskeri.id

SELECT Maskine.navn,COUNT(Bookning.id) AS brugtemaskiner FROM Bookning
join Maskine ON Bookning.maskine_id = Maskine.id
group by Maskine.navn
DELETE FROM Bookning WHERE CAST(tidspunkt as Time) BETWEEN '12:00' AND '13:00'

UPDATE Bruger
SET [Password] = 'SelinaKyle'
WHERE [Email] = 'noreply@thecave.com'
AND [Password] = 'Rob1n'


