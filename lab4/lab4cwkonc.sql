 --- cw 1
SELECT C.CompanyName, C.Phone from Customers as C
where C.CustomerID IN (
select Orders.CustomerID from Orders
inner join Shippers S on S.ShipperID = Orders.ShipVia
where S.CompanyName = 'United Package' and  year(ShippedDate) = 1997
               )

select Distinct C.CompanyName, C.Phone from Customers as C
inner join Orders O on C.CustomerID = O.CustomerID
inner join Shippers S on S.ShipperID = O.ShipVia
where S.CompanyName = 'United Package' and  year(ShippedDate) = 1997

 select Distinct C.CompanyName, C.Phone from Customers as C
inner join Orders O on C.CustomerID = O.CustomerID
inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
inner join Products P on P.ProductID = [O D].ProductID
inner join Categories C2 on C2.CategoryID = P.CategoryID
where C2.CategoryName = 'Confections'

 select Distinct C.CompanyName, C.Phone from Customers as C
     where C.CustomerID NOT IN (
select Distinct C.CustomerID from Customers as C
inner join Orders O on C.CustomerID = O.CustomerID
inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
inner join Products P on P.ProductID = [O D].ProductID
inner join Categories C2 on C2.CategoryID = P.CategoryID
where C2.CategoryName = 'Confections'
)


--------------------cw2

 select P.ProductID, max([O D].Quantity) as max from Products as P
 inner join [Order Details] [O D] on P.ProductID = [O D].ProductID
 group by P.ProductID


select ProductID from Products
where UnitPrice < (select avg(UnitPrice) from Products)

---cw 2.3
select productid, prod_zew.CategoryID, UnitPrice, (select avg(UnitPrice) from Products as p_wewn where p_wewn.CategoryID = prod_zew.CategoryID) as 'sredniaKat' from Products as prod_zew
where UnitPrice < (select avg(UnitPrice) from Products as p_wewn where p_wewn.CategoryID = prod_zew.CategoryID)

 SELECT productname, unitprice
,( SELECT AVG(unitprice) FROM products as p_wew
WHERE p_zewn.CategoryID = p_wew.categoryid ) AS
average
FROM products as p_zewn
WHERE p_zewn.UnitPrice <
( SELECT AVG(unitprice) FROM products as p_wew
WHERE p_zewn.CategoryID = p_wew.categoryid )


---- cw 3
select ProductName, UnitPrice, (select avg(UnitPrice) from Products) as srednia,
       (UnitPrice - (select avg(UnitPrice) from Products)) as diff
       from Products

select  C.CategoryName,P.ProductName, P.UnitPrice,
    (select avg(unitPrice) from Products as inP where inP.CategoryID =C.CategoryID) as srednia,
    (UnitPrice - (select avg(unitPrice) from Products as inP where inP.CategoryID =C.CategoryID)) as diff
    from Products as P
    inner join Categories C on C.CategoryID = P.CategoryID


---cw 4

select O.OrderId, (sum(convert(money, OD.UnitPrice * OD.Quantity * (1-OD.Discount))) + O.Freight) from Orders as O
    inner join [Order Details] OD on O.OrderID = OD.OrderID
    group by O.OrderId, O.Freight


SELECT C.Address FROM Customers AS C
WHERE C.CustomerID NOT IN
    ( SELECT O.CustomerID FROM Orders AS O WHERE year(O.OrderDate) = 1997 )

select x.ProductId, count(Distinct x.CustomerID) as wynik from
    (select Distinct P.ProductId, O.CustomerID from Products as P
    inner join [Order Details] [O D] on P.ProductID = [O D].ProductID
    inner join Orders O on O.OrderID = [O D].OrderID) as x
group by x.ProductId
having count(*)  >1

--cw 5
SELECT concat(E.FirstName, ' ' ,E.LastName) as imienazw, (select sum(Freight) from Orders as oi where E.EmployeeID = oi.EmployeeID) + sum(convert(money, [O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount))) as 'kwota', (select  TOP 1 ShippedDate from Orders as ord where E.EmployeeID = ord.EmployeeID order by ShippedDate DESC ) from Employees as E
inner join Orders O on E.EmployeeID = O.EmployeeID
inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
WHERE YEAR(OrderDate) = 1997
group by concat(E.FirstName, ' ' ,E.LastName), E.EmployeeID
 ORDER BY kwota DESC


 ---5.1
 SELECT concat(E.FirstName, ' ' ,E.LastName) as imienazw, (select sum(Freight) from Orders as oi where E.EmployeeID = oi.EmployeeID) + sum(convert(money, [O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount))) as 'kwota' from Employees as E
inner join Orders O on E.EmployeeID = O.EmployeeID
inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
group by concat(E.FirstName, ' ' ,E.LastName), E.EmployeeID
 ORDER BY kwota DESC

 ---5.2
 SELECT TOP 1 concat(E.FirstName, ' ' ,E.LastName) as imienazw, (select sum(Freight) from Orders as oi where E.EmployeeID = oi.EmployeeID) + sum(convert(money, [O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount))) as 'kwota' from Employees as E
inner join Orders O on E.EmployeeID = O.EmployeeID
inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
WHERE YEAR(OrderDate) = 1997
group by concat(E.FirstName, ' ' ,E.LastName), E.EmployeeID
 ORDER BY kwota DESC

--3 MAJĄ PODWLADNYCH
SELECT concat(E.FirstName, ' ' ,E.LastName) as imienazw, E.EmployeeID, (select sum(Freight) from Orders as oi where E.EmployeeID = oi.EmployeeID) + sum(convert(money, [O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount))) as 'kwota', (select  TOP 1 ShippedDate from Orders as ord where E.EmployeeID = ord.EmployeeID order by ShippedDate DESC ) as 'ost_obs' from Employees as E
inner join Orders O on E.EmployeeID = O.EmployeeID
inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
WHERE E.EmployeeID in (
    select a.EmployeeID from Employees as a
        inner join Employees as b on a.EmployeeID = b.ReportsTo
    )
group by concat(E.FirstName, ' ' ,E.LastName), E.EmployeeID
 ORDER BY kwota DESC

--- 3 NIE MAJĄ PODWŁADNYCH
SELECT concat(E.FirstName, ' ' ,E.LastName) as imienazw, E.EmployeeID, (select sum(Freight) from Orders as oi where E.EmployeeID = oi.EmployeeID) + sum(convert(money, [O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount))) as 'kwota', (select  TOP 1 ShippedDate from Orders as ord where E.EmployeeID = ord.EmployeeID order by ShippedDate DESC ) as 'ost_obs' from Employees as E
inner join Orders O on E.EmployeeID = O.EmployeeID
inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
WHERE E.EmployeeID NOT IN (
    select a.EmployeeID from Employees as a
        inner join Employees as b on a.EmployeeID = b.ReportsTo
    )
group by concat(E.FirstName, ' ' ,E.LastName), E.EmployeeID
 ORDER BY kwota DESC



