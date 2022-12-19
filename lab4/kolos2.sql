with wypozyczenia as (select wypo.title_no, t.author, count(*) as ilosc from (select title_no from loanhist
union ALL
select title_no from loan) as wypo
    inner join title t on wypo.title_no = t.title_no
group by wypo.title_no, t.author)
select  wzewn.title_no, wzewn.ilosc, wzewn.author from wypozyczenia as wzewn
where wzewn.ilosc > (select avg(ilosc) from wypozyczenia wwewn where wwewn.author = wzewn.author)
--- każda ksiazka ma tyle samo wypozyczen


--Kategorie które w roku 1997 grudzień były
--obsłużone wyłącznie przez ‘United Package
select C.CategoryID, count(distinct O.ShipVia) from [Order Details] as [0 D]
inner join Products P on [0 D].ProductID = P.ProductID
inner join Categories C on C.CategoryID = P.CategoryID
inner join Orders O on [0 D].OrderID = O.OrderID
inner join Shippers S on O.ShipVia = S.ShipperId
where year(ShippedDate) = 1997 and month(ShippedDate) = 12
group by C.CategoryID
having count(distinct O.ShipVia) = 1

select Distinct C.CategoryID from Orders
inner join [Order Details] [O D] on Orders.OrderID = [O D].OrderID
inner join Products P on P.ProductID = [O D].ProductID
inner join Categories C on C.CategoryID = P.CategoryID
inner join Shippers S on S.ShipperID = Orders.ShipVia
where year(ShippedDate) = 1997 and month(ShippedDate) = 12 and S.CompanyName <> 'United Package'


select S.CompanyName, year(O.OrderDate), month(O.OrderDate), sum(convert(money, [O D].UnitPrice * [O D].Quantity * (1 - [O D].Discount))) from Suppliers S
inner join Products P on S.SupplierID = P.SupplierID
inner join [Order Details] [O D] on P.ProductID = [O D].ProductID
inner join Orders O on O.OrderID = [O D].OrderID
group by S.CompanyName, year(O.OrderDate), month(O.OrderDate)
having sum(convert(money, [O D].UnitPrice * [O D].Quantity * (1 - [O D].Discount))) >
       (select sum(convert(money, od2.UnitPrice * od2.Quantity * (1-od2.Discount)))/(select count(*) from Suppliers) from [Order Details] od2
                        inner join Orders O2 on O2.OrderID = od2.OrderID
                        where year(O2.OrderDate) = year(O.OrderDate) and month(O2.OrderDate) = month(O.OrderDate)
                                                                                                                     )


