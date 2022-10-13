select title, title_no from title

select title from title where title_no = 10

select member_no, fine_assessed FROM loanhist
where fine_assessed BETWEEN  8 and 9

select title_no, author from title
where author in ('Charles Dickens','Jane Austen')

select title_no, title from title
where title like  '%adventures%'

select member_no, fine_assessed, fine_paid from loanhist
where ISNULL(fine_assessed, 0) - ISNULL(fine_waived, 0) > ISNULL(fine_paid, 0)

select distinct  city, state from adult