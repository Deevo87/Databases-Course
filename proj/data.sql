set dateformat mdy

insert INTO GlobalVars (id, WZ, WK)
values (1,4,5)

Insert Into Countries (Name)
VALUES ('Polska'), ('Niemcy')


INSERT Into Cities (Name, CountryID)
VALUES ('Kraków', 1), ('Warszawa', 1), ('Berlin', 2), ('Dortmund', 2)


INSERT INTO Users (Name, PhoneNumber, email)
VALUES ('Jan Kowalski', '781422839', 'test7@gmail.com'), ('Andrzej Nowak', '782333567', 'test2@gmail.com'), ('Pawel Koziol', '333444555', 'test3@gmail.com'),
       ('Pawel Maly', '213543333', 'test4@gmail.com'), ('Piotr Nowakowski', '78123333', 'test5@gmail.com'), ('Marek Niskopienny', '333666777', 'test6@gmail.com'),
       ('Polgros', '333555666', 'firma1@gmail.com'), ('Tadex', '333444655', 'firma2@gmail.com'),
       ('Anna Nowak', '817263495', 'annanowak@yahoo.com'),
       ('Piotr Kowalczyk', '913758426', 'piotrkowalczyk@gmail.com'),
       ('Agnieszka Wiśniewska', '857394025', 'agnieszkawisniewska@outlook.com'),
       ('Marcin Wójcik', '719538064', 'marcinwojcik@gmail.com'),
       ('Katarzyna Kamińska', '625984713', 'katarzynakaminska@yahoo.com'),
        ('Tomasz Nowak', '847193065', 'tomasznowak@gmail.com'),
        ('Ewa Kowalczyk', '738502946', 'ewakowalczyk@yahoo.com'),
        ('Adam Wiśniewski', '915827634', 'adamwisniewski@outlook.com'),
        ('Marta Wójcik', '831749605', 'martawojcik@gmail.com'),
        ('Kamil Kamiński', '706253847', 'kamilkaminski@yahoo.com'),
        ('Joanna Nowakowska', '976384510', 'joannanowakowska@gmail.com'),
        ('Jakub Kowalski', '842917563', 'jakubkowalski@yahoo.com'),
        ('Magdalena Wiśniewska', '958273649', 'magdalenawisniewska@outlook.com'),
        ('Paweł Wójcik', '856193027', 'pawelwojcik@gmail.com'),
        ('Monika Kamińska', '906253841', 'monikakaminska@yahoo.com'),
        ('Dawid Nowak', '948635207', 'dawidnowak@gmail.com'),
        ('Justyna Kowalczyk', '865027394', 'justynakowalczyk@yahoo.com'),
        ('Barbara Wiśniewska', '859073214', 'barbarawisniewska@outlook.com'),
        ('Mateusz Wójcik', '958172304', 'mateuszwojcik@gmail.com'),
        ('Agata Kamińska', '960748352', 'agatakaminska@yahoo.com'),
        ('Jacek Nowakowski', '857940362', 'jaceknowakowski@gmail.com'),
        ('Paulina Kowalska', '769053218', 'paulinakowalska@yahoo.com'),
        ('Szymon Wiśniewski', '938052147', 'szymonwisniewski@outlook.com'),
        ('Krystyna Wójcik', '847062538', 'krystynawojcik@gmail.com'),
        ('Marcin Kamiński', '876940251', 'marcinkaminski@yahoo.com'),
        ('Aleksandra Nowak', '958273640', 'aleksandranowak@gmail.com'),
        ('Iwona Kowalczyk', '938157904', 'iwonakowalczyk@yahoo.com'),
        ('Maciej Wiśniewski', '987025341', 'maciejwisniewski@outlook.com'),
        ('Oliwia Wójcik', '901875324', 'oliwiawojcik@gmail.com'),
        ('Jan Kamiński', '840756932', 'jankaminski@yahoo.com')

INSERT INTO Employees (EmployeeID, BirthDate, HireDate, Position, Address, CityID, PostalCode, IsManager, ReportsTo)
values (1, '1/1/1992', '1/3/2020', 'Waiter', 'Kawiory 32', 1, '62-200', 0, 1),
       (2, '1/1/1970', '1/3/2001', 'Senior Waiter Manager', 'Kawiory 25', 2, '34-059', 1, null),
        (9, '1/1/1998', '1/3/2018', 'Junior Cook', 'Witolda Budryka 2', 2, '21-377', 0, 1),
       (10, '1/1/1972', '1/3/2001', 'Senior Cook', 'Kawiory 42', 2, '42-690', 0, 1)

