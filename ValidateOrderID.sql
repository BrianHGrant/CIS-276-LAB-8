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


IF EXISTS (SELECT name FROM sys.objects WHERE name = 'ValidateOrderID')
    BEGIN DROP PROCEDURE ValidateOrderID; END;
GO

CREATE PROCEDURE ValidateOrderID -- with custid and orderid input
	@vCustID SMALLINT,
	@vOrderID SMALLINT,
	@vOFound CHAR(5) OUTPUT,
	@vMatchFound CHAR(5) OUTPUT
AS
 
BEGIN
	
	SET @vOFound = 'FALSE';		-- initialize test variables
	SET @vMatchFound = 'FALSE';
	
	SELECT @vOFound = 'TRUE' -- test if OrderID found in ORDERS table 
	FROM ORDERS O
	WHERE O.OrderID = @vOrderID

	IF (@vOFound = 'TRUE')		-- if OrderId is found
		BEGIN
			SELECT @vMatchFound = 'TRUE'	-- test for match of OrderID and CustId in ORDERS table
			FROM ORDERS O
			WHERE O.CustID = @vCustID 
				AND	O.OrderID = @vOrderID;
		END;
	--ENDIF
END;
GO

-- testing block for ValidateOrderID
BEGIN   
	DECLARE @vFoundOrder CHAR(5);
	DECLARE @vMatchedOrder CHAR(5);

	EXECUTE ValidateOrderID 1, 6099, @vFoundOrder OUTPUT, @vMatchedOrder OUTPUT;
	PRINT 'ValidateCustID test with valid OrderID 6099 and matching CustID 1 returns ' + @vFoundOrder + ' and ' + @vMatchedOrder;
	-- When OrderID is valid and matches CustID.

	EXECUTE ValidateOrderID 1, 7500, @vFoundOrder OUTPUT, @vMatchedOrder OUTPUT;
	PRINT 'ValidateCustID test invalid OrderID 7500 returns ' + @vFoundOrder + ' and ' + @vMatchedOrder;
	-- When OrderID is invalid and matches CustID.

	EXECUTE ValidateOrderID 1, 6107, @vFoundOrder OUTPUT, @vMatchedOrder OUTPUT;
	PRINT 'ValidateCustID test with valid OrderID 6107 and non-matching CustID 1 returns ' + @vFoundOrder + ' and ' + @vMatchedOrder;
	-- When OrderID is valid and matches CustID.
	 

END;
GO