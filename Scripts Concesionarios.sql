create database Concesionarios

CREATE TABLE Concesionarios(
	NIT nchar(15) NOT NULL,
	Nombre varchar(50) NOT NULL,
	Direccion varchar(50) NOT NULL,
 CONSTRAINT PK_Concesionario PRIMARY KEY (NIT)
)

CREATE TABLE ServicioOf(
	NIT nchar(15) NOT NULL,
	Nombre varchar(50) NOT NULL,
	Direccion varchar(50) NOT NULL,
	NIT_CON nchar(15) NOT NULL,
 CONSTRAINT PK_ServicioOf PRIMARY KEY (NIT), 
 CONSTRAINT FK_ServicioOf_Concesionarios FOREIGN KEY(NIT_CON) REFERENCES Concesionarios (NIT)
)

CREATE TABLE Modelos(
	CodModelo char(10) NOT NULL,
	Modelo varchar(30) NOT NULL,
	Marca char(20) NOT NULL,
	Precio money NOT NULL,
	Descuento int NOT NULL,
	Potencia nchar(10) NOT NULL,
	Cilindrada nchar(10) NOT NULL,
	NumPuertas nchar(2) NOT NULL,
	Traccion char(10) NOT NULL,
	NIT nchar(15) NOT NULL,
 CONSTRAINT PK_Modelos PRIMARY KEY (CodModelo),
 CONSTRAINT FK_Modelos_Concesionarios FOREIGN KEY(NIT) REFERENCES Concesionarios
)

CREATE TABLE Equipamiento(
	CodEquipo char(20) NOT NULL,
	Descripcion varchar(50) NOT NULL,
	Precio money NOT NULL,
 CONSTRAINT PK_Equipamiento PRIMARY KEY (CodEquipo)
) 

CREATE TABLE Vendedores(
	CI nchar(10) NOT NULL,
	Domicilio varchar(60) NOT NULL,
	Nombre varchar(50) NOT NULL,
	Telefono nchar(10) NOT NULL,
	NIT nchar(15) NULL,
 CONSTRAINT PK_Vendedores PRIMARY KEY (CI),
 CONSTRAINT FK_Vendedores_Concesionarios FOREIGN KEY(NIT) REFERENCES Concesionarios,
 CONSTRAINT FK_Vendedores_ServicioOf FOREIGN KEY(NIT) REFERENCES ServicioOf 
)

CREATE TABLE Automoviles(
	NroChasis nchar(20) NOT NULL,
	Color char(20) NOT NULL,
	CodModelo char(10) NOT NULL,
	NIT nchar(15) NOT NULL,
 CONSTRAINT PK_Automoviles PRIMARY KEY (NroChasis),
 CONSTRAINT FK_Automoviles_Concesionarios FOREIGN KEY(NIT) REFERENCES Concesionarios,
 CONSTRAINT FK_Automoviles_Modelos FOREIGN KEY(CodModelo) REFERENCES Modelos,
 CONSTRAINT FK_Automoviles_ServicioOf FOREIGN KEY(NIT) REFERENCES ServicioOf
 /*ojo con el error de apuntar las dos FK a NIT*/
)

CREATE TABLE ModeloEquipo(
	CodModelo char(10) NOT NULL,
	CodEquipo char(20) NOT NULL,
	DeSerie char(1) NOT NULL,
 CONSTRAINT PK_ModeloEquipo PRIMARY KEY (CodModelo, CodEquipo),
 CONSTRAINT FK_ModeloEquipo_Equipamiento FOREIGN KEY(CodEquipo) REFERENCES Equipamiento (CodEquipo),
 CONSTRAINT FK_ModeloEquipo_Modelos FOREIGN KEY(CodModelo) REFERENCES Modelos (CodModelo)
)