select * from Users
INSERT Into Admins (AdminID)
VALUES (3)

INSERT Into Customers (CustomerID)
VALUES  (4), (5), (6), (7), (8), (11), (12), (13), (14), (15), (16), (17), (18), (19), (20), (21), (22), (23), (24), (25), (26), (27), (28), (29), (30), (31), (32), (33), (34), (35), (36), (37), (38)

--27 privateCustomers
INSERT INTO PrivateCustomers (CustomerID)
values (4), (5), (6), (11), (12), (13), (14), (15), (16), (17), (18), (19), (20), (21), (22), (23), (24), (25), (26), (27), (28), (29), (30), (31), (32), (33), (34), (35), (36), (37), (38)

INSERT INTO CompanyCustomers (CustomerID, nip, Address, CityID, PostalCode) VALUES
            (7, '1234567', 'KAWIORY 83', 2, '64-900'), (8, '3333222', 'Czarnowiejska 3', 1, '30-059')

INSERT INTO Categories (Name) values
            ('Seafood') , ('Meat'), ('Poundry'), ('Drinks'), ('Pasta')


INSERT INTO Products (Name, CategoryID, Description) values
                ('Salmon', 1, 'Tasty fishh'), ('Trout', 1, 'Delicous fish'), ('Porkchop', 2, 'Tasty meat'), ('Ham', 2, 'Nicely done ham'),
                ('Milk', 3, 'Flavoured milk'), ('Butter', 3, 'Brilliant butter'), ('Chicken', 2, 'Perfectly cooked chicken'),
                ('Coffee', 4, 'Tasty Arabica'), ('Wine', 4, 'Well aged wine'), ('Orange juice', 4, 'Fresh juice from oranges'),
                ('Apple juice', 4, 'Fresh juice from apples'), ('Tea', 4, 'Delicious earl grey'), ('Water', 4, 'Water from glacier'),
                ('Garlicky Lemon Baked Tilapia', 1, 'Baked with garlic and love'), ('Sheet Pan Shrimp Boil', 1, 'The best shrimp on the west coast'),
                ('Honey Garlic Glazed Salmon', 1, 'Out cooks catch those salmons with bare hands'), ('Spaghetti Puttanesca', 5, 'Lovely pasta'),
                ('Pasta alla vodka', 5, 'With REAL vodka'), ('Cheesy Broccoli Pasta Bake', 5, 'You dont need to eat broccoli...')

--6 ich jest
Insert into DiscountParams (R1, R2, InDate, OutDate) values
            (0.2, 0.1, '11/12/2022', '12/15/2022'), (0.3, 0.2, '12/16/2022', '3/3/2023'),
            (0.25, 0.15, '12/24/2022', '3/15/2023'), (0.35, 0.25, '3/15/2023', '3/18/2023'),
            (0.1, 0.5, '12/27/2022', '4/20/2023'), (0.21, 0.37, '12/21/2022', '4/25/2023')

--6 ich jest
INSERT into DiscountConditions (Z1, K1, K2, D1, InDate, OutDate) values
            (4, 40, 30, 8, '11/12/2022', '12/15/2022'), (5, 50, 30, 15, '12/16/2022', '3/3/2023'),
            (5, 45, 35, 10, '12/24/2022', '3/15/2023'), (6, 30, 35, 12, '3/15/2023', '3/18/2023'),
            (5, 40, 40, 13, '12/27/2022', '4/20/2023'), (4, 21, 37, 20, '12/21/2022', '4/25/2023')
select * from Discounts

