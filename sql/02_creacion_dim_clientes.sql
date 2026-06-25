-- ============================================================
-- 02 - DIMENSION CLIENTES (una fila por Customer_ID)
-- La fuente es inconsistente (ver 01), por eso se resuelve al
-- registro mas reciente de cada cliente (SCD Tipo 1)
-- ============================================================

USE Ecom_SupplyChain_DB;

CREATE TABLE Dim_Clientes (
	Customer_ID VARCHAR(20) PRIMARY KEY,
	Customer_Age TINYINT NULL,
	Customer_Gender VARCHAR(10) NULL,
	Country VARCHAR(20) NULL,
	City VARCHAR(20) NULL
	);

-- Al corroborar en la auditoria de calidad que el 100% de lo Customer_ID han sido reusados
-- Por ello, se decide mantener Customer_ID de acuerdo al Order_ID más reciente

WITH customer_rankeado AS (
	SELECT
	Customer_ID,
	Customer_Age,
	Customer_Gender,
	Country,
	City,
	ROW_NUMBER() OVER (
		PARTITION BY Customer_ID
		ORDER BY Order_Date DESC, Order_ID DESC) as rn
FROM raw_table
) 
	
INSERT INTO Dim_Clientes (
	Customer_ID, 
	Customer_Age, 
	Customer_Gender, 
	Country,
	City
	)

SELECT
	Customer_ID,
	Customer_Age,
	Customer_Gender,
	Country,
	City
FROM cutomer_rankeado
WHERE rn=1;
