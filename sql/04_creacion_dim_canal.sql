-- ============================================================
-- 04 - DIMENSION CANAL (como compra el cliente)
-- Agrupa atributos categoricos del pedido.
-- Usa surrogate key (Canal_Key) porque es una combinacion sin llave
-- de negocio natural, el INSERT toma combinaciones unicas con DISTINCT.
-- ============================================================

CREATE TABLE Dim_Canal (
	Canal_Key INT IDENTITY(1,1) PRIMARY KEY,
	Payment_Method VARCHAR(30) NULL, 
	Device_Type VARCHAR(30) NULL, 
	Traffic_Source VARCHAR(30) NULL, 
	Membership_Status VARCHAR(30) NULL
);

INSERT INTO Dim_Canal (
	Payment_Method, 
	Device_Type, 
	Traffic_Source, 
	Membership_Status
)

SELECT DISTINCT
	Payment_Method, 
	Device_Type, 
	Traffic_Source, 
	Membership_Status
FROM raw_table;