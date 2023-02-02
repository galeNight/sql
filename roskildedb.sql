go
use master
go

if DB_ID('RoskildeDB') is not null
	begin
	alter database RoskildeDB set single_user with rollback immediate
	drop database RoskildeDB
	end
create database RoskildeDB
go
use RoskildeDB

create table artist(
id int identity(1,1) primary key,
[name] nvarchar(100),
email nvarchar(100) UNIQUE 
)
insert into artist ([name],email) values('lil nas x','smalldickenergy@getalife.com')
insert into artist ([name],email) values('rosalía','rosa51@gg.gg')
insert into artist ([name],email) values('blur','bur@blur.blur')

create table scene(
id int identity(1,1),
[name] nvarchar(100) 
)
insert into scene ([name]) values('orange')
insert into scene ([name]) values('arena')
insert into scene ([name]) values('apollo')

create table schedule(
id int identity(1,1),
[time] datetime,
artistid int foreign key REFERENCES artist(id),
scendeid int 
)
insert into schedule([time],artistid,scendeid) values ('2023-07-01 21:00:00',1,1)
insert into schedule([time],artistid,scendeid) values ('2023-07-02 22:00:00',2,3)
insert into schedule([time],artistid,scendeid) values ('2023-07-01 21:00:00',3,1)

select *from artist
select *from scene
select *from schedule

go
create view wiewschedule as
select top 100 [time],artist.[name] as artist,scene.[name] as scene from schedule
join artist on artist.id = schedule.artistid
join scene on scene.id = schedule.scendeid
order by artist.[name]
go

update schedule
set [time]='2023-07-01 23:00:00'
where artistid=(select top 1 id from artist where [name] like 'blur') 
and scendeid = (select top 1 id from scene where [name] like 'orange')

select * from wiewschedule

alter table scene add manger nvarchar(100)
alter table scene add mobile nvarchar(10)

