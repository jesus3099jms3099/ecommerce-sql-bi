-- ============================================================
-- 07 - EXPLORACION Y VALIDACION DE TABLAS
-- ============================================================

-- Exploración de tabla Dim_Customer
SELECT * FROM Dim_Clientes;
SELECT COUNT(*) FROM Dim_Clientes; -- 8683 resgitros

-- Exploración de nueva tabla Dim_Product
SELECT COUNT(*) FROM Dim_Producto; -- 2500 registros

SELECT DISTINCT
	p.Product_ID,
	Product_Category,
	Product_Subcategory,
	Brand,
	o.Unit_Price
FROM Dim_Producto p
JOIN Fact_Orders o
	ON p.Product_ID = o.Product_ID
ORDER BY 2,3,4; -- Productos con mismas caracteristicas, pero distinto precio

-- Exploración nueva tabla Dim_Canal
SELECT * FROM Dim_Canal;
SELECT COUNT(*) FROM Dim_Canal; -- 431 registros

-- Exploración nueva tabla Dim_Logistica
SELECT * FROM Dim_Logistica;
SELECT COUNT(*) FROM Dim_Logistica; -- 100 registros

-- Exploración nueva tabla fact_orders
SELECT * FROM Fact_Orders;
SELECT COUNT(*) FROM Fact_Orders; -- 30000 registros
