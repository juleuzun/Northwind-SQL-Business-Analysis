USE NORTHWND;
GO

--01 KPI ANALYSIS

--1.1 Total Revenue
--Business Question:What is the total revenue?

SELECT
	ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) , 2) AS TotalRevenue
FROM [Order Details] od

--1.2 Total Orders
--Business Question:How many orders have been placed?

SELECT
	COUNT(OrderID) AS TotalOrders
FROM Orders

--1.3 Average Order Value (AOV)
--Business Question:What is the average order value (AOV)?

SELECT
	ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) / 
	COUNT(DISTINCT od.OrderID) , 2 ) AS AverageOrderValue
FROM [Order Details] od

--1.4 Total Customers
--Business Question:How many customers are there?

SELECT
	COUNT(CustomerID) AS TotalCustomers
FROM Customers

---------------------------------------------------------------------
