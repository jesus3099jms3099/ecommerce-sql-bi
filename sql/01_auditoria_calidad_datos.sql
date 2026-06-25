-- ============================================================
-- 01 - AUDITORIA DE CALIDAD DE DATOS
-- Perfila raw_table y mide la integridad de las llaves de negocio
-- ANTES de modelar. Hallazgo: Customer_ID 87% inconsistente, Product_ID 100%.
-- ============================================================

SELECT TOP 10 * FROM raw_table;

SELECT COUNT(*) FROM raw_table; -- 30000 registros

SELECT 
	COUNT (DISTINCT Customer_ID)
FROM raw_table; -- 8683 valores distintos

SELECT 
	COUNT (DISTINCT	Product_ID)
FROM raw_table; -- 2500 valores distintos

SELECT 
	COUNT (DISTINCT	Order_ID)
FROM raw_table; -- 30000 valores distintos

-- Revision de variable Customer_ID 
SELECT
	Customer_ID,
	Customer_Age,
	Customer_Gender,
	Country,
	City
FROM raw_table
ORDER BY 1,2; -- Existen Customer_ID que están reusados para diferentes productos

WITH duplicados_Customer_ID AS (
	SELECT
		Customer_ID,
		COUNT(DISTINCT CONCAT(Customer_ID,'|',Customer_Age,'|',Customer_Gender,'|',Country,'|',City)) AS conteo
	FROM raw_table
	GROUP BY Customer_ID
)

SELECT
	COUNT(CASE WHEN conteo > 1 THEN 1 END) AS Total_duplicados,
	COUNT(CASE WHEN conteo = 1 THEN 1 END) AS Total_Unicos,
	CAST(COUNT(CASE WHEN conteo > 1 THEN 1 END) * 100.0 / COUNT(*)AS DECIMAL(5,2))
FROM duplicados_Customer_ID; -- 87.72% Customer_ID duplicados (reusados en diferentes clientes)

-- Revision de variable Product_ID
SELECT
	Product_ID,
	Product_Category,
	Product_Subcategory,
	Brand
FROM raw_table
ORDER BY 1,2; -- Existen Product_ID que están reusados para diferentes productos

WITH duplicados_Product_ID AS (
	SELECT
		Product_ID,
		COUNT(DISTINCT CONCAT(Product_ID,'|',Product_Category,'|',Product_Subcategory,'|',Brand)) AS conteo
	FROM raw_table
	GROUP BY Product_ID
)

SELECT
	COUNT(CASE WHEN conteo > 1 THEN 1 END) AS Total_duplicados,
	COUNT(CASE WHEN conteo = 1 THEN 1 END) AS Total_Unicos,
	CAST(COUNT(CASE WHEN conteo > 1 THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS pct_duplicados
FROM duplicados_Product_ID; -- 100% Product_ID duplicados (reusados en diferentes productos)
