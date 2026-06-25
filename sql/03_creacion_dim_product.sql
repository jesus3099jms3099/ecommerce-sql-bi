-- ============================================================
-- 03 - DIMENSION PRODUCTO (una fila por Product_ID)
-- Mismo criterio que clientes: registro mas reciente (SCD Tipo 1).
-- ============================================================

CREATE TABLE Dim_Producto (
	Product_ID VARCHAR(30) PRIMARY KEY,
	Product_Category VARCHAR(30) NULL,
	Product_Subcategory VARCHAR(30) NULL,
	Brand VARCHAR(30) NULL
	);

-- Al corroborar en la auditoria de calidad que el 100% de lo Product_ID han sido reusados
-- Por ello, se decide mantener Product_ID de acuerdo al Order_ID más reciente
WITH product_rankeados AS (
	SELECT
		Product_ID,
		Product_Category,
		Product_Subcategory,
		Brand,
		ROW_NUMBER() OVER(
			PARTITION BY Product_ID
			ORDER BY Order_Date DESC, Order_ID DESC) as rn
	FROM raw_table
)

INSERT INTO Dim_Producto (
	Product_ID,Product_Category,Product_Subcategory,Brand
	)

SELECT 
	Product_ID,
	Product_Category,
	Product_Subcategory,
	Brand
FROM product_rankeados
WHERE rn=1;
