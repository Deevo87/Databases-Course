 SELECT concat(E.FirstName, ' ' ,E.LastName) as imienazw,
        (select sum(Freight) from Orders as oi where E.EmployeeID = oi.EmployeeID)
            +
        sum(convert(money, [O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount))) as 'kwota' from Employees as E
inner join Orders O on E.EmployeeID = O.EmployeeID
inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
group by concat(E.FirstName, ' ' ,E.LastName), E.EmployeeID
 ORDER BY kwota DESC