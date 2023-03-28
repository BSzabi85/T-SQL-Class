--HW Szabi DB11

USE AdventureWorks2012;

-- 1. Retrieve the top 10 most expensive products in the 'Product' table.  
SELECT TOP 10 * 
FROM Production.Product 
ORDER BY ListPrice DESC;

-- 2. Find the total number of products for each product subcategory.

SELECT ProductCategoryID, COUNT(*) AS NmbCategory
FROM Production.ProductSubcategory
GROUP BY ProductCategoryID;

-- 3. List all products that have a standard cost between $100 and $500.

SELECT * 
FROM Production.Product
WHERE StandardCost >= 100 AND StandardCost <= 500;


-- 4. Retrieve the top 5 product subcategories with the highest average list price.

SELECT TOP 5 ProductSubcategoryID, AVG(ListPrice) AS AvgPrice
FROM Production.Product
GROUP BY ProductSubcategoryID 
ORDER BY AvgPrice DESC;

-- 5. Find the total number of discontinued products.

SELECT COUNT(sellenddate) AS DiscontinuedProducts
FROM Production.Product;

