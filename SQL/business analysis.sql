
--business KPIs
SELECT
    COUNT(DISTINCT Order_Id) AS TotalOrders,
    SUM(Order_Item_Quantity) AS TotalQuantity,
    ROUND(SUM(Sales), 2) AS TotalSales,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS TotalProfit,
    ROUND(SUM(Order_Profit_Per_Order) * 100.0 / SUM(Sales),2) AS ProfitMargin,
    ROUND(SUM(CAST(Late_delivery_risk AS INT)) * 100.0 / COUNT(*),2) AS LateDeliveryRate
FROM dataco_supply_chain;


--monthly sales,profit and order trend
SELECT
    YEAR(order_date_DateOrders) AS OrderYear,
    MONTH(order_date_DateOrders) AS OrderMonth,
    COUNT(DISTINCT Order_Id) AS TotalOrders,
    ROUND(SUM(Sales), 2) AS TotalSales,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS TotalProfit
FROM dataco_supply_chain
GROUP BY
    YEAR(order_date_DateOrders),
    MONTH(order_date_DateOrders)
ORDER BY
    OrderYear,
    OrderMonth;



--market performance
SELECT
    Market,
    COUNT(DISTINCT Order_Id) AS TotalOrders,
    ROUND(SUM(Sales), 2) AS TotalSales,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS TotalProfit,
    ROUND(SUM(Order_Profit_Per_Order) * 100.0 / SUM(Sales),2) AS ProfitMargin
FROM dataco_supply_chain
GROUP BY Market
ORDER BY TotalSales DESC;




--regional performance
SELECT
    Order_Region,
    COUNT(DISTINCT Order_Id) AS TotalOrders,
    ROUND(SUM(Sales), 2) AS TotalSales,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS TotalProfit
FROM dataco_supply_chain
GROUP BY Order_Region
ORDER BY TotalSales DESC;


--product category performance
SELECT
    Category_Name,
    SUM(Order_Item_Quantity) AS QuantitySold,
    ROUND(SUM(Sales), 2) AS TotalSales,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS TotalProfit,
    ROUND(SUM(Order_Profit_Per_Order) * 100.0 / SUM(Sales),2) AS ProfitMargin
FROM dataco_supply_chain
GROUP BY Category_Name
ORDER BY TotalSales DESC;




--shipping mode performance
SELECT
    Shipping_Mode,
    COUNT(DISTINCT Order_Id) AS TotalOrders,
    ROUND(AVG(CAST(Days_for_shipping_real AS DECIMAL(10,2))),2) AS AverageShippingDays,
    ROUND(SUM(CAST(Late_delivery_risk AS INT)) * 100.0 / COUNT(*),2) AS LateDeliveryRate
FROM dataco_supply_chain
GROUP BY Shipping_Mode
ORDER BY LateDeliveryRate DESC;



--delivery status distribution
SELECT
    Delivery_Status,
    COUNT(*) AS TotalRecords,
    ROUND(COUNT(*) * 100.0 /(SELECT COUNT(*) FROM dataco_supply_chain),2) AS PercentageOfRecords
FROM dataco_supply_chain
GROUP BY Delivery_Status
ORDER BY TotalRecords DESC;


--customer segment performance
SELECT
    Customer_Segment,
    COUNT(DISTINCT Order_Id) AS TotalOrders,
    ROUND(SUM(Sales), 2) AS TotalSales,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS TotalProfit
FROM dataco_supply_chain
GROUP BY Customer_Segment
ORDER BY TotalSales DESC;



--loss making categories
SELECT
    Category_Name,
    ROUND(SUM(Sales), 2) AS TotalSales,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS TotalProfit
FROM dataco_supply_chain
GROUP BY Category_Name
HAVING SUM(Order_Profit_Per_Order) < 0
ORDER BY TotalProfit;




