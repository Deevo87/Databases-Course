
with nieprzezUP as (
    select distinct P.CategoryID from Orders
    inner join [Order Details] [O D] on Orders.OrderID = [O D].OrderID
    inner join Products P on [O D].ProductID = P.ProductID
    where ShipVia <> 2 and year(ShippedDate) = 1997 and month(ShippedDate) = 1
),
   przezUP as (
           select distinct P.CategoryID from Orders
    inner join [Order Details] [O D] on Orders.OrderID = [O D].OrderID
    inner join Products P on [O D].ProductID = P.ProductID
    where ShipVia = 2 and year(ShippedDate) = 1997 and month(ShippedDate) = 1
   ),
   onlyUP as (
    SELECT * from przezUP
    EXCEPT
    SELECT * FROM nieprzezUP
   )
select * from onlyUP o
inner join Categories C on C.CategoryID = o.CategoryID

select m.member_no, m.firstname, m.lastname, a.state, a.street, (select count(*) from loan l where l.member_no = m.member_no), 'dziecko' from juvenile j
inner join adult a on a.member_no = j.adult_member_no
inner join member m on m.member_no = j.member_no

-- autor ksiazki najcheteniej wypozyczanej przez dzieci z arizony w 2001
 with filtered2001Wypo as (
    select * from loanhist l
    where year(out_date) = 2001 and member_no IN ( select j.member_no from juvenile j
    inner join adult a on a.member_no = j.adult_member_no
    where state = 'AZ')
),
     grp as (
         select title_no, count(*) as wypoz from filtered2001Wypo
            group by title_no

     )
select top 1 with ties * from grp
    inner join title t on t.title_no = grp.title_no
   order by wypoz DESC

select O.OrderID, ([O D].Quantity * [O D].UnitPrice * (1 - [O D].Discount)) from Orders O
inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
inner join Products P on P.ProductID = [O D].ProductID
inner join Categories C on C.CategoryID = P.CategoryID
where CategoryName = 'Seafood' and year(OrderDate) = 1997 and month(OrderDate) = 7


---wyłącznie jedna kat w marcu 1997
with grpd as (
    select O.CustomerID as liczba from Orders O
    inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
    inner join Products P on P.ProductID = [O D].ProductID
    where year(OrderDate) = 1997 and month(OrderDate) =3
    group by O.CustomerID
    having count(distinct P.CategoryID) = 1
)
select distinct CustomerID, C.CategoryName from Orders
    inner join [Order Details] [O D2] on Orders.OrderID = [O D2].OrderID
inner join Products P2 on P2.ProductID = [O D2].ProductID
inner join Categories C on C.CategoryID = P2.CategoryID
where year(OrderDate) = 1997 and month(OrderDate) =3 and CustomerID in  (
   select * from grpd
)

 with filtered2001Wypo as (
    select * from loanhist l
    where year(out_date) = 2001 and member_no IN ( select j.member_no from juvenile j
    inner join adult a on a.member_no = j.adult_member_no
    where state = 'AZ')
),
     grp as (
         select title_no, count(*) as wypoz from filtered2001Wypo
            group by title_no

     )
select top 1 with ties * from grp
    inner join title t on t.title_no = grp.title_no
   order by wypoz DESC

--- wybierz tytuly ksiazek gdzie ilosc wypozyczen ksiazki jest wieksza od sredniej ilosci wypozyczen tego samego autora
WITH wypoz as ( --- licze ile ksiazek wypozoczono - po autorze i tytule
    select t.title_no, author from loanhist
                    inner join title t on t.title_no = loanhist.title_no
    union all
    select t.title_no, author from loan
                     inner join title t on t.title_no = loan.title_no
),
    mean as ( --- liczę srednią dla każdego autora
        select  wypozewn.author, ((select count(*) from wypoz wypozwewn where wypozewn.author = wypozwewn.author) -- liczba wypozyczen jego ksiązki
                                      /
                                  (select count(distinct wypozwewn.title_no) from wypoz wypozwewn where wypozewn.author = wypozwewn.author))  -- liczba ksiązek które napisał
            as srednia from wypoz wypozewn
        group by wypozewn.author
    ),
    ilosc as ( -- liczę ilosc wypozyczen kazdego tytułu
        select wypozewn.title_no, wypozewn.author, (select count(*) from wypoz wypozwewn where wypozewn.title_no = wypozwewn.title_no) as ile from wypoz wypozewn
        group by wypozewn.title_no, wypozewn.author
    )
