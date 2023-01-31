USE master
IF DB_ID('FISKdB') IS NOT NULL
BEGIN
DROP DATABASE fiskDB
END

CREATE DATABASE fiskDB
GO
USE fiskDB
GO

DROP TABLE IF exists fisk
CREATE TABLE fisk(
id INT IDENTITY(1,1),
[name] NVARCHAR(32),
k�n NVARCHAR(32),
l�ngte DECIMAL,
v�gt DECIMAL,
lokalition NVARCHAR(32),
[type] NVARCHAR(32)
)

INSERT INTO fisk([name], k�n,l�ngte,v�gt,lokalition,[type]) 
VALUES('torsk','fimale',12,5,'lake','ferskvand')
SELECT *FROM fisk