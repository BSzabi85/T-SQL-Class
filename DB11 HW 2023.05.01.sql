use AdventureWorks2012;

--1. Order details to text.

select
	Pp.FirstName + ' ' + Pp.LastName + ', having ID '+ cast(Sc.PersonID as varchar(10)) + ', ordered ' + CAST(SoD.OrderQty as varchar(3))
	+ ' pcs ' + Prod.Name + ' for ' + Cast(SoD.LineTotal as varchar(12)) + '$'
from Person.Person Pp
	join Sales.Customer Sc
		on Pp.BusinessEntityID=Sc.PersonID
	join Sales.SalesOrderHeader SoH
		on SoH.CustomerID=Sc.CustomerID
	join Sales.SalesOrderDetail SoD
		on SoD.SalesOrderID=SoH.SalesOrderID
	join Production.Product Prod
		on SoD.ProductID=Prod.ProductID
 order by Pp.FirstName, Pp.LastName;

--2. Upper case Names

select top 5 
	upper(Pp.name)
from Production.Product Pp
order by Pp.name;

--3. Reverse full names

select  FirstName,
		Case 
			when MiddleName is null then
				'N/A'
			when MiddleName is not null then
				MiddleName
		end as MiddleName,
		LastName,
		'->' as ' ', 
		case 
			when MiddleName IS NULL then
				concat(reverse(lastname),' ', reverse(Firstname))
			when middlename is not null then 
				concat(reverse(LastName), ' ', reverse(MiddleName), ' ', reverse(FirstName))
		end 
		as ReverseName
from Person.Person Pp
where BusinessEntityID<10
order by FirstName;

--4. Total orders grouped by days of week.

select 
	count(*) as TotalComenzi, 
	Case
		when datename(weekday,OrderDate)='Monday' then 'Luni'
		when datename(weekday,OrderDate)='Tuesday' then 'Marti'
		when datename(weekday,OrderDate)='Wednesday' then 'Miercuri'
		when datename(weekday,OrderDate)='Thursday' then 'Joi'
		when datename(weekday,OrderDate)='Friday' then 'Vineri'
		when datename(weekday,OrderDate)='Saturday' then 'Sambata'
		when datename(weekday,OrderDate)='Sunday' then 'Duminica'
 end
 as ZileSaptamana
from Sales.SalesOrderHeader
group by datename(weekday,OrderDate)
order by count(*) desc;

--5. Total orders grouped by days of week.

select 
	count(*) as NrComenzi,
	day(orderdate) as ZiDinLuna
from sales.SalesOrderHeader
group by day(orderdate)
order by day(orderdate);

--6. Sold product by sesons of the year. For ex ProductID 811, LL Road Handlebars were sold only in Spring and Summer

select distinct
	Pp.ProductID ID,
	Pp.Name ProductName,
	choose(month(SoH.OrderDate),'Winter', 'Winter', 'Spring', 'Spring', 'Spring', 'Summer', 'Summer', 'Summer', 'Autumn', 'Autumn', 'Autumn', 'Winter') TimeOfYear
from Sales.SalesOrderHeader SoH
	join Sales.SalesOrderDetail SoD
		on SoH.SalesOrderID=SoD.SalesOrderID
	join Production.Product Pp
		on SoD.ProductID=Pp.ProductID
order by Pp.Name;

--7. Round Function

select 
	SalesOrderID, 
	TotalDue, 
	round(Totaldue,0) RoundedToWhole, 
	round(TotalDue,1) RoundedTo1Decimals,
	round(TotalDue,2) RoundedTo2Decimals
from sales.SalesOrderHeader;

--8. Small chart for ordered items using replicate function.

select 
	Prod.Name, 
	count(SoD.OrderQty) TotalOrdered, 
	replicate('|', (count(SoD.OrderQty)/10)+1) Chart	
from Sales.SalesOrderDetail SoD
	join Production.Product Prod
		on SoD.ProductID=Prod.ProductID
group by Prod.Name
order by prod.Name;

--9. Chaning date format.

