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
	@vOrderID SMALLINT,
	@vNewDetail SMALLINT OUTPUT

AS 
BEGIN
	
	SET @vNewDetail = 0;
	SELECT @vNewDetail = ISNULL((MAX(OI.Detail)+1), 1)
	FROM ORDERITEMS OI
	WHERE OI.OrderID = @vOrderID;
END;
GO

-- testing block for GetNewDetail
BEGIN
	DECLARE @vDetailNew SMALLINT;
	
	EXECUTE GetNewDetail 6099, @vDetailNew OUTPUT;
	PRINT 'When valid OrderID 6099 entered, will return max detail + 1 which is ' + CONVERT(VARCHAR(5), @vDetailNew);

END;
GO