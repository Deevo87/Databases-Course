--cw1
select o.OrderID, CompanyName, sum([O D].Quantity) as ilosc from Orders as o
    inner join Customers C on o.CustomerID = C.CustomerID
    inner join [Order Details] [O D] on o.OrderID = [O D].OrderID
    group by o.OrderID, CompanyName
    having sum([O D].Quantity) > 250


select o.OrderID, CompanyName, concat(E.FirstName, ' ', E.LastName) as obsluga, sum(convert(money, ([O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount)))) as kwota from Orders as o
    inner join Customers C on o.CustomerID = C.CustomerID
    inner join [Order Details] [O D] on o.OrderID = [O D].OrderID
    inner join Employees E on E.EmployeeID = o.EmployeeID
    group by o.OrderID, CompanyName, concat(E.FirstName, ' ', E.LastName)
    having sum([O D].Quantity) > 250


---=-------------------------------- cw2
select P.categoryId, sum([O D].Quantity) as ilosc from Products as P
    inner join [Order Details] [O D] on P.ProductID = [O D].ProductID
    group by P.categoryId


select P.categoryId, sum(convert(money, ([O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount)))) as kwota from Products as P
    inner join [Order Details] [O D] on P.ProductID = [O D].ProductID
    group by P.categoryId
--    order by sum(convert(money, ([O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount))))
    order by sum([O D].Quantity)

select O.OrderID, (sum(convert(money, ([O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount)))) - O.Freight) as kwota from Orders as O
    inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
group by O.OrderID, O.Freight


--------------------------------CW3

select S.CompanyName, count(*)  from Shippers as S -- top1
    inner join Orders O on S.ShipperID = O.ShipVia
    where YEAR(O.ShippedDate) = 1997
    group by S.CompanyName
    order by count(*) DESC

--3/5
select TOP 1 concat(E.firstname, ' ', E.lastname) as imie, sum(convert(money, ([O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount)))) as kwota   from Employees as E
    inner join Orders O on E.EmployeeID = O.EmployeeID
    inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
    group by concat(E.firstname, ' ', E.lastname)
    order by sum(convert(money, ([O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount)))) DESC

select TOP 1 concat(E.firstname, ' ', E.lastname) as imie, count(*)  from Employees as E
    inner join Orders O on E.EmployeeID = O.EmployeeID
    where year(O.OrderDate) = 1997
    group by concat(E.firstname, ' ', E.lastname)
    order by  count(*) DESC


--------------------------------cw4
select  concat(E.firstname, ' ', E.lastname) as imie, sum(convert(money, ([O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount)))) as kwota   from Employees as E
    inner join Orders O on E.EmployeeID = O.EmployeeID
    inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
    group by concat(E.firstname, ' ', E.lastname)

select * from Employees

--a wykonane inner joinem
    select  concat(E.firstname, ' ', E.lastname) as imie, sum(convert(money, ([O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount)))) as kwota   from Employees as E
    inner join Orders O on E.EmployeeID = O.EmployeeID
    inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
    inner join Employees Podwladni on E.EmployeeID = Podwladni.ReportsTo
    group by concat(E.firstname, ' ', E.lastname)

--B wykonane outer joinem
    select  concat(E.firstname, ' ', E.lastname) as imie, sum(convert(money, ([O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount)))) as kwota   from Employees as E
    inner join Orders O on E.EmployeeID = O.EmployeeID
    inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
    full outer join Employees Podwladni on E.EmployeeID = Podwladni.ReportsTo
    where Podwladni.ReportsTo is NULL
    group by concat(E.firstname, ' ', E.lastname)
    having sum(convert(money, ([O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount)))) is not null











