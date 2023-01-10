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
GRANT EXECUTE ON CancelOrder to Manager
GRANT EXECUTE ON CancelReservation to Manager
GRANT EXECUTE ON ChangeUser to Manager
GRANT EXECUTE ON ChangeCompanyCustomer to Manager



CREATE ROLE PrivateCustomer AUTHORIZATION dbo
Grant EXECUTE On PlaceOrder to PrivateCustomer
Grant EXECUTE ON CancelOrder to PrivateCustomer
GRANT EXECUTE ON ShowFreeTablesAt to PrivateCustomer
GRANT EXECUTE ON AddReservation to PrivateCustomer
Grant EXECUTE On CancelReservation to PrivateCustomer
Grant EXECUTE ON GetTotalOrderAmount to PrivateCustomer
GRANT SELECT ON CurrentMenu to PrivateCustomer



CREATE Role CompanyCustomer AUTHORIZATION dbo
GRANT EXECUTE ON AddReservation to CompanyCustomer
Grant EXECUTE ON AddReservationDetails to CompanyCustomer
GRANT EXECUTE ON ShowFreeTablesAt to CompanyCustomer
Grant EXECUTE ON CancelReservation to CompanyCustomer
GRANT SELECT ON CurrentMenu to CompanyCustomer
