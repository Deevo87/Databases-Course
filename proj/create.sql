-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-12-20 08:01:07.34

-- tables
-- Table: Admins
CREATE TABLE Admins (
    AdminID int  NOT NULL,
    CONSTRAINT Admins_pk PRIMARY KEY  (AdminID)
);

-- Table: Categories
CREATE TABLE Categories (
    CategoryID int  NOT NULL IDENTITY(1, 1),
    Name nvarchar(40)  NOT NULL,
    CONSTRAINT Categories_pk PRIMARY KEY  (CategoryID)
);

-- Table: Cities
CREATE TABLE Cities (
    CityID int  NOT NULL IDENTITY(1, 1),
    Name varchar(90)  NOT NULL,
    CountryID int  NOT NULL,
    CONSTRAINT UQCItyName UNIQUE (Name),
    CONSTRAINT Cities_pk PRIMARY KEY  (CityID)
);

-- Table: CompanyCustomers
CREATE TABLE CompanyCustomers (
    CustomerID int  NOT NULL,
    nip varchar(10)  NOT NULL CHECK (ISNUMERIC(nip) = 1),
    Address nvarchar(60)  NOT NULL,
    CityID int  NOT NULL,
    PostalCode varchar(10)  NOT NULL,
    CONSTRAINT UniqNip UNIQUE (nip),
    CONSTRAINT PostalCheck CHECK (PostalCode LIKE '__-___'),
    CONSTRAINT CompanyCustomers_pk PRIMARY KEY  (CustomerID)
);

-- Table: Countries
CREATE TABLE Countries (
    CountryID int  NOT NULL IDENTITY(1, 1),
    Name varchar(90)  NOT NULL,
    CONSTRAINT Countries_pk PRIMARY KEY  (CountryID)
);

-- Table: Customers
CREATE TABLE Customers (
    CustomerID int  NOT NULL,
    CONSTRAINT Customers_pk PRIMARY KEY  (CustomerID)
);

-- Table: DiscountConditions
CREATE TABLE DiscountConditions (
    ConditionsID int  NOT NULL IDENTITY(1, 1),
    Z1 int  NOT NULL CHECK (Z1 > 0),
    K1 money  NOT NULL CHECK (K1 >0),
    K2 money  NOT NULL CHECK (K2 > 0),
    D1 int  NOT NULL CHECK (D1>0),
    InDate smalldatetime  NOT NULL,
    OutDate smalldatetime  NOT NULL,
    CONSTRAINT DateCheckscondts CHECK (InDate < OutDate),
    CONSTRAINT BottomDatecondst CHECK (InDate > '1/1/2022'),
    CONSTRAINT DiscountConditions_pk PRIMARY KEY  (ConditionsID)
);

-- Table: DiscountParams
CREATE TABLE DiscountParams (
    ParamsID int  NOT NULL IDENTITY(1, 1),
    R1 float  NOT NULL CHECK (R1 BETWEEN 0.00 AND 1.00),
    R2 float  NOT NULL CHECK (R2 BETWEEN 0.00 AND 1.00),
    InDate smalldatetime  NOT NULL,
    OutDate smalldatetime  NOT NULL,
    CONSTRAINT DateChecks CHECK (InDate < OutDate),
    CONSTRAINT BottomDate CHECK (InDate > '1/1/2022'),
    CONSTRAINT DiscountParams_pk PRIMARY KEY  (ParamsID)
);

-- Table: Discounts
CREATE TABLE Discounts (
    DiscountID int  NOT NULL IDENTITY(1, 1),
    CustomerID int  NOT NULL,
    DiscountType varchar(30)  NOT NULL CHECK (discountType IN ('lifetime', 'temporary')),
    StartDate smalldatetime  NULL,
    EndDate smalldatetime  NULL,
    UsedDate smalldatetime  NULL,
    ParamsID int  NOT NULL,
    ConditionsID int  NOT NULL,
    CONSTRAINT chk_datediscoutns CHECK (ISNULL(EndDate, '1/1/2030') > ISNULL(StartDate, '1/1/2000')),
    CONSTRAINT bottm_datediscounts CHECK (ISNULL(StartDate, '1/1/2030') > '1/1/2020'),
    CONSTRAINT usedDatediscounts CHECK (ISNULL(UsedDate, '1/1/2030') > ISNULL(StartDate, '1/1/2000') AND ISNULL(UsedDate, '1/1/2018') < ISNULL(EndDate, '1/1/2019')),
    CONSTRAINT Discounts_pk PRIMARY KEY  (DiscountID)
);

