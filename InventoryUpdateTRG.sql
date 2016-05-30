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

DECLARE @vStockQty SMALLINT;
DECLARE @vCurrentStock SMALLINT;
DECLARE @vErrStr  VARCHAR(80);

BEGIN 
	SELECT @vStockQty = StockQty FROM INSERTED;

	IF @vStockQty < 0
		BEGIN			
			SET @vErrStr = 'Error in InventoryUpdateTRG: This action would set StockQty in ' +
						'INVENTORY table to ' + LTRIM(STR(@vStockQty)) + '. Negative StockQty is invalid.'
			RaisError(@vErrStr,1,1) WITH SetError;
		END;
	-- ENDIF
END;
GO


BEGIN

BEGIN TRANSACTION
 UPDATE INVENTORY
 SET StockQty = 25
 WHERE PartID = 1001;

PRINT 'When valid number entered for StockQty, should succeed:'

 IF @@ERROR <> 0
   BEGIN 
     PRINT 'The first update failed.';
     ROLLBACK TRANSACTION
   END;
 ELSE
   BEGIN 
     PRINT 'The first update succeeded.';
     COMMIT TRANSACTION
   END;
  
PRINT 'When invalid number entered for StockQty, should fail:'
 
 BEGIN TRANSACTION
 UPDATE INVENTORY
 SET StockQty = -1
 WHERE PartID = 1001;
 
 IF @@ERROR <> 0
   BEGIN 
     PRINT 'The second update failed.';
     ROLLBACK TRANSACTION
   END;
 ELSE
   BEGIN 
     PRINT 'The second update succeeded.';
     COMMIT TRANSACTION
   END; 

PRINT 'When valid number 0 entered for StockQty, should succeed:'

 BEGIN TRANSACTION
 UPDATE INVENTORY
 SET StockQty = 0
 WHERE PartID = 1001;
 
 IF @@ERROR <> 0
   BEGIN 
     PRINT 'The third update failed.';
     ROLLBACK TRANSACTION
   END;
 ELSE
   BEGIN 
     PRINT 'The third update succeeded.';
     COMMIT TRANSACTION
   END;　
　
SELECT *
FROM INVENTORY
WHERE PartID = 1001;

END;
GO