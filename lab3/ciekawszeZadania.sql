---Na kolosie może być coś typu : podaj to na 2 sposoby
---czyli podzapytania i joiny np




---Dla każdego członka biblioteki podaj liczbę pozyczonych przez niego książek


select member.member_no,firstname, lastname,  count(l.out_date) + count(l2.out_date)  as l_ksizaek from member
LEFT OUTER JOIN  loan l on member.member_no = l.member_no
LEFT OUTER JOIN loanhist l2 on member.member_no = l2.member_no
group by member.member_no,firstname, lastname
order by member_no







--pokaż tytuły ksiązek pozyczone przez wiecej niz 1 czytelnika w przeszłości
select loanhist.title_no, t.title, count( distinct  member_no) as l_wypozyczen from loanhist
inner join title t on loanhist.title_no = t.title_no
group by loanhist.title_no, t.title
having count(distinct member_no) > 0
order by l_wypozyczen DESC

---podaj pary czytelników wypożyczających tą samą książkę +
-- ci co nie mają dzieci
select l1.member_no, l2.member_no from loanhist as l1
join loanhist l2 on l1.isbn = l2.isbn
where l1.member_no > l2.member_no
and     ---- oboje z pary są dziecmi
    (
            (l1.member_no in (select member_no from juvenile) and l2.member_no in (select member_no from juvenile))
            or
            ---oboje z pary nie mają dzieci
            (l1.member_no in
             (select a.member_no as 'l'
              from adult a
              where (select count(*) from juvenile as jv where jv.adult_member_no = a.member_no) = 0)
                and
             (l2.member_no in (select a.member_no
                               from adult a
                               where (select count(*) from juvenile where juvenile.adult_member_no = a.member_no) = 0))
                )
        )







--pokaz imiona i nazwiska tych czytelnikow
select  t.title, firstname, lastname, count(*) as l_wypozyczen from loanhist
inner join member on member.member_no = loanhist.member_no
inner join title t on loanhist.title_no = t.title_no
group by loanhist.title_no, t.title, loanhist.member_no ,firstname, lastname
having count(distinct loanhist.member_no) > 0
order by l_wypozyczen DESC


---Wyświetl produkt, który przyniósł najmniejszy, ale niezerowy, przychód w 1996 roku GIT
select ProductName, sum(convert(money, [O D].UnitPrice * [O D].Quantity * (1 - [O D].Discount))) as przychod from Products
inner join [Order Details] [O D] on Products.ProductID = [O D].ProductID
inner join Orders O on [O D].OrderID = O.OrderID
where year(OrderDate) = 1996
group by Products.ProductID, ProductName
order by przychod ASC


-- Zad.2. Wyświetl wszystkich członków biblioteki (imię i nazwisko, adres)
-- rozróżniając dorosłych i dzieci (dla dorosłych podaj liczbę dzieci),
-- którzy nigdy nie wypożyczyli książki - 8 032 wyników
select m.member_no, concat(firstname, ' ', lastname) as imie, concat(city, ' ', street) as adres, (select count(*) from juvenile where juvenile.adult_member_no = adult.member_no) as dzieci, 'dorosly' from adult
inner join member m on m.member_no = adult.member_no
where adult.member_no not in (select distinct member_no from loanhist union select distinct member_no from loan)
union
select m.member_no, concat(firstname, ' ', lastname) as imie, concat(city, ' ', street) as adres, 0, 'dziecko' from juvenile
inner join adult a on a.member_no = juvenile.adult_member_no
inner join member m on m.member_no = juvenile.member_no
where juvenile.member_no not in (select distinct member_no from loanhist union select distinct member_no from loan)
order by m.member_no


--- na wiki był błąd - niegrupowanie po memberID
select m1.member_no,m1.firstname +' '+m1.lastname as name, a.street,
	'Adult',count(j.adult_member_no) as dzieci
	from member m1
	inner join adult a on m1.member_no = a.member_no
	left join juvenile j on a.member_no = j.adult_member_no
	where m1.member_no not in (select lh.member_no from loanhist lh)
	and m1.member_no not in (select l.member_no from loan l)
	group by m1.member_no,m1.firstname+' '+ m1.lastname, a.street
