use master
go

if DB_ID('carDB') is not null
	begin
	alter database carDB set single_user with rollback immediate
	drop database carDB
	end
create database carDB
go
use carDB
go

create table manufacturer(
id int identity(1,1)primary key,
[name] nvarchar(max),
FK_country_id int
)

create table country(
id int identity(1,1)primary key,
[name] nvarchar(max),
 )

create table model(
id int identity(1,1),
[name] nvarchar(max),
releaseyear int,
FK_manufacturer_id int
constraint FK_manufacturer_id foreign key(FK_manufacturer_id) references manufacturer(id)
)

 create table equipment(
 id int identity(1,1),
[name] nvarchar(max)
 )

 create table modelequipment(
 model_id int,
 equipment_id int
 )

 alter table manufacturer add foreign key (FK_country_id) references country(id)
 go


 insert into country values('japan'), ('tyskland'), ('sydkorea')
 insert into manufacturer values('mazda', 1), ('kia', 3), ('hyundai', 3)
 insert into model values ('626', 1986, 1), ('fxz coupe', 2000, 3), ('rio', 2012, 2)
 insert into equipment values ('servo'), ('abs'), ('heated seats'), ('sunroof'), ('gps'), ('seatbelts')

 insert into modelequipment values (1, 6), (2, 1), (2, 2), (2, 6), (3, 1), (3, 2), (3, 3), (3, 5), (3, 6)

 --select * from model
 --join manufacturer on model.FK_manufacturer_id = FK_manufacturer_id
 --join country on manufacturer.FK_country_id = FK_country_id

 go
 create view modelequip as
 select  model.FK_manufacturer_id, model.[name],model.releaseyear, string_agg (equipment.[name], ',') as equipment from model
 join modelequipment on model.id = modelequipment.model_id
 join equipment on modelequipment.equipment_id = equipment.id
 group by model.[name],model.releaseyear,model.FK_manufacturer_id
 go

 select manufacturer.[name] as manufacturer, modelequip.[name] as model, releaseyear, equipment, country.[name] as country 
 from modelequip
 join manufacturer on FK_manufacturer_id = manufacturer.id
 join country on manufacturer.FK_country_id = country.id

  select * from modelequip