-- ============================================================
-- 09 · VISTA DE REPORTE PARA POWER BI
-- Capa de consumo: desnormaliza fact_orders + dimensiones para que Power BI
-- no consulte las tablas base directamente y la BD quede intacta.
-- ============================================================

USE Ecom_SupplyChain_DB;
GO

CREATE VIEW dbo.vw_Reporte_Ordenes
AS
SELECT
	c.Customer_ID,
	c.Country,
	c.City,
	p.Product_ID,
	p.Product_Category,
	p.Product_Subcategory,
	p.Brand,
	f.Order_ID,
	f.Order_date,
	f.Quantity,
    f.Order_Amount,
    f.Shipping_Cost,
    f.Profit_Amount,
    f.Delivery_Days,
    f.Review_Rating,
	f.Customer_Segment
FROM Fact_Orders f
JOIN Dim_Clientes c
	ON f.Customer_ID = c.Customer_ID
JOIN Dim_Producto p
	ON f.Product_ID = p.Product_ID;