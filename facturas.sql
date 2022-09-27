use master;
drop database if EXISTS FACTURAS ;
GO
-- Creacón base de datos
create database FACTURAS;
GO

-- Uso de base de datos
use FACTURAS;

-- -- ||||| Encargados Tablas |||| 

-- Daniel = D    Sebas = S    Kevin = K    Nico = N

---------------------------------
-- ||||   DICCIONARIO   ||||
--		CL	= CLIENTE
--		PR	= PROVEEDOR
--		E	= EMPLEADO
--		P	= PRODUCTO
--		CT	= CATEGORIA
--		V	= VENTA
--		C	= COMPRA
---------------------------------
GO


-- -- ||||| Creacion Tablas |||| 

create table EMPLEADO (
	-- Primary key 
	id_empleado int primary key IDENTITY(1,1),
	-- Atributos 
	nombre_E varchar(20) not null,
	apellido_E varchar(100) not null,
	telefono_E varchar(20) not null,
	correo_E varchar(100) not null,
	contraseña_E varchar(100) not null,
	direccion_E varchar(150) not null
);

-- D
GO
create table CATEGORIA (
	-- Primary key
	id_categ int primary key IDENTITY(1,1),
	-- Atributos base
	nom_CT varchar (20) not null,
	descripcion_CT varchar (100) not null 

);

-- K
GO
create table PRODUCTO (
	-- Primary Key
	cod_P int primary key IDENTITY(1,1),
	-- Foreign key
	id_categ int not null,
	-- Atributos base
	nom_P varchar(60) not null,
	descripcion_P varchar(300) not null,
	valor float not null,
	stock int not null,
	-- Foreign Key
	foreign key (id_categ) references CATEGORIA(id_categ)
);

-- S
GO
create table  PROVEEDOR (
	-- Primary Key
	id_Provedor int primary key IDENTITY(1,1),
	nom_PR varchar(50) not null,
	descript_PR varchar(300) not null,
	direccion_PR varchar(200) not null,
	correo_PR varchar(50) not null,
	contraseña_PR varchar(100) not null,
	pagina_web_PR varchar(50) null,
);

-- K
GO
create table TELEFONO_PROVEEDOR (
	-- Primary Key
	id_tel int primary key IDENTITY(1,1),
	-- Foreign Key
	id_Provedor int not null,
	-- ATRIBUTOS
	telefono varchar(20) not null,
	-- Vinculo Foreign Key
	foreign key (id_Provedor) references PROVEEDOR(id_Provedor)
);
GO

-- K
create table COMPRA (
	-- Primary Key
	nro_C int primary key IDENTITY(1,1),
	-- Foreign Key
	id_Provedor int not null,
	id_empleado int not null,
	-- Atributos base
	fecha varchar (20) not null,
	total float not null,
	subtotal float not null, 
	iva float not null,
	-- Vinculo Foreign Key
	foreign key (id_Provedor) references PROVEEDOR(id_Provedor),
	foreign key (id_empleado) references EMPLEADO(id_empleado)
);
GO

-- N
create table CLIENTE(
	-- Primary key
	id_CL int primary key IDENTITY(1,1),
	-- Atributo
	nom_CL varchar(20) not null,
	apellido_CL varchar(100) not null,
	telefono_CL varchar(20) not null,
	direccion_CL varchar(150) not null
 ); 
 GO

  -- S
create table VENTA (
	-- Primary key 
	nro_V int  primary key IDENTITY(1,1),
	-- Foreign Key
	id_E int not null ,
	id_CL int  not null,
	-- Atributos
	fecha_V varchar (20) not null,
	iva float not null,
	subtotal float not null,
	total float not null,
	-- Vinculo Foreign Key
	foreign key (id_E) references	EMPLEADO (id_empleado),
	foreign key (id_CL) references CLIENTE (id_CL)
 );
 GO

GO

 -- || TABLAS FUENTE ||
 -- K & D
