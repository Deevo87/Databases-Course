CREATE NONCLUSTERED INDEX OrdersCustomerIDIndex ON Orders(CustomerID);
CREATE NONCLUSTERED INDEX OrdersDatesIDIndex ON Orders(OrderDate,
ReceiveDate);

---

Create NONCLUSTERED INDEX ReservationCompanyIDIndex ON Reservations(CompanyID)
Create NONCLUSTERED INDEX ReservationOrderIDIndex ON Reservations(OrderID)
CREATE NONCLUSTERED INDEX ReservationDatesIDIndex ON Reservations(DoneReservationDate,
ReservationDate);

---

Create NONCLUSTERED INDEX CompanyNIPIndex ON CompanyCustomers(nip)



---


CREATE NONCLUSTERED INDEX UserPhoneIndex on Users(PhoneNumber)
CREATE NONCLUSTERED INDEX UserEmailIndex on Users(email)
CREATE NONCLUSTERED INDEX UserNameIndex on Users(Name)


--

CREATE NONCLUSTERED INDEX CategoryNameIndex on Categories(Name)

--

CREATE NONCLUSTERED INDEX ProductNameIndex on Products(Name)

--

CREATE NONCLUSTERED INDEX MenuDatesIDIndex on Menus(InDate, OutDate)
CREATE NONCLUSTERED INDEX MenuDetailsProductIDIndex on MenuDetails(ProductID)


--

CREATE NONCLUSTERED INDEX DiscountConditionsHistoryIndex on DiscountConditions(InDate, OutDate)
CREATE NONCLUSTERED INDEX DiscountParamsHistoryIndex on DiscountParams(InDate, OutDate)

--

CREATE NONCLUSTERED INDEX CityNameIndex on Cities(Name)