INSERT INTO Discounts (CustomerID, DiscountType, StartDate, EndDate, UsedDate, ParamsID, ConditionsID)
values  (4, 'lifetime', '1/6/2022', null, null, 2, 2),
        (5, 'temporary', '12/19/2022', '1/30/2023', null, 1, 2),
        (6, 'lifetime',  '1/3/2022' , null, null, 1, 1),
        (11, 'temporary', '12/8/2022', '12/31/2022', null, 4, 6),
        (12, 'temporary', '12/2/2022', '12/25/2022', null, 2, 3),
        (13, 'temporary', '12/3/2022', '12/24/2022', null, 6, 1),
        (14, 'temporary', '12/1/2022', '12/29/2022', null, 1, 4),
        (15, 'temporary', '12/4/2022', '12/26/2022', null, 5, 2),
        (16, 'temporary', '12/7/2022', '12/29/2022', null, 3, 1),
        (17, 'temporary', '12/9/2022', '12/30/2022', null, 6, 5),
        (18, 'temporary', '12/4/2022', '12/26/2022', null, 4, 3),
        (19, 'temporary', '12/5/2022', '12/28/2022', null, 2, 1),
        (20, 'temporary', '12/19/2022', '12/30/2022', null, 5, 4),
        (21, 'temporary', '12/2/2022', '12/29/2022', null, 3, 2),
        (22, 'temporary', '12/23/2022', '12/25/2022', null, 1, 6),
        (23, 'temporary', '12/4/2022', '12/28/2022', null, 4, 5),
        (24, 'temporary', '12/20/2022', '12/30/2022', null, 2, 3),
        (25, 'temporary', '12/21/2022', '12/29/2022', null, 6, 1),
        (26, 'temporary', '12/6/2022', '12/27/2022', null, 5, 4),
        (27, 'temporary', '12/19/2022', '12/30/2022', null, 3, 2),
        (28, 'temporary', '12/5/2022', '12/29/2022', null, 2, 5),
        (29, 'temporary', '12/3/2022', '12/27/2022', null, 6, 4),
        (30, 'temporary', '12/20/2022', '12/30/2022', null, 5, 3),
        (31, 'temporary', '12/24/2022', '12/29/2022', null, 1, 1),
        (32, 'temporary', '12/3/2022', '12/30/2022', null, 2, 6),
        (33, 'temporary', '12/22/2022', '12/27/2022', null, 2, 3),
        (34, 'temporary', '12/6/2022', '12/28/2022', null, 3, 4),
        (35, 'temporary', '12/1/2022', '12/29/2022', null, 6, 1),
        (36, 'temporary', '12/26/2022', '12/27/2022', null, 5, 4),
        (37, 'temporary', '12/6/2022', '12/30/2022', null, 3, 2),
        (38, 'temporary', '12/25/2022', '12/29/2022', null, 2, 5)

INSERT into Invoices (Date, CustomerID, Address, CityID, PostalCode) values
                    ('1/1/2022', 4, 'Kawiory 18', 1, '62-200'),
                    ('1/1/2022', 7, 'Kawiory 18', 1, '62-200'),
                    ('12/15/2022', 8, 'Kawiory 14', 1, '30-059')


