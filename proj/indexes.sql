--Orders

CREATE NONCLUSTERED INDEX OrdersDatesIDIndex on Orders(OrderDate, ReceiveDate);
CREATE NONCLUSTERED INDEX ReadyForDelivery on Orders(IsPaid, TakeOut)

---
--Reservations

Create NONCLUSTERED INDEX ReservationCompanyIDIndex on Reservations(CompanyID)
Create NONCLUSTERED INDEX ReservationOrderIDIndex on Reservations(OrderID)
CREATE NONCLUSTERED INDEX ReservationDatesIDIndex on Reservations(DoneReservationDate, ReservationDate);

---
--Users

CREATE NONCLUSTERED INDEX UserNameIndex on Users(Name)

---
--Categories

CREATE NONCLUSTERED INDEX CategoryNameIndex on Categories(Name)

---
--Products

CREATE NONCLUSTERED INDEX ProductNameIndex on Products(Name)
CREATE NONCLUSTERED INDEX ProductNameIndex on Products(CategoryID)
CREATE NONCLUSTERED INDEX WasUsedBeforeIndex on Products(IsActive)

---
--Menus

CREATE NONCLUSTERED INDEX MenuDatesIDIndex on Menus(InDate, OutDate)
CREATE NONCLUSTERED INDEX MenuDetailsProductIDIndex on MenuDetails(ProductID)

---
-- Discounts/DiscountConditions/DiscountParams

CREATE NONCLUSTERED INDEX DiscountConditionsHistoryIndex on DiscountConditions(InDate, OutDate)
CREATE NONCLUSTERED INDEX DiscountParamsHistoryIndex on DiscountParams(InDate, OutDate)
CREATE NONCLUSTERED INDEX DiscountUsedIndex on Discounts(UsedDate, EndDate)
CREATE NONCLUSTERED INDEX DiscountNameIndex on Discounts(DiscountType)

---
--Employees

CREATE NONCLUSTERED INDEX HireDateIndex on Employees(HireDate)
CREATE NONCLUSTERED INDEX PositionIndex on Employees(Position)