union
select m.member_no, m.firstname+' '+ m.lastname as name, a2.street,
	'Child', null
	from member m
	inner join juvenile j2 on m.member_no = j2.member_no
	inner join adult a2 on j2.adult_member_no = a2.member_no
	where m.member_no not in (select lh.member_no from loanhist lh)
	and m.member_no not in (select l.member_no from loan l)
	group by m.member_no,m.firstname+' '+ m.lastname, a2.street
	order by 1,2



-- Wyświetl podsumowanie zamówień (całkowita cena + fracht) obsłużonych
-- przez pracowników w lutym 1997 roku, uwzględnij wszystkich, nawet jeśli suma
-- wyniosła 0.

select  E.EmployeeID, count(Distinct Orders.OrderID) as l_zamowien, sum(convert(money, [O D].Quantity * [O D].UnitPrice * (1- [O D].Discount) )) + sum(convert(money, Freight)) from Orders
inner join [Order Details] [O D] on Orders.OrderID = [O D].OrderID
Right outer join Employees E on Orders.EmployeeID = E.EmployeeID
where year(ShippedDate) = 1997 and month(ShippedDate) =2
group by E.EmployeeID
union
select E.EmployeeId, 0, 0 from Employees E
where EmployeeID not in (select Distinct EmployeeID from Orders where year(ShippedDate) = 1997 and month(ShippedDate) =2)


select O.ShipVia, sum(Freight) from Orders O
    group by O.ShipVia

select Distinct O.ShipVia, (select sum(Freight) from Orders o2 where o2.ShipVia = O.ShipVia) from Orders O

    --- ci mają podwłądnych
 select a.EmployeeID from Employees as a
 inner join Employees as b on a.EmployeeID = b.ReportsTo

-- Dla każdego klienta najczęsciej zamawianą kategorię

--- Podzapytania
with counts as (select C.CustomerId, P.CategoryID, sum(Quantity) as zamowien from Customers C
                 Inner Join Orders O on C.CustomerID = O.CustomerID
                 INNER JOIN [Order Details] [O D] on O.OrderID = [O D].OrderID
                 INNER JOIN Products P on P.ProductID = [O D].ProductID
                 group by C.CustomerId, P.CategoryID
                 ),
    maxperclient as (select c.CustomerId, max(c.zamowien) maxclient from counts c
                     group by c.CustomerId  )
select * from counts
 where counts.zamowien = (select maxclient from maxperclient where maxperclient.CustomerID = counts.CustomerID)

--- Bez podzapytań
select * from (select C.CustomerID, P.CategoryID, sum(Quantity) as ilosc, ROW_NUMBER() over (PARTITION BY C.CustomerID ORDER BY sum(Quantity) desc) as 'row'  from Customers C
    inner join Orders O on C.CustomerID = O.CustomerID
    inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
    INNER JOIN Products P on P.ProductID = [O D].ProductID
    group by C.CustomerID, P.CategoryID
    ) as tab
where tab.row = 1







--- również błąd w liczeniu liczby zamówień
with table1 as

(select E.EmployeeID, E.FirstName, E.LastName, count(O.OrderID) as ilosc,

round(sum(od.Quantity*od.UnitPrice*(1-od.Discount)) + sum(o.Freight),2) as suma

from Employees E

inner join Orders O on E.EmployeeID = O.EmployeeID

inner join [Order Details] od on O.OrderID = od.OrderID

where year(O.ShippedDate) = 1997 and month(O.ShippedDate) = 2

group by E.EmployeeID, E.FirstName, E.LastName)


select E.EmployeeID, E.FirstName, E.LastName, isnull(t1.ilosc,0) as ilosc, isnull(t1.suma,0) as suma from table1 t1

right join Employees E on t1.EmployeeID = E.EmployeeID

order by 4 desc

-- Wypisz wszystkich członków biblioteki z adresami i
-- info czy jest dzieckiem czy nie i
-- ilość wypożyczeń w poszczególnych latach i miesiącach

