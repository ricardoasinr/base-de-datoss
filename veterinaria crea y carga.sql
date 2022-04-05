create table Clientes
(
  CodigoCli      char(10) primary key not null,
  ApellidoFam    varchar(20) not null,
  CuentaBancaria char(15) not null,
  Direccion      varchar(50),
  TelefonoFijo   nchar(8) not null,
  TelefonoCel    nchar(15) not null
);

 create table Personas
 (
   CI          char(10) primary key not null,
   Nombre      varchar(30) not null,
   ApellidoP   varchar(30) not null,
   ApellidoM   varchar(30) not null,
   TelefonoCel nchar(15) not null
 )
;

Create table PersonaCliente
 (
 CodigoCli char(10) not null,
 CI char(10) not null,
 FechaAsociacion date not null,
 constraint PKPC primary key (CodigoCli, CI),
 constraint FK_PPC foreign key (CI) references Personas,
 constraint FK_CPC foreign key (CodigoCli) references Clientes
 );
 
create table Mascotas
(
  CodMascota char(10) not null,
  Alias varchar(40) not null,
  Especie varchar(20) not null,
  Raza varchar(20) not null,
  color varchar(20) not null,
  FechaNac date not null,
  PesoActual int not null,
  CodCliente char(10) not null,
  constraint PKMascota primary key(CodMascota),
  constraint FKCliente foreign key(CodCliente) references Clientes
);

Create table HistoricoPeso
 (
    CodMascota   char(10) not null,
FechaVisita  date not null,
Peso         decimal(5,2) not null,    
constraint PK_HP primary key (CodMascota, FechaVisita),
constraint FK_HP foreign key (CodMascota) references Mascotas
 );
 
Create table HistoriaClinica
 (
    CodMascota   char(10) not null,
FechaVisita  date not null,
Enfermedad   varchar(100) not null,
Medicacion   varchar(100),
MontoPagado  money not null,
constraint PK_HC primary key (CodMascota, FechaVisita),
constraint FK_HC foreign key (CodMascota) references Mascotas
 );
 
Create table Vacunas
 (
    CodVacuna char(10) not null,
NombreVac  varchar(100) not null,    
EnfermedadPrev varchar(100) not null,
constraint PK_Vac primary key (CodVacuna)
 );

Create table AplicaVacunas
 (
    CodMascota   char(10) not null,
CodVacuna char(10) not null,
FechaVacuna  date not null,
constraint PK_AV primary key (CodMascota, CodVacuna),
constraint FK_AVM foreign key (CodMascota) references Mascotas,
constraint FK_AVV foreign key (CodVacuna) references Vacunas
 );

/**/
insert into Clientes (codigocli, apellidofam, CuentaBancaria, Direccion, TelefonoFijo, TelefonoCel)
values ('A', 'Eguez', '1051-2200', 'El Remanso', '3444058', '78528705');
insert into Clientes values ('B', 'Sin Miedo', '44-77-5888', 'Barrio Bravo', '3525154', '71041523');
insert into Clientes values ('C', 'Mendoza', '2550-444-7415', 'Zona Norte', '3547484', '75052531');

insert into personas values ('92929292', 'Otro', 'Eguez', 'Terrazas', '70819650');
insert into personas values ('1', 'Juan', 'Sin', 'miedo', '77766655');
insert into personas values ('2', 'Pedro', 'Sin', 'miedo', '77766644');
insert into personas values ('3', 'Maria', 'Sin', 'miedo', '77766633');
insert into personas values ('4', 'Teresa', 'Mendoza', 'Palenque', '78866655');
insert into personas values ('5', 'Jaime', 'Mendoza', 'Tarradelles', '78844655');
insert into personas values ('92113281', 'Carlos', 'Eguez', 'Terrazas', '78528705');
insert into personas values ('6', 'Zacarias', 'Mendosa', 'Palenque', '78866655');
insert into personas values ('7', 'Jacinto', 'Mendosza', 'Palenque', '78866655');


