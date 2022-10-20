select concat(ISNULL(phone, ''), ',', isnull(Fax, ''))  from Suppliers


select count(*) from Products where UnitPrice not BETWEEN 10 and 20

select Top 1 UnitPrice from Products where UnitPrice < 20 order by UnitPrice Desc

select max(UnitPrice) as max, min(UnitPrice) as min, avg(UnitPrice) as avg from Products where QuantityPerUnit like '%bottle%'

select ProductName from Products where UnitPrice > (select avg(UnitPrice) from Products)

select round(sum(UnitPrice * Quantity * (1-Discount)), 2)  from [Order Details] where OrderID = 10250


select ProductID,max(UnitPrice) as max from [Order Details]
group by ProductID

select ProductID, max(UnitPrice) as max from [Order Details]
group by ProductID
order by max(UnitPrice)

select OrderID, max(UnitPrice) as max, min(UnitPrice) as min from [Order Details]
group by OrderID

select ShipVia, count(*) as liczba from Orders
group by ShipVia

select top 1 ShipVia from Orders
where year(ShippedDate) = 1997
group by ShipVia
order by count(*) desc

select OrderID, count(*) from [Order Details]
group by OrderID
having count(*) > 5

select CustomerID, count(*) as l_zam, sum(Freight) as koszta from Orders
where year(ShippedDate) = 1998                                                  group by CustomerID
having count(*) > 8
order by sum(Freight) desc

select sum(quantity) from orderhist

select productid, sum(quantity) from orderhist
group by productid

select OrderID, productid, sum(quantity)
from orderhist
group by OrderID, productid
order by orderid,productid


SELECT productid, orderid, SUM(quantity) AS total_quantity FROM orderhist
GROUP BY productid, orderid
WITH cube
ORDER BY productid, orderid