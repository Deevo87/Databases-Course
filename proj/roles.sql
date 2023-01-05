CREATE ROLE Admin AUTHORIZATION dbo
GRANT all to Admin

CREATE ROLE Employee AUTHORIZATION dbo
GRANT EXECUTE ON AddNewOrder to Employee
GRANT EXECUTE ON PlaceOrder to Employee
GRANT EXECUTE ON InsertToOrder to Employee
GRANT EXECUTE ON CreateInvoice to Employee
GRANT EXECUTE ON AddNewPrivateCustomer to Employee
GRANT EXECUTE ON AddReservation to Employee
GRANT EXECUTE ON AddReservationDetails to Employee
GRANT EXECUTE ON setOrderPaid to Employee
GRANT EXECUTE ON ConfirmReservation to Employee


CREATE ROLE Manager AUTHORIZATION dbo
GRANT EXECUTE ON AddNewOrder to Employee
GRANT EXECUTE ON PlaceOrder to Employee
GRANT EXECUTE ON InsertToOrder to Employee
GRANT EXECUTE ON CreateInvoice to Employee
GRANT EXECUTE ON AddNewPrivateCustomer to Employee
GRANT EXECUTE ON AddReservation to Employee
GRANT EXECUTE ON AddReservationDetails to Employee
GRANT EXECUTE ON setOrderPaid to Employee
GRANT EXECUTE ON ConfirmReservation to Employee
GRANT EXECUTE ON CreateMenu to Employee
GRANT EXECUTE ON MenuOfTheDay to Employee
GRANT EXECUTE ON AddNewEmployee to Employee
GRANT EXECUTE ON InsertToMenu to Employee
GRANT EXECUTE ON ConfirmReservation to Employee
GRANT EXECUTE ON ConfirmReservation to Employee