create table PRODUCTO_COMPRA (
	-- Foreign Key
	cod_P int not null,
	nro_C int not null,
	-- Atributos
	cant int not null,
	costo float not null,
	valor_Total float  not null ,
	-- Vinculo Foreign Key
	foreign key (cod_P) references PRODUCTO (cod_P),
	foreign KEY (nro_C) references COMPRA (nro_C), 	
	-- Primary Key compuesta  
	primary key (cod_P , nro_C)
 );

 -- K Y D 
 GO
 create table PRODUCTO_VENTA (
 	-- Foreign Key
	cod_P int not null,
	nro_V int not null,
	-- Atributos
	valorTotal float not null,
	cant int not null,
	-- Vinculo Foreign Key
	foreign key (cod_P) references PRODUCTO (cod_P),
	foreign key (nro_V) references VENTA (nro_V),
	-- Primary Key compuesta 
	primary key (cod_P, nro_V)
 );
 GO


 -- || INSERCCIÓN DATOS ||
-- K & S
INSERT INTO  CLIENTE (nom_CL, apellido_CL, telefono_CL, direccion_CL) VALUES
					 ('Kevin', 'Garzon', '3107070709', 'calle30 #26-49'	);
GO
INSERT INTO EMPLEADO (nombre_E, apellido_E, telefono_E, correo_E, contraseña_E, direccion_E) VALUES
						('Pepe','Ortega','3107465490','slash123@gmail.com', 'empleado123', 'calle 21#26-45 apto 301 barrio San José');
GO
INSERT INTO CATEGORIA (nom_CT,descripcion_CT) VALUES
						('Electrónicos','Toda una gamma completa de Televisores, Computadores, etc...');
GO
INSERT INTO PRODUCTO (id_categ, nom_P, descripcion_P, valor, stock) VALUES
						(1, 'Televisor Samsung', 'Televisor de 52pg hd ultra 4k', 1000000, 99);
GO
INSERT INTO PROVEEDOR (nom_PR, descript_PR, direccion_PR, correo_PR,contraseña_PR, pagina_web_PR) VALUES
						('Importanciones gomez hermanos', 'Los mejores proovedores de todo el pais', 'calle10a #77-44', 'importancionesgomezhermanos@gmail.com', 'proveedor123', 'www.gomezhermanos.com');
GO
INSERT INTO TELEFONO_PROVEEDOR (id_Provedor, telefono) VALUES
						(1, '3107567654');
GO
INSERT INTO  COMPRA (id_Provedor, id_empleado, fecha, total, subtotal, iva) VALUES
						(1, 1, '2022-10-20', 1630000, 1600000, 30000);
GO
INSERT INTO  PRODUCTO_COMPRA (cod_P, nro_C, cant, costo, valor_Total) VALUES
						(1, 1, 2, 800000, 1600000);
GO
INSERT INTO  VENTA (id_E, id_CL, fecha_V, iva, subtotal, total) VALUES
						(1, 1, '2022-10-10', 30000, 2000000, 2030000);
GO
INSERT INTO  PRODUCTO_VENTA (cod_P, nro_V, valorTotal, cant) VALUES
						(1, 1, 2000000, 2);
GO


 -- || PROCEDIMIENTOS ALMACENADOS ||

-- PROCEDIMIENTOS EMPLEADO (Daniel Alfonso)

CREATE PROCEDURE USP_Registro_Empleado
	@nom_E VARCHAR(20),
	@ape_E VARCHAR(100),
	@tele_E VARCHAR(20),
	@Correo_E VARCHAR(100),
	@contraseña_E varchar(100),
	@direc_E VARCHAR(150)
	as
	BEGIN 
		INSERT INTO EMPLEADO (nombre_E, apellido_E, telefono_E, correo_E, contraseña_E, direccion_E) VALUES
							(@nom_E, @ape_E, @tele_E, @Correo_E, @contraseña_E, @direc_E);
	END
GO

