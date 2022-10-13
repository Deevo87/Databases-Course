select ContactName, Address FROM Customers

SELECT ContactName,Address from Customers where Country = 'Spain' or Country = 'France'

select ProductName, UnitPrice from Products where UnitPrice between 20 and 30

select ProductName, UnitPrice from Products where CategoryID = 6

select ProductName from Products where UnitsInStock =0