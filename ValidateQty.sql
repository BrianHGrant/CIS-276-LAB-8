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
Input quantity validation:
--------------------------------------------------------------------------------
*/
IF EXISTS (SELECT name FROM sys.objects WHERE name = 'ValidateQty')
    BEGIN DROP PROCEDURE ValidateQty; END;
GO

CREATE PROCEDURE ValidateQty 
	@vQty SMALLINT,
	@vValidQty CHAR(5) OUTPUT
AS 
BEGIN 
	SET @vValidQty = 'FALSE'
	IF (@vQty > 0)
		BEGIN
			SET @vValidQty = 'True'
		END;
	--ENDIF 
END;
GO

-- testing block for ValidateQty
BEGIN 
   DECLARE @vQtyIsValid CHAR(5);

   EXECUTE ValidateQty 5, @vQtyIsValid OUTPUT;
   PRINT 'When valid Qty 5 is entered for Order Qty will return ' + @vQtyIsValid;

   EXECUTE ValidateQty 0, @vQtyIsValid OUTPUT;
   PRINT 'When invalid Qty 0 is entered for Order Qty will return ' + @vQtyIsValid;

   EXECUTE ValidateQty 0, @vQtyIsValid OUTPUT;
   PRINT 'When invalid Qty -9 is entered for Order Qty will return ' + @vQtyIsValid;

END;
GO