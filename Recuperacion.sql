--Para la base de datos de AdventureWorks2014:

--1 Identifique llave primaria, llaves foraneas e índices de:
-- [Production].[ProductCostHistory]
-- [Production].[Location]
-- [Person].[StateProvince]
-- [HumanResources].[EmployeeDepartmentHistory]
-- [HumanResources].[Employee]

USE AdventureWorks2014 
GO  
  
SELECT * FROM information_schema.key_column_usage  
WHERE table_name = 'ProductCostHistory' or table_name = 'StateProvince' or table_name = 'EmployeeDepartmentHistory' or table_name = 'Employee'
GO

USE AdventureWorks2014 
GO  
select * from sys.indexes
where object_id = (select object_id from sys.objects where name = 'Location') 
or object_id = (select object_id from sys.objects where name = 'StateProvince') 
or object_id = (select object_id from sys.objects where name = 'EmployeeDepartmentHistory')
or object_id = (select object_id from sys.objects where name = 'Employee') 

-- 2 Mostrar listado del histórico de precios de productos que han sido modificados el '2013-05-16'

select ProductCostHistory.ProductID, Name, ProductCostHistory.StandardCost,ProductCostHistory.ModifiedDate from Production.ProductCostHistory
join Production.Product
on ProductCostHistory.ProductID = Product.ProductID 
where ProductCostHistory.ModifiedDate = '2013-05-16' 

-- 3 ¿Cuántos empleados que no tienen el título de ingenieros de desarrollo e investigación están casados?

Select COUNT(*) from HumanResources.Employee
where JobTitle != 'Research and Development Engineer' and MaritalStatus = 'M'

-- 4 Mostrar listado de empleados que se encuentran en el departamento de ventas y mercadeo, residen en el estado de Colorado y no han realizado ventas.

-- 5 ¿Cuántos y cuáles empleados no han cambiado de departamento a lo largo de su historia laboral?

SELECT EmployeeDepartmentHistory.BusinessEntityID, FirstName, LastName FROM HumanResources.EmployeeDepartmentHistory
join Person.Person p
on EmployeeDepartmentHistory.BusinessEntityID = p.BusinessEntityID
GROUP BY EmployeeDepartmentHistory.BusinessEntityID, FirstName, LastName
HAVING COUNT(EmployeeDepartmentHistory.BusinessEntityID) = 1;

-- R: 285 personas no han cambiado de departamento a lo largo de su historia laboral.

-- 6 ¿Cuál es el nombre del producto que más se ha vendido? 

-- 7 ¿Cuál es la cantidad total de productos que se encuentran ubicados en la localización de 'Metal Storage'?

Select Count(ProductInventory.LocationID), Location.Name from Production.ProductInventory 
join Production.Location
On ProductInventory.LocationID = Location.LocationID
Where ProductInventory.LocationID = '5'
Group by ProductInventory.LocationID, Location.Name

-- R: Hay 51 productos que se encuentran ubicados en Metal Storage.

-- 8 ¿Cuantós empleados que trabajan en el turno de noche, han realizado ventas superiores a 865.204?