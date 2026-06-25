-- ============================================================
-- 06 - TABLA DE HECHOS (grano: una orden = una fila; Order_ID unico)
-- Reune metricas + FKs a las 4 dimensiones. 
-- Llave natural en Clientes/Producto y surrogate en Canal/Logistica.
-- ============================================================

USE Ecom_SupplyChain_DB;

CREATE TABLE Fact_Orders (
-- Llaves foraneas
	Customer_ID VARCHAR(20) NOT NULL,
	Product_ID VARCHAR(30) NOT NULL,
	Canal_Key INT NOT NULL,
	Logistica_Key INT NOT NULL,

-- Llaves del negocio y tiempo
	Order_ID VARCHAR(30) PRIMARY KEY NOT NULL,
	Order_date DATE NOT NULL,

-- Datos de métrica
	Unit_Price DECIMAL(18,2),
	Quantity INT,
	Discount_Percent DECIMAL(18,2),
	Discount_Amount DECIMAL(18,2), 
	Shipping_Cost DECIMAL(18,2), 
	Tax_Amount DECIMAL(18,2), 
	Order_Amount DECIMAL(18,2), 
	Profit_Amount DECIMAL(18,2), 
	Profit_Margin_Percent DECIMAL(18,2),
	Delivery_Days INT, 
	Review_Rating DECIMAL(18,2), 
	Customer_Lifetime_Value DECIMAL(18,2),
	Customer_Segment VARCHAR(30),

-- Indicadores lógicos
	Coupon_Used INT, 
	Returned INT, 
	High_Value_Order INT,

-- Restricciones de FK
	CONSTRAINT FK_FactOrders_DimClientes FOREIGN KEY (Customer_ID) REFERENCES Dim_Clientes (Customer_ID),
	CONSTRAINT FK_FactOrders_DimProducto FOREIGN KEY (Product_ID) REFERENCES Dim_Producto (Product_ID),
	CONSTRAINT FK_FactOrders_DimCanal FOREIGN KEY (Canal_Key) REFERENCES Dim_Canal (Canal_Key),
	CONSTRAINT FK_FactOrders_DimLogistica FOREIGN KEY (Logistica_Key) REFERENCES Dim_Logistica (Logistica_Key)
);

-- Agregar valores a la tabla nueva Fact_Orders
INSERT INTO Fact_Orders (
	Customer_ID,Product_ID,Canal_Key,Logistica_Key,Order_ID,
	Order_date,Unit_Price,Quantity,Discount_Percent,
	Discount_Amount,Shipping_Cost,Tax_Amount,Order_Amount, 
	Profit_Amount,Profit_Margin_Percent,Delivery_Days,Review_Rating,
	Customer_Lifetime_Value,Customer_Segment,Coupon_Used,Returned,High_Value_Order
)

SELECT
	c.Customer_ID,
	p.Product_ID,
	ca.Canal_Key,
	lo.Logistica_Key,
	r.Order_ID,
	r.Order_date,
	r.Unit_Price,
	r.Quantity,
	r.Discount_Percent,
	r.Discount_Amount,
	r.Shipping_Cost,
	r.Tax_Amount,
	r.Order_Amount, 
	r.Profit_Amount,
	r.Profit_Margin_Percent,
	r.Delivery_Days,
	r.Review_Rating,
	r.Customer_Lifetime_Value,
	r.Customer_Segment,
	r.Coupon_Used,
	r.Returned,
	r.High_Value_Order

FROM raw_table r
JOIN Dim_Clientes c
	ON r.Customer_ID = c.Customer_ID
JOIN Dim_Producto p
	ON r.Product_ID = p.Product_ID
JOIN Dim_Canal ca
	ON ca.Device_Type = r.Device_Type
	AND ca.Membership_Status = r.Membership_Status
	AND ca.Payment_Method = r.Payment_Method
	AND ca.Traffic_Source = r.Traffic_Source
JOIN Dim_Logistica lo
	ON lo.Order_Status = r.Order_Status
	AND lo.Shipping_Method = r.Shipping_Method
	AND lo.Warehouse_Region = r.Warehouse_Region;