CREATE PROCEDURE USP_Actualizar_Empleado
	@nom_E VARCHAR(20),
	@ape_E VARCHAR(100),
	@tele_E VARCHAR(20),
	@Correo_E VARCHAR(100),
	@constraseña_E VARCHAR(100),
	@direc_E VARCHAR(150)
	AS
	BEGIN
		UPDATE EMPLEADO
		SET nombre_E =@nom_E,
			apellido_E=@ape_E,
			telefono_E=@tele_E,
			correo_E= @Correo_E,
			direccion_E = @direc_E
		WHERE contraseña_E = @constraseña_E	
	END

	GO

-- PROCEDIMIENTOS CATEGORIA (Daniel Alfonso)

CREATE PROCEDURE USP_Registro_Categoria
	@nom_CT VARCHAR(20),
	@descrip_CT VARCHAR(100)
	as
	BEGIN 
		INSERT INTO CATEGORIA(nom_CT , descripcion_CT) VALUES
						 (@nom_CT , @descrip_CT);
	END
GO

CREATE PROCEDURE USP_Actualizar_Categoria
	@id_Cat INT,
	@nom_CT VARCHAR(20),
	@descrip_CT VARCHAR(100)
	AS
	BEGIN
		UPDATE CATEGORIA
		SET nom_CT = @nom_CT,
			descripcion_CT = @descrip_CT
		WHERE 	id_categ = @id_Cat 
	END
GO

CREATE PROCEDURE USP_eliminar_Categoria
	@id_Cat INT
	AS
	BEGIN
	DELETE FROM CATEGORIA
		WHERE id_categ = @id_Cat	
	END
GO


-- PROCEDIMIENTOS PRODUCTOS (Kevin Ortega - Sebastian)
CREATE PROCEDURE USP_Registro_Producto
	@nom_P VARCHAR(60),
	@id_categ int,
	@descripcion_P VARCHAR(300),
	@valor float,
	@stock int
	as
	BEGIN 
		INSERT INTO PRODUCTO (nom_P, id_categ, descripcion_P, valor, stock) VALUES
						 (@nom_P, @id_categ, @descripcion_P, @valor, @stock);
	END
GO

CREATE PROCEDURE USP_Actualizar_Producto
	@cod_P int,
	@nom_p varchar(20),
	@id_categ int,
	@descripcion_P varchar(300),
	@valor float,
	@stock int
	AS
	BEGIN
		UPDATE PRODUCTO
		SET nom_P = @nom_p,
			id_categ =  @id_categ,
			descripcion_P = @descripcion_P,
			valor = @valor,
			stock = @stock
		WHERE 	cod_P = @cod_P 
	END
GO
CREATE PROCEDURE USP_eliminar_Producto
	@cod_P INT
	AS
	BEGIN
	DELETE FROM PRODUCTO
		WHERE cod_P = @cod_P	
	END
GO

-- PROCEDIMIENTOS PROVEEDOR (Kevin Ortega)
CREATE PROCEDURE USP_Registro_Proveedor
	@nom_PR varchar(50),
	@descript_PR varchar(300),
	@direccion_PR varchar(200),
	@correo_PR varchar(50),
	@contraseña_PR varchar(100),
	@pagina_web_PR varchar(50)
	as
	BEGIN 
		INSERT INTO PROVEEDOR(nom_PR, descript_PR, direccion_PR, Correo_PR, contraseña_PR, pagina_web_PR) VALUES
						 (@nom_PR, @descript_PR, @direccion_PR, @correo_PR,@contraseña_PR, @pagina_web_PR);
	END
GO
CREATE PROCEDURE USP_Actualizar_Proveedor
	@id_Provedor int,
	@nom_PR varchar(50),
	@descript_PR varchar(300),
	@direccion_PR varchar(200),
	@correo_PR varchar(50),
	@contraseña_PR varchar(100),
	@pagina_web_PR varchar(50)
	AS
	BEGIN
		UPDATE PROVEEDOR
		SET nom_PR = @nom_PR,
			descript_PR =  @descript_PR,
			direccion_PR = @direccion_PR,
			correo_PR = @correo_PR,
			contraseña_PR = @contraseña_PR ,
			pagina_web_PR = @pagina_web_PR
		WHERE 	id_Provedor = @id_Provedor 
	END
GO

