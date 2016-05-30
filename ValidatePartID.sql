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
INVENTORY.PartID validation:
--------------------------------------------------------------------------------
*/
IF EXISTS (SELECT name FROM sys.objects WHERE name = 'ValidatePartID')
    BEGIN DROP PROCEDURE ValidatePartID; END;
GO

CREATE PROCEDURE ValidatePartID
	@vPartID SMALLINT,
	@vPFound CHAR(5) OUTPUT	
AS 
BEGIN
	SET @vPFound = 'FALSE'
	SELECT @vPFound = 'TRUE'
	FROM INVENTORY I
	WHERE I.PartID = @vPartID  
END;
GO

-- testing block for ValidatePartID
BEGIN
	DECLARE @vFoundPart CHAR(5);
	
	EXECUTE ValidatePartID 1001, @vFoundPart OUTPUT;
	PRINT 'When valid PartID 1001 entered will return ' + @vFoundPart;
	
	EXECUTE ValidatePartID 1111, @vFoundPart OUTPUT;
	PRINT 'When invalid PartID 1111 entered will return ' + @vFoundPart;   
END;
GO