CREATE TABLE Ventas(
	NroFactura nchar(10) NOT NULL,
	FechaVenta date NOT NULL,
	Precio money NOT NULL,
	ModoPago char(10) NOT NULL,
	NombreCliente varchar(50) NOT NULL,
	NitCliente nchar(10) NULL,
	FechaEntrega date NOT NULL,
	Placa char(10) NOT NULL,
	DeStock char(1) NOT NULL,
	CI nchar(10) NOT NULL,
	NroChasis nchar(20) NOT NULL,
 CONSTRAINT PK_Ventas PRIMARY KEY (NroFactura),
 CONSTRAINT FK_Ventas_Automoviles FOREIGN KEY(NroChasis) REFERENCES Automoviles,
 CONSTRAINT FK_Ventas_Vendedores FOREIGN KEY(CI) REFERENCES Vendedores
)

CREATE TABLE IncluyeEq(
	NroChasis nchar(20) NOT NULL,
	CodEquipo char(20) NOT NULL,
 CONSTRAINT PK_IncluyeEq PRIMARY KEY (NroChasis, CodEquipo),
 CONSTRAINT FK_IncluyeEq_Automoviles FOREIGN KEY(NroChasis) REFERENCES Automoviles,
 CONSTRAINT FK_IncluyeEq_Equipamiento FOREIGN KEY(CodEquipo) REFERENCES Equipamiento
)



/*Modificaciones de llaves en tablas existentes*/
alter table ModeloEquipo drop constraint FK_ModeloEquipo_Equipamiento
alter table ModeloEquipo drop constraint PK_ModeloEquipo 
alter table IncluyeEq drop constraint FK_IncluyeEq_Equipamiento
alter table IncluyeEq drop constraint PK_IncluyeEq
alter table Equipamiento drop constraint PK_Equipamiento

alter table Equipamiento alter column CodEquipo char(25) not null
alter table ModeloEquipo  alter column CodEquipo char(25) not null
alter table IncluyeEq alter column CodEquipo char(25) not null

alter table Equipamiento add CONSTRAINT PK_Equipamiento PRIMARY KEY (CodEquipo)
alter table ModeloEquipo add CONSTRAINT PK_ModeloEquipo PRIMARY KEY (CodModelo, CodEquipo)
alter table ModeloEquipo add CONSTRAINT FK_ModeloEquipo_Equipamiento FOREIGN KEY(CodEquipo) REFERENCES Equipamiento (CodEquipo)
alter table IncluyeEq add CONSTRAINT PK_IncluyeEq PRIMARY KEY (NroChasis, CodEquipo)
alter table IncluyeEq add CONSTRAINT FK_IncluyeEq_Equipamiento FOREIGN KEY(CodEquipo) REFERENCES Equipamiento


/* corregir falencia de doble referencia en vendedores*/

CREATE TABLE Vendedores(
	CI nchar(10) NOT NULL,
	Domicilio varchar(60) NOT NULL,
	Nombre varchar(50) NOT NULL,
	Telefono nchar(10) NOT NULL,
	NIT nchar(15) NULL,
 CONSTRAINT PK_Vendedores PRIMARY KEY (CI),
 CONSTRAINT FK_Vendedores_Concesionarios FOREIGN KEY(NIT) REFERENCES Concesionarios,
 CONSTRAINT FK_Vendedores_ServicioOf FOREIGN KEY(NIT) REFERENCES ServicioOf 
)

alter table vendedores drop constraint FK_Vendedores_Concesionarios
alter table vendedores drop constraint FK_Vendedores_ServicioOf 
alter table vendedores add nit_so nchar(15) NULL
alter table vendedores  add CONSTRAINT FK_Vendedores_Concesionarios FOREIGN KEY(NIT) REFERENCES Concesionarios
alter table vendedores  add CONSTRAINT FK_Vendedores_ServicioOf FOREIGN KEY(NIT_SO) REFERENCES ServicioOf(NIT)
alter table vendedores add default '0000' for NIT
alter table vendedores add default '0000' for NIT_SO

alter table vendedores alter column nit_so nchar(15) not NULL

/*
entorno desarrollo  ---> entorno de pruebas o calidad ---> entorno de produccion

*/
 
 declare @fechahoy date
 set @fechahoy=getdate()
 select @fechahoy
 Select CONVERT(varchar,@fechahoy,0) 
 Select CONVERT(varchar,@fechahoy,1) 
 Select CONVERT(varchar,@fechahoy,2)
 Select CONVERT(varchar,@fechahoy,6)
 Select CONVERT(varchar,@fechahoy,7)


