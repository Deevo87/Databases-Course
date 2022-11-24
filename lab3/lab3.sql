---- zadanie np.
---- Pokaż tych ktorzy nie zrobili zakupów
--- outer join (wtedy są nulle)



--- cw1
select ProductName, S.Address from Products
INNER JOIN Suppliers S on Products.SupplierID = S.SupplierID
where UnitPrice BETWEEN 20 and 30

--cw2
select ProductName, UnitsInStock from Products
INNER JOIN Suppliers S on Products.SupplierID = S.SupplierID
where S.CompanyName = 'Tokyo Traders'

--cw 3
SELECT Address, customers.customerid, orderdate
FROM customers
LEFT OUTER JOIN orders
ON customers.customerid = orders.customerid
AND year(orders.OrderDate) = 1997
where OrderDate is NULL

--cw 4
select UnitsInStock, CompanyName, Phone from Products
Inner Join Suppliers S on S.SupplierID = Products.SupplierID
where UnitsInStock = 0

--cw 5

select firstname, lastname, j.birth_date from member
inner join juvenile j on member.member_no = j.member_no

--cw 6

select Distinct  t.title from loan
inner join title t on t.title_no = loan.title_no

--cw 7

select in_date,due_date, datediff(day, due_date, in_date) as przetrz, fine_paid, fine_assessed  from loanhist
inner join title t on t.title_no = loanhist.title_no
where t.title = 'Tao Teh King' and datediff(day, due_date, in_date) > 0

--cw 8

select isbn, concat(firstname, ' ', middleinitial, ' ', lastname) as fullname from reservation
inner join member m on reservation.member_no = m.member_no
where concat(firstname, ' ', middleinitial, ' ', lastname) = 'Stephen A Graff'


-- cw 9
select ProductName, C.CategoryName, UnitPrice, S.Address from Products
inner join Suppliers S on Products.SupplierID = S.SupplierID
inner join Categories C on Products.CategoryID = C.CategoryID
where C.CategoryName = 'Meat/Poultry' and UnitPrice BETWEEN 20 and 30


--cs 10
select ProductName, C.CategoryName, UnitPrice, S.CompanyName from Products
inner join Suppliers S on Products.SupplierID = S.SupplierID
inner join Categories C on Products.CategoryID = C.CategoryID
where C.CategoryName = 'Confections'

-- cw 11
select C.CompanyName, C.Phone, OrderDate from Orders
inner join Shippers S on S.ShipperID = Orders.ShipVia
inner join Customers C on C.CustomerID = Orders.CustomerID
where year(ShippedDate) =1997 and S.CompanyName = 'United Package'

--cw12
select Distinct C.CompanyName, C.Phone from Orders
inner join Customers C on Orders.CustomerID = C.CustomerID
inner join [Order Details] [O D] on Orders.OrderID = [O D].OrderID
inner join Products P on P.ProductID = [O D].ProductID
inner join Categories C2 on C2.CategoryID = P.CategoryID
where C2.CategoryName = 'Confections'


select juvenile.member_no,
       concat(parentM.firstname, ' ', parentM.lastname) as rodzic,
       concat(selfM.firstname, ' ', selfM.lastname) as imienazw,
       birth_date,
       concat(a.street, ',', a.city) as adres
from juvenile
inner join adult a on a.member_no = juvenile.adult_member_no
inner join member parentM on a.member_no = parentM.member_no
inner join member selfM on juvenile.member_no = selfM.member_no


--cw 14

select przelozeni.EmployeeID, podwladni.EmployeeID, podwladni.ReportsTo FROM Employees podwladni
inner join Employees przelozeni on podwladni.ReportsTo = przelozeni.EmployeeID


--cw 15
select przelozeni.EmployeeID, podwladni.EmployeeID, przelozeni.ReportsTo FROM Employees podwladni
right outer join Employees przelozeni on podwladni.ReportsTo = przelozeni.EmployeeID
where podwladni.EmployeeID is null


--cw16
select distinct concat(city, ' ', street) from adult
    inner join juvenile j on adult.member_no = j.adult_member_no
    where j.birth_date < '1/1/1996'

--cw17
select distinct adult.member_no,concat(city, ' ', street) as adress, l.due_date from adult
    inner join juvenile j on adult.member_no = j.adult_member_no
    left outer join loan l on adult.member_no = l.member_no
    where j.birth_date < '1/1/1996' and isnull(due_date, '1/1/2030') > GETDATE();


SELECT ( + firstname + ' ' + lastname) AS name
,city, postalcode, 'p'
FROM employees
UNION ---usuwanie duplikatów - union all [bez duplikatów wtedy]
SELECT companyname, city, postalcode, 'k'
FROM customers
order by 4

--- UNION, INTERSECT, MINUS, EXCEPT
---DO KOLOSA - CWICZENIE 1, 2, 3 Z UNIONÓW

select * from juvenile
order by member_no

select concat(firstname, ' ', lastname) as nazwa , count(*) as l_dzieci from adult
    inner join member m on m.member_no = adult.member_no
    inner join juvenile j on adult.member_no = j.adult_member_no
    where state = 'AZ'
    group by adult.member_no, concat(firstname, ' ', lastname)
    having count(*)  > 2
UNION
select concat(firstname, ' ', lastname) as nazwa , count(*) as l_dzieci from adult
    inner join member m on m.member_no = adult.member_no
    inner join juvenile j on adult.member_no = j.adult_member_no
    where state = 'CA'
    group by adult.member_no, concat(firstname, ' ', lastname)
    having count(*)  =3