select 'dziecko' as 'typ', j.member_no,concat(m.firstname, ' ', m.lastname) as imie, concat(a.street, ' ', a.city) as adres, year(l.out_date) as rok, month(out_date) as miesiac, count(out_date) as wypozyczen from juvenile as j
left outer join loanhist l on j.member_no = l.member_no
inner join member m on j.member_no = m.member_no
inner join adult a on j.adult_member_no = a.member_no
group by j.member_no,concat(m.firstname, ' ', m.lastname), concat(a.street, ' ', a.city), year(l.out_date), month(out_date)
union
select 'dorosly' as 'typ', a.member_no, concat(m.firstname, ' ', m.lastname) as imie, concat(a.street, ' ', a.city) as adres, year(l.out_date) as rok, month(out_date) as miesiac, count(out_date) as wypozyczen from adult as a
left outer join loanhist l on a.member_no = l.member_no
inner join member m on a.member_no = m.member_no
group by a.member_no,concat(m.firstname, ' ', m.lastname), concat(a.street, ' ', a.city), year(l.out_date), month(out_date)
order by member_no, rok, miesiac


--Zamówienia z Freight większym niż AVG danego roku
select * from Orders where Freight > (select avg(Freight) from Orders)

--Klienci, którzy nie zamówili nigdy nic z kategorii 'Seafood' w trzech wersjach

select Distinct CustomerID from Orders where OrderID not IN (
    select Distinct OrderID from [Order Details] where ProductID IN (select ProductID from Products
inner join Categories C on C.CategoryID = Products.CategoryID
where CategoryName = 'Seafood' )
        )






select O.CustomerID, P.CategoryID, count(P.CategoryID)from Orders as  O
inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
inner join Products P on P.ProductID = [O D].ProductID
group by O.CustomerID, P.CategoryID
having count(P.CategoryID) = (
    select max(l_zam) from (select o.CustomerID, PR.CategoryID, count(P.CategoryID) AS 'l_zam' from Orders o
inner join [Order Details] [OD] on o.OrderID = [OD].OrderID
inner join Products PR on PR.ProductID = [OD].ProductID
where o.CustomerID = O.CustomerID
group by o.CustomerID, PR.CategoryID ) as CICIlz
    )


select CustomerID, max(l_zam) from
(select O.CustomerID, P.CategoryID, count(P.CategoryID) as l_zam from Orders as  O
inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
inner join Products P on P.ProductID = [O D].ProductID
group by O.CustomerID, P.CategoryID) as tab
group by CustomerID

--Podział na company, year month i suma freight
select CustomerID, year(ShippedDate), month(ShippedDate), sum(Freight) from Orders
group by CustomerID, year(ShippedDate), month(ShippedDate)


--Wypisać wszystkich czytelników, którzy nigdy nie
-- wypożyczyli książki dane adresowe i podział czy ta osoba jest dzieckiem (joiny, in, exists
select juvenile.member_no, 'dziecko', concat(street, ' ', city) as typ from juvenile
inner join adult a on a.member_no = juvenile.adult_member_no
inner join member m on m.member_no = a.member_no
where juvenile.member_no not in (select distinct member_no from loanhist union select distinct member_no from loanhist)
union
select a.member_no, 'dorosly', concat(street, ' ', city) as typ from adult as a
inner join member m on m.member_no = a.member_no
where a.member_no not in (select distinct member_no from loanhist union select distinct member_no from loanhist)


select sub.member_no, sub.imie_nazw, sub.wypozyczen, state, (select count(*) from juvenile where juvenile.adult_member_no = sub.member_no) as dzieci from                                                                                                                      (select  m.member_no,concat(firstname, ' ', lastname) as imie_nazw, count(out_date) as wypozyczen  from member as m
left outer join loanhist l on m.member_no = l.member_no
group by m.member_no,concat(firstname, ' ', lastname)
) as sub
inner join adult as a on sub.member_no = a.member_no

where (select count(*) from juvenile where juvenile.adult_member_no = sub.member_no) > CASE
    when  state = 'AZ' then 3
    when state = 'CA' then 2
    else -1
end
order by dzieci




select distinct state from adult