-- Table: Employees
CREATE TABLE Employees (
    EmployeeID int  NOT NULL,
    BirthDate smalldatetime  NOT NULL CHECK (birthDate <= GETDATE()),
    HireDate smalldatetime  NOT NULL CHECK (hireDate <= GETDATE()),
    Position varchar(90)  NOT NULL,
    Address varchar(90)  NOT NULL,
    CityID int  NOT NULL,
    PostalCode varchar(10)  NOT NULL,
    IsManager bit  NOT NULL DEFAULT 0,
    ReportsTo int  NULL,
    CONSTRAINT DateUnequality CHECK (BirthDate < HireDate),
    CONSTRAINT BirthGreaterThan CHECK (BirthDate > '1/1/1910'),
    CONSTRAINT Employees_pk PRIMARY KEY  (EmployeeID)
);

-- Table: GlobalVars
CREATE TABLE GlobalVars (
    id int  NOT NULL,
    WZ money  NOT NULL CHECK (WZ > 0),
    WK int  NOT NULL CHECK (WK > 0),
    CONSTRAINT id PRIMARY KEY  (id)
);

-- Table: Invoices
CREATE TABLE Invoices (
    InvoiceID int  NOT NULL IDENTITY(1, 1),
    Date smalldatetime  NOT NULL,
    CustomerID int  NOT NULL,
    Address varchar(100)  NOT NULL,
    CityID int  NOT NULL,
    PostalCode varchar(10)  NOT NULL,
    CONSTRAINT PostalCheckInvoices CHECK (PostalCode LIKE '__-___'),
    CONSTRAINT InvoiceID PRIMARY KEY  (InvoiceID)
);

-- Table: MenuDetails
CREATE TABLE MenuDetails (
    MenuID int  NOT NULL,
    ProductID int  NOT NULL,
    UnitPrice int  NOT NULL CHECK (UnitPrice >0),
    CONSTRAINT MenuDetails_pk PRIMARY KEY  (MenuID,ProductID)
);

-- Table: Menus
CREATE TABLE Menus (
    MenuID int  NOT NULL IDENTITY(1, 1),
    InDate smalldatetime  NOT NULL CHECK (inDate > GETDATE()),
    OutDate smalldatetime  NOT NULL CHECK (outDate > GETDATE()),
    CONSTRAINT DateChecksmenus CHECK (InDate < OutDate),
    CONSTRAINT BottomChecksmanus CHECK (InDate > '1/1/2022'),
    CONSTRAINT MenuID PRIMARY KEY  (MenuID)
);

-- Table: OrderDetails
CREATE TABLE OrderDetails (
    OrderID int  NOT NULL,
    ProductID int  NOT NULL,
    UnitPrice money  NOT NULL CHECK (UnitPrice>0),
    Quantity int  NOT NULL CHECK (Quantity > 0),
    CONSTRAINT OrderDetails_pk PRIMARY KEY  (OrderID,ProductID)
);

-- Table: Orders
CREATE TABLE Orders (
    OrderID int  NOT NULL IDENTITY(1, 1),
    CustomerID int  NOT NULL,
    EmployeeID int  NOT NULL,
    OrderDate smalldatetime  NOT NULL CHECK (OrderDate <= GETDATE()),
    ReceiveDate smalldatetime  NOT NULL CHECK (ReceiveDate >= GETDATE()),
    IsPaid bit  NOT NULL,
    TakeOut bit  NOT NULL,
    InvoiceID int  NULL,
    DiscountID int  NULL,
    CONSTRAINT Orders_pk PRIMARY KEY  (OrderID)
);

