with xdd as(
select TOP 1  P.CategoryId from Products P
inner join [Order Details] [O D] on P.ProductID = [O D].ProductID
inner join Orders O on O.OrderID = [O D].OrderID
where year(OrderDate) = 1997
group by P.CategoryId
order by convert(money, sum([O D].UnitPrice * Quantity * (1- Discount))) DESC
) select P.CategoryID, month(O2.OrderDate), convert(money, sum( [O D2].UnitPrice * Quantity * (1- Discount))) from Products P
    inner join [Order Details] [O D2] on P.ProductID = [O D2].ProductID
    inner join Orders O2 on O2.OrderID = [O D2].OrderID
where year(OrderDate) = 1997 and P.CategoryID = (SELECT * FROM xdd)
GROUP BY P.CategoryID, month(O2.OrderDate) WITH ROLLUP


with doroslizdziecmi as (
    select member_no, state, (select count(*) from juvenile where juvenile.adult_member_no = adult.member_no) as ldzieci from adult
),
accepted_dorosli as (
select member_no from doroslizdziecmi where (state = 'AZ' and ldzieci > 2) or (state = 'CA' and ldzieci > 3)
),
   liczba as (
   select member_no, (select count(*) as wypo from loanhist
   where (loanhist.member_no in (select juvenile.member_no from juvenile where juvenile.adult_member_no = adult.member_no) or (loanhist.member_no = adult.member_no)) and year(in_date) = 2001 and month(in_date) = 12 ) as ksiazek
   from adult)
select * from liczba l
where l.member_no in (select * from accepted_dorosli)

select * from Orders zew where zew.Freight > (select avg(wew.Freight) from Orders wew where year(wew.ShippedDate) = year(zew.ShippedDate))

select m.member_no, l.due_date from member m
    left outer join loanhist l on m.member_no = l.member_no
    where out_date is null
    order by m.member_no

select distinct member_no from loanhist
union
select distinct member_no from loan
order by member_no

select a.EmployeeID, a.City, b.EmployeeID from Employees a
inner join Employees b on a.City = b.City
where a.Title = 'Sales representative' and b.Title = 'Sales representative'
and a.EmployeeID > b.EmployeeID