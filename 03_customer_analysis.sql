USE NORTHWND;
GO

-- 03 CUSTOMER ANALYSIS

-- 3.1 Top 10 Customers by Revenue
--Business Question:Which customers contribute the most to total revenue?

SELECT TOP 10
	c.CustomerID,
	c.CompanyName,
	ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2 ) AS TotalRevenue
FROM Customers c
INNER JOIN [Orders] o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY TotalRevenue DESC;

--3.2 Top 10 Customers by Number of Orders
--Business Question:Which customers have placed the most orders?

SELECT TOP 10
c.CustomerID,
c.CompanyName,
COUNT (o.OrderID) AS TotalOrders
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
	c.CustomerID,
	c.CompanyName
ORDER BY 
	TotalOrders DESC;

--3.3 Customer Revenue by Country
--Business Question:Which countries generate the highest customer revenue?

SELECT TOP 10
	c.Country,
	ROUND(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)), 2) AS TotalRevenue
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID

GROUP BY
	c.Country

ORDER BY 
	TotalRevenue DESC


SELECT
	ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) , 2) AS TotalRevenue
FROM [Order Details] od


--3.4 Average Order Value by Customer
--Business Question:What is the average order value for each customer?

SELECT
	c.CustomerID,
	c.CompanyName,

	ROUND(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) /
	COUNT(DISTINCT o.OrderID) , 2) AS AverageOrderValue

FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON  o.OrderID = od.OrderID

GROUP BY
	c.CustomerID,
	c.CompanyName
ORDER BY
	AverageOrderValue DESC


--3.5 Customers with Only One Order
--Business Question:Which customers have placed only one order?

SELECT
	c.CustomerID,
	c.CompanyName,
	COUNT(o.OrderID) AS TotalOrders
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY
	c.CustomerID, 
	c.CompanyName
HAVING 
	COUNT(o.OrderID)=1
ORDER BY 
	c.CustomerID ASC;


------------------------------------------