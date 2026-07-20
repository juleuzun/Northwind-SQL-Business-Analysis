USE NORTHWND;
GO

-- 04 SALES TREND ANALYSIS

--4.1 Revenue by Year
--Business Question:How has total revenue changed over the years?

SELECT
	YEAR(o.OrderDate) AS OrderYear,
	ROUND(SUM(od.UnitPrice * od.Quantity * (1 -od.Discount)) , 2) AS TotalRevenue
	
FROM Orders o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID

GROUP BY YEAR(o.OrderDate)
ORDER BY OrderYear;


--4.2 Revenue by Month
--Business Question:Which months generate the highest revenue?

SELECT
	DATENAME(MONTH,o.OrderDate) AS OrderMonth,
	ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS TotalRevenue

FROM Orders o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID

GROUP BY DATENAME(MONTH, o.OrderDate)
ORDER BY TotalRevenue DESC;


--4.3 Orders by Year
--Business Question:How many orders were placed each year?

SELECT
	YEAR(o.OrderDate) AS OrderYear,
	COUNT(o.OrderID) AS TotalOrders


FROM Orders o
GROUP BY YEAR(o.OrderDate)
ORDER BY OrderYear;


--4.4 Monthly Sales Trend
--Business Question:How does monthly sales revenue change over time?

SELECT
	YEAR(o.OrderDate) AS OrderYear,
	DATENAME(Month,o.OrderDate) AS OrderMonth,
	ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) , 2) AS TotalRevenue

FROM Orders o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY YEAR(o.OrderDate), MONTH(OrderDate), DATENAME(Month,o.OrderDate)
ORDER BY YEAR(o.OrderDate)  DESC, MONTH(o.OrderDate);


--4.5 Monthly Order Count
--Business Question:How many orders were placed each month?

SELECT
	DATENAME(MONTH,o.OrderDate) AS OrderMonth,
	COUNT(o.OrderID) AS TotalOrders

FROM Orders o
GROUP BY MONTH(o.OrderDate), DATENAME(MONTH,o.OrderDate)
ORDER BY MONTH(o.OrderDate) DESC;

