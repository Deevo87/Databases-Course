
--- cw1
select Top 10 WITH TIES OrderID, sum(convert(money, Quantity * UnitPrice * (1 - Discount))) as Total
from [Order Details]
group by OrderID
order by Total desc

------cw2
select ProductID, SUM(Quantity) AS Count  from [Order Details]
where ProductID < 3
group by ProductID

select ProductID, sum(Quantity) AS units from [Order Details]  group by ProductID


select OrderID, sum(convert(money, Quantity * UnitPrice * (1 - Discount))) as Value,
       sum(Quantity) as Units
from [Order Details]
group by OrderID
having sum(Quantity) >250


--cw3
select  EmployeeID, count(*) AS ORDERS from Orders group by EmployeeID

SELECT ShipVia as Spedytor,  sum(Freight) as 'oplata za przesylke' from Orders
where ShippedDate between '1996/1/1' and '1997/12/31'
group by ShipVia


---cw 4
select  EmployeeID,year(OrderDate) as rok, month(OrderDate) as miesiac, count(EmployeeID) AS ORDERS from Orders
where EmployeeID IS NOT NULL
group by EmployeeID, year(OrderDate), month(OrderDate)
order by EmployeeID, year(OrderDate), month(OrderDate)

select CategoryID, min(UnitPrice) as min, max(UnitPrice) as max from Products
group by CategoryID