select 
	SalesOrderID,
	OrderDate,
	format(OrderDate,'D','en-US') LongDate
from Sales.SalesOrderHeader;

--10. Days since last order by CustomerID

select
	CustomerID,
	max(orderdate) LastOrdered,
	datediff(d,max(orderdate),getdate()) as Days_since_last_order
from Sales.SalesOrderHeader
group by CustomerID
order by Days_since_last_order desc;

--11. Generate recommended USERID

select
	BusinessEntityID,
	FirstName,
	LastName,
	concat(lower(FirstName),lower(LastName), right(cast(BusinessEntityID as varchar(6)),3)) as UniqueID
from Person.Person;

--12. Avarage sales by productID

select 
	SoD.ProductID,
	Pp.Name,
	avg(SoD.OrderQty) AvarageQtyOrdered,
	count(SoD.OrderQty) TotalOrdered
from Sales.SalesOrderDetail SoD
	join Production.Product Pp
		on SoD.ProductID=Pp.ProductID
group by SoD.ProductID, Pp.Name
order by Pp.Name;

--13. Calculate 30 day duedate for each order.

select 
	SalesOrderID,
	OrderDate,
	dateadd(day, 30, OrderDate) as DueDate
from Sales.SalesOrderHeader;

--14. Price rounded to 2 decimals, find the first letter of color, find product description lenght for 
-- products where discontinued date is NULL.

select
	Pp.ProductID, 
	Pp.Name,
	round(Pp.ListPrice, 2) AS RoundedPrice,
	upper(substring(Pp.Color, 1, 1)) AS FirstLetterColor,
	len(PDesc.Description) AS DescriptionLength
from Production.Product Pp
	join Production.ProductModelProductDescriptionCulture PMod
		on Pp.ProductModelID=PMod.ProductModelID
	join Production.ProductDescription PDesc
		on PMod.ProductDescriptionID=PDesc.ProductDescriptionID
where Pp.DiscontinuedDate IS NULL;

--15. Hiding certain characters at output in a string

select 
	SalesOrderID,
	salesordernumber,
	stuff(SalesOrderNumber,3,3,'***') MaskedSalesOrderNumer,
	OrderDate
from Sales.SalesOrderHeader;

--16. Show Top X number of RANDOM products having color Black, Silver or Red

select top 5 
	ProductID, 
	Name, 
	ListPrice, 
	Color
from Production.Product
where Color IN ('Black', 'Silver', 'Red')
order by newid();

--17. Generate a random number using CHECKSUM, ABS to make sure it is a positive number, " % " to restrict the value to a number between 0 and 99 and add 1 to it

 declare @R as tinyint
 set @r=abs(checksum(newid())) % 100 + 1 
 select 
	@R as Radius, 
	pi()*2*@R as Circuference , 
	pi()*power(@R,2) as Surface;

--18. C		onvert price to binary

select ListPrice, convert(binary(5),ListPrice)
from Production.Product
where ListPrice > 0;

--19. See discountes price by discountpct

select distinct
	prod.Name,
	sod.UnitPrice,
	spec.DiscountPct,
	cast(sod.UnitPrice*(1-spec.DiscountPct) as varchar(30)) as DiscountedPrice
from Sales.SalesOrderDetail sod
	join Sales.SpecialOffer spec
		on sod.SpecialOfferID=spec.SpecialOfferID
	join Production.Product prod
		on prod.ProductID=sod.ProductID
order by spec.DiscountPct desc;

--20. Each customers total order ammount.

select
 concat(upper(PP.FirstName), ' ',
 upper(PP.LastName)),
 cast(sum(SOD.LineTotal) as varchar(30)) TotalOrdered
from Sales.SalesOrderDetail SOD
	join Sales.SalesOrderHeader SOH
		on sod.SalesOrderID=SOH.SalesOrderID
	join Person.Person PP
		on PP.BusinessEntityID=SOH.CustomerID
group by PP.FirstName, PP.LastName, PP.BusinessEntityID
order by pp.BusinessEntityID;
