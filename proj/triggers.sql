CREATE TRIGGER CheckOverlappingMenus
    ON Menus
    FOR INSERT AS
BEGIN
    DECLARE @inDate SMALLDATETIME
    SET @inDate = (SELECT inDate FROM inserted)

    DECLARE @outDate SMALLDATETIME
    SET @outDate = (SELECT outDate FROM inserted)

    IF (EXISTS(SELECT *
        FROM Menus
        WHERE (@inDate < inDate AND inDate < @outDate AND @outDate < outDate)
        OR (inDate < @inDate AND @inDate < outDate AND outDate < @outDate)
        OR (inDate < @inDate AND @inDate < @outDate AND @outDate < outDate)
        OR (@inDate < inDate AND inDate < outDate AND outDate < @outDate)))
    BEGIN
        RAISERROR ('Menus are overlapping.', -1, -1)
        ROLLBACK TRANSACTION
    END
END

CREATE TRIGGER DishesWithSeafood
    ON OrderDetails
FOR INSERT, UPDATE
AS
BEGIN
    IF ((SELECT C.Name FROM Products AS P
        INNER JOIN Categories AS C ON P.CategoryID = C.categoryId
        WHERE P.ProductID = (SELECT ProductID FROM INSERTED)) = 'Seafood')
        BEGIN
            DECLARE @receiveDate AS smalldatetime
            SET @receiveDate = (SELECT O.receiveDate FROM Orders AS O WHERE O.orderId = (SELECT orderId FROM INSERTED))
        IF (DATENAME(WEEKDAY, @receiveDate) NOT IN ('Thursday','Friday','Saturday'))
            BEGIN
            RAISERROR ('Cannot order Seafood on that day of the week', -1, -1)
            ROLLBACK TRANSACTION
            RETURN
        END
        DECLARE @orderDate AS smalldatetime
        SET @orderDate = (SELECT O.orderDate FROM Orders AS O WHERE O.orderId = (SELECT orderId FROM INSERTED))

        IF (DATENAME(WEEKDAY, @receiveDate) = 'Thursday')
            BEGIN
                IF (@orderDate > DATEADD(DAY, -3, @receiveDate))
                BEGIN
                RAISERROR ('When ordering Seafood, must order before Monday of that week', -1, -1)
                ROLLBACK TRANSACTION
                RETURN
            END
        END
        IF (DATENAME(WEEKDAY, @receiveDate) = 'Friday')
        BEGIN
        IF (@orderDate > DATEADD(DAY, -4, @receiveDate))
            BEGIN
                RAISERROR ('When ordering Seafood, must order before Monday of that week', -1, -1)
                ROLLBACK TRANSACTION
            RETURN
        END
        END
    IF (DATENAME(WEEKDAY, @receiveDate) = 'Saturday')
        BEGIN
        IF (@orderDate > DATEADD(DAY, -5, @receiveDate))
            BEGIN
            RAISERROR ('When ordering Seafood, must order before Monday of that week', -1, -1)
            ROLLBACK TRANSACTION
        RETURN
    END
END
END
END


CREATE TRIGGER OnlyOneFactors
ON GlobalVars
FOR INSERT
AS
    BEGIN
        IF ((SELECT COUNT(*) FROM GlobalVars) > 1)
            BEGIN
            RAISERROR ('Too much globalVars', -1, -1)
            ROLLBACK TRANSACTION
        END
END

CREATE TRIGGER UnconfirmedReservation
ON Reservations
FOR DELETE
AS
    BEGIN
        DECLARE @ReservationID INT
        SET @ReservationID = (SELECT ReservationID FROM deleted)

        DECLARE @ReservationDate SMALLDATETIME
        SET @ReservationDate = (SELECT ReservationDate from Reservations)

        IF ((SELECT Confirmed from Reservations) = 0 AND @ReservationDate < GETDATE())
            BEGIN
                DELETE from Reservations where ReservationID = @ReservationID
            END
        ELSE
            BEGIN
               RAISERROR('Time to confirm reservation did not expire.', -1, -1)
            END
    END

CREATE TRIGGER ChangedIsActive
ON MenuDetails
FOR INSERT
AS
    BEGIN
        DECLARE @ProductID INT
        SET @ProductID = (SELECT ProductID from inserted)

        IF EXISTS(SELECT ProductID from Products as P where P.ProductID = @ProductID)
            BEGIN
               UPDATE Products
               SET IsActive = 0
               WHERE ProductID = @ProductID
            END
        ELSE
            BEGIN
                RAISERROR ('Product does not exist', -1, -1)
            END
    END