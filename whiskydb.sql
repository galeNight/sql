USE master -- masteren som man stater i
IF DB_ID('WHISKYDB') IS NOT NULL --hvis der er en database
	BEGIN -- begynder 
		DROP DATABASE WhiskyDB --sletter databasen
	END --afslutter

CREATE DATABASE WhiskyDB -- laver en database
GO --gør dette
USE WhiskyDB --kommer ind på databasen fra master
GO 

DROP TABLE IF exists whisky -- sletter tabel
CREATE TABLE whisky( --laver en tabel
id INT IDENTITY(1,1), -- int som er tal
[name] NVARCHAR(32), -- nvarchar som er bogstaver
region NVARCHAR(32),
[type] NVARCHAR(32),
price DECIMAL
)
 --beste a insætte via columns 
INSERT INTO whisky ([name],region,[type]) VALUES ('glenn scotia','Islay','blended')
INSERT INTO whisky ([name],region,[type]) VALUES ('Highland park','highland','blended')
INSERT INTO whisky ([name],region,[type]) VALUES ('skye','spayside','single malt')

--SELECT * FROM whisky WHERE [type] like '%blend%'
SELECT *FROM whisky ORDER BY [name] DESC

SELECT COUNT(id) AS number,[type] AS 'whisky type' from whisky GROUP BY [type] 

SELECT STRING_AGG([name],'') AS names,[type] AS 'whisky type' from whisky GROUP BY [type]
