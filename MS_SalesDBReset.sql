USE Miles
/*
SalesDBreset - SQL Server 2012
*/

-- --------------------------------------------------
-- Equivalent to drop-salesdb.sql
-- --------------------------------------------------

DROP TABLE ORDERITEMS;  -- child dropped before parents
DROP TABLE ORDERS;
DROP TABLE INVENTORY;
DROP TABLE CUSTOMERS;
DROP TABLE SALESPERSONS;

-- ----------------------------------------------------
-- Equivalent to create-salesdb.sql
-- ----------------------------------------------------

CREATE TABLE CUSTOMERS
 (
  [CustID] [smallint] NOT NULL PRIMARY KEY,
  [Cname] [nvarchar](25) NOT NULL,
  [Credit] [nvarchar](1) NOT NULL
 );

CREATE TABLE SALESPERSONS
 (
	[EmpID] [smallint] NOT NULL PRIMARY KEY,
	[Ename] [nvarchar](15) NOT NULL,
	[Rank] [smallint] NOT NULL,
	[Salary] [money] NOT NULL
 );

CREATE TABLE INVENTORY
 (
  [PartID] [smallint] NOT NULL PRIMARY KEY,
  [Description] [nvarchar](10) NOT NULL,
  [StockQty] [smallint] NOT NULL,
  [ReorderPnt] [smallint] NULL,
  [Price] [money] NOT NULL
 );

CREATE TABLE ORDERS
 (
  [OrderID] [smallint] NOT NULL PRIMARY KEY,
  [EmpID] [smallint] NOT NULL,
  [CustID] [smallint] NOT NULL,
  [SalesDate] [smalldatetime] NOT NULL,
  FOREIGN KEY([CustID]) REFERENCES [CUSTOMERS] ([CustID]),
  FOREIGN KEY([EmpID])  REFERENCES [SALESPERSONS]
);

CREATE TABLE ORDERITEMS
 (
  [OrderID] [smallint] NOT NULL,
  [Detail] [smallint] NOT NULL,
  [PartID] [smallint] NOT NULL,
  [Qty] [smallint] NOT NULL,
  CONSTRAINT ORDERITEMS_ORD_pk PRIMARY KEY([OrderID], [Detail]),
  FOREIGN KEY([PartID]) REFERENCES [INVENTORY],
  FOREIGN KEY([OrderID]) REFERENCES [ORDERS] 
 );
 
 -- ---------------------------------------------------
 -- Equivalent to index-salesdb.sql
 -- ---------------------------------------------------
 
CREATE INDEX CUSTOMERS_cname_idx       ON CUSTOMERS (Cname ASC);
CREATE INDEX SALESPERSONS_ename_idx    ON SALESPERSONS (Ename ASC);
CREATE INDEX ORDERS_salesdate_idx      ON ORDERS (SalesDate ASC);
CREATE INDEX INVENTORY_description_idx ON INVENTORY (Description ASC);

 -- --------------------------------------------------
 -- Equivalent to load-salesdb.sql
 -- --------------------------------------------------
 
INSERT INTO CUSTOMERS 
	SELECT * FROM SalesDB.dbo.CUSTOMERS;
INSERT INTO SALESPERSONS 
	SELECT * FROM SalesDB.dbo.SALESPERSONS;
INSERT INTO ORDERS 
	SELECT * FROM SalesDB.dbo.ORDERS;
INSERT INTO INVENTORY 
	SELECT * FROM SalesDB.dbo.INVENTORY;
INSERT INTO ORDERITEMS 
	SELECT * FROM SalesDB.dbo.ORDERITEMS; 
