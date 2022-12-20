set dateformat mdy
Insert Into Countries (Name)
VALUES ('Polska'), ('Niemcy')


INSERT Into Cities (Name, CountryID)
VALUES ('Kraków', 1), ('Warszawa', 1), ('Berlin', 2), ('Dortmund', 2)


INSERT INTO Users (Name, PhoneNumber, email)
VALUES ('Jan Kowalski', '781422836', 'test@gmail.com'), ('Andrzej Nowak', '782333567', 'test2@gmail.com'), ('Pawel Koziol', '333444555', 'test3@gmail.com'),
       ('Pawel Maly', '213543333', 'test4@gmail.com'), ('Piotr Nowakowski', '78123333', 'test5@gmail.com'), ('Marek Niskopienny', '333666777', 'test6@gmail.com'),
       ('Polgros', '333555666', 'firma1@gmail.com'), ('Tadex', '333444655', 'firma2@gmail.com')

INSERT INTO Employees (EmployeeID, BirthDate, HireDate, Position, Address, CityID, PostalCode, IsManager, ReportsTo)
values (1, '1/1/1992', '1/3/2020', 'Waiter', 'Kawiory32', 1, '62-200', 0, 1),
       (2, '1/1/1970', '1/3/2001', 'Senior Waiter Manager', 'Kawiory 25', 2, '34-059', 1, null)

INSERT Into Admins (AdminID)
VALUES (3)

INSERT Into Customers (CustomerID)
VALUES  (4), (5), (6), (7), (8)

INSERT INTO PrivateCustomers (CustomerID)
values (4), (5), (6)

INSERT INTO CompanyCustomers (CustomerID, nip, Address, CityID, PostalCode) VALUES
            (7, '1234567', 'KAWIORY 83', 2, '64-900'), (8, '3333222', 'Czarnowiejska 3', 1, '30-059')

INSERT INTO Categories (Name) values
            ('Seafood') , ('Meat'), ('Poundry')

INSERT INTO Products (Name, CategoryID, Description) values
                ('Salmon', 1, 'Tasty fishh'), ('Trout', 1, 'Delicous fish'), ('Porkchop', 2, 'Tasty meat'), ('Ham', 2, 'Nicely done ham'),
                ('Milk', 3, 'Flavoured milk'), ('Butter', 3, 'Brilliant butter')




Insert into DiscountParams (R1, R2, InDate, OutDate) values
            (0.2, 0.1, '11/12/2022', '12/15/2022'), (0.3, 0.2, '12/16/2022', '3/3/2023')

INSERT into DiscountConditions (Z1, K1, K2, D1, InDate, OutDate)
values (4, 40, 30, 8, '11/12/2022', '12/15/2022'), (5, 50, 30, 15, '12/16/2022', '3/3/2023')





INSERT INTO Discounts (CustomerID, DiscountType, StartDate, EndDate, UsedDate, ParamsID, ConditionsID)
values  (4, 'lifetime', '1/6/2022', null, null, 2, 2),
        (5, 'temporary', '12/19/2022', '1/30/2023', null, 1, 2),
        (6, 'lifetime',  '1/3/2022' , null, null, 1, 1)

INSERT into Invoices (Date, CustomerID, Address, CityID, PostalCode) values
                    ('1/1/2022', 7, 'Kawiory 18', 1, '62-200'),
                    ('12/15/2022', 8, 'Kawiory 14', 1, '30-059')

INSERT into Orders (CustomerID, EmployeeID, OrderDate, ReceiveDate, IsPaid, TakeOut, InvoiceID, DiscountID) values
                    (4, 1, '1/1/2022', '12/31/2022', 1, 1, null, 1),
                    (5, 1, '12/3/2022', '12/30/2022', 1, 0, null, 2),
                    (7, 2,'12/12/2022', '12/30/2022', 0, 0, 1, null),
                    (8, 2,'12/14/2022', '12/30/2022', 0, 0, 2, null)


INSERT into OrderDetails (OrderID, ProductID, UnitPrice, Quantity) VALUES
                        (1,2, 30, 3), (1,1,20,3), (1,3, 15, 2),
                        (2,2,40,5), (2,6,4,4), (2,5,4,3),
                        (3,4,40,3), (3,5,80,2), (3,1,20,4),
                        (4,2,40,3), (4,4,50,2), (4,5,20,3)


INSERT into Reservations (OrderID, ReservationDate, DoneReservationDate, NumberOfGuests, CompanyID, Confirmed) values
                            ( 3, '1/3/2023', '1/2/2022',8, null, 1),
                            ( 4, '1/13/2023', '1/12/2022',6, null, 1),
                            ( null, '12/30/2022', '12/20/2022',8, 8, 1)


SET IDENTITY_INSERT Tables ON
INSERT into Tables (TableID)values
                (1), (2), (3), (4), (5), (6)
SET IDENTITY_INSERT Tables OFF


INSERT Into ReservationDetails (ReservationID, TableID) values
                                (1, 1), (1,2), (2,3), (2,4), (3,1), (3,4)


INSERT into Menus (InDate, OutDate) values
                ('12/30/2022', '1/10/2023'),
                ('12/25/2022', '12/29/2022')

INSERT into MenuDetails (MenuID, ProductID, UnitPrice) values
                        (1, 3, 20), (1,2, 100), (1,4,50), (1,5, 50),
                         (2, 1, 20), (2,4, 100), (2,6,50), (2,2, 50), (2,3,14)




