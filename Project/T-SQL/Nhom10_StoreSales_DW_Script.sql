create database DWStoreSales
use DWStoreSales

/* Create table dbo.DimDate */
CREATE TABLE dbo.DimDate (
   [DateKey]  int   NOT NULL
,  [Year]  int   NULL
,  [Quarter]  int   NULL
,  [Month]  int   NULL
,  [Day]  int   NULL
, CONSTRAINT [PK_dbo.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;

/* Create table dbo.DimCategory */
CREATE TABLE dbo.DimCategory (
   [CategoryKey]  int IDENTITY  NOT NULL
,  [CategoryID]  float   NOT NULL
,  [CategoryName]  nvarchar(255)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_dbo.DimCategory] PRIMARY KEY CLUSTERED 
( [CategoryKey] )
) ON [PRIMARY]
;

/* Create table dbo.DimCustomer */
CREATE TABLE dbo.DimCustomer (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerID]  float   NOT NULL
,  [FullName]  nvarchar(255)   NOT NULL
,  [CustomerCity]  nvarchar(255)   NOT NULL
,  [CustomerCountry]  nvarchar(255)   NOT NULL
,  [CustomerState]  nvarchar(255)   NOT NULL
,  [CustomerStreet]  nvarchar(255)   NOT NULL
,  [CustomerZipcode]  float   NOT NULL
,  [CustomerSegement]  nvarchar(255)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_dbo.DimCustomer] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;

/* Create table dbo.DimDepartment */
CREATE TABLE dbo.DimDepartment (
   [DepartmentKey]  int IDENTITY  NOT NULL
,  [DepartmentID]  float   NOT NULL
,  [DepartmentName]  nvarchar(255)   NOT NULL
,  [Latitude]  float   NOT NULL
,  [Longtitude]  float   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_dbo.DimDepartment] PRIMARY KEY CLUSTERED 
( [DepartmentKey] )
) ON [PRIMARY]
;

/* Create table dbo.DimLocation */
CREATE TABLE dbo.DimLocation (
   [LocationKey]  int IDENTITY  NOT NULL
,  [LocationID]  float   NOT NULL
,  [City]  nvarchar(255)   NOT NULL
,  [State]  nvarchar(255)   NOT NULL
,  [Country]  nvarchar(255)   NOT NULL
,  [Region]  nvarchar(255)   NOT NULL
,  [Market]  nvarchar(255)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_dbo.DimLocation] PRIMARY KEY CLUSTERED 
( [LocationKey] )
) ON [PRIMARY]
;

/* Create table dbo.DimProduct */
CREATE TABLE dbo.DimProduct (
   [ProductKey]  int IDENTITY  NOT NULL
,  [ProductID]  float   NOT NULL
,  [ProductName]  nvarchar(255)   NOT NULL
,  [ProductPrice]  float   NOT NULL
,  [ProductStatus]  float   NOT NULL
,  [CategoryKey]  int   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_dbo.DimProduct] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;

/* Create table dbo.FactSales */
CREATE TABLE dbo.FactSales (
   [ProductKey]  int   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [ShipDateKey]  int   NOT NULL
,  [DepartmentKey]  int   NOT NULL
,  [Price]  float   NOT NULL
,  [Quantity]  float   NOT NULL
,  [ExtendedPriceAmount]  float   NOT NULL
,  [SoldAmount]  float   NOT NULL
,  [DiscountAmount]  float   NOT NULL
,  [OrderProfitPerOrder]  float   NOT NULL
,  [OrderStatus]  nvarchar(255)   NOT NULL
,  [Type]  nvarchar(255)   NOT NULL
,  [OrderID]  float   NOT NULL
, CONSTRAINT [PK_dbo.FactSales] PRIMARY KEY NONCLUSTERED 
( [OrderID] )
) ON [PRIMARY]
;

/* Create table dbo.FactDelivery */
CREATE TABLE dbo.FactDelivery (
   [CustomerKey]  int   NOT NULL
,  [LocationKey]  int   NOT NULL
,  [DepartmentKey]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [ShipDateKey]  int   NOT NULL
,  [OrderID]  float   NOT NULL
,  [CategoryKey]  int   NOT NULL
,  [Scheduled]  float   NOT NULL
,  [Real]  float   NOT NULL
,  [Status]  nvarchar(255)   NOT NULL
,  [Late_delivery_risk]  float   NOT NULL
,  [Mode]  nvarchar(255)   NOT NULL
, CONSTRAINT [PK_dbo.FactDelivery] PRIMARY KEY NONCLUSTERED 
( [OrderID] )
) ON [PRIMARY]
;

ALTER TABLE dbo.DimProduct ADD CONSTRAINT
   FK_dbo_DimProduct_CategoryKey FOREIGN KEY
   (
   CategoryKey
   ) REFERENCES DimCategory
   ( CategoryKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_ShipDateKey FOREIGN KEY
   (
   ShipDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_DepartmentKey FOREIGN KEY
   (
   DepartmentKey
   ) REFERENCES DimDepartment
   ( DepartmentKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactDelivery ADD CONSTRAINT
   FK_dbo_FactDelivery_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactDelivery ADD CONSTRAINT
   FK_dbo_FactDelivery_LocationKey FOREIGN KEY
   (
   LocationKey
   ) REFERENCES DimLocation
   ( LocationKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactDelivery ADD CONSTRAINT
   FK_dbo_FactDelivery_DepartmentKey FOREIGN KEY
   (
   DepartmentKey
   ) REFERENCES DimDepartment
   ( DepartmentKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactDelivery ADD CONSTRAINT
   FK_dbo_FactDelivery_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactDelivery ADD CONSTRAINT
   FK_dbo_FactDelivery_ShipDateKey FOREIGN KEY
   (
   ShipDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactDelivery ADD CONSTRAINT
   FK_dbo_FactDelivery_CategoryKey FOREIGN KEY
   (
   CategoryKey
   ) REFERENCES DimCategory
   ( CategoryKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;


