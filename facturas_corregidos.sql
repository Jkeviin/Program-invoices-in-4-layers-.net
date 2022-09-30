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
		cedula_E  varchar(50) primary key,
		-- Atributos 
		nombre_E varchar(20) not null,
		apellido_E varchar(100) not null,
		telefono_E varchar(20) not null,
		correo_E varchar(100) not null,
		contraseña_E varchar(100) not null,
		direccion_E varchar(150) not null,
		estado_E bit not null,
	);

	-- D
	GO
	create table CATEGORIA (
		-- Primary key
		cod_referenceCT varchar(50) primary key,
		-- Atributos base
		nom_CT varchar (20) not null,
		descripcion_CT varchar (100) not null,
		estado_CT bit not null
	);


	-- K
	GO
	create table PRODUCTO (
		-- Primary Key
		cod_P varchar(50) primary key,
		-- Foreign key
		cod_referenceCT varchar(50) not null,
		-- Atributos base
		nom_P varchar(60) not null,
		descripcion_P varchar(300) not null,
		valor float not null,
		stock int not null,
		estado_P bit not null,
		-- Foreign Key
		foreign key (cod_referenceCT) references CATEGORIA(cod_referenceCT)
	);

	-- S
	GO
	create table  PROVEEDOR (
		-- Primary Key
		nitProveedor varchar(50) primary key,
		-- Atributos base
		nom_PR varchar(50) not null,
		descript_PR varchar(300) not null,
		direccion_PR varchar(200) not null,
		correo_PR varchar(50) not null,
		contraseña_PR varchar(100) not null,
		pagina_web_PR varchar(50) null,
		estado_PR bit not null,
	);

	-- K
	GO
	create table TELEFONO_PROVEEDOR (
		-- Primary Key
		id_tel int primary key identity(1,1),
		-- Foreign Key
		nitProveedor varchar(50) not null,
		-- ATRIBUTOS
		telefono varchar(20) not null,
		-- Vinculo Foreign Key
		foreign key (nitProveedor) references PROVEEDOR(nitProveedor)
	);
	GO

	-- K
	create table COMPRA (
		-- Primary Key
		nro_C varchar(50) primary key,
		-- Foreign Key
		nitProveedor varchar(50) not null,
		cedula_E   varchar(50) not null,
		-- Atributos base
		fecha varchar (20) not null,
		total float not null,
		subtotal float not null, 
		iva float not null,
		-- Vinculo Foreign Key
		foreign key (nitProveedor) references PROVEEDOR(nitProveedor),
		foreign key (cedula_E  ) references EMPLEADO(cedula_E)
	);
	GO

	-- N
	create table CLIENTE(
		-- Primary key
		cedula_CL varchar(50) primary key,
		-- Atributo
		nom_CL varchar(20) not null,
		apellido_CL varchar(100) not null,
		telefono_CL varchar(20) not null,
		direccion_CL varchar(150) not null,
		estado_CL bit not null
	 ); 
	 GO

	  -- S
	create table VENTA (
		-- Primary key 
		nro_V int  primary key IDENTITY(1,1),
		-- Foreign Key
		id_E varchar(50) not null ,
		cedula_CL varchar(50)  not null,
		-- Atributos
		fecha_V varchar (20) not null,
		iva float not null,
		subtotal float not null,
		total float not null,
		-- Vinculo Foreign Key
		foreign key (id_E) references	EMPLEADO (cedula_E  ),
		foreign key (cedula_CL) references CLIENTE (cedula_CL)
	 );
	 GO

	GO

	 -- || TABLAS FUENTE ||
	 -- K & D
	create table PRODUCTO_COMPRA (
		-- Foreign Key
		cod_P varchar(50) not null,
		nro_C varchar(50) not null,
		-- Atributos
		cant int not null,
		costo float not null,
		valor_Total float  not null,
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
		cod_P varchar(50) not null,
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
	INSERT INTO  CLIENTE (cedula_CL,nom_CL, apellido_CL, telefono_CL, direccion_CL, estado_CL) VALUES
						 ('1','Kevin', 'Garzon', '3107070709', 'calle30 #26-49', 1);
	GO
	INSERT INTO EMPLEADO (cedula_E   ,nombre_E, apellido_E, telefono_E, correo_E, contraseña_E, direccion_E, estado_E) VALUES
							('12','Pepe','Ortega','3107465490','slash123@gmail.com', 'empleado123', 'calle 21#26-45 apto 301 barrio San José', 1);
	GO
	INSERT INTO CATEGORIA (cod_referenceCT,nom_CT,descripcion_CT, estado_CT) VALUES
							('123','Electrónicos','Toda una gamma completa de Televisores, Computadores, etc...', 1);
	GO
	INSERT INTO PRODUCTO (cod_P,cod_referenceCT, nom_P, descripcion_P, valor, stock, estado_P) VALUES
							('1234','123', 'Televisor Samsung', 'Televisor de 52pg hd ultra 4k', 1000000, 99, 1);
	GO
	INSERT INTO PROVEEDOR (nitProveedor,nom_PR, descript_PR, direccion_PR, correo_PR,contraseña_PR, pagina_web_PR, estado_PR) VALUES
							('12345','Importanciones gomez hermanos', 'Los mejores proovedores de todo el pais', 'calle10a #77-44', 'importancionesgomezhermanos@gmail.com', 'proveedor123', 'www.gomezhermanos.com', 1);
	GO
	INSERT INTO PROVEEDOR (nitProveedor,nom_PR, descript_PR, direccion_PR, correo_PR,contraseña_PR, pagina_web_PR, estado_PR) VALUES
							('1','Admin', 'Detalle Ad,om', '000', 'admin', 'admin', 'www.admin.com', 1);
	GO
	INSERT INTO TELEFONO_PROVEEDOR (nitProveedor, telefono) VALUES
							('12345', '3107567654');
	GO
	INSERT INTO  COMPRA (nro_C,nitProveedor, cedula_E  , fecha, total, subtotal, iva) VALUES
							('1234567','12345', '12', '2022-10-20', 1630000, 1600000, 30000);
	GO
	INSERT INTO  PRODUCTO_COMPRA (cod_P, nro_C, cant, costo, valor_Total) VALUES
							('1234', '1234567', 2, 800000, 1600000);
	GO
	INSERT INTO  VENTA (id_E, cedula_CL, fecha_V, iva, subtotal, total) VALUES
							('12', '1', '2022-10-10', 30000, 2000000, 2030000);
	GO
	INSERT INTO  PRODUCTO_VENTA (cod_P, nro_V, valorTotal, cant) VALUES
							('1234', 1, 2000000, 2);
	GO


	 -- || PROCEDIMIENTOS ALMACENADOS ||

	-- PROCEDIMIENTOS EMPLEADO (Daniel Alfonso)

	CREATE PROCEDURE USP_Registro_Empleado
		@cedula_E  varchar(50),
		@nom_E VARCHAR(20),
		@ape_E VARCHAR(100),
		@tele_E VARCHAR(20),
		@Correo_E VARCHAR(100),
		@contraseña_E varchar(100),
		@direc_E VARCHAR(150)
		as
		BEGIN 
			INSERT INTO EMPLEADO (cedula_E, nombre_E, apellido_E, telefono_E, correo_E, contraseña_E, direccion_E, estado_E) VALUES
								(@cedula_E, @nom_E, @ape_E, @tele_E, @Correo_E, @contraseña_E, @direc_E, 1);
		END
	GO

	CREATE PROCEDURE USP_Actualizar_Empleado
		@cedula_E  varchar(50),
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
				direccion_E = @direc_E,
				contraseña_E = @constraseña_E
			WHERE cedula_E = @cedula_E	
		END
	GO

	CREATE PROCEDURE USP_Eliminar_Empleado
		@cedula_E varchar(50)
		AS
		BEGIN
			UPDATE EMPLEADO
			SET estado_E = 0
			WHERE cedula_E = @cedula_E	
		END
	GO



	-- PROCEDIMIENTOS CATEGORIA (Daniel Alfonso)

	CREATE PROCEDURE USP_Registro_Categoria
		@cod_referenceCT varchar(50),
		@nom_CT VARCHAR(20),
		@descrip_CT VARCHAR(100)
		as
		BEGIN 
			INSERT INTO CATEGORIA(cod_referenceCT, nom_CT , descripcion_CT, estado_CT) VALUES
							 (@cod_referenceCT, @nom_CT , @descrip_CT, 1);
		END
	GO



	CREATE PROCEDURE USP_Actualizar_Categoria
		@cod_referenceCT varchar(50),
		@nom_CT VARCHAR(20),
		@descrip_CT VARCHAR(100)
		AS
		BEGIN
			UPDATE CATEGORIA
			SET
				nom_CT = @nom_CT,
				descripcion_CT = @descrip_CT
			WHERE 	cod_referenceCT = @cod_referenceCT 
		END
	GO

	CREATE PROCEDURE USP_Eliminar_Categoria
		@cod_referenceCT varchar(50)
		AS
		BEGIN
		UPDATE CATEGORIA
			SET estado_CT = 0
			WHERE cod_referenceCT = @cod_referenceCT	
		END
	GO


	-- PROCEDIMIENTOS PRODUCTOS (Kevin Ortega - Sebastian)
	CREATE PROCEDURE USP_Registro_Producto
		@cod_P varchar(50),
		@nom_P VARCHAR(60),
		@cod_referenceCT varchar(50),
		@descripcion_P VARCHAR(300),
		@valor float
		as
		BEGIN 
			INSERT INTO PRODUCTO (cod_P, nom_P, cod_referenceCT, descripcion_P, valor, stock, estado_P) VALUES
							 (@cod_P, @nom_P, @cod_referenceCT, @descripcion_P, @valor, 0, 1);
		END
	GO

	CREATE PROCEDURE USP_Actualizar_Producto
		@cod_P varchar(50),
		@nom_p varchar(20),
		@cod_referenceCT varchar(50),
		@descripcion_P varchar(300),
		@valor float,
		@stock int
		AS
		BEGIN
			UPDATE PRODUCTO
			SET
				nom_P = @nom_p,
				cod_referenceCT =  @cod_referenceCT,
				descripcion_P = @descripcion_P,
				valor = @valor,
				stock = @stock
			WHERE 	cod_P = @cod_P 
		END
	GO
	CREATE PROCEDURE USP_eliminar_Producto
		@cod_P varchar(50)
		AS
		BEGIN
			UPDATE PRODUCTO
			SET estado_P = 0
			WHERE 	cod_P = @cod_P 	
		END
	GO

	-- PROCEDIMIENTOS PROVEEDOR (Kevin Ortega)
	CREATE PROCEDURE USP_Registro_Proveedor
		@nitProveedor varchar(50),
		@nom_PR varchar(50),
		@descript_PR varchar(300),
		@direccion_PR varchar(200),
		@correo_PR varchar(50),
		@contraseña_PR varchar(100),
		@pagina_web_PR varchar(50),
		@telefono varchar(20)
		as
		BEGIN 
			INSERT INTO PROVEEDOR(nitProveedor, nom_PR, descript_PR, direccion_PR, Correo_PR, contraseña_PR, pagina_web_PR, estado_PR) VALUES
							 (@nitProveedor, @nom_PR, @descript_PR, @direccion_PR, @correo_PR,@contraseña_PR, @pagina_web_PR, 1);
			-- Telefono
		
			INSERT INTO TELEFONO_PROVEEDOR(nitProveedor, telefono) VALUES
							 (@nitProveedor, @telefono);
		END
	GO

	--execute USP_Registro_Proveedor '1234', 'Amazon', 'Excelentes productos de toda gama', 'calle 3 #24', 'amazon@gmail.com', 'proveedor123', 'www.amazon.com', '31012341212';
	--go

	CREATE PROCEDURE USP_Actualizar_Proveedor
		@nitProveedor varchar(50),
		@nom_PR varchar(50),
		@descript_PR varchar(300),
		@direccion_PR varchar(200),
		@correo_PR varchar(50),
		@contraseña_PR varchar(100),
		@pagina_web_PR varchar(50)
		AS
		BEGIN
			UPDATE PROVEEDOR
			SET
				nom_PR = @nom_PR,
				descript_PR =  @descript_PR,
				direccion_PR = @direccion_PR,
				correo_PR = @correo_PR,
				contraseña_PR = @contraseña_PR ,
				pagina_web_PR = @pagina_web_PR
			WHERE 	nitProveedor = @nitProveedor
		END
	GO

	CREATE PROCEDURE USP_eliminar_Proovedor
		@nitProveedor varchar(50)
		AS
		BEGIN
		UPDATE PROVEEDOR
			SET estado_PR = 0
			WHERE nitProveedor = @nitProveedor	
		END
	GO
	-- PROCEDIMIENTOS TELEFONO_PROVEEDOR (Kevin Ortega)

	CREATE PROCEDURE USP_Actualizar_Telefono_Proveedor
		@id_tel int,
		@nitProveedor varchar(50),
		@telefono varchar(20)
		AS
		BEGIN
			UPDATE TELEFONO_PROVEEDOR
			SET nitProveedor = @nitProveedor,
				telefono =  @telefono
			WHERE 	id_tel = @id_tel 
		END
	GO

	-- PROCEDIMIENTOS COMPRA (Kevin Ortega)
	CREATE PROCEDURE USP_Registro_Compra
		@nro_C varchar(50),
		@nitProveedor varchar(50),
		@cedula_E   varchar(50),
		@fecha VARCHAR(20),
		@total float,
		@subtotal float,
		@iva float
		as
		BEGIN 
			INSERT INTO COMPRA(nro_C, nitProveedor, cedula_E  , fecha, total, subtotal, iva) VALUES
							 (@nro_C, @nitProveedor, @cedula_E  , @fecha, @total, @subtotal, @iva);
		END
	GO

	-- PROCEDIMIENTOS VENTA (Nicolas Rivera)
	CREATE PROCEDURE USP_Registro_Venta
		@id_E int,
		@cedula_CL varchar(50),
		@fecha_V VARCHAR(20),
		@iva float,
		@subtotal float,
		@total float
		as
		BEGIN 
			INSERT INTO VENTA(id_E, cedula_CL, fecha_V, iva, subtotal, total) VALUES
							 (@id_E, @cedula_CL, @fecha_V, @iva, @subtotal, @total );
		END
	GO

	-- PROCEDIMIENTOS PRODUCTO COMPRA (Kevin Ortega)
	CREATE PROCEDURE USP_Registro_Compra_Producto
		@cod_P varchar(50),
		@nro_C varchar(50),
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
		@cod_P varchar(50),
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
		@cedula_CL varchar(50),
		@nom_CL VARCHAR(20),
		@apellido_CL VARCHAR(100),
		@telefono_CL VARCHAR(20),
		@direccion_CL VARCHAR(20)
		as
		BEGIN 
			INSERT INTO CLIENTE(cedula_CL, nom_CL, apellido_CL, telefono_CL, direccion_CL, estado_CL) VALUES
							 (@cedula_CL, @nom_CL, @apellido_CL, @telefono_CL, @direccion_CL, 1);
		END
	GO

	CREATE PROCEDURE USP_Actualizar_Cliente
		@cedula_CL varchar(50),	
		@nom_CL VARCHAR(20),
		@apellido_CL VARCHAR(100),
		@telefono_CL VARCHAR(20),
		@direccion_CL VARCHAR(20)
	
		AS
		BEGIN
			UPDATE CLIENTE
			SET cedula_CL = @cedula_CL,
				nom_CL = @nom_CL,
				apellido_CL =  @apellido_CL,
				telefono_CL = @telefono_CL,
				direccion_CL = @direccion_CL
			WHERE 	cedula_CL = @cedula_CL 
		END

	GO

	CREATE PROCEDURE USP_eliminar_Cliente
		@cedula_CL varchar(50)
		AS
		BEGIN
		UPDATE CLIENTE
			SET estado_CL = 0
			WHERE 	cedula_CL = @cedula_CL 
		END
	GO

	-- INICIO SESION EMPLEADO (Kevin Ortega)
	CREATE PROCEDURE USP_inicio_sesion_Empleado
		@correo_E varchar(100),
		@contraseña_E varchar(100)
		AS
		BEGIN
		select cedula_E   from EMPLEADO where contraseña_E = @contraseña_E and correo_E = @correo_E and estado_E = 1;
		END
	GO


	-- INICIO SESION PROVEEDOR (Kevin Ortega)
	CREATE PROCEDURE USP_inicio_sesion_Proveedor
		@correo_PR varchar(100),
		@contraseña_PR varchar(100)

		AS
		BEGIN
		select * from PROVEEDOR where contraseña_PR = @contraseña_PR and correo_PR = @correo_PR and estado_PR = 1;
		END
	GO

	select * from PROVEEDOR

	go
	 -- || COMBO BOX ||

	 -- Combo box Cliente (Daniel)
	CREATE PROCEDURE USP_COMBOBOX_CLIENTES
		AS
		BEGIN
			SELECT '0' as cedula_CL , 'Seleccione cliente' as  nom_CL from  CLIENTE
		union
			SELECT cedula_CL , nom_CL + ' ' + apellido_CL from CLIENTE where estado_CL = 1 order by nom_CL asc;
		END
	GO

	 -- Combo box Categirua (Kevin - Sebastian)
	CREATE PROCEDURE USP_COMBOBOX_CATEGORIA 
		AS
		BEGIN
			SELECT '0' as cod_referenceCT , 'Seleccione una categoria' as  nom_CT from  CATEGORIA
		union
			SELECT cod_referenceCT , nom_CT from CATEGORIA where estado_CT = 1;
		END
	GO


	 -- Combo box Producto (Kevin - Daniel)
	CREATE PROCEDURE USP_COMBOBOX_PRODUCTO
		@cod_referenceCT varchar(50) 
		AS
		BEGIN
			SELECT '0' as cod_P , 'Seleccione una producto' as  nom_P from  PRODUCTO 
		union 
			SELECT p.cod_P , p.nom_P FROM PRODUCTO as p INNER JOIN CATEGORIA as c ON c.cod_referenceCT = p.cod_referenceCT where c.cod_referenceCT = @cod_referenceCT and estado_P = 1;
		END
	GO


	-- || LISTAR ||  (Sebastian)

	CREATE PROCEDURE USP_Listar_Productos
		AS
		BEGIN	
			SELECT p.cod_P as CODIGO, p.nom_P as NOMBRE, c.nom_CT as CATEGORIA, descripcion_P as DESCRIPCION, p.valor as VALOR, p.stock as STOCK FROM PRODUCTO as p inner join CATEGORIA as c on c.cod_referenceCT = p.cod_referenceCT where estado_P = 1 order by nom_CT asc
		END
	GO


	CREATE PROCEDURE USP_Listar_Productos_Venta
		AS
		BEGIN	
			SELECT p.nom_P ,c.nom_CT , p.valor FROM PRODUCTO as p INNER JOIN CATEGORIA as c ON c.cod_referenceCT = p.cod_referenceCT ORDER BY c.nom_CT ASC;
		END
	GO

	CREATE PROCEDURE USP_Listar_Productos_Compra
		AS
		BEGIN	
			SELECT p.nom_P, c.nom_CT, pc.costo FROM PRODUCTO as p INNER JOIN PRODUCTO_COMPRA as pc ON pc.cod_P = p.cod_P INNER JOIN CATEGORIA as c ON c.cod_referenceCT = p.cod_referenceCT ORDER BY c.nom_CT ASC;
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

	create Procedure USP_Listar_COMPRAS
		as
		BEGIN
			SELECT C.fecha as 'Fecha', P.nom_PR as 'Proveedor', E.nombre_E as 'Empleado', C.total as 'Costo Total' FROM COMPRA as C inner join EMPLEADO as E on C.cedula_E   = E.cedula_E   inner join PROVEEDOR as P on P.nitProveedor = C.nitProveedor;
		END
	GO

	-- PROCEDIMIENTOS BUSQUEDA (Sebastián)
	--EMPLEADO
	GO
	CREATE PROCEDURE USP_buscar_empleado
	@cedula_E   varchar(50)
	as
	BEGIN
			SELECT * FROM EMPLEADO WHERE cedula_E   = @cedula_E  
	END
	GO


	--CATEGORIA
	CREATE PROCEDURE USP_buscar_categoria
	@cod_referenceCT varchar(50)
	as 
	BEGIN 
			SELECT * FROM CATEGORIA WHERE cod_referenceCT = @cod_referenceCT
	END
	GO


	--PRODUCTO
	GO
	CREATE PROCEDURE USP_buscar_producto
	@cod_p varchar(50)
	as
	BEGIN
			SELECT * FROM PRODUCTO WHERE cod_P = @cod_p
	END
	GO

	--PROVEEDOR
	GO
	CREATE PROCEDURE USP_buscar_proveedor
	@nitProveedor varchar(50)
	as
	BEGIN
			SELECT * FROM PROVEEDOR WHERE nitProveedor = @nitProveedor
	END
	GO


	--TELEFONO PROVEEDOR
	GO
	CREATE PROCEDURE USP_buscar_telefono_proveedor
	@id_tel int
	as
	BEGIN
			SELECT * FROM TELEFONO_PROVEEDOR WHERE id_tel = @id_tel
	END
	GO


	--COMPRA
	GO
	CREATE PROCEDURE USP_buscar_compra
	@nro_C varchar(50)
	as
	BEGIN
			SELECT * FROM COMPRA WHERE nro_C = @nro_C
	END
	GO


	--CLIENTE
	GO
	CREATE PROCEDURE USP_buscar_cliente
	@cedula_CL varchar(50)
	as
	BEGIN
			SELECT * FROM CLIENTE WHERE cedula_CL = @cedula_CL
	END
	GO


	--VENTA
	GO
	CREATE PROCEDURE USP_buscar_venta
	@nro_V int
	as
	BEGIN
			SELECT * FROM VENTA WHERE nro_V = @nro_V
	END
	GO

