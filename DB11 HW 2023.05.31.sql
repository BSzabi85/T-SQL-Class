use AdventureWorks2012;
Go

--1. Customers who have not placed any orders

Select 
	Pp.FirstName, 
	Pp.LastName
From Person.Person Pp
Where Pp.BusinessEntityID not in
	(
	Select Sc.PersonID
	From Sales.Customer Sc
	Where sc.CustomerID in
		(
		Select CustomerID
		From Sales.SalesOrderHeader
		)
	)
Group By Pp.FirstName, Pp.LastName
Order By pp.FirstName, pp.LastName;

--2. Product with the maximum number of colors available

Select 
	Pp.ProductID, 
	Pp.Name, 
  (
	Select 
		Count(Distinct ProductPhotoID) 
  From Production.ProductProductPhoto PPh
  Where PPh.ProductID = Pp.ProductID
	) NmbColors
From Production.Product Pp
Order By NmbColors Desc;

--3. Sales person who made the highest number of sales

Select 
	Soh.SalesPersonID , 
	(
	Select Pp.FirstName
	From Person.Person Pp
	Where Pp.BusinessEntityID=SoH.SalesPersonID
	) FirstName,
	(
	Select Pp1.LastName
	From Person.Person Pp1
	Where Pp1.BusinessEntityID=SoH.SalesPersonID
	) LastName,
	Count(SalesPersonID) NmbSales
From Sales.SalesOrderHeader SoH
Where SoH.SalesPersonID is not NULL
Group By SoH.SalesPersonID
Order By NmbSales Desc;

--4. Products that are more expensive than the cheapest product in the 'Bikes' category


Select Pp.ProductID, pp.Name, pp.ListPrice,pp.ProductSubcategoryID
From Production.Product Pp
Where Pp.ListPrice  > 
	(
	Select Min(Pp1.ListPrice)
	From Production.Product Pp1
	Where Pp1.ProductSubcategoryID in
		(
		Select PpS.ProductSubcategoryID
		From Production.ProductSubcategory PpS
		Where PpS.ProductSubcategoryID in
			(
			Select Pc.ProductCategoryID
			From Production.ProductCategory PC
			Where PC.Name Like 'Bikes%'
			)
		)
	);
