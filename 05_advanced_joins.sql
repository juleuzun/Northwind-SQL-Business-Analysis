USE NORTHWND;
GO

--05 ADVANCED JOINS

--5.1 Employee Sales Performance	
--Business Question:Which employees generated the highest revenue?

SELECT
	e.EmployeeID,
	CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
	ROUND(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)),2) AS TotalRevenue


FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalRevenue DESC;


--5.2 Orders by Shipper	
--Business Question:Which shipping companies handled the most orders?

SELECT
	s.CompanyName,
	s.ShipperID,
	COUNT(o.OrderID) AS TotalOrders

FROM Orders o
INNER JOIN Shippers s ON o.ShipVia = s.ShipperID

GROUP BY s.ShipperID, s.CompanyName
ORDER BY TotalOrders DESC;


--5.3 Customers Without Orders	
--Business Question:Which customers have never placed an order?

SELECT
	c.CustomerID,
	c.CompanyName,
	o.OrderID

FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID 

WHERE o.OrderID IS NULL


--5.4 Products by Supplier	
--Business Question:Which suppliers provide the highest number of products?

SELECT
s.SupplierID,
s.CompanyName,
COUNT(p.ProductID) AS TotalProducts


FROM Suppliers s
INNER JOIN Products p ON s.SupplierID = p.SupplierID

GROUP BY
s.SupplierID,
s.CompanyName

ORDER BY
TotalProducts DESC

--5.5 Revenue by Supplier	
--Business Question:Which suppliers generate the highest sales revenue?

SELECT
	s.SupplierID,
	s.CompanyName,
	ROUND(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)),2) AS TotalRevenue

FROM Suppliers s
INNER JOIN Products p ON s.SupplierID = p.SupplierID
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID

GROUP BY 
s.CompanyName,
s.SupplierID

ORDER BY
TotalRevenue DESC;


--5.6 Products per Category and Supplier	
--Business Question:Which suppliers provide the highest number of products in each category?

SELECT
	c.CategoryName,
	s.CompanyName,
	s.SupplierID,
	COUNT(p.ProductID) AS TotalProducts


FROM Categories c
INNER JOIN Products p ON c.CategoryID = p.CategoryID
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID

GROUP BY
c.CategoryName,
s.SupplierID,
s.CompanyName

ORDER BY
TotalProducts DESC;