INSERT into Orders (CustomerID, EmployeeID, OrderDate, ReceiveDate, IsPaid, TakeOut, InvoiceID, DiscountID) values
                    (4, 1, '1/1/2022', '12/31/2022', 1, 1, 1, 1),
                    (5, 1, '12/3/2022', '12/30/2022', 1, 0, null, 2),
                    (7, 2,'12/12/2022', '12/30/2022', 0, 0, 2, null),
                    (8, 2,'12/14/2022', '12/30/2022', 0, 0, 3, null),
                    (11, 1, '12/2/2022', '12/30/2022', 0, 0, null, 4),
                    (12, 2, '12/21/2022', '12/25/2022', 0, 0, null, 5),
                    (13, 1, '12/18/2022', '12/24/2022', 1, 0, null, 6),
                    (14, 2, '12/19/2022', '12/29/2022', 1, 0, null, 7),
                    (15, 1, '12/17/2022', '12/26/2022', 0, 1, null, 8),
                    (16, 2, '12/18/2022', '12/29/2022', 1, 0, null, 9),
                    (17, 1, '12/19/2022', '12/30/2022', 1, 0, null, 10),
                    (18, 2, '12/20/2022', '12/26/2022', 0, 1, null, 11),
                    (19, 1, '12/21/2022', '12/28/2022', 1, 0, null, 12),
                    (20, 2, '12/16/2022', '12/30/2022', 0, 1, null, 13),
                    (21, 1, '12/17/2022', '12/29/2022', 0, 1, null, 14),
                    (22, 2, '12/13/2022', '12/25/2022', 1, 0, null, 15),
                    (23, 1, '12/14/2022', '12/28/2022', 1, 0, null, 16),
                    (24, 2, '12/15/2022', '12/30/2022', 0, 1, null, 17),
                    (25, 1, '12/14/2022', '12/29/2022', 0, 1, null, 18),
                    (26, 2, '12/16/2022', '12/27/2022', 1, 0, null, 19),
                    (27, 1, '12/17/2022', '12/30/2022', 1, 0, null, 20),
                    (28, 2, '12/15/2022', '12/29/2022', 0, 1, null, 21),
                    (29, 1, '12/13/2022', '12/27/2022', 0, 1, null, 22),
                    (30, 2, '12/12/2022', '12/30/2022', 1, 0, null, 23),
                    (31, 1, '12/14/2022', '12/29/2022', 1, 0, null, 24),
                    (32, 2, '12/13/2022', '12/30/2022', 0, 1, null, 25),
                    (33, 2, '12/12/2022', '12/27/2022', 1, 0, null, 26),
                    (34, 1, '12/16/2022', '12/28/2022', 0, 1, null, 27),
                    (35, 2, '12/12/2022', '12/30/2022', 1, 0, null, 28),
                    (36, 1, '12/14/2022', '12/29/2022', 1, 1, null, 29),
                    (37, 1, '12/13/2022', '12/30/2022', 0, 1, null, 30),
                    (38, 2, '12/19/2022', '1/24/2023', 0, 1, null, 31)

select * from Orders

INSERT into OrderDetails (OrderID, ProductID, UnitPrice, Quantity) VALUES
                        (1,2, 30, 3), (1,1,20,3), (1,3, 15, 2),
                        (2,2,40,5), (2,6,4,4), (2,5,4,3),
                        (3,4,40,3), (3,5,80,2), (3,1,20,4),
                        (4,2,40,3), (4,4,50,2), (4,5,20,3),
                        (11, 6, 63, 6), (11, 3, 63, 2), (11, 12, 47, 10) ,
                        (12, 18, 64, 7), (12, 11, 70, 9), (12, 13, 79, 10),
                        (13, 6, 66, 7), (13, 16, 53, 5), (13, 19, 59, 7),
                        (14, 9, 70, 4), (14, 18, 41, 5), (14, 13, 53, 7),
                        (15, 14, 65, 1), (15, 8, 39, 3), (15, 16, 69, 3),
                        (16, 7, 37, 1), (16, 6, 47, 2), (16, 8, 60, 3),
                        (17, 2, 48, 10), (17, 11, 62, 9), (17, 17, 78, 5),
                        (18, 12, 50, 1), (18, 10, 66, 1), (18, 18, 39, 7)

select * from OrderDetails

INSERT into Reservations (OrderID, ReservationDate, DoneReservationDate, NumberOfGuests, CompanyID, Confirmed) values
                            ( 3, '1/3/2023', '1/2/2022',8, null, 1),
                            ( 4, '1/13/2023', '1/12/2022',6, null, 1),
                            ( null, '12/30/2022', '12/20/2022',8, 8, 1)


SET IDENTITY_INSERT Tables ON
SET IDENTITY_INSERT Tables ON
INSERT into Tables (TableID)values
                (1), (2), (3), (4), (5), (6)
SET IDENTITY_INSERT Tables OFF
SET IDENTITY_INSERT Tables OFF


INSERT Into ReservationDetails (ReservationID, TableID) values
                                (1, 1), (1,2), (2,3), (2,4), (3,1), (3,4)

set dateformat mdy
INSERT into Menus (InDate, OutDate) values
                ('1/7/2023', '1/8/2023'),
                ('1/9/2023', '1/10/2023'),
                ('1/11/2023', '2/24/2023')

INSERT into MenuDetails (MenuID, ProductID, UnitPrice) values
                        (1, 3, 20), (1,2, 100), (1,4,50), (1,5, 50),
                         (2, 1, 20), (2,4, 100), (2,6,50), (2,2, 50), (2,3,14),
                         (3, 1, 20), (3,4, 100), (3,6,50), (3,2, 50), (3,3,14), (3, 7, 9), (3,12,15)



