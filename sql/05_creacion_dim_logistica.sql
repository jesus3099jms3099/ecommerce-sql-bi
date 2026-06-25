-- ============================================================
-- 05 · DIMENSION LOGISTICA (como se entrega la orden)
-- Agrupa atributos categoricos del pedido.
-- Misma logica que Canal: surrogate key y
-- combinaciones unicas a través de DISTINCT.
-- ============================================================

CREATE TABLE Dim_Logistica (
	Logistica_Key INT IDENTITY(1,1) PRIMARY KEY,
	Shipping_Method VARCHAR(30) NULL, 
	Warehouse_Region VARCHAR(30) NULL, 
	Order_Status VARCHAR(30) NULL
);

INSERT INTO Dim_Logistica (
	Shipping_Method, 
	Warehouse_Region, 
	Order_Status
)

SELECT DISTINCT
	Shipping_Method, 
	Warehouse_Region, 
	Order_Status
FROM raw_table;