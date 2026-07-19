USE NORTHWND;
GO

-- 02 PRODUCT ANALYSIS

-- 2.1 Top 10 Products by Revenue
--Business Question:Which products contribute the most to total revenue?

SELECT TOP 10
	p.ProductName,
	p.ProductID,
	ROUND(SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)), 2) AS TotalRevenue,
	SUM(od.Quantity) AS TotalSalesQuantity
FROM [Products] p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY
	p.ProductID,
	p.ProductName
ORDER BY
	TotalRevenue DESC


-- 2.2 Top 10 Products by Sales Volume
--Business Question:Which products have the highest sales volume?

SELECT TOP 10
	p.ProductName,
	p.ProductID,
	SUM(od.Quantity) AS TotalQuantity
	
FROM [Products] p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY
	p.ProductID,
	p.ProductName
ORDER BY
	TotalQuantity DESC


-- 2.3 Category Revenue Analysis
--Business Question:Which product categories generate the highest revenue?

SELECT
	c.CategoryName,
	c.CategoryID,
	ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) , 2) AS TotalRevenue
FROM [Products] p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
INNER JOIN [Categories] c ON c.CategoryID = p.CategoryID
GROUP BY
	c.CategoryName,
	c.CategoryID
ORDER BY
	TotalRevenue DESC;


--2.4 Average Product Price by Category
--Business Question:How do average product prices vary across categories?


SELECT
	c.CategoryName,
	c.CategoryID,
ROUND(AVG(p.UnitPrice), 2) AS AverageProductPrice
FROM [Products] p
INNER JOIN [Categories] c ON p.CategoryID = c.CategoryID
GROUP BY
	c.CategoryName,
	c.CategoryID
ORDER BY
	AverageProductPrice DESC;

--2.5 Products Never Sold
-- Business Question:Which products have never been sold?

SELECT
	p.ProductID,
	p.ProductName

FROM [Products] p
LEFT JOIN [Order Details] od ON p.ProductID = od.ProductID
WHERE od.OrderID IS NULL;

--2.6 Low Stock Products
--Business Question:Which products are low in stock?

SELECT
	ProductID,
	ProductName,
	UnitsInStock,
	UnitsOnOrder,
	ReorderLevel

FROM Products
WHERE UnitsInStock <=ReorderLevel
ORDER BY UnitsInStock;

------------------------------------------------------------------------