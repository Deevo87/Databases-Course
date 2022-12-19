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
SELECT R.ReservationID, R.NumberOfGuests, R.DoneReservationDate, R.ReservationDate, O.OrderID, U.Name, SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(ISNULL(D.DiscountType, 'lifetime')) = 'lifetime', isnull(DP.R1, 0), isnull(dp.R2, 0))) as kwota from Reservations R
inner join Orders O on O.OrderID = R.OrderID
inner join PrivateCustomers PC on O.CustomerID = PC.CustomerID
inner join CompanyCustomers CC on CC.CustomerID = R.CompanyID
inner join Customers C on C.CustomerID = O.CustomerID or C.CustomerID = R.CompanyID
inner join Users U on C.CustomerID = U.UserID
inner join OrderDetails OD on O.OrderID = OD.OrderID
left outer join Discounts D on O.DiscountID = D.DiscountID
left outer join DiscountParams DP on D.ParamsID = DP.ParamsID
where ReservationDate >= GETDATE()
group by R.ReservationID, R.NumberOfGuests, R.DoneReservationDate, R.ReservationDate, O.OrderID, U.Name
