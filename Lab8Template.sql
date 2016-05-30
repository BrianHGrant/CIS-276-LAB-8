/*
********************************************************************************
CIS276 @PCC using SQL Server 2012
THIS IS A TEMPLATE
2015.03.02 Alan Miles, Instructor
********************************************************************************
*/
USE Miles  -- instructor database account area, please use the appropriate one

/*
--------------------------------------------------------------------------------
CUSTOMERS.CustID validation
Coded in full for a free-five points . . .
--------------------------------------------------------------------------------
*/

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'ValidateCustID')
    BEGIN 
        DROP PROCEDURE ValidateCustID; 
    END;    -- must use block for more than one statement
-- END IF;  SQL Server does not use END IF 
GO

-- Notice my found variable contains the customer name
-- YOU can/should do something else to indicate a row exists to validate CustID

CREATE PROCEDURE ValidateCustID 
    @vCustid SMALLINT,
    @vFound  CHAR(25) OUTPUT 
AS 
BEGIN 
    SET @vFound = 'blank';  -- initializes my found variable
    SELECT @vFound = Cname 
    FROM CUSTOMERS
    WHERE CustID = @vCustid;
END;
GO

-- testing block for ValidateCustID
BEGIN
    
    DECLARE @vCname CHAR(25);  -- holds value returned from procedure

    EXECUTE ValidateCustID 1, @vCname OUTPUT;
    PRINT 'ValidateCustID test with valid CustID 1 returns ' + @vCname;
	-- When @vCname contains a customer name the custid is validated

    EXECUTE ValidateCustID 5, @vCname OUTPUT;
    PRINT 'ValidateCustID test w/invalid CustID 5 returns ' + @vCname;
	-- When @vCname contains 'blank' the custid is not in the CUSTOMERS table

END;
GO

/*
--------------------------------------------------------------------------------
ORDERS.OrderID validation:
--------------------------------------------------------------------------------
*/

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'ValidateOrderID')
    BEGIN DROP PROCEDURE ValidateOrderID; END;
GO

CREATE PROCEDURE ValidateOrderID -- with custid and orderid input
AS 
BEGIN 
-- OrderID found in ORDERS table . . .
    -- CustID/OrderID matching allows further processing 
    -- CustID/OrderID pairing is invalid.
-- OrderID not found in ORDERS table is invalid.
END;
GO

-- testing block for ValidateOrderID
BEGIN    

END;
GO

/*
--------------------------------------------------------------------------------
INVENTORY.PartID validation:
--------------------------------------------------------------------------------
*/
IF EXISTS (SELECT name FROM sys.objects WHERE name = 'ValidatePartID')
    BEGIN DROP PROCEDURE ValidatePartID; END;
GO

CREATE PROCEDURE ValidatePartID 
AS 
BEGIN 
END;
GO

-- testing block for ValidatePartID
BEGIN    
END;
GO

/*
--------------------------------------------------------------------------------
Input quantity validation:
--------------------------------------------------------------------------------
*/
IF EXISTS (SELECT name FROM sys.objects WHERE name = 'ValidateQty')
    BEGIN DROP PROCEDURE ValidateQty; END;
GO

CREATE PROCEDURE ValidateQty 
AS 
BEGIN 
-- No query required; test for positive value
END;
GO

-- testing block for ValidateQty
BEGIN    
END;
GO

/*
--------------------------------------------------------------------------------
ORDERITEMS.Detail determines new value:
You can handle NULL within the projection but it can be done in two steps
(SELECT and then test).  It is important to deal with the possibility of NULL
because the detail is part of the primary key and therefore cannot contain NULL.
--------------------------------------------------------------------------------
*/
IF EXISTS (SELECT name FROM sys.objects WHERE name = 'GetNewDetail')
    BEGIN DROP PROCEDURE GetNewDetail; END;
GO

CREATE PROCEDURE GetNewDetail 
AS 
BEGIN 
-- Use @vOrderid (input) to get @vNewDetail (output) via a query;
END;
GO

-- testing block for GetNewDetail
BEGIN    
END;
GO

/*
--------------------------------------------------------------------------------
INVENTORY trigger for an UPDATE:
--------------------------------------------------------------------------------
*/
IF EXISTS (SELECT name FROM sys.objects WHERE name = 'InventoryUpdateTRG')
    BEGIN DROP TRIGGER InventoryUpdateTRG; END;
GO

CREATE TRIGGER InventoryUpdateTRG
ON INVENTORY
FOR UPDATE
AS
BEGIN 
-- compare (SELECT Stockqty FROM INSERTED) to zero
-- your error handling
END;
GO

-- testing blocks for InventoryUpdateTRG
-- There should be at least three testing blocks here
BEGIN
END;
GO

/*
--------------------------------------------------------------------------------
ORDERITEMS trigger for an INSERT:
--------------------------------------------------------------------------------
*/

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'OrderitemsInsertTRG')
    BEGIN DROP TRIGGER OrderitemsInsertTRG; END;
GO

CREATE TRIGGER OrderitemsInsertTRG
ON ORDERITEMS
FOR INSERT
AS
BEGIN 
    -- get new values for qty and partid from the INSERTED table
    -- get current (changed) StockQty for this PartID
    -- UPDATE with current (changed) StockQty 
    -- your error handling
END
GO

-- testing blocks for OrderItemsInsertTrg
-- There should be at least three testing blocks here
BEGIN
END;
GO

/* 
--------------------------------------------------------------------------------
The TRANSACTION, this procedure calls GetNewDetail and performs an INSERT
to the ORDERITEMS table which in turn performs an UPDATE to the INVENTORY table.
Error handling determines COMMIT/ROLLBACK.
--------------------------------------------------------------------------------
*/

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'AddLineItem')
    BEGIN DROP PROCEDURE AddLineItem; END;
GO

CREATE PROCEDURE AddLineItem [with OrderID, PartID and Qty input parameters]
AS
BEGIN
BEGIN TRANSACTION    -- this is the only BEGIN TRANSACTION for the lab assignment
    EXECUTE GetNewDetail inputorderid, outputdetail OUTPUT;
    INSERT 
    -- your error handling
-- END TRANSACTION;
END;
GO

-- No AddLineItem tests, saved for main block testing
-- well, you could EXECUTE AddLineItem 6099,1001,50
GO

/* 
--------------------------------------------------------------------------------
Puts all of the previous together to produce a solution for Lab8 done in
SQL Server. This stored procedure accepts the 4 pieces of input: 
Custid, Orderid, Partid, and Qty (in that order please). It validates all the 
data and does the transaction processing by calling the previously written and 
tested modules.
--------------------------------------------------------------------------------
*/
IF EXISTS (SELECT name FROM sys.objects WHERE name = 'Lab8proc')
    BEGIN DROP PROCEDURE Lab8proc; END;
GO

CREATE PROCEDURE Lab8proc (with the four values input)
AS

BEGIN
    -- EXECUTE ValidateCustId
	-- EXECUTE ValidateOrderid
    -- EXECUTE ValidatePartId
    -- EXECUTE ValidateQty
	-- IF everything validates THEN we can do the TRANSACTION
        -- EXECUTE AddLineItem
    -- ELSE send a message?
    -- ENDIF;
END;
GO 

/*
--------------------------------------------------------------------------------
-- Your testing blocks for Lab8proc goes last
--------------------------------------------------------------------------------
*/

DECLARE
BEGIN
    -- EXECUTE
END;