/********* Consultas*********/
/*
- Consulta que nos liste las ventas realizadas, incluyendo oficina de ventas,
   vendedor, veh�culo, accesorios, precio
- Listado de modelos y sus accesorios de f�brica
- Listado de modelos y sus accesorios opcionales
- Listado de los veh�culos en stock por oficina
- listado de ventas por vendedor
- listado de los servicios oficiales que trabajan con un concesionario
- Listado de monto de ventas totales
- Listado de monto de ventas por oficina
- Listado de monto de ventas por tipo de pago
- Listado de las placas entregas y el veh�culo al que corresponde
*/


/*- Listado de las placas entregas y el veh�culo al que corresponde*/
select placa, marca, modelo, Color, ventas.NroChasis  from Ventas
    inner join Automoviles on Automoviles.NroChasis = Ventas.NroChasis
	inner join modelos on Modelos.CodModelo = Automoviles.CodModelo



/*- Listado de monto de ventas totales*/
select count(ventas.CI) as CantVentas, sum(Ventas.Precio) as TotalVentas  from Ventas

/*- Listado de monto de ventas por oficina*/
select Concesionarios.NIT, Concesionarios.Nombre, count(Concesionarios.NIT) as CantVentas, sum(Ventas.Precio) as TotalVentas  from Ventas
    inner join Vendedores on Vendedores.CI = Ventas.CI
    inner join Concesionarios on Concesionarios.NIT = Vendedores.nit  
	group by Concesionarios.NIT, Concesionarios.Nombre
union
select ServicioOf.NIT, ServicioOf.Nombre, count(ServicioOf.NIT) as CantVentas, sum(Ventas.Precio) as TotalVentas  from Ventas
    inner join Vendedores on Vendedores.CI = Ventas.CI
    inner join ServicioOf on ServicioOf.NIT = Vendedores.nit  
	group by ServicioOf.NIT, ServicioOf.Nombre


/*- Listado de monto de ventas por tipo de pago*/
select Ventas.ModoPago,count(ventas.CI) as CantVentas, sum(Ventas.Precio) as TotalVentas  from Ventas
    group by Ventas.ModoPago

/*- listado de los servicios oficiales que trabajan con un concesionario*/
select concesionarios.NIT as NIT_Concesionario, concesionarios.Nombre as Concesionario, ServicioOf.NIT as NIT_SO, ServicioOf.Nombre as ServicioOficial, ServicioOf.Direccion from Concesionarios
  inner join ServicioOf on ServicioOf.NIT_CON = Concesionarios.NIT

/*- listado de los servicios oficiales que trabajan con un concesionarioincluyendo parametro */
declare @nitparam nchar(15)
set @nitparam = '20105252'
select concesionarios.NIT as NIT_Concesionario, concesionarios.Nombre as Concesionario, ServicioOf.NIT as NIT_SO, ServicioOf.Nombre as ServicioOficial, ServicioOf.Direccion from Concesionarios
  inner join ServicioOf on ServicioOf.NIT_CON = Concesionarios.NIT
  where Concesionarios.NIT like @nitparam


/*- listado de ventas por vendedor*/
select vendedores.CI, vendedores.Nombre, ventas.NroFactura, ventas.FechaVenta, modelos.Precio as PrecioLista, Ventas.Precio as PrecioVenta, ventas.NombreCliente, 
       marca, modelo, automoviles.NroChasis, Color from Ventas
 inner join Vendedores on Ventas.CI = Vendedores.CI
 inner join Automoviles on Automoviles.NroChasis = Ventas.NroChasis
 inner join Modelos on Modelos.CodModelo = Automoviles.CodModelo
 
/*- total de ventas por vendedor*/
select vendedores.CI, vendedores.Nombre, count(ventas.CI) as CantVentas, sum(Ventas.Precio) as TotalVentas  from Ventas
    inner join Vendedores on Ventas.CI = Vendedores.CI
	group by vendedores.CI, Vendedores.Nombre

