use AdventureWorks2012;

-- Problem 1: List all products and their suppliers.

select
	Pp.ProductID ProductID,
	pp.Name ProductName,
	PvE.Name SupplierName
from Production.Product Pp
	join Purchasing.ProductVendor PpV
		on Pp.ProductID=PpV.ProductID
	join Purchasing.Vendor PvE
		on PvE.BusinessEntityID=PpV.BusinessEntityID;

-- Problem 2: List all orders placed by a specific customer (e.g., CustomerID = 29825) along with the order details.

select 
	SoD.SalesOrderID SalesOrderID,
	SoDH.OrderDate OrderDate,
	Pp.ProductID ProductID,
	Pp.Name ProductName,
	SoD.OrderQty OderQuantity,
	SoD.UnitPrice UnitPrice,
	sod.LineTotal LineTotal
from Sales.SalesOrderDetail SoD
	join Sales.SalesOrderHeader SoDH
		on SoD.SalesOrderID=SoDH.SalesOrderID
	join Production.Product Pp
		on Pp.ProductID=sod.ProductID
	join Sales.Customer SCust
		on SCust.CustomerID=SoDH.CustomerID
where SCust.CustomerID=29825;

-- Problem 3: List all customers and their respective sales territories.

select 
	SCust.CustomerID CustomerID,
	Pp.FirstName FirstName,
	Pp.LastName LastName,
	SsT.Name Territory
from Sales.Customer SCust
	join Sales.SalesTerritory SsT
		on SCust.TerritoryID=SsT.TerritoryID
	join Person.Person Pp
		on SCust.PersonID=Pp.BusinessEntityID;

-- Problem 4: List all products with their subcategories and categories.

select 
	Pp.ProductID ProductID,
	Pp.Name ProductName,
	PpSc.Name SubcategoryName,
	PpC.Name CategoryName
from Production.Product Pp
	join Production.ProductSubcategory PpSc
		on Pp.ProductSubcategoryID=PpSc.ProductSubcategoryID
	join Production.ProductCategory PpC
		on ppc.ProductCategoryID=PpSc.ProductCategoryID;

-- Problem 5: List all vendors and their respective purchase order approvers.

select distinct
	Pv.BusinessEntityID BusinessEntityID,
	Pv.Name VendorName,
	Pp.FirstName FirstName,
	Pp.LastName LastName,
	Pe.EmailAddress EmailAddress
from Purchasing.PurchaseOrderHeader PpoH
	join Purchasing.Vendor Pv
		on PpoH.VendorID=Pv.BusinessEntityID
	join Person.Person Pp
		on PpoH.EmployeeID=Pp.BusinessEntityID
	join Person.EmailAddress Pe
		on Pp.BusinessEntityID=Pe.BusinessEntityID;