CREATE PROCEDURE USP_eliminar_Proovedor
	@id_Provedor INT
	AS
	BEGIN
	DELETE FROM PROVEEDOR
		WHERE id_Provedor = @id_Provedor	
	END
GO

-- PROCEDIMIENTOS TELEFONO_PROVEEDOR (Kevin Ortega)
CREATE PROCEDURE USP_Registro_Telefono_Proveedor
	@id_Provedor int,
	@telefono varchar(20)
	as
	BEGIN 
		INSERT INTO TELEFONO_PROVEEDOR(id_Provedor, telefono) VALUES
						 (@id_Provedor, @telefono);
	END
GO
CREATE PROCEDURE USP_Actualizar_Telefono_Proveedor
	@id_tel int,
	@id_Provedor int,
	@telefono varchar(20)
	AS
	BEGIN
		UPDATE TELEFONO_PROVEEDOR
		SET id_Provedor = @id_Provedor,
			telefono =  @telefono
		WHERE 	id_tel = @id_tel 
	END
GO

-- PROCEDIMIENTOS COMPRA (Kevin Ortega)
CREATE PROCEDURE USP_Registro_Compra
	@id_Provedor int,
	@id_empleado int,
	@fecha VARCHAR(20),
	@total float,
	@subtotal float,
	@iva float
	as
	BEGIN 
		INSERT INTO COMPRA(id_Provedor, id_empleado, fecha, total, subtotal, iva) VALUES
						 (@id_Provedor, @id_empleado, @fecha, @total, @subtotal, @iva);
	END
GO

-- PROCEDIMIENTOS VENTA (Nicolas Rivera)
CREATE PROCEDURE USP_Registro_Venta
	@id_E int,
	@id_CL int,
	@fecha_V VARCHAR(20),
	@iva float,
	@subtotal float,
	@total float
	as
	BEGIN 
		INSERT INTO VENTA(id_E, id_CL, fecha_V, iva, subtotal, total) VALUES
						 (@id_E, @id_CL, @fecha_V, @iva, @subtotal, @total );
	END
GO

-- PROCEDIMIENTOS PRODUCTO COMPRA (Kevin Ortega)
CREATE PROCEDURE USP_Registro_Compra_Producto
	@cod_P int,
	@nro_C int,
	@cant int,
	@costo float,
	@valor_total float
	as
	BEGIN 
		INSERT INTO PRODUCTO_COMPRA (cod_P, nro_C, cant, costo, valor_total) VALUES
						 (@cod_P, @nro_C, @cant, @costo, @valor_total);
	END
GO

-- PROCEDIMIENTOS PRODUCTO VENTA (Kevin Ortega)
CREATE PROCEDURE USP_Registro_Venta_Producto
	@cod_P int,
	@nro_V int,
	@valorTotal float,
	@cant int
	as
	BEGIN 
		INSERT INTO PRODUCTO_VENTA(cod_P, nro_V, valorTotal, cant) VALUES
						 (@cod_P, @nro_V, @valorTotal, @cant);
	END
GO


-- PROCEDIMIENTOS CLIENTE (Nicolas Rivera - Kevin Ortega)

CREATE PROCEDURE USP_Registro_Cliente
	@nom_CL VARCHAR(20),
	@apellido_CL VARCHAR(100),
	@telefono_CL VARCHAR(20),
	@direccion_CL VARCHAR(20)
	as
	BEGIN 
		INSERT INTO CLIENTE(nom_CL, apellido_CL, telefono_CL, direccion_CL) VALUES
						 (@nom_CL, @apellido_CL, @telefono_CL, @direccion_CL );
	END
GO

CREATE PROCEDURE USP_Actualizar_Cliente 
	@id_Cl int,	
	@nom_CL VARCHAR(20),
	@apellido_CL VARCHAR(100),
	@telefono_CL VARCHAR(20),
	@direccion_CL VARCHAR(20)
	
	AS
	BEGIN
		UPDATE CLIENTE
		SET nom_CL = @nom_CL,
			apellido_CL =  @apellido_CL,
			telefono_CL = @telefono_CL,
			direccion_CL = @direccion_CL
		WHERE 	id_CL = @id_CL 
	END

