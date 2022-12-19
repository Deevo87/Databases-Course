with wypozyczylicos as (
        select member_no from loanhist
                         union all
        select member_no from loan
) select m.member_no,m.firstname, m.lastname, concat(a.street, ' ', a.city), 'dziecko' as typ, 0 as dzieci from juvenile j
    inner join adult a on a.member_no = j.adult_member_no
    inner join member m on j.member_no = m.member_no
    where m.member_no not in ( select * from wypozyczylicos)
    union
    select m2.member_no,m2.firstname, m2.lastname,concat(a2.street, ' ', a2.city), 'dorosly', (select count(*) from juvenile dzieci where dzieci.adult_member_no = a2.member_no) as dzieci  from adult a2
    inner join member m2 on m2.member_no = a2.member_no
    where m2.member_no not in (select * from wypozyczylicos)







