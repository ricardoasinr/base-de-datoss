CREATE TABLE concesionaria (
  NITCS varchar (10) NOT NULL,
  NombreCS char(40) Not NULL,
  DireccionCS char(40) NOT NULL,
  TelefonoCS decimal(8,0) NOT NULL,
  CONSTRAINT PK_conce PRIMARY KEY (NITCS)
);

CREATE TABLE modelo (
  codmodelo varchar(20) NOT NULL,
  marca varchar(20) NOT NULL,
  NroPuertas int NOT NULL,
  cilindradas int NOT NULL,
  NroRuedas INT NOT NULL,
  Procedencia varchar(100) NOT NULL,
  CodPasajeros INT NOT NULL,
  CONSTRAINT PK_modelo PRIMARY KEY (codmodelo)
);

CREATE TABLE equipo (
  codequipo decimal(10,0) NOT NULL,
  descripcion varchar(40) not NULL,
  precio decimal(10,2) not NULL,
  CONSTRAINT PK_equipo PRIMARY KEY (codequipo)
);

CREATE TABLE tipoequipo (
  Codmodelo varchar(20) NOT NULL,
  Codequipo decimal(10,0) NOT NULL,
  Tipoequipo varchar(50) NOT NULL,
  constraint pk_Tipo primary key (codmodelo, codequipo),
  constraint fk_Tipo_Modelo foreign key (codmodelo) references modelo (codmodelo),
  constraint fk_Tipo_Equipo foreign key (codequipo) references equipo (codequipo)
);

create TABLE automovil (
  NroChasis int NOT NULL,
  NITCS varchar (10) NOT NULL,
  CodModelo varchar(20) not NULL,
  Color varchar(15) NOT NULL,
  FechaFabricacion date NOT NULL,
  LugarFabricacion varchar(30) not NULL,
  Descuento int NOT NULL,
  CONSTRAINT PK_chasis PRIMARY KEY (NroChasis),
  CONSTRAINT FK_conce FOREIGN KEY (nitcs) REFERENCES concesionaria,
  CONSTRAINT FK_modelo FOREIGN KEY (codmodelo) REFERENCES modelo
);

CREATE TABLE serie(
  codequipo decimal(10,0) NOT NULL,
  nrochasis int not NULL,
  NroSerie varchar(25) not NULL,
  CONSTRAINT PK_serie PRIMARY KEY (codequipo, nrochasis),
  CONSTRAINT FK_seriequipo FOREIGN KEY (codequipo) REFERENCES equipo (codequipo),
  CONSTRAINT FK_autoequipo FOREIGN KEY (nrochasis) REFERENCES automovil (nrochasis)
);

CREATE TABLE serviciosof (
  NITSO varchar (10) not null,
  NITCS varchar (10) not null,
  NombreSO varchar (50) not null,
  DireccionSO varchar (50) not null,
  TelefonoSO varchar (30) not null,
  constraint PK_ServOficial primary key (NITSO),
  constraint FK_ServOf_Conce foreign key (nitcs) references concesionaria (nitcs)
);

CREATE TABLE vendedor (
  CodVendedor varchar (10) not null,
  nitcs varchar (10) not null,
  nitso varchar (10) not null,
  NombreV varchar (50) not null,
  TelefonoV varchar (30) not null,
  Email varchar (50) not null,
  constraint PK_Vendedor primary key (codvendedor),
  constraint FK_Vendedor_Concesionaria foreign key (nitcs) references concesionaria (nitcs),
  constraint FK_Vendedor_ServOficial foreign key (nitso) references serviciosof (nitso)
);

CREATE TABLE venta (
  Factura decimal(10,0) NOT NULL,
  codvendedor varchar (10) not null,
  Fecha date NOT NULL,
  Lugar varchar(50) NOT NULL,
  CostoVenta decimal(10,2) not NULL,
  MetodoDePago varchar(10) NOT NULL,
  CONSTRAINT PK_venta PRIMARY KEY (Factura),
  CONSTRAINT FK_vendedor FOREIGN KEY (codvendedor) REFERENCES vendedor (codvendedor)
);


 insert into concesionaria values ('45456','Ricardo Automotors','Villa Fatima 23', '7345789');
 insert into concesionaria values ('45633','Ricardo Automotors','Villa Guadalupe 27', '7344789');
 insert into concesionaria values ('34566','Ricardo Automotors','Villa Mercedes 22', '7564322');
 insert into serviciosof values ('2222','45456','Monica','Villa Alameda 23', '74522536');
 insert into serviciosof values ('2223','45633','Ricardo','Villa Alameda 22', '74522566');
 insert into serviciosof values ('2224','34566','Fernando','Villa Alameda 53', '74522567');
 insert into modelo values ('12345','Mazda','5','36000','5','Japon', '45456');
 insert into modelo values ('12344','Nissan','5','18000','5','Japon', '23432');
 insert into modelo values ('12346','Toyota','5','36000','5','Japon', '67544');
 insert into equipo values ('678','Android auto','300');
 insert into equipo values ('787','Android auto','300');
 insert into equipo values ('797','Android auto','300');


 insert into tipoequipo values ('12345','678','Farol');

 insert into vendedor values ('555','45456','2222','Jose Mario Santa Cruz','76363458','marito2010@hotmail.com');
 insert into vendedor values ('554','45633','2223','Marcelo Davila','76564333','marcelito2010@hotmail.com');
 insert into vendedor values ('556','34566','2224','Franklin Romero','76854677','franklincito2010@hotmail.com');

 insert into automovil values ('1111','45456','12345','blanco','20190318','Japon','20');
 insert into automovil values ('12342','45633','12344','rojo','20190418','Japon','15');
 insert into automovil values ('9878','34566','12346','negro','20190518','Japon','5');

 insert into serie values ('678','1111','5411');
 insert into venta values ('3333','555','20190507','Bolivia','20000','Trans');
 insert into venta values ('3334','123','20190507','Bolivia','2500','Trans');

alter table automovil add Estado varchar(10)

update automovil set Estado = 'En Stock' where NroChasis = '1111'
update automovil set Estado = 'En Stock' where NroChasis = '9878'
update automovil set Estado = 'Vendido' where NroChasis = '12342'

select * from vendedor;
select * from concesionaria;
select * from serviciosof;
select * from modelo;
select * from equipo;
select * from tipoequipo;
select * from vendedor;
select * from automovil;
select * from serie;
select * from venta;

select Estado from automovil


alter table venta add CONSTRAINT FK_Vendedores_Concesionarios FOREIGN KEY(CodVendedor) REFERENCES vendedor

create function ListaVendedores()
RETURNS SETOF vendedor as $$

        select * from vendedor;


$$
    language sql;

drop procedure ListaVendedores();
select * from ListaVendedores();

create function verVendedor ()
RETURNS SETOF vendedor as $$

        select * from vendedor;


$$
    language sql;



/**/