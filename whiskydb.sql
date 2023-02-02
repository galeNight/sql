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
regionid int,
[typeid] int,
price DECIMAL -- så man kan bruger tal
)
drop table if exists whiskytype
create table wiskytype(
id int identity(1,1),
[type] nvarchar(32)
)
insert into wiskytype([type]) VALUES ('Blended')
insert into wiskytype([type]) VALUES ('Single Malt')
insert into wiskytype([type]) VALUES ('Single Cask')

drop table if exists whiskyregion
create table whiskyregion(
id int identity(1,1),
region nvarchar(32)
)
insert into whiskyregion (region) values ('Islay')
insert into whiskyregion (region) values ('Highland')
insert into whiskyregion (region) values ('Spayside')
insert into whiskyregion (region) values ('Sønderjyske')

 --beste a insætte via columns 
insert into whisky ([name],regionid,[typeid]) values ('glenn scotia',1,1)
insert into whisky ([name],regionid,[typeid]) values ('Highland park',2,1)
insert into whisky ([name],regionid,[typeid]) values ('skye',3,2)
insert into whisky ([name],[typeid]) values ('Nikka', 1)

--SELECT * FROM whisky WHERE [typeid] like '%blend%' -- vælger en bestemt culonne

--SELECT *FROM whisky ORDER BY [name] DESC -- alfabetick odre DESC rfa bunden til først

--SELECT COUNT(id) AS number,[typeid] AS 'whisky type' from whisky GROUP BY [typeid]  -- laver id om til nummer og type som whisky type fra gruppen type

--SELECT STRING_AGG([name],'') AS names,[typeid] AS 'whisky type' from whisky GROUP BY [typeid] -- laver navn til navn og type til whisky type fra gruppen type
