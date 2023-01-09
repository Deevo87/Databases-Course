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
GRANT EXECUTE ON GetTotalOrderAmount to Employee
GRANT EXECUTE ON MenuOfTheDay to Employee



CREATE ROLE Manager AUTHORIZATION dbo
GRANT EXECUTE ON AddNewOrder to Manager
GRANT EXECUTE ON PlaceOrder to Manager
GRANT EXECUTE ON InsertToOrder to Manager
GRANT EXECUTE ON CreateInvoice to Manager
GRANT EXECUTE ON AddNewPrivateCustomer to Manager
GRANT EXECUTE ON AddReservation to Manager
GRANT EXECUTE ON AddReservationDetails to Manager
GRANT EXECUTE ON setOrderPaid to Manager
GRANT EXECUTE ON ConfirmReservation to Manager
GRANT EXECUTE ON CreateMenu to Manager
GRANT EXECUTE ON MenuOfTheDay to Manager
GRANT EXECUTE ON AddNewEmployee to Manager
GRANT EXECUTE ON InsertToMenu to Manager
GRANT EXECUTE ON ConfirmReservation to Manager
GRANT EXECUTE ON ConfirmReservation to Manager
GRANT EXECUTE ON CancelOrder to Manager
GRANT EXECUTE ON CancelReservation to Manager
GRANT EXECUTE ON ChangeUser to Manager
GRANT EXECUTE ON ChangeCompanyCustomer to Manager


--- dodać role Private Customer i Company Customer