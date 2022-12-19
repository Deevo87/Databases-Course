select ContactName, Address FROM Customers

SELECT ContactName,Address from Customers where Country = 'Spain' or Country = 'France'

select ProductName, UnitPrice from Products where UnitPrice between 20 and 30

select ProductName, UnitPrice from Products where CategoryID = 6

select ProductName from Products where UnitsInStock =0

select ProductName, QuantityPerUnit from Products where QuantityPerUnit like '%bottle%'

select Title, LastName from Employees where LastName like '[B-L]%'

select Title, LastName from Employees where LastName like '[BL]%'

SELECT CategoryName from Categories where Categories.Description like '%,%'

select CompanyName from Customers where CompanyName like '%store%'

select Distinct ShipCountry from Orders

select OrderID, OrderDate, CustomerID from Orders where (ShippedDate > GETDATE() or ShippedDate is null) AND ShipCountry ='Argentina'

select CompanyName, Country from Customers
ORDER BY Country, CompanyName

select CategoryID, ProductName, UnitPrice from Products
order by CategoryID, UnitPrice desc

select CompanyName, Country from Customers where Country in ('Japan', 'Italy')
order by Country, CompanyName

select phone, fax from Suppliers

select isnull(phone,'') + ',' + isnull(Fax,'') as zad from Suppliers

--- ci mają podwłądnych
 select a.EmployeeID from Employees as a
 inner join Employees as b on a.EmployeeID = b.ReportsTo

