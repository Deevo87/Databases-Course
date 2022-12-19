-- Wybierz dzieci wraz z adresem, które nie
--     wypożyczyły książek w lipcu 2001 autorstwa ‘Jane Austin
select j.member_no, a.state from juvenile as j
    inner join adult a on a.member_no = j.adult_member_no
inner join member m on m.member_no = j.member_no
where j.member_no not in  (select member_no from loanhist
                            inner join title t on loanhist.title_no = t.title_no
                            where author = 'Jane Austen' and year(out_date) = 2001 and month(out_date) = 7
                                            )



--- ci mają podwłądnych
 select a.EmployeeID from Employees as a
 inner join Employees as b on a.EmployeeID = b.ReportsTo


-- Dane pracownika i najczęstszy dostawca pracowników bez podwładnych
 with Pracownicy_Bez_Podw as (select * from Employees where  EmployeeID not in (
 select a.EmployeeID from Employees as a
 inner join Employees as b on a.EmployeeID = b.ReportsTo
)),
 groupped as (select E.EmployeeID, E.FirstName, E.LastName, O.ShipVia, count(O.ShipVia) as ilosc from Pracownicy_Bez_Podw E
inner join Orders O  on E.EmployeeID = O.EmployeeID
group by  E.EmployeeID, E.FirstName, E.LastName, O.ShipVia  ),
 with_max as (
      select groupped.EmployeeID, groupped.FirstName, groupped.LastName, max(groupped.ilosc) as maxx from groupped
       group by  groupped.EmployeeID, groupped.FirstName, groupped.LastName
 )
select *, (select groupped.ShipVia from groupped where groupped.EmployeeID = with_max.EmployeeID and groupped.ilosc = with_max.maxx) as top_FIRMA from with_max



-- Wybierz tytuły książek, gdzie ilość wypożyczeń książki jest
-- większa od średniej ilości wypożyczeń książek tego samego autora



with wypozyczenia as (select wypo.title_no, count(*) as ilosc from (select title_no from loanhist
union ALL
select title_no from loan) as wypo
group by wypo.title_no)
select  wypozyczenia.title_no from wypozyczenia



