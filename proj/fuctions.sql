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