Insert Into Countries (Name)
VALUES ('Polska')

Insert Into Countries (Name)
VALUES ('Niemcy')

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


select * from DiscountConditions

Insert into DiscountParams (R1, R2, InDate, OutDate) values
            (0.2, 0.1, '11/12/2022', '12/15/2022'), (0.3, 0.2, '12/16/2022', '3/3/2023')

INSERT into DiscountConditions (Z1, K1, K2, D1, InDate, OutDate)
values (4, 40, 30, 8, '11/12/2022', '12/15/2022'), (5, 50, 30, 15, '12/16/2022', '3/3/2023')

select convert(smalldatetime, '1/1/2022')

INSERT INTO Discounts (CustomerID, DiscountType, StartDate, ParamsID, ConditionsID)
values  (4, 'lifetime',  '1/1/2022', 1, 1)


select * from Discounts