use master
go
if DB_id ('musik') is not null
	begin
		alter database musik set single_user with rollback immediate
		drop database musik
	end
create database musik

go
use musik
go

create table song(
id int identity(1,1)primary key,
song nvarchar(max)
)

create table artist(
id int identity(1,1)primary key,
artist nvarchar(max)
)

create table song_artist(
id  int identity(1,1),
artist_id int foreign key references song(id),
song_id int foreign key references artist(id),
)

insert into song (song) values ('mamma mia'),('Jailhouse Rock'),('Hard To Say Im Sorry')
insert into artist (artist) values ('arba'),('elvis presly'),('chicago')
insert into song_artist values (1,1),(2,2),(3,3)


select song.song, STRING_AGG(artist.artist,' , ') from song
join song_artist on song.id = song_artist.song_id
join artist on artist.id = song_artist.artist_id
group by song.song
