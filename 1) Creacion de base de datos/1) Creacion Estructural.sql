-- Creacion de base de datos
CREATE SCHEMA LuGas;
USE	LuGas;
SET SQL_SAFE_UPDATES = 0;
drop schema LuGas;

-- Creacion de tablas para base de datos
-- Creacion de tabla Clientes
CREATE TABLE Clientes
(
  Nombre VARCHAR(50) NOT NULL,
  ApePaterno VARCHAR(50) NOT NULL,
  ApeMaterno VARCHAR(45) NOT NULL,
  NomCalle VARCHAR(45) NOT NULL,
  NumCalle INT NOT NULL,
  NomColonia VARCHAR(45) NOT NULL,
  NomEstado VARCHAR(45) NOT NULL,
  RFCNom VARCHAR(4) NOT NULL,
  RFCFecha DATE NOT NULL,
  NumTelefono VARCHAR(10) NOT NULL,
  Correo VARCHAR(45) NOT NULL,
  CONSTRAINT Clientes PRIMARY KEY
  (
	RFCNom,
    RFCFecha
  )
);
-- Crea un índice único compuesto en las columnas columna1 y columna2
CREATE UNIQUE INDEX ID_Cliente
ON Clientes (RFCNom, RFCFecha);


-- Creacion de tabla Personal
CREATE TABLE Personal
(
	NombreEmp VARCHAR(50) NOT NULL,
    ApePaterno VARCHAR(50) NOT NULL,
    ApeMaterno VARCHAR(50) NOT NULL,
    Puesto VARCHAR(45) NOT NULL,
    Edad INT NOT NULL,
    NomCalle VARCHAR(50) NOt NULL,
    NumCalle INT NOT NULL,
    NomColonia VARCHAR(50) NOT NULL,
    NomEstado VARCHAR(50) NOT NULL,
    NumCP INT NOT NULL,
    NomAlcaldia VARCHAR(50) NOT NULL,
    Sueldo FLOAT(10) NOT NULL, 
    NumTelefono VARCHAR(10) NOT NULL,
    RFCNomEmpl VARCHAR(4) NOT NULL,
    RFCFechaEmpl DATE NOT NULL,
    Activo BOOLEAN NOT NULL,
    CONSTRAINT Personal PRIMARY KEY
    (
		RFCNomEmpl,
        RFCFechaEmpl
    )
);


-- Creacion de tabla Ventas
CREATE TABLE Ventas
(
	Material_Venta VARCHAR(50) NOT NULL,
    Fecha_Venta DATE NOT NULL,
    Cantidad INT NOT NULL,
    Precio_Unitario FLOAT(10) NOT NULL,
    Sub_Total FLOAT(10) NOT NULL,
    IVA FLOAT(10) NOT NULL,
    Total_Pagar FLOAT(10) NOT NULL,
    CFDI VARCHAR(50) NOT NULL,
    Metodo_Pago TINYINT NOT NULL,
	FK_RFCNom_Cliente VARCHAR(4) NOT NULL,
    FK_RFCFecha_Cliente DATE NOT NULL,
    FK_RFCNom_Empleado VARCHAR(4) NOT NULL,
    FK_RFCFecha_Empleado DATE NOT NULL,
    CONSTRAINT Ventas PRIMARY KEY
    (
		Material_Venta
    )
);

-- Agregar una llave foránea en tabla_hija que hace referencia a la clave única compuesta en tabla_padre
ALTER TABLE Ventas ADD CONSTRAINT FK_Cliente FOREIGN KEY (FK_RFCNom_Cliente, FK_RFCFecha_Cliente) REFERENCES Clientes (RFCNom, RFCFecha);
ALTER TABLE Ventas ADD CONSTRAINT FK_Empleado FOREIGN KEY (FK_RFCNom_Empleado, FK_RFCFecha_Empleado)  REFERENCES Personal (RFCNomEmpl, RFCFechaEmpl);

ALTER TABLE Ventas ADD CONSTRAINT FK_RFCNom_Cliente FOREIGN KEY (FK_RFCNom_Cliente) REFERENCES Clientes(RFCNom);
ALTER TABLE Ventas ADD CONSTRAINT FK_RFCFecha_Cliente foreign key(FK_RFCFecha_Cliente) REFERENCES Clientes(RFCFecha);
ALTER TABLE Ventas ADD CONSTRAINT RFC_NomEmpleado_FK foreign key(FK_RFCNom_Empleado) REFERENCES Personal(RFCNomEmpl);
ALTER TABLE Ventas ADD CONSTRAINT RFC_FecEmpleado_FK foreign key(FK_RFCFecha_Empleado) REFERENCES Personal(RFCFechaEmpl);


