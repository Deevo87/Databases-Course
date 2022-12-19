
--- ad 2
--- sposob 1
with wartosckazdego as (
    select O.OrderId, SUM(Quantity * UnitPrice * (1- Discount)) as wartosczam from Orders O
    INNER JOIN [Order Details] [O D] on O.OrderID = [O D].OrderID
    group by O.OrderId
), sredniacena as (
    select O.OrderId, AVG([O D2].UnitPrice) AS srednia from Orders O
     inner join [Order Details] [O D2] on O.OrderID = [O D2].OrderID
    group by O.OrderId
)
select *
from wartosckazdego w where w.wartosczam < (select s.srednia from sredniacena s where s.OrderID = w.OrderID);

--sposob 2
select O.OrderId, AVG([O D].UnitPrice) as srednia, SUM(Quantity * UnitPrice * (1- Discount)) as wartosc from Orders O
inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
group by O.OrderId
having SUM(Quantity * UnitPrice * (1- Discount)) < AVG([O D].UnitPrice)

---zad 3
--- rozumiem to tak że produkty które nie były z kategorii beverages ORAZ nie były kupowane w przedziale czasowym
--- poniżej szukam takich ktore byly w tym przedziale i byly z kategorii beverages
with kupowanewprzedzialeBevaregs as (
    select [O D].ProductID from Orders O
    inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
    inner join Products P on P.ProductID = [O D].ProductID
    inner join Categories C on P.CategoryID = C.CategoryID
    where (OrderDate between '1997/2/20' and '1997/2/25') and CategoryName = 'Beverages'
)select P2.ProductName, S.CompanyName, C2.CategoryName from Products P2
    inner join Suppliers S on P2.SupplierID = S.SupplierID
    inner join Categories C2 on P2.CategoryID = C2.CategoryID
    where P2.ProductID not in (select * from kupowanewprzedzialeBevaregs)




select * FROM Orders O WHERE O.Freight > (
    SELECT AVG(Freight) FROM Orders wew where year(wew.OrderDate) = year(O.OrderDate)
    )




