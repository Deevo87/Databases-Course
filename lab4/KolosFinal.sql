--- najczestsza kategoria dla klienta


with maxperclient as (
    select O.CustomerID, P.CategoryID, count(*) as liczba from Orders O
    inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
    inner join Products P on P.ProductID = [O D].ProductID
    group by  O.CustomerID, P.CategoryID
), maxclient as (
    select m.CustomerId, max(liczba) as maxx from maxperclient m
    group by m.CustomerId
)

select * from maxperclient
where maxperclient.liczba = (select maxx from maxclient where maxclient.CustomerID = maxperclient.CustomerID)


select * from Orders zew where Freight > (select avg(Freight) from Orders wew where year(wew.OrderDate) = year(zew.OrderDate))


with pracbezpod as (select EmployeeID from Employees where EmployeeID not in (
    select a.EmployeeId from Employees a
inner join Employees b on a.EmployeeID = b.ReportsTo
    ))
, groupped as (
    select O.EmployeeId, O.ShipVia, count(*) as liczba from Orders O
    where O.EmployeeID in (select * from pracbezpod)
    group by O.EmployeeId, O.ShipVia
),
maxperEmp as (
    select g.EmployeeId, max(liczba) as maxx from groupped g
    group by g.EmployeeId
                                     )
select * from groupped g
         inner join Employees E on g.EmployeeID = E.EmployeeID
         where g.liczba = (select maxx from maxperEmp where maxperEmp.EmployeeID = g.EmployeeID)


with wypozyczyli as (
    select member_no from loanhist
    inner join title t on t.title_no = loanhist.title_no
    where author = 'Jane Austen' and
          year(out_date) = 2001 and month(out_date) = 7
)
select * from wypozyczyli

with best as
(select  P.CategoryId from Products P
inner join [Order Details] [O D] on P.ProductID = [O D].ProductID
inner join Orders O on O.OrderID = [O D].OrderID
where year(OrderDate) = 1997
group by P.CategoryId
order by convert(money, sum([O D].UnitPrice * Quantity * (1- Discount))) DESC)


select top 1 P.ProductId from Products P
inner join [Order Details] [O D] on P.ProductID = [O D].ProductID
inner join Orders O on [O D].OrderID = O.OrderID
where year(OrderDate) = 1996
GROUP BY P.ProductID
having sum(Quantity * [O D].UnitPrice * (1 - Discount)) > 0




