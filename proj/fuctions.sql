-- Funkcja zwracająca informacje czy dany produkt jest owocem morza
Create function IsSeafood (@ProductId INT)
returns bit
as
    begin
        if 'Seafood' = (Select C.Name from Products
            inner join Categories C on C.CategoryID = Products.CategoryID
            Where ProductID = @ProductId)
        begin
            return 1
        end

        return 0
    end

--Funkcja zwracająca wartość zamówienia
CREATE FUNCTION GetTotalOrderAmount (@OrderId int)
returns money
as
    begin
        return (
            select
    convert(money,SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) as 'Spending'
from Orders as O
inner join OrderDetails OD on O.OrderID = OD.OrderID
left outer join Discounts D on O.DiscountID = D.DiscountID
left outer join DiscountParams DP on D.ParamsID = DP.ParamsID
where O.OrderID = @OrderId
            )
    end

--Funkcja zwracająca tabelę z zamówiniami powyżej określonej kwoty
CREATE FUNCTION GetTotalOrderAmountAboveX (@min_price int)
returns table AS
RETURN
    select O.OrderID, O.CustomerID,
        convert(money,SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) as 'Price'
    from Orders as O
    inner join OrderDetails OD on O.OrderID = OD.OrderID
    left outer join Discounts D on O.DiscountID = D.DiscountID
    left outer join DiscountParams DP on D.ParamsID = DP.ParamsID
    group by O.OrderID, O.CustomerID
    having convert(money, SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) >= @min_price

--Funkcja zwracająca menu o danym ID
CREATE FUNCTION GetMenuByID (@id int)
returns table AS
RETURN
    select MD.ProductID, P.Name, MD.UnitPrice
    from MenuDetails as MD
    inner join Products P on P.ProductID = MD.ProductID
    where MD.MenuID = @id

--Funkcja zwracająca produkty sprzadane określoną ilość razy w danym okresie czasu
CREATE FUNCTION GetSoldDishesAtLeastX (@amount int, @startDate date, @endDate date)
returns table AS
RETURN
    select P.ProductID, P.Name, sum(OD.Quantity) as 'amount'
    from Products as P
    inner join OrderDetails OD on P.ProductID = OD.ProductID
    inner join Orders O on O.OrderID = OD.OrderID
    where O.OrderDate between @startDate and @endDate
    group by P.ProductID, P.Name
    having sum(OD.Quantity) >= @amount


--Funkcja zwracająca wartość zamówień danego dnia
CREATE FUNCTION GetPriceOnSpecificDay (@data date)
returns int
AS
BEGIN
    RETURN
    (select SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0)))) 'suma'
    from OrderDetails as OD
    inner join Orders O on OD.OrderID = O.OrderID
    left outer join Discounts D on O.DiscountID = D.DiscountID
    left outer join DiscountParams DP on D.ParamsID = DP.ParamsID
    where YEAR(@data) = YEAR(O.OrderDate) and MONTH(@data) = MONTH(O.OrderDate) and DAY(@data) = DAY(O.OrderDate))
end

--Funkcja zwracająca wartość zamówień danego miesiąca
CREATE FUNCTION GetPriceOnSpecificMonth (@year int, @month int)
returns int
AS
BEGIN
    RETURN
    (select SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0)))) 'suma'
    from OrderDetails as OD
    inner join Orders O on OD.OrderID = O.OrderID
    left outer join Discounts D on O.DiscountID = D.DiscountID
    left outer join DiscountParams DP on D.ParamsID = DP.ParamsID
    where @year = YEAR(O.OrderDate) and @month = MONTH(O.OrderDate))
end

--Funkcja zwracająca klientów, którzy zamówili nie mniej niż X razy w danym okresie czasu
CREATE FUNCTION GetClientsWithOrdersCountAboveX (@amount int, @startDate date, @endDate date)
returns table AS
RETURN
    select C.CustomerID, U.Name, count(O.CustomerID) 'orders'
    from Customers as C
    inner join Users U on U.UserID = C.CustomerID
    inner join Orders O on C.CustomerID = O.CustomerID
    where O.OrderDate between @startDate and @endDate
    group by C.CustomerID, U.Name
    having count(O.CustomerID) >= @amount

--Funkcja zwracająca klientów, którzy są u nas zadłużeni więcej niż X
CREATE FUNCTION GetClientsWhoOweAboveX (@value int)
returns table AS
RETURN
    select C.CustomerID, convert(money,SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0))))) 'owned'
    from Customers as C
    inner join Orders O on C.CustomerID = O.CustomerID
    inner join OrderDetails OD on O.OrderID = OD.OrderID
    left outer join Discounts D on D.DiscountID = O.DiscountID
    left outer join DiscountParams DP on D.ParamsID = DP.ParamsID
    group by C.CustomerID
    having SUM(OD.UnitPrice * OD.Quantity * ( 1 -IIF(D.DiscountType = 'lifetime', isnull(DP.R1, 0), isnull(DP.R2, 0)))) > @value

--Funkcja zwracająca wolne stoliki w określonym czasie
CREATE FUNCTION GetCompanyEmployees (@startDate date, @endDate date)
returns table AS
return
    select distinct R.TableID
    from ReservationDetails as R
    left outer join Reservations R2 on R.ReservationID = R2.ReservationID
    where ReservationDate between @startDate and @endDate

