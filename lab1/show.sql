 select Distinct C.CompanyName, C.Phone from Customers as C
     where C.CustomerID NOT IN (
select Distinct C.CustomerID from Customers as C
inner join Orders O on C.CustomerID = O.CustomerID
inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
inner join Products P on P.ProductID = [O D].ProductID
inner join Categories C2 on C2.CategoryID = P.CategoryID
where C2.CategoryName = 'Confections'
)