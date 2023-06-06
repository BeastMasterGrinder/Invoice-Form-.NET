use master
DROP DATABASE IF Exists [Invoice(freelancing)]
CREATE DATABASE [Invoice(freelancing)]
use [Invoice(freelancing)]


/****** Object:  Table [dbo].[customer]    Script Date: 5/26/2023 8:04:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[customer](
	[ct_code] [nvarchar](15) NOT NULL,
	[ct_name] [nvarchar](60) NOT NULL,
	[addr] [nvarchar](200) NULL,
	[ct_cat] [nvarchar](2) NULL,
	[ct_type] [nvarchar](2) NULL,
	[area] [nvarchar](3) NULL,
	[phone1] [nvarchar](30) NULL,
	[phone2] [nvarchar](30) NULL,
	[con_per] [nvarchar](30) NULL,
	[ntn_no] [nvarchar](30) NULL,
	[gst_no] [nvarchar](30) NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED 
(
	[ct_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

GO

/****** Object:  Table [dbo].[product]    Script Date: 5/26/2023 8:05:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[product](
	[cp_code] [nvarchar](3) NOT NULL,
	[pr_code] [nvarchar](3) NOT NULL,
	[pr_name] [nvarchar](60) NOT NULL,
	[packing] [nvarchar](20) NULL,
	[cost_price] [numeric](20, 4) NULL,
	[trade_price] [numeric](20, 4) NULL,
	[retail_price] [numeric](20, 4) NULL,
	[active] [bit] NULL,
	[crt_size] [numeric](18, 0) NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[pr_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


GO

/****** Object:  Table [dbo].[ord]    Script Date: 5/26/2023 8:05:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
Drop Table ord
CREATE TABLE [dbo].[ord](
	[ord_no] [nvarchar](5) NULL,
	[ct_code] [nvarchar](15) NULL,
	[ord_amt] [nvarchar](15) NULL,
	[time] [char](10) NULL,
	[date] [datetime] NULL,
	[u_id] [nvarchar](15) NULL
) ON [PRIMARY]
GO

GO

/****** Object:  Table [dbo].[ord_deta]    Script Date: 5/26/2023 8:07:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--DROP TABLE ord_deta

CREATE TABLE [dbo].[ord_deta](
	[ord_no] [numeric](5, 0) NULL,
	[pr_code] [nvarchar](3) NULL,
	[qty] [numeric](10, 0) NULL,
	[bonus] [numeric](10, 0) NULL,
	[price] [numeric](15, 2) NULL,
	[per] [numeric](6, 2) NULL,
	[qdis] [numeric](12, 2) NULL,
	[total] [numeric](15, 2) NULL,
	[u_id] [char](3) NULL
) ON [PRIMARY]
GO


select ct_name, addr from dbo.customer
select * from dbo.ord
select * from dbo.ord_deta
select * from dbo.product

--Insertions
INSERT INTO customer (ct_code, ct_name, addr, ct_cat, ct_type, area, phone1, phone2, con_per, ntn_no, gst_no, active)
VALUES
  ('CT001', 'John', '123 Main Street, Cityville', 'CC', 'CT', 'AR1', '1234567890', '9876543210', 'John Smith', 'NTN001', 'GST001', 1),
  ('CT002', 'Sarah', '456 Elm Street, Townsville', 'CC', 'CT', 'AR2', '2345678901', '8765432109', 'Sarah Johnson', 'NTN002', 'GST002', 1),
  ('CT003', 'Michael', '789 Oak Street, Villagetown', 'CC', 'CT', 'AR3', '3456789012', '7654321098', 'Michael Brown', 'NTN003', 'GST003', 1),
  ('CT004', 'Emily', '234 Maple Avenue, Hamletville', 'CC', 'CT', 'AR4', '4567890123', '6543210987', 'Emily Davis', 'NTN004', 'GST004', 1),
  ('CT005', 'David', '567 Pine Street, Boroughville', 'CC', 'CT', 'AR5', '5678901234', '5432109876', 'David Wilson', 'NTN005', 'GST005', 1);

INSERT INTO [dbo].[product] ([cp_code], [pr_code], [pr_name], [packing], [cost_price], [trade_price], [retail_price], [active], [crt_size])
VALUES
('CP1', 'PR1', 'iPhone 12', '64GB', 799.99, 899.99, 999.99, 1, 100),
('CP2', 'PR2', 'Samsung Galaxy S21', '128GB', 899.99, 999.99, 1099.99, 1, 200),
('CP3', 'PR3', 'Sony PlayStation 5', 'Standard Edition', 499.99, 549.99, 599.99, 1, 150),
('CP4', 'PR4', 'Canon EOS R6', 'Body Only', 2499.99, 2699.99, 2899.99, 1, 300),
('CP5', 'PR5', 'Nike Air Max 90', 'Black/White', 119.99, 129.99, 139.99, 1, 250);

SELECT ord_no, ct_code, ord_amt from ord;