GO

CREATE PROCEDURE USP_eliminar_Cliente
	@id_CL INT
	AS
	BEGIN
	DELETE FROM CLIENTE
		WHERE id_CL = @id_CL	
	END
GO

-- INICIO SESION EMPLEADO (Kevin Ortega)
CREATE PROCEDURE USP_inicio_sesion_Empleado
	@correo_E varchar(100),
	@contraseña_E varchar(100)

	AS
	BEGIN
	select id_empleado from EMPLEADO where contraseña_E = @contraseña_E and correo_E = @correo_E;
	END
GO

-- INICIO SESION PROVEEDOR (Kevin Ortega)
CREATE PROCEDURE USP_inicio_sesion_Proveedor
	@correo_PR varchar(100),
	@contraseña_PR varchar(100)

	AS
	BEGIN
	select id_Provedor from PROVEEDOR where contraseña_PR = @contraseña_PR and correo_PR = @correo_PR;
	END
GO

 -- || COMBO BOX ||

 -- Combo box Cliente (Daniel)
CREATE PROCEDURE USP_COMBOBOX_CLIENTES
	AS
	BEGIN
		SELECT '0' as id_CL , 'Seleccione cliente' as  nom_CL from  CLIENTE
	union
		SELECT id_CL , nom_CL + ' ' + apellido_CL from CLIENTE order by nom_CL asc;
	END
GO

 -- Combo box Categirua (Kevin - Sebastian)
CREATE PROCEDURE USP_COMBOBOX_CATEGORIA 
	AS
	BEGIN
		SELECT '0' as id_categ , 'Seleccione una categoria' as  nom_CT from  CATEGORIA
	union
		SELECT id_categ , nom_CT  from CATEGORIA order by nom_CT ASC;
	END
GO

 -- Combo box Producto (Kevin - Daniel)
CREATE PROCEDURE USP_COMBOBOX_PRODUCTO
	@id_cate INT 
	AS
	BEGIN
		SELECT '0' as cod_P , 'Seleccione una producto' as  nom_P from  PRODUCTO
	union 
		SELECT p.cod_P , p.nom_P FROM PRODUCTO as p INNER JOIN CATEGORIA as c ON c.id_categ = p.id_categ where c.id_categ = @id_cate
	END
GO


-- || LISTAR ||  (Sebastian)
CREATE PROCEDURE USP_Listar_Productos_Venta
	AS
	BEGIN	
		SELECT p.nom_P ,c.nom_CT , p.valor FROM PRODUCTO as p INNER JOIN CATEGORIA as c ON c.id_categ = p.id_categ ORDER BY c.nom_CT ASC;
	END
GO

CREATE PROCEDURE USP_Listar_Productos_Compra
	AS
	BEGIN	
		SELECT p.nom_P, c.nom_CT, pc.costo FROM PRODUCTO as p INNER JOIN PRODUCTO_COMPRA as pc ON pc.cod_P = p.cod_P INNER JOIN CATEGORIA as c ON c.id_categ = p.id_categ ORDER BY c.nom_CT ASC;
	END
GO

CREATE PROCEDURE USP_Listar_Categoria
	AS
	BEGIN
	SELECT nom_CT AS "Nombre" FROM CATEGORIA order by nom_CT ASC;
	END
GO

CREATE PROCEDURE USP_Listar_Cliente
	as
	BEGIN 
		SELECT nom_CL + ' '+ apellido_CL, telefono_CL AS "Telefono", direccion_CL AS "Direccion" FROM CLIENTE order by nom_CL asc;
	END
GO

create Procedure US_Listar_COMPRAS
	as
	BEGIN
		SELECT C.fecha as 'Fecha', P.nom_PR as 'Proveedor', E.nombre_E as 'Empleado', C.total as 'Costo Total' FROM COMPRA as C inner join EMPLEADO as E on C.id_empleado = E.id_empleado inner join PROVEEDOR as P on P.id_Provedor = C.id_Provedor;
	END
GO
