-- ============================================================
-- 08 - AUDITORIA DEL MODELO (reconciliacion / cuadre de caja)
-- SUM(Order_Amount) y los conteos deben coincidir entre raw_table
-- y el modelo. Garantiza que el ETL no perdio ni inflo datos.
-- ============================================================

-- Revisión del cuadre de caja
SELECT SUM(Order_Amount) AS Total_Modelo_Estrella FROM Fact_Orders; -- 11370043.99
SELECT SUM(Order_Amount) AS Total_Tabla_Rustica FROM raw_table; -- 11370043.99

-- Revisión del volumen de registros
SELECT COUNT(*) FROM raw_table; -- 30000
SELECT COUNT(*) FROM Fact_Orders; -- 30000

-- Simulacro analítico (Prueba de estres)
SELECT
	p.Product_Category,
	SUM(Order_Amount) AS Venta_Categoria
FROM Dim_Producto p
JOIN Fact_Orders o
	ON p.Product_ID = o.Product_ID
GROUP BY p.Product_Category
ORDER BY Venta_Categoria DESC
