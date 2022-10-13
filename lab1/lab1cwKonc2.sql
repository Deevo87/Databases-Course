select title from title
order by title

select member_no, isbn, fine_assessed, 2*fine_assessed as 'Double fine' from loanhist
where ISNULL(fine_assessed, 0) > 0

select lower(concat(firstname, middleinitial, substring(lastname,0,2))) as email_name from member
where lastname = 'Anderson'

select concat('The title is: ', title, ', title number ', title_no) as col from title