-- Crear el esquema "empresa"
create schema empresa;

-- Crear la tabla "vehiculo"
create table empresa.vehiculo (
    id_vehiculo serial primary key,
    matricula varchar(10) not null,
    id_marca int not null,
    id_modelo int not null,
    fecha_compra date not null,
    id_color int not null,
    n_poliza varchar(20) null,
    kilometros_totales int null
);

-- Crear la tabla "grupo_empresarial"
create table empresa.grupo_empresarial (
    id_grupo_empresarial serial primary key,
    nombre_grupo varchar(50) not null
);

-- Crear la tabla "marcas"
create table empresa.marcas (
    id_marca serial primary key,
    nombre_marca varchar (50) not null,
    id_grupo_empresarial int not null
);

-- Crear la tabla "modelos"
create table empresa.modelos (
    id_modelo serial primary key,
    nombre_modelo varchar (50) not null,
    id_marca int not null
);

-- Crear la tabla "aseguradora"
create table empresa.aseguradora (
    id_aseguradora serial primary key,
    nombre_aseguradora varchar(50) not null
);

-- Crear la tabla "seguro"
create table empresa.seguro (
    n_poliza varchar(10) primary key not null,
    id_aseguradora int not null,
    fecha_alta_seguro date not null,
    fecha_baja_seguro date not null
);

-- Crear la tabla "color"
create table empresa.color (
	id_color serial primary key,
	nombre_color varchar(15) not null

);


-- Crear la tabla "revisiones"
create table empresa.revisiones (
    id_revision serial primary key,
    importe_revision float not null,
    moneda varchar(10) not null,
    kilometros_revision int not null,
    id_vehiculo int not null
);

-- Agregar CONSTRAINTS a la tabla VEHICULO
alter table empresa.vehiculo add constraint pk_vehiculo_marcas foreign key(id_marca) references empresa.marcas(id_marca);
alter table empresa.vehiculo add constraint pk_vehiculo_modelos foreign key(id_modelo) references empresa.modelos(id_modelo);
alter table empresa.vehiculo add constraint pk_vehiculo_seguro foreign key(n_poliza) references empresa.seguro(n_poliza);
alter table empresa.revisiones add constraint pk_revisiones_vehiculo foreign key(id_vehiculo) references empresa.vehiculo(id_vehiculo);
alter table empresa.vehiculo add constraint pk_vehiculo_color foreign key(id_color) references empresa.color(id_color);
-- Agregar CONSTRAINTS a la tabla MARCAS
alter table empresa.marcas add constraint pk_marcas_grupo_empresarial foreign key(id_grupo_empresarial) references empresa.grupo_empresarial(id_grupo_empresarial);

-- Agregar CONSTRAINTS a la tabla MODELOS
alter table empresa.modelos add constraint pk_modelos_marcas foreign key(id_marca) references empresa.marcas(id_marca);

-- Agregar CONSTRAINTS a la tabla SEGURO
alter table empresa.seguro add constraint pk_seguro_aseguradora foreign key(id_aseguradora) references empresa.aseguradora(id_aseguradora);

INSERT INTO empresa.color (nombre_color)
values
	('Rojo'),
	('Azul'),
	('Verde');

-- INSERTAR VALORES A LA TABLA EMPRESA.GRUPO_EMPRESARIAL

INSERT INTO empresa.grupo_empresarial (nombre_grupo)
VALUES 
   ('Volkswagen Group'),
   ('Renault-Nissan-Mitsubishi Alliance'),
   ('Toyota Group'),
   ('General Motors (GM)'),
   ('Ford Motor Company');

-- INSERTAR VALORES A LA TABLA EMPRESA.MARCAS
INSERT INTO empresa.marcas (nombre_marca, id_grupo_empresarial)
VALUES 
   ('Volkswagen', 1),
   ('BMW', 2),
   ('Renault', 3),
   ('Peugeot', 4),
   ('Mercedes-Benz', 5);

-- INSERTAR VALORES A LA TABLA EMPRESA.MODELOS
INSERT INTO empresa.modelos (nombre_modelo, id_marca)
VALUES 
   ('Golf', 1),
   ('3 Series', 2),
   ('Clio', 3),
   ('208', 4),
   ('C-Class', 5);
  
  -- INSERTAR VALORES A LA TABLA EMPRESA.ASEGURADORA
INSERT INTO empresa.aseguradora (nombre_aseguradora)
VALUES 
   ('Allianz'),
   ('AXA'),
   ('Generali'),
   ('Mapfre'),
   ('Zurich');

-- INSERTAR VALORES A LA TABLA EMPRESA.SEGURO
INSERT INTO empresa.seguro (n_poliza, id_aseguradora, fecha_alta_seguro, fecha_baja_seguro)
VALUES 
   ('POL001', 1, '2023-09-10', '2023-09-20'),
   ('POL002', 2, '2023-09-11', '2023-09-21'),
   ('POL003', 3, '2023-09-12', '2023-09-22'),
   ('POL004', 4, '2023-09-13', '2023-09-23'),
   ('POL005', 5, '2023-09-14', '2023-09-24');


INSERT INTO empresa.vehiculo (matricula, id_marca, id_modelo, fecha_compra, id_color, n_poliza, kilometros_totales)
VALUES 
   ('ABC123', 1, 1, '2023-09-10', 1, 'POL001', 10000),
   ('DEF456', 2, 2, '2023-09-11', 2, 'POL002', 20000),
   ('GHI789', 3, 3, '2023-09-12', 3, 'POL003', 15000),
   ('XYZ789', 1, 1, '2023-09-10', 1, 'POL001', 8000),
   ('LMN012', 2, 3, '2023-09-11', 2, 'POL003', 15000);
  
  INSERT INTO empresa.revisiones (importe_revision, moneda, kilometros_revision, id_vehiculo)
VALUES 
   (120.0, 'EUR', 9000, 1),
   (95.0, 'USD', 4500, 2),
   (180.0, 'GBP', 7000, 3),
   (140.0, 'EUR', 6000, 4),
   (110.0, 'USD', 5500, 5);

--CONSULTAS
  --Nombre modelo,marca,grupo_empresarial 
  select empresa.modelos.nombre_modelo,empresa.marcas.nombre_marca,empresa.grupo_empresarial.nombre_grupo,empresa.vehiculo.fecha_compra,empresa.vehiculo.matricula,empresa.color.nombre_color,empresa.vehiculo.kilometros_totales,empresa.aseguradora.nombre_aseguradora,empresa.seguro.n_poliza  from empresa.vehiculo
  inner join empresa.modelos on empresa.modelos.id_modelo = empresa.vehiculo.id_modelo
  inner join empresa.marcas on empresa.marcas.id_marca = empresa.vehiculo.id_marca
  inner join empresa.grupo_empresarial on empresa.grupo_empresarial.id_grupo_empresarial  = empresa.marcas.id_grupo_empresarial
  inner join empresa.color on empresa.color.id_color = empresa.vehiculo.id_color
  inner join empresa.seguro on empresa.seguro.n_poliza = empresa.vehiculo.n_poliza
  inner join empresa.aseguradora on empresa.aseguradora.id_aseguradora = empresa.seguro.id_aseguradora 


