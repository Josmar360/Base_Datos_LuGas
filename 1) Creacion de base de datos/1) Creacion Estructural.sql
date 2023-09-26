-- Creacion de base de datos
CREATE SCHEMA LuGas;
USE	LuGas;
SET SQL_SAFE_UPDATES = 0;
drop schema LuGas;

-- Creacion de tablas para base de datos
-- Creacion de tabla existencias
CREATE TABLE Existencias
(
	ID_Existencias INT NOT NULL,
    Existencias INT NOT NULL,
    Nom_Prod VARCHAR(50) NOT NULL,
    Desp_ob INT NOT NULL,
    CONSTRAINT PRIMARY KEY
    (
		ID_Existencias
	)
);


-- Creacion de tabla Inventario
CREATE TABLE Inventario
(
	IDInventario INT NOT NULL,
    Fecha_Inv DATE NOT NULL,
    Observaciones VARCHAR(45) NOT NULL,
    ExistenciasF INT NOT NULL,
    FK_Existencias_ID_Existencias INT NOT NULL,
    CONSTRAINT PRIMARY KEY
    (
		IDInventario
    )
);

ALTER TABLE Inventario ADD CONSTRAINT FK_Existencias FOREIGN KEY (FK_Existencias_ID_Existencias) REFERENCES Existencias (ID_Existencias);


-- Crear tabla Proveedores
CREATE TABLE Proveedores
(
	RFCNom VARCHAR(50) NOT NULL,
    RFCFecha DATE NOT NULL,
    Telefono_Contacto VARCHAR(10) NOT NULL,
    Nombre_rep VARCHAR(50) NOT NULL,
    Ape_Paterno_Rep VARCHAR(50) NOT NULL,
    Ape_Materno_Rep VARCHAR(50) NOT NULL,
    CONSTRAINT PRIMARY KEY
    (
		RFCNom,
        RFCFecha
    )
);


-- Crear tabla Compras
CREATE TABLE Compras
(
	IDCompras VARCHAR(50) NOT NULL,
    Sub_Total FLOAT NOT NULL,
    Iva FLOAT NOT NULL,
    Total FLOAT NOT NULL,
    Fecha_Pedido DATE NOT NULL,
    Fecha_Entrega DATE NOT NULL,
    FK_RFC_Nom_Proveedor VARCHAR(50) NULL,
    FK_RFC_Fecha_Proveedor DATE NULL,
    CONSTRAINT PRIMARY KEY
    (
		IDCompras
    )
);

ALTER TABLE Compras ADD CONSTRAINT FK_Proveedores FOREIGN KEY (FK_RFC_Nom_Proveedor, FK_RFC_Fecha_Proveedor) REFERENCES Proveedores (RFCNom, RFCFecha);

-- Creacion de tabla Material Comprado
CREATE TABLE Material_Comprado
(
	Cantidad INT NOT NULL,
    Precio_Unitario FLOAT NOT NULL,
    Sub_Total FLOAT NOT NULL,
    FK_ID_Compras VARCHAR(50) NOT NULL,
    FK_ID_Existencias INT NOT NULL,
    CONSTRAINT PRIMARY KEY
    (
		FK_ID_Compras,
        FK_ID_Existencias
    )
);

ALTER TABLE Material_Comprado ADD CONSTRAINT FK_Existencias_Compras FOREIGN KEY (FK_ID_Existencias) REFERENCES Existencias (ID_Existencias);
ALTER TABLE MAterial_Comprado ADD CONSTRAINT FK_Material_Compras FOREIGN KEY (FK_ID_Compras) REFERENCES Compras (IDCompras);


-- Crear tabla clientes
CREATE TABLE Clientes
(
	RFCNom VARCHAR(4) NOT NULL,
    RFCFecha DATE NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Ape_Paterno VARCHAR(50) nOT NULL,
    Ape_Materno VARCHAR(50) NOT NULL,
    Nom_Calle VARCHAR(45) NOT NULL,
    Num_CAlle INT NOT NULL,
    Nom_Colonia VARCHAR(45) NOT NULL,
    Nom_Estado VARCHAR(45) NOT NULL,
    Num_Telefono VARCHAR(10) NOT NULL,
    Correo VARCHAR(45) NOT NULL,
    CONSTRAINT PRIMARY KEY
    (
		RFCNom,
        RFCFecha
    )
);


-- Crear tabla personal
CREATE TABLE Personal
(
	RFCNombre VARCHAR(45) NOT NULL,
	RFCFecha DATE NOT NULL,
	NombreEmp VARCHAR(50) NOT NULL,
    Ape_Paterno VARCHAR(50) NOT NULL,
    Ape_Materno VARCHAR(50) NOT NULL,
    Puesto VARCHAR(50) NOT NULL,
    Edad INT NOT NULL,
    NomCalle VARCHAR(50) NOT NULL,
    NumCalle INT NOT NULL,
    NomColonia VARCHAR(50) NOT NULL,
    NomEstado VARCHAR(50) NOT NULL,
    NumCP INT NOT NULL,
    NomAlcaldia VARCHAR(50) NOT NULL,
    Sueldo FLOAT NOT NULL,
    Telefono VARCHAR(10) NOT nULL,
    CONSTRAINT PRIMARY KEY
    (
		RFCNombre,
        RFCFecha
    )
);


-- Crear tabla Ventas
CREATE TABLE Ventas
(
	FolioVenta INT NOT NULL,
	Fecha_Venta DATE NOT NULL,
    Sub_Total FLOAT NOT NULL,
    IVA FLOAT NULL NULL,
    Total_Pagar FLOAT NOT NULL,
    Metodo_Pago TINYINT NOT NULL,
    FK_RFC_Nom_Emp VARCHAR(4) NOT NULL,
    FK_RFC_Fecha_Emp DATE NOT NULL,
    FK_RFC_Nom_Cliente VARCHAR(4) NULL,
    FK_RFC_Fecha_Cliente DATE NULL,
    CONSTRAINT PRIMARY KEY
    (
		FolioVenta
    )
);

ALTER TABLE Ventas ADD CONSTRAINT FK_Clientes FOREIGN KEY (FK_RFC_Nom_Cliente, FK_RFC_Fecha_Cliente) REFERENCES Clientes (RFCNom, RFCFecha);
ALTER TABLE Ventas ADD CONSTRAINT FK_Personal FOREIGN KEY (FK_RFC_Nom_Emp, FK_RFC_Fecha_Emp) REFERENCES Personal (RFCNombre, RFCFecha);


-- Crear tabla Material_Vendid
CREATE TABLE Material_Vendido 
(
	Cantidad INT NOT NULL,
    PrecioV FLOAT NOT NULL,
    Subtotal FLOAT NOT NULL,
    FK_ID_Existencias INT NOT NULL,
    FK_Folio_Venta INT NOT NULL,
    Material_Vendido VARCHAR(90) NOT NULL,
    Metodo_Pago VARCHAR(30) NOT NULL,
    CONSTRAINT PRIMARY KEY
    (
		FK_ID_Existencias,
        FK_Folio_Venta
    )
);

ALTER TABLE Material_Vendido ADD CONSTRAINT FK_Existencias_Material FOREIGN KEY (FK_ID_Existencias) REFERENCES Existencias (ID_Existencias);
ALTER TABLE Material_Vendido ADD CONSTRAINT FK_Ventas_Material FOREIGN KEY (FK_Folio_Venta) REFERENCES Ventas (FolioVenta);
