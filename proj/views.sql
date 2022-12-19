---ProductsOnMenuFromPastTwoWeeks
Create VIEW ProductsOnMenuFromPastTwoWeeks
AS
select P.ProductID, P.Name from Products P
where P.ProductID in (
    select MD.ProductID from MenuDetails as MD
    inner join Menus M on MD.MenuID = M.MenuID
    where InDate < GETDATE() and DATEDIFF(DAY, OutDate, getdate() < 14)
    )

---Upcoming Reservations
CREATE VIEW UpcomingReservations
AS
SELECT R.ReservationID, R.NumberOfGuests, R.Confirmed, R.DoneReservationDate, R.ReservationDate, O.OrderID, U.Name,
       SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(ISNULL(D.DiscountType, 'lifetime')) = 'lifetime', isnull(DP.R1, 0), isnull(dp.R2, 0))) as kwota
from Reservations R
inner join Orders O on O.OrderID = R.OrderID
inner join PrivateCustomers PC on O.CustomerID = PC.CustomerID
inner join CompanyCustomers CC on CC.CustomerID = R.CompanyID
inner join Customers C on C.CustomerID = O.CustomerID or C.CustomerID = R.CompanyID
inner join Users U on C.CustomerID = U.UserID
inner join OrderDetails OD on O.OrderID = OD.OrderID
left outer join Discounts D on O.DiscountID = D.DiscountID
left outer join DiscountParams DP on D.ParamsID = DP.ParamsID
where ReservationDate >= GETDATE()
group by R.ReservationID, R.NumberOfGuests, R.Confirmed,R.DoneReservationDate, R.ReservationDate, O.OrderID, U.Name


--upcoming orders
CREATE VIEW UpcomingOrders
AS SELECT O.OrderID, O.ReceiveDate, O.TakeOut, O.IsPaid,
          SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(ISNULL(D.DiscountType, 'lifetime')) = 'lifetime', isnull(DP.R1, 0), isnull(dp.R2, 0))) as kwota
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

--order stats
CREATE VIEW OrderStatistics
AS
SELECT YEAR(O.OrderDate), MONTH(O.OrderDate) ,
SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(ISNULL(D.DiscountType, 'lifetime')) = 'lifetime', isnull(DP.R1, 0), isnull(dp.R2, 0))) as 'Total income',
AVG(OD.UnitPrice * OD.Quantity * ( 1 -IIF(ISNULL(D.DiscountType, 'lifetime')) = 'lifetime', isnull(DP.R1, 0), isnull(dp.R2, 0))) as 'Avg price',
COUNT(O.OrderID) as 'Number of orders',
COUNT(O.DiscountID) as 'Used discounts'
from Orders O
inner join OrderDetails OD on O.OrderID = OD.OrderID
left outer join Discounts D on O.DiscountID = D.DiscountID
left outer join DiscountParams DP on D.ParamsID = DP.ParamsID
group by YEAR(O.OrderDate), MONTH(O.OrderDate)

---TableReservationCount
CREATE VIEW TableReservationCount
AS
SELECT T.TableID, YEAR(R.ReservationDate), month(R.ReservationDate),
Count(*) as 'Number of reservations'
from Tables T
inner join ReservationDetails RD on T.TableID = RD.TableID
inner join Reservations R on RD.ReservationID = R.ReservationID
group by T.TableID, YEAR(R.ReservationDate), month(R.ReservationDate)

--ProductPurchaseCount
CREATE VIEW ProductPurchaseCount
as
SELECT P.ProductID, P.Name, YEAR(Orders.OrderDate), MONTH(ORDERS.OrderDate),
       count(P.ProductID) as 'Number of orders'
from Products P
INNER JOIN OrderDetails OD on P.ProductID = OD.ProductID
INNER JOIN Orders ON OD.OrderID = Orders.OrderID
group by P.ProductID, P.Name, YEAR(Orders.OrderDate), MONTH(ORDERS.OrderDate)

-- CustomerSpendingStats
CREATE VIEW CustomerSpendingStatistics
AS
select C.CustomerID, U.Name, (IIF(PC.CustomerID is null, 'Firma', 'Osoba prywatna')) as typ,
SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(ISNULL(D.DiscountType, 'lifetime')) = 'lifetime', isnull(DP.R1, 0), isnull(dp.R2, 0))) as 'Spending'
       from Customers C
inner join Users U on U.UserID = C.CustomerID
inner join Orders O on C.CustomerID = O.CustomerID
inner join OrderDetails OD on O.OrderID = OD.OrderID
inner join CompanyCustomers CC on CC.CustomerID = C.CustomerID
inner join PrivateCustomers PC on C.CustomerID = PC.CustomerID
left outer join Discounts D on PC.CustomerID = D.CustomerID
left join DiscountParams DP on D.ParamsID = DP.ParamsID
group by C.CustomerID, U.Name, pc.CustomerID