-- Creacion de tabla Existencias
CREATE TABLE Existencias
(
	ID_Existencias INT NOT NULL,
    Existencias INT NOT NULL,
    Fecha_Ex DATE NOT NULL,
    Nom_Prod VARCHAR(50) NOT NULL,
    Fecha_Inv DATE NOT NULL,
    Cantidad INT NOT NULL,
    Totales INT NOT NULL,
    Desp_ob INT NOT NULL,
    TotalF INT NOT NULL,
    Observaciones VARCHAR(50) NOT NULL,
    CONSTRAINT Existencias PRIMARY KEY
    (
		ID_Existencias
    )
);


-- Creacion de tabla Proveedores
CREATE TABLE Proveedores
(
	RFCNom VARCHAR(50) NOT NULL,
    RFCFecha DATE NOT NULL,
    Telefono_Contacto VARCHAR(10) NOT NULL,
    Nombre_rep VARCHAR(50) NOT NULL,
    ApePaterno_Rep VARCHAR(50) NOT NULL,
    ApeMaterno_Rep VARCHAR(50) NOT NULL,
    CONSTRAINT Proveedores PRIMARY KEY 
    (
		RFCNom,
        RFCFecha
    )
);
  
  
-- Creacion de tabla Compras
CREATE TABLE Compras 
(
	IDCompras VARCHAR(50) NOT NULL,
    Proveedor VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(90) NOT NULL,
    Cantidad INT NOT NULL,
    Precio_Unitario FLOAT(10) NOT NULL,
    Sub_Total FLOAT(10) NOT NULL,
    Iva FLOAT(10) NOT NULL,
    Total FLOAT(10) NOT NULL,
    Fecha_Pedido DATE NOT NULL,
    Fecha_Entrega DATE NOT NULL,
    CONSTRAINT Compras PRIMARY KEY 
    (
		IDCompras
    )
);


-- Creacion de tabla Instalacion
CREATE TABLE Instalacion
(
	Modelo_Instalar VARCHAR(10) NOT NULL,
    Matricula_Unidad VARCHAR(10) NOT NULL,
    Modelo INT NOT NULL,
    Marca VARCHAR(20) NOT NULL,
    Cilindros VARCHAR(10) NOT NULL,
    FK_RFC_Nombre_Cliente VARCHAR(45) NOT NULL,
    FK_RFC_Fecha_Cliente DATE NOT NULL,
    CONSTRAINT Instalacion PRIMARY KEY
    (
		Modelo
    )
);

ALTER TABLE Instalacion ADD CONSTRAINT FK_Clientes FOREIGN KEY (FK_RFC_Nombre_Cliente, FK_RFC_Fecha_Cliente) REFERENCES Clientes (RFCNom, RFCFecha);


-- Creacion de tabla Material_Comprado
CREATE TABLE Material_Comprado
(
	Folio_Compra VARCHAR(10) NOT NULL,
    Cantidad INT NOT NULL,
    Precio_Unitario FLOAT(10) NOT NULL,
    Sub_Total FLOAT(10) NOT NULL,
    FK_IDCompras VARCHAR(50) NOT NULL,
    CONSTRAINT Material_Comprado PRIMARY KEY
    (
		Folio_Compra
    )
);

ALTER TABLE Material_Comprado ADD CONSTRAINT FK_Compras FOREIGN KEY (FK_IDCompras) REFERENCES Compras(IDCompras);


-- Creacion de tabla Material_Vendido
CREATE TABLE Material_Vendido
(
	Materia_Ven VARCHAR(50) NOT NULL,
    Codigo INT NOT NULL,
    FK_RFC_Nombre_Cliente VARCHAR(45) NOT NULL,
    FK_RFC_Fecha_Cliente DATE NOT NULL,
    CONSTRAINT Materia_Vendido PRIMARY KEY
    (
		Codigo
    )
);

ALTER TABLE Material_Vendido ADD CONSTRAINT FK_Clientes_Material FOREIGN KEY (FK_RFC_Nombre_Cliente, FK_RFC_Fecha_Cliente) REFERENCES Clientes (RFCNom, RFCFecha);