select * from ilosc il
where il.ile > (select m.srednia from mean m where m.author = il.author)

--- wybierz tytuly ksiazek gdzie ilosc wypozyczen ksiazki jest wieksza od sredniej ilosci wypozyczen tego samego autora


-- 1.Podaj listę dzieci będąych członkami biblioteki, które w dniu '2001-12-14' zwróciły do biblioteki książkę o tytule 'Walking'
-- 2.Wyświetl klientów wraz z informacjami jaką kategorię produktow najczęściej zamawiali w 1997 roku
-- 3.Dla każdego dziecka będącego członkiem biblioteki jego imię i nazwisko, adres, imię i nazwisko opiekuna oraz informację ile książek oddali dziecko i rodzic w grudniu 2001
--

---ad 1
select m.firstname, m.lastname from loanhist
inner join title t on loanhist.title_no = t.title_no
inner join member m on loanhist.member_no = m.member_no
where year(in_date) = 2001 and month(in_date) = 12 and day(in_date) = 14 and title = 'Walking'
and m.member_no in (select j.member_no from juvenile j)
--ad 2

with counts as (select C.CustomerId, P.CategoryID, count(*) as zamowien from Customers C
                 Inner Join Orders O on C.CustomerID = O.CustomerID
                 INNER JOIN [Order Details] [O D] on O.OrderID = [O D].OrderID
                 INNER JOIN Products P on P.ProductID = [O D].ProductID
                 group by C.CustomerId, P.CategoryID
                 ),
    maxperclient as (select c.CustomerId, max(c.zamowien) maxclient from counts c
                     group by c.CustomerId  )
select * from counts
 where counts.zamowien = (select maxclient from maxperclient where maxperclient.CustomerID = counts.CustomerID)


-- jeszcze raz
with counts as (
                    select C.CustomerId, P.CategoryID, count(*) as zamowien from Customers C
                    inner join Orders O on C.CustomerID = O.CustomerID
                    inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
                    inner join Products P on P.ProductID = [O D].ProductID
                    group by C.CustomerId, P.CategoryID
                    ),
     maxPerClient as (
         select c.CustomerId, max(c.zamowien) maxclient from counts c
         group by c.CustomerId
            )
select * from counts
where counts.zamowien = (select maxclient from maxPerClient where maxPerClient.CustomerID = counts.CustomerID)

select jm.firstname + ' ' + jm.lastname as danedziecka, am.firstname + ' ' + am.lastname as danerodzica, a.street + ' ' + a.city as 'adres',
       (select count(*) from loanhist l where year(l.in_date) = 2001 and month(l.in_date)= 12 and l.member_no in (a.member_no, j.member_no)) as ileodano
       from juvenile j
inner join adult a on a.member_no = j.adult_member_no
inner join member am on am.member_no = a.member_no
inner join member jm on jm.member_no = j.member_no

----
---1. Podaj ilu jest pracowników, którzy urodzili się pomiędzy latami 1953-54 lub 1955-57 lub 1959-62 i nie mieszkają ani w Londynie ani w Seattle.
--2. Podaj nazwę, cenę jednostkową i adres dostawcy dla produktów z kategorii "Meat/Poultry"
-- których cena jednostkowa jest pomiędzy 20, a 30

-- Wyświetl ID Zamówienia, Nazwę Klienta i Nazwę Spedytora
-- dla zamówień których cena za przewóz jest mniejsza niż 70% średniej ceny za przewóz
with warunek as (
    select 0.7 * avg(Freight) as wartsc from Orders
)
select OrderID, C.CompanyName, S.CompanyName from Orders
inner join Shippers S on S.ShipperID = Orders.ShipVia
inner join Customers C on C.CustomerID = Orders.CustomerID
where Freight < (select * from warunek)

with dokonali as (
    select CustomerID from Orders where year(OrderDate) = 1997

) select CustomerID from Customers EXCEPT (select * from dokonali)

---Wyświetl produkt, który przyniósł najmniejszy, ale niezerowy, przychód w 1996 roku
select P.ProductId, sum ([O D].Quantity * [O D].UnitPrice * (1- Discount)) from Products P
inner join [Order Details] [O D] on P.ProductID = [O D].ProductID
inner join Orders O on [O D].OrderID = O.OrderID
where year(OrderDate) = 1996
group by P.ProductId