/*- Listado de los veh�culos en stock por oficina*/
select marca, Modelo, NroChasis, Color, concesionarios.NIT, nombre from Automoviles
 inner join Modelos on Modelos.CodModelo = Automoviles.CodModelo
 inner join Concesionarios on concesionarios.NIT = Automoviles.NIT
  
/*- Listado de modelos y sus accesorios de f�brica*/
select modelos.CodModelo, marca, Modelo, ModeloEquipo.CodEquipo, Equipamiento.Descripcion from Modelos
    inner join ModeloEquipo on ModeloEquipo.CodModelo = Modelos.CodModelo
	inner join Equipamiento on Equipamiento.CodEquipo = ModeloEquipo.CodEquipo
	where DeSerie = 'T'

/*- Listado de modelos y sus accesorios opcionales*/
select modelos.CodModelo, marca, Modelo, ModeloEquipo.CodEquipo, Equipamiento.Descripcion from Modelos
    inner join ModeloEquipo on ModeloEquipo.CodModelo = Modelos.CodModelo
	inner join Equipamiento on Equipamiento.CodEquipo = ModeloEquipo.CodEquipo
	where DeSerie = 'F'

/*
- Consulta que nos liste las ventas realizadas, incluyendo oficina de ventas,
   vendedor, veh�culo, accesorios, precio*/
select vendedores.CI, vendedores.Nombre, concesionarios.Nombre as PuntoDeVenta, ventas.NroFactura, ventas.FechaVenta, modelos.Precio as PrecioLista, Ventas.Precio as PrecioVenta, ventas.NombreCliente, 
       marca, modelo, automoviles.NroChasis, Color, Descripcion as Accesorio, Equipamiento.Precio as PrecioAccesorio from Ventas
 inner join Vendedores on Ventas.CI = Vendedores.CI
 inner join Automoviles on Automoviles.NroChasis = Ventas.NroChasis
 inner join Concesionarios on vendedores.NIT = Concesionarios.NIT
 inner join Modelos on Modelos.CodModelo = Automoviles.CodModelo
 inner join IncluyeEq on IncluyeEq.NroChasis = Automoviles.NroChasis
 inner join Equipamiento on Equipamiento.CodEquipo = IncluyeEq.CodEquipo
 where Vendedores.NIT <> '0000'
 union
select vendedores.CI, vendedores.Nombre, ServicioOf.Nombre as PuntoDeVenta, ventas.NroFactura, ventas.FechaVenta, modelos.Precio as PrecioLista, Ventas.Precio as PrecioVenta, ventas.NombreCliente, 
       marca, modelo, automoviles.NroChasis, Color, Descripcion as Accesorio, Equipamiento.Precio as PrecioAccesorio from Ventas
 inner join Vendedores on Ventas.CI = Vendedores.CI
 inner join Automoviles on Automoviles.NroChasis = Ventas.NroChasis
 inner join ServicioOf on vendedores.nit_so = ServicioOf.NIT
 inner join Modelos on Modelos.CodModelo = Automoviles.CodModelo
 inner join IncluyeEq on IncluyeEq.NroChasis = Automoviles.NroChasis
 inner join Equipamiento on Equipamiento.CodEquipo = IncluyeEq.CodEquipo
 where Vendedores.nit_so <> '0000'

  select vendedores.CI, vendedores.Nombre, ServicioOf.Nombre as PuntoDeVenta, ventas.NroFactura, ventas.FechaVenta, modelos.Precio as PrecioLista, Ventas.Precio as PrecioVenta, ventas.NombreCliente, 
       marca, modelo, automoviles.NroChasis, Color, Descripcion as Accesorio, Equipamiento.Precio as PrecioAccesorio 
	   from Ventas, Vendedores, Automoviles, ServicioOf, Modelos, IncluyeEq, Equipamiento
	   where  Ventas.CI = Vendedores.CI and
  Automoviles.NroChasis = Ventas.NroChasis and
  vendedores.nit_so = ServicioOf.NIT and
  Modelos.CodModelo = Automoviles.CodModelo and
  IncluyeEq.NroChasis = Automoviles.NroChasis and
  Equipamiento.CodEquipo = IncluyeEq.CodEquipo and
  Vendedores.nit_so <> '0000'


