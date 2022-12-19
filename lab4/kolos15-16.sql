-- 1.a) Wyświetl imię, nazwisko, dane adresowe oraz ilość wypożyczonych książek dla każdego członka biblioteki.
-- Ilość wypożyczonych książek nie może być nullem, co najwyżej zerem.
-- b) j/w + informacja, czy dany członek jest dzieckiem


select member_no, firstname, lastname,
       (select count(*) from loanhist l where l.member_no = m.member_no),
        CASE WHEN (select count(*) from juvenile j where j.member_no = m.member_no) > 0 then 'dziecko' else 'dorosly' END
from member as m

select member_no from juvenile

-- 2. wyświetl imiona i nazwiska osób, które nigdy nie wypożyczyły żadnej książki
-- a) bez podzapytań
-- b) podzapytaniami

select firstname, lastname from member where member_no not in (select member_no from loanhist union  select member_no from loan)


select firstname, lastname, count(l.out_date)  + count(l2.out_date) from member
left outer join loanhist l on member.member_no = l.member_no
left outer join loan l2 on member.member_no = l2.member_no
group by firstname, lastname, member.member_no
having count(l.out_date)  + count(l2.out_date) = 0
order by member.member_no


-- 3. wyświetl numery zamówień, których cena dostawy była większa niż średnia cena za przesyłkę w tym roku
-- a) bez podzapytań
-- b) podzapytaniami

SELECT OrderID from Orders where Freight > (select avg(Freight) from Orders)

-- 4. wyświetl ile każdy z przewoźników miał dostać wynagrodzenia w poszczególnych latach i miesiącach.
-- a) bez podzapytań
-- b) podzapytaniami

select ShipVia, year(ShippedDate), month(ShippedDate), sum(Freight) from Orders
group by ShipVia, year(ShippedDate), month(ShippedDate)

select *, (select sum(Freight) from  Orders as wew where
                                       wew.ShipVia = tab.ShipVia and
                                        year(wew.ShippedDate) = tab.rok
                                                   and
                                        month(wew.ShippedDate) = tab.miesiac
                                                ) from (select Distinct ShipVia, year(ShippedDate) as rok, month(ShippedDate) as miesiac from Orders as zew) as tab