-- Table: PrivateCustomers
CREATE TABLE PrivateCustomers (
    CustomerID int  NOT NULL,
    CONSTRAINT PrivateCustomers_pk PRIMARY KEY  (CustomerID)
);

-- Table: Products
CREATE TABLE Products (
    ProductID int  NOT NULL IDENTITY(1, 1),
    Name varchar(50)  NOT NULL,
    CategoryID int  NOT NULL,
    Description nvarchar(150)  NOT NULL,
    IsActive bit  NOT NULL DEFAULT 1,
    CONSTRAINT Products_pk PRIMARY KEY  (ProductID)
);

-- Table: ReservationDetails
CREATE TABLE ReservationDetails (
    ReservationID int  NOT NULL,
    TableID int  NOT NULL,
    CONSTRAINT ReservationDetails_pk PRIMARY KEY  (ReservationID,TableID)
);

-- Table: Reservations
CREATE TABLE Reservations (
    ReservationID int  NOT NULL IDENTITY(1, 1),
    OrderID int  NULL,
    ReservationDate smalldatetime  NOT NULL CHECK (ReservationDate >= GETDATE()),
    DoneReservationDate smalldatetime  NOT NULL CHECK (DoneReservationDate <= GETDATE()),
    NumberOfGuests int  NOT NULL CHECK (NumberOfGuests > 0),
    CompanyID int  NULL,
    Confirmed bit  NOT NULL,
    CONSTRAINT Reservations_pk PRIMARY KEY  (ReservationID)
);

-- Table: Tables
CREATE TABLE Tables (
    TableID int  NOT NULL IDENTITY(1, 1),
    CONSTRAINT Tables_pk PRIMARY KEY  (TableID)
);

-- Table: Users
CREATE TABLE Users (
    UserID int  NOT NULL IDENTITY(1, 1),
    Name nvarchar(100)  NOT NULL,
    PhoneNumber char(9)  NULL CHECK (PhoneNumber IS NULL OR ISNUMERIC(PhoneNumber) = 1),
    email nvarchar(60)  NOT NULL CHECK (email IS NULL OR email LIKE '%_@%_.%_'),
    CONSTRAINT UqPhoneNumber UNIQUE (PhoneNumber),
    CONSTRAINT UqEmail UNIQUE (email),
    CONSTRAINT Users_pk PRIMARY KEY  (UserID)
);

-- foreign keys
-- Reference: Admins_Users (table: Admins)
ALTER TABLE Admins ADD CONSTRAINT Admins_Users
    FOREIGN KEY (AdminID)
    REFERENCES Users (UserID);

-- Reference: Categories_Products (table: Products)
ALTER TABLE Products ADD CONSTRAINT Categories_Products
    FOREIGN KEY (CategoryID)
    REFERENCES Categories (CategoryID);

-- Reference: Cities_Countries (table: Cities)
ALTER TABLE Cities ADD CONSTRAINT Cities_Countries
    FOREIGN KEY (CountryID)
    REFERENCES Countries (CountryID);

-- Reference: Cities_Invoices (table: Invoices)
ALTER TABLE Invoices ADD CONSTRAINT Cities_Invoices
    FOREIGN KEY (CityID)
    REFERENCES Cities (CityID);

-- Reference: CompanyCustomer_Cities (table: CompanyCustomers)
ALTER TABLE CompanyCustomers ADD CONSTRAINT CompanyCustomer_Cities
    FOREIGN KEY (CityID)
    REFERENCES Cities (CityID);

-- Reference: Customers_CompanyCustomer (table: CompanyCustomers)
ALTER TABLE CompanyCustomers ADD CONSTRAINT Customers_CompanyCustomer
    FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID);

-- Reference: Customers_Orders (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Customers_Orders
    FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID);

-- Reference: Customers_PrivateCustomers (table: PrivateCustomers)
ALTER TABLE PrivateCustomers ADD CONSTRAINT Customers_PrivateCustomers
    FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID);

