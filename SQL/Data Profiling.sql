select * from dataco_supply_chain;
SELECT COUNT(*) AS TotalRows,
	COUNT(DISTINCT Order_Id) AS UniqueOrders,
	COUNT(DISTINCT Order_Item_Id) AS UniqueOrderItems,
	COUNT(DISTINCT Customer_Id) AS UniqueCustomers,
	COUNT(DISTINCT Product_Card_Id) AS UniqueProducts
FROM dataco_supply_chain;

--dataset size and grain



--date range
SELECT 
	MIN([order_date_DateOrders]) AS FirstOrderDate,
	MAX([order_date_DateOrders]) AS LastOrderDate
FROM dataco_supply_chain;


--delivery status distribution
SELECT 
	Delivery_Status,
	COUNT(*) AS TotalRecords
FROM dataco_supply_chain
GROUP BY Delivery_Status
ORDER BY TotalRecords DESC;


--late delivery risk 
SELECT 
	Late_delivery_risk,
	COUNT(*) AS TotalRecords
FROM dataco_supply_chain
GROUP BY Late_delivery_risk;


--business KPIs
SELECT 
    COUNT(DISTINCT Order_Id) AS TotalOrders,
    SUM(Order_Item_Quantity) AS TotalQuantity,
    ROUND(SUM(Sales), 2) AS TotalSales,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS TotalProfit,
    ROUND(SUM(Order_Profit_Per_Order) * 100.0 / NULLIF(SUM(Sales), 0),2) AS ProfitMargin,
    ROUND(AVG(CAST(Days_for_shipping_real AS DECIMAL(10,2))),2) AS AverageActualShippingDays,
    ROUND(AVG(CAST(Days_for_shipment_scheduled AS DECIMAL(10,2))),2) AS AverageScheduledShippingDays
FROM dataco_supply_chain;



--missing values
SELECT
	SUM(CASE WHEN Customer_Lname IS NULL THEN 1 ELSE 0 END) AS MissingCustomerLname,
	SUM(CASE WHEN Customer_Zipcode IS NULL THEN 1 ELSE 0 END) AS MissingCustomerZipcode,
	SUM(CASE WHEN Order_Zipcode IS NULL THEN 1 ELSE 0 END) AS MissingOrderZipcode,
	SUM(CASE WHEN Product_Description IS NULL THEN 1 ELSE 0 END) AS MissingProductDescription
FROM dataco_supply_chain;


--duplicate order check
SELECT
    Order_Item_Id,
    COUNT(*) AS RecordCount
FROM dataco_supply_chain
GROUP BY Order_Item_Id
HAVING COUNT(*) > 1;


--main dimensions
SELECT
    COUNT(DISTINCT Market) AS Markets,
    COUNT(DISTINCT Order_Region) AS Regions,
    COUNT(DISTINCT Category_Name) AS Categories,
    COUNT(DISTINCT Department_Name) AS Departments,
    COUNT(DISTINCT Shipping_Mode) AS ShippingModes
FROM dataco_supply_chain;