insert into PersonaCliente values ('A', '1', '2021-09-30');
insert into PersonaCliente values ('A', '92113281', '2021-03-31');
insert into PersonaCliente values ('B', '2', '2021-03-31');
insert into PersonaCliente values ('B', '3', '2021-03-31');
insert into PersonaCliente values ('C', '4', '2021-03-31');
insert into PersonaCliente values ('C', '5', '2021-03-31');
insert into PersonaCliente values ('C', '6', '2021-03-31');
insert into PersonaCliente values ('C', '7', '2021-03-31');

insert into Mascotas
values('M1', 'Bato', 'Felino', 'gato de techo', 'gris rayado', '2020-01-01', '3', 'A');
insert into Mascotas
values('M2', 'Odin', 'Canino', 'salchicha', 'rojo caramelo', '2010-01-01', '7', 'A');
insert into Mascotas
values('M3', 'Satan', 'Canino', 'doberman', 'negro', '2011-05-01', '37', 'B');
insert into Mascotas
values('M4', 'Jamon', 'cerdo', 'castilla', 'blanco', '2019-01-01', '44', 'C');
insert into Mascotas
values('M5', 'Mefisto', 'Canino', 'rotweiler', 'negro', '2015-05-01', '25', 'B');

insert into vacunas values ('V1', 'Moquillex', 'Moquillo');
insert into vacunas values ('V2', 'AntiX', 'X-medad');

insert into AplicaVacunas values ('M1', 'V1', '2021-09-30');
insert into AplicaVacunas values ('M2', 'V1', '2021-09-30');
insert into AplicaVacunas values ('M2', 'V2', '2021-09-30');

insert into HistoricoPeso values ('M1', '2021-09-30', 5);
insert into HistoriaClinica values ('M1', '2021-09-30', 'Sarna', 'Talco antisarna', 100);

/* - Consultar contenido de una tabla*/
select * from Clientes, Mascotas;




/*Consultar contenido de una tabla*/
select * from Clientes, Mascotas;

/* Consutlar datos combinando dos tablas con producto cartesiano (Cliente y mascota)*/
select * from Clientes, Mascotas where Clientes.CodigoCli = Mascotas.CodCliente

/*Consutlar datos combinando dos tablas con producto cartesiano (Cliente y mascota) seleccionado solo algunos campos*/
select * from Clientes inner join mascotas on Clientes.CodigoCli = Mascotas.CodCliente

/* Consulta para listar los clientes y las personas asociadas a el (con producto cartesiano y con operación de conjunto (join))*/
select CodCliente, ApellidoFam, TelefonoFijo, CodMascota, Alias, Especie
from clientes inner join mascotas on Clientes.CodigoCli = Mascotas.CodCliente

/*Consulta para listar los clientes y las personas asociadas a el (con producto cartesiano y con operación de conjunto (join))
filtrando por nombres y apellidos (completos y subcadenas)*/
select Clientes.CodigoCli, ApellidoFam, TelefonoFijo, personas.CI, Nombre, ApellidoP, ApellidoM from Clientes
inner join PersonaCliente on Clientes.CodigoCli = PersonaCliente.CodigoCli
inner join Personas on Personas.CI = PersonaCliente.CI

/* OTRA FORMA*/

select Clientes.CodigoCli, ApellidoFam, TelefonoFijo, personas.CI, (Nombre || ' ' || ApellidoP || ' ' || ApellidoM)
 as NombreCompleto from Clientes
inner join PersonaCliente on Clientes.CodigoCli = PersonaCliente.CodigoCli
inner join Personas on Personas.CI = PersonaCliente.CI

/* Contar la cantidad de personas asociadas a un cliente
/* Contar la cantidad de personas asociadas a un cliente filtrando por apellido (completo y subcadenas)
/* Consulta para alcular el peso total y el peso promedio de las mascotas
/* Consulta para identificar que personas pueden llevar a una mascota*/