-- Reference: Discounts_DiscountConditions (table: Discounts)
ALTER TABLE Discounts ADD CONSTRAINT Discounts_DiscountConditions
    FOREIGN KEY (ConditionsID)
    REFERENCES DiscountConditions (ConditionsID);

-- Reference: Discounts_DiscountParams (table: Discounts)
ALTER TABLE Discounts ADD CONSTRAINT Discounts_DiscountParams
    FOREIGN KEY (ParamsID)
    REFERENCES DiscountParams (ParamsID);

-- Reference: Employees_Cities (table: Employees)
ALTER TABLE Employees ADD CONSTRAINT Employees_Cities
    FOREIGN KEY (CityID)
    REFERENCES Cities (CityID);

-- Reference: Employees_Employees (table: Employees)
ALTER TABLE Employees ADD CONSTRAINT Employees_Employees
    FOREIGN KEY (ReportsTo)
    REFERENCES Employees (EmployeeID);

-- Reference: Employees_Users (table: Employees)
ALTER TABLE Employees ADD CONSTRAINT Employees_Users
    FOREIGN KEY (EmployeeID)
    REFERENCES Users (UserID);

-- Reference: Invoices_Orders (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Invoices_Orders
    FOREIGN KEY (InvoiceID)
    REFERENCES Invoices (InvoiceID);

-- Reference: MenuDetails_Menus (table: MenuDetails)
ALTER TABLE MenuDetails ADD CONSTRAINT MenuDetails_Menus
    FOREIGN KEY (MenuID)
    REFERENCES Menus (MenuID);

-- Reference: MenuDetails_Products (table: MenuDetails)
ALTER TABLE MenuDetails ADD CONSTRAINT MenuDetails_Products
    FOREIGN KEY (ProductID)
    REFERENCES Products (ProductID);

-- Reference: OrderDetails_Orders (table: OrderDetails)
ALTER TABLE OrderDetails ADD CONSTRAINT OrderDetails_Orders
    FOREIGN KEY (OrderID)
    REFERENCES Orders (OrderID);

-- Reference: Orders_Discounts (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Orders_Discounts
    FOREIGN KEY (DiscountID)
    REFERENCES Discounts (DiscountID);

-- Reference: Orders_Employees (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Orders_Employees
    FOREIGN KEY (EmployeeID)
    REFERENCES Employees (EmployeeID);

-- Reference: Orders_Reservation (table: Reservations)
ALTER TABLE Reservations ADD CONSTRAINT Orders_Reservation
    FOREIGN KEY (OrderID)
    REFERENCES Orders (OrderID);

-- Reference: PrivateCustomers_Discounts (table: Discounts)
ALTER TABLE Discounts ADD CONSTRAINT PrivateCustomers_Discounts
    FOREIGN KEY (CustomerID)
    REFERENCES PrivateCustomers (CustomerID);

-- Reference: Products_OrderDetails (table: OrderDetails)
ALTER TABLE OrderDetails ADD CONSTRAINT Products_OrderDetails
    FOREIGN KEY (ProductID)
    REFERENCES Products (ProductID);

-- Reference: ReservationDetails_Tables (table: ReservationDetails)
ALTER TABLE ReservationDetails ADD CONSTRAINT ReservationDetails_Tables
    FOREIGN KEY (TableID)
    REFERENCES Tables (TableID);

-- Reference: Reservation_CompanyCustomer (table: Reservations)
ALTER TABLE Reservations ADD CONSTRAINT Reservation_CompanyCustomer
    FOREIGN KEY (CompanyID)
    REFERENCES CompanyCustomers (CustomerID);

-- Reference: Reservation_ReservationDetails (table: ReservationDetails)
ALTER TABLE ReservationDetails ADD CONSTRAINT Reservation_ReservationDetails
    FOREIGN KEY (ReservationID)
    REFERENCES Reservations (ReservationID);

-- Reference: Users_Customers (table: Customers)
ALTER TABLE Customers ADD CONSTRAINT Users_Customers
    FOREIGN KEY (CustomerID)
    REFERENCES Users (UserID);

-- End of file.

