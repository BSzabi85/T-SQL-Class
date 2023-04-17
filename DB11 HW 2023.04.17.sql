use AdventureWorks2012;

/* 
1. You have to create a report based on the tables Production.Product and Production.ProductCategory.
The report should contain the product name and the category name of each product.
*/

select 
	Pr.Name ProductName, 
	PCat.Name ProductCathegory 
from Production.Product Pr
join Production.ProductSubcategory PSub
on Pr.ProductSubcategoryID=PSub.ProductSubcategoryID
join Production.ProductCategory PCat
on PSub.ProductCategoryID=PCat.ProductCategoryID;

/*
2. Write a query that returns all customers who placed at least one order, with detailed information about eachone. The tables are Sales.Customers, Sales.SalesOrderHeader and Sales.OrderDetails.
*/

select 
	Cu.CustomerID CustomerID, 
	Sh.OrderDate OrderDate, 
	Sd.ProductID ProductID, 
	Sd.OrderQty OrderQty, 
	Sd.UnitPrice UnitPrice,
	Sd.LineTotal TotalPrice
from Sales.Customer Cu
join Sales.SalesOrderHeader Sh
on Cu.CustomerID=Sh.CustomerID
join Sales.SalesOrderDetail Sd
on Sh.SalesOrderID=Sd.SalesOrderID;

/*
3. You have to create a report based on the tables Production.ProductSubcategory and Production.ProductCategory.
The report should return every combination between the category name and the subcategory name.
*/

select 
	Pc.Name CategoryName, 
	Ps.Name SubCategoryName
from Production.ProductCategory Pc
cross join Production.ProductSubcategory Ps;