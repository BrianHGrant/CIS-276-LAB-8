/*
********************************************************************************
CIS276 @PCC using SQL Server 2012
Lab 8 
2016-05-59
	Brian Grant - Student
	Added Query Answers
********************************************************************************
*/

USE s276BGrand

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