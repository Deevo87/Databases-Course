---ProductsOnMenuFromPastTwoWeeks
Create VIEW ProductsOnMenuFromPastTwoWeeks
AS
select P.ProductID, P.Name from Products P
where P.ProductID in (
    select MD.ProductID from MenuDetails as MD
    inner join Menus M on MD.MenuID = M.MenuID
    where InDate < GETDATE() and DATEDIFF(DAY, OutDate, getdate()) < 14
    )

---Upcoming Reservations
CREATE VIEW UpcomingReservations
AS
SELECT R.ReservationID, R.NumberOfGuests, R.Confirmed, R.DoneReservationDate, R.ReservationDate, O.OrderID, U.Name,
       convert(money,SUM(OD.UnitPrice * OD.Quantity * ( 1 - iif(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) as kwota
from Reservations as R
left outer join Orders O on O.OrderID = R.OrderID
inner join Customers C on C.CustomerID = O.CustomerID or C.CustomerID = R.CompanyID
inner join Users U on C.CustomerID = U.UserID
left outer join OrderDetails OD on O.OrderID = OD.OrderID
left outer join Discounts D on O.DiscountID = D.DiscountID
left outer join DiscountParams DP on D.ParamsID = DP.ParamsID
where ReservationDate >= GETDATE() -- tutaj nie powinno byc komentarza ale dla celow demonstracyjnych jest
group by R.ReservationID, R.NumberOfGuests, R.Confirmed,R.DoneReservationDate, R.ReservationDate, O.OrderID, U.Name

--upcoming orders
CREATE VIEW UpcomingOrders
AS SELECT O.OrderID, O.ReceiveDate, O.TakeOut, O.IsPaid,
          convert(money,SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) as kwota
   from Orders O
inner join OrderDetails OD on O.OrderID = OD.OrderID
inner join Customers C on O.CustomerID = C.CustomerID
inner join Users U on C.CustomerID = U.UserID
left outer join PrivateCustomers PC on C.CustomerID = PC.CustomerID
left outer join CompanyCustomers CC on C.CustomerID = CC.CustomerID
left outer join Discounts D on O.DiscountID = D.DiscountID
left outer join DiscountParams DP on D.ParamsID = DP.ParamsID
where O.ReceiveDate > GETDATE()
group by O.OrderID, O.ReceiveDate, O.TakeOut, O.IsPaid

--OrderStatisticsMonthly
CREATE VIEW OrderStatisticsMonthly
AS
SELECT YEAR(O.OrderDate) as 'year', MONTH(O.OrderDate) as 'month' ,
convert(money,SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) as 'Total income',
convert(money,AVG(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) as 'Avg price',
COUNT(O.OrderID) as 'Number of orders',
COUNT(O.DiscountID) as 'Used discounts'
from Orders O
inner join OrderDetails OD on O.OrderID = OD.OrderID
left outer join Discounts D on O.DiscountID = D.DiscountID
left outer join DiscountParams DP on D.ParamsID = DP.ParamsID
group by YEAR(O.OrderDate), MONTH(O.OrderDate)

--OrderStatisticsWeekly
CREATE VIEW OrderStatisticsWeekly
AS
SELECT YEAR(O.OrderDate) as 'year', DATEPART(week, O.OrderDate) as 'week' ,
convert(money,SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) as 'Total income',
convert(money,AVG(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) as 'Avg price',
COUNT(O.OrderID) as 'Number of orders',
COUNT(O.DiscountID) as 'Used discounts'
from Orders O
inner join OrderDetails OD on O.OrderID = OD.OrderID
left outer join Discounts D on O.DiscountID = D.DiscountID
left outer join DiscountParams DP on D.ParamsID = DP.ParamsID
group by YEAR(O.OrderDate), DATEPART(week, O.OrderDate)

---MonthlyTableReservationCount
CREATE VIEW MonthlyTableReservationCount
AS
SELECT T.TableID, YEAR(R.ReservationDate) as 'year', month(R.ReservationDate) as 'month',
Count(*) as 'Number of reservations'
from Tables T
inner join ReservationDetails RD on T.TableID = RD.TableID
inner join Reservations R on RD.ReservationID = R.ReservationID
group by T.TableID, YEAR(R.ReservationDate), month(R.ReservationDate)

---WeeklyTableReservationCount
CREATE VIEW WeeklyTableReservationCount
AS
SELECT T.TableID, YEAR(R.ReservationDate) as 'year', datepart(week ,R.ReservationDate) as 'week',
Count(*) as 'Number of reservations'
from Tables T
inner join ReservationDetails RD on T.TableID = RD.TableID
inner join Reservations R on RD.ReservationID = R.ReservationID
group by T.TableID, YEAR(R.ReservationDate), datepart(week ,R.ReservationDate)


--ProductPurchaseCount
CREATE VIEW ProductPurchaseCount
as
SELECT P.ProductID, P.Name, YEAR(Orders.OrderDate) as 'rok', MONTH(ORDERS.OrderDate) as 'miesiac',
       count(P.ProductID) as 'Number of orders'
from Products P
INNER JOIN OrderDetails OD on P.ProductID = OD.ProductID
INNER JOIN Orders ON OD.OrderID = Orders.OrderID
group by P.ProductID, P.Name, YEAR(Orders.OrderDate), MONTH(ORDERS.OrderDate)

-- CustomerSpendingStats
CREATE VIEW CustomerSpendingStatistics
AS
select C.CustomerID, U.Name, (IIF(PC.CustomerID is null, 'Firma', 'Osoba prywatna')) as typ,
convert(money,SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) as 'Spending'
       from Customers C
inner join Users U on U.UserID = C.CustomerID
inner join Orders O on C.CustomerID = O.CustomerID
inner join OrderDetails OD on O.OrderID = OD.OrderID
left outer join CompanyCustomers CC on CC.CustomerID = C.CustomerID
left outer join PrivateCustomers PC on C.CustomerID = PC.CustomerID
left outer join Discounts D on PC.CustomerID = D.CustomerID
left join DiscountParams DP on D.ParamsID = DP.ParamsID
group by C.CustomerID, U.Name, pc.CustomerID

--UnpaidOrders
CREATE VIEW UnpaidOrders as
select O.CustomerID, U.Name,
    convert(money,SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) as 'Spending'
from Orders as O
inner join OrderDetails OD on O.OrderID = OD.OrderID
inner join Customers C on O.CustomerID = C.CustomerID
inner join Users U on C.CustomerID = U.UserID
left outer join Discounts D on O.DiscountID = D.DiscountID
left outer join DiscountParams DP on D.ParamsID = DP.ParamsID
where O.IsPaid = 0
group by O.CustomerID, U.Name

--MealsInfo
CREATE VIEW MealsInfo AS
    select P.Name as ProductName, C.Name as CategoryName, P.Description from Products as P
    inner join Categories C on C.CategoryID = P.CategoryID

--CurrentMenu
CREATE VIEW CurrentMenu AS
    select ProductID, UnitPrice from MenuDetails  as MD
    inner join Menus M on M.MenuID = MD.MenuID
    where GETDATE() between M.InDate and M.OutDate

--FreeTablesForToday
CREATE VIEW FreeTablesForToday AS
    select T.TableID from Tables T
    where TableID not in
            (
            select RD.TableID from Reservations
            inner join ReservationDetails RD on Reservations.ReservationID = RD.ReservationID
            where ReservationDate = GETDATE()
            )


CREATE VIEW CustomerInvoices AS
    SELECT I.CustomerID ,I.InvoiceID, O.OrderID, O.EmployeeID, O.OrderDate, O.ReceiveDate,
            convert(money,SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) as 'Value',
            convert(money,SUM(OD.UnitPrice * OD.Quantity ))
            - convert(money,SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) as 'DiscountValue'
    FROM Invoices I
    INNER JOIN Orders O on I.InvoiceID = O.InvoiceID
    INNER JOIN OrderDetails OD ON O.OrderID = OD.OrderID
    Left OUTER JOIN Discounts D on O.DiscountID = D.DiscountID
    LEFT OUTER JOIN DiscountParams DP on D.ParamsID = DP.ParamsID
    group by I.CustomerID ,I.InvoiceID, O.OrderID, O.EmployeeID, O.OrderDate, O.ReceiveDate

CREATE VIEW UpcomingSeafoodOrders AS
    SELECT P.ProductID, P.Name, O.ReceiveDate, sum(Quantity) AS 'Quantity' FROM Orders O
    Inner Join OrderDetails OD on O.OrderID = OD.OrderID
    inner join Products P on P.ProductID = OD.ProductID
    INNER JOIN Categories C on C.CategoryID = P.CategoryID
    WHERE C.Name = 'Seafood'
        and ReceiveDate >= getdate()
        and ReceiveDate <= getdate() + 10
        and DATEPART(weekday, O.ReceiveDate) IN (5,6,7)
    GROUP BY P.ProductID, P.Name, O.ReceiveDate
    WITH ROLLUP

CREATE View UnconfirmedReservations AS
    SELECT R.ReservationID, R.NumberOfGuests, R.DoneReservationDate, R.ReservationDate, O.OrderID, U.Name,
        IIF(R.CompanyID is null, 'Indywidualna', 'Firmowa') as type,
       convert(money,SUM(OD.UnitPrice * OD.Quantity * ( 1 - iif(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) as kwota
    from Reservations as R
    left outer join Orders O on O.OrderID = R.OrderID
    inner join Customers C on C.CustomerID = O.CustomerID or C.CustomerID = R.CompanyID
    inner join Users U on C.CustomerID = U.UserID
    left outer join OrderDetails OD on O.OrderID = OD.OrderID
    left outer join Discounts D on O.DiscountID = D.DiscountID
    left outer join DiscountParams DP on D.ParamsID = DP.ParamsID
    where R.Confirmed = 0 and ReservationDate >= GETDATE()
    group by R.ReservationID, R.NumberOfGuests, R.DoneReservationDate, R.ReservationDate, O.OrderID, U.Name, R.CompanyID

CREATE VIEW DiscountReportsMonthly as
    SELECT D.CustomerID, D.DiscountType, YEAR(D.StartDate) as year, month(D.StartDate) as month, count(*) as NumberOfDiscounts FROM Discounts D
    INNER JOIN DiscountConditions DC on DC.ConditionsID = D.ConditionsID
    INNER JOIN DiscountParams DP on DP.ParamsID = D.ParamsID
    group by D.CustomerID, D.DiscountType, YEAR(D.StartDate), month(D.StartDate)

CREATE VIEW DiscountReportsWeekly as
    SELECT D.CustomerID, D.DiscountType, YEAR(D.StartDate) as year, datepart( week ,D.StartDate) as week, count(*) as NumberOfDiscounts FROM Discounts D
    INNER JOIN DiscountConditions DC on DC.ConditionsID = D.ConditionsID
    INNER JOIN DiscountParams DP on DP.ParamsID = D.ParamsID
    group by D.CustomerID, D.DiscountType, YEAR(D.StartDate), datepart( week ,D.StartDate)

--MealsOrderCountMonthly
CREATE VIEW MealsOrderCountMonthly as
    select YEAR(O.OrderDate) year, MONTH(O.OrderDate) month, P.name, isNULL(count(OD.ProductID), 0) [ordered times]
    from Products as P
    inner join OrderDetails OD on P.ProductID = OD.ProductID
    inner join Orders O on O.OrderID = OD.OrderID
    group by YEAR(O.OrderDate), MONTH(O.OrderDate), P.name

--MealsOrderCountWeekly
CREATE VIEW MealsOrderCountWeekly as
    select YEAR(O.OrderDate) year, DATEPART(week, O.OrderDate) week, P.name, isNULL(count(OD.ProductID), 0) [ordered times]
    from Products as P
    inner join OrderDetails OD on P.ProductID = OD.ProductID
    inner join Orders O on O.OrderID = OD.OrderID
    group by YEAR(O.OrderDate), DATEPART(week, O.OrderDate), P.name