create DATABASE BDASIN


CREATE TABLE concesionaria (
  NITCS varchar (10) NOT NULL,
  NombreCS char(40) Not NULL,
  DireccionCS char(40) NOT NULL,
  TelefonoCS decimal(8,0) NOT NULL,
  CONSTRAINT PK_conce PRIMARY KEY (NITCS)
);
insert into concesionaria values ('45456','Ricardo Automotors','Villa Fatima 23', '7345789');
 select * from concesionaria;
