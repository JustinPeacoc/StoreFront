/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.5026)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Products]') AND type in (N'U'))
ALTER TABLE [dbo].[Products] DROP CONSTRAINT IF EXISTS [FK_Products_StockStatus]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Products]') AND type in (N'U'))
ALTER TABLE [dbo].[Products] DROP CONSTRAINT IF EXISTS [FK_Products_Category]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employee]') AND type in (N'U'))
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT IF EXISTS [FK_Employee_Employee]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employee]') AND type in (N'U'))
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT IF EXISTS [FK_Employee_Department]
GO
/****** Object:  Table [dbo].[StockStatus]    Script Date: 2022/04/17 9:57:54 PM ******/
DROP TABLE IF EXISTS [dbo].[StockStatus]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2022/04/17 9:57:54 PM ******/
DROP TABLE IF EXISTS [dbo].[Products]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 2022/04/17 9:57:54 PM ******/
DROP TABLE IF EXISTS [dbo].[Employee]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 2022/04/17 9:57:54 PM ******/
DROP TABLE IF EXISTS [dbo].[Department]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 2022/04/17 9:57:54 PM ******/
DROP TABLE IF EXISTS [dbo].[Category]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2022/04/17 9:57:54 PM ******/
DROP TABLE IF EXISTS [dbo].[__MigrationHistory]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2022/04/17 9:57:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[__MigrationHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Category]    Script Date: 2022/04/17 9:57:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] NOT NULL,
	[CategoryName] [nchar](20) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Department]    Script Date: 2022/04/17 9:57:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Department]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] NOT NULL,
	[DepartmentName] [nchar](20) NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 2022/04/17 9:57:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] NOT NULL,
	[EmployeeFName] [nchar](20) NOT NULL,
	[EmployeeLName] [nchar](20) NOT NULL,
	[DateOfHire] [date] NOT NULL,
	[ExitDate] [date] NULL,
	[DepartmentID] [int] NOT NULL,
	[DirectReportID] [int] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2022/04/17 9:57:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Products]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Price] [money] NULL,
	[Description] [nvarchar](max) NULL,
	[StockStatusID] [int] NOT NULL,
	[ProductImage] [varchar](100) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[StockStatus]    Script Date: 2022/04/17 9:57:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StockStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[StockStatus](
	[StockStatusID] [int] IDENTITY(1,1) NOT NULL,
	[InStock] [varchar](20) NULL,
 CONSTRAINT [PK_StockStatus] PRIMARY KEY CLUSTERED 
(
	[StockStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202203150342125_InitialCreate', N'StoreFront.UI.MVC.Models.ApplicationDbContext', 0x1F8B0800000000000400DD5CDB6EE336107D2FD07F10F4D416592B97EE621BD82D52276983E68675B2E8DB82966847588952252A9BA0E897F5A19FD45FE850A26EBCE8622BB6531428D6E2F0CC7038430E87C3FCFBF73FE39F9E7CCF78C451EC0664621E8CF64D03133B705CB29C98095DBC796FFEF4E3D75F8DCF1CFFC9F898D31D313AE849E289F94069786C59B1FD807D148F7CD78E823858D0911DF8167202EB707FFF07EBE0C0C200610296618C3F2484BA3E4E7FC0CF69406C1CD20479578183BD987F8796598A6A5C231FC721B2F1C49CD120C2E75140E8E8FE6274F5713ACAFA98C689E722906786BD85692042028A28487B7C1FE319850ECB59081F9077F71C62A05B202FC67C14C72579D701ED1FB2015965C71CCA4E621AF83D010F8EB8862CB1FB4A7A360B0D820ECF40D7F4998D3AD5E3C4BC7070FAE943E081024486C7532F62C413F3AA60711287D7988EF28EA30CF23C02B82F41F4795445DC333AF7DB2B2CEA70B4CFFEDB33A6894793084F084E6884BC3DE336997BAEFD1B7EBE0B3E6332393A982F8EDEBF7D879CA377DFE3A3B7D591C25881AEF6013EDD46418823900D2F8AF19B8655EF67891D8B6E953E9956C096C0394CE30A3D5D62B2A40FE03687EF4DE3DC7DC24EFE851BD73D71C197A0138D12F8799D781E9A7BB868B71A79B2FF37703D7CFB6E10AED7E8D15DA6532FF007C789C0AF3E602F6D8D1FDC3073AFDA7C7FE264E0933EFB5DB7AFACF5D32C48229B0D26D092DCA16889695DBAB1551A6F27936650C39B758EBAFBA6CD2495CD5B49CA06B48A27E42C36ED0DB9BC2FCBB7B3C59D84214C5E6A5A4C234D06A7DBB24602C69E2151966674D0D58C080CEFFFBC2A9EF9C8F50658163B7081B864E1463E2E46F973004688486F996F511CC3AAE0FC8AE28706D1E19F03883EC3761281B1CE28F2C317E776FB10107C9DF873E6039BE335D8D4DC7D09CE910D7E774658AFB5F12E03FB7390D033E29C228AEFA99D03B29F77AEDF1D6010714E6C1BC7F139183376A60184DD39E005A14787BDE1D832B5EDB064EA21D757C725C282FA29272D63133585149F68C854314A93A897C1D225DD44CD49F5A26614ADA272B2BEA232B06E92724ABDA02941AB9C19D560515F3A43C3877D29ECEEC77DEB6DDEBAB5A0A2C63432F905131CC132E6DC224A7144CA19E8B26E6C235848A78F317DF1BD29E5F41179C9D0AC56F286741118DE1B52D8DDF786544CF8FCE83A2C2AE97018CA8901BE13BDFA9CD5EE7382649B7687DA3037CD7C336B80CE5D4EE238B0DDD40B1469309EC4A8CB0F319CD19ED1C846236645606060E82EDBF2E00B8CCD148DEA869C620F536C9CD8599A708A621B39B21A61404E0FC1F21D552158991DA90BF79DC4132C1D47AC136287A0183CD52554760B97D86E88BC562D093D3B6E616CEC050FB1E51487983086AD9AE8C25C9D0C6102147C844969D3D0D8AA585CB3216AA256DD9CB785B0E5BC4B398A8DD8644BECACB14B1EBFBD8861366B6C03C6D9AC922E0268137BDB30507E56E96A00E2C165D70C543831690C9487541B31D0BAC6B660A07595BC3A03CD8EA85DE75F38AFEE9A79D60FCA9BDFD61BD5B505DBACE963C74C338B3DA10F851E3892CDF374CE1AF113551CCE404E7E3E8B79A82B9A08039F615A4FD994F1AE320EB59A4144236A022C0DAD05945F094A409243F5102ECFE5354AC7A3881EB079DEAD1196AFFD026CC50664ECEAD56885507F812A1A67A7D34731B2C21A2423EF7458A8E0280C425CBCEA03EFA0145D5E56564C9758B84F345C19189F8C0605B544AE1A25E583195C4BB969B66B491590F509C9D6D292103E69B4940F66702D711B6D57922228E81116ACA5A2FA163E90B3E5998E62B729DAC6565637C53F8C2D4D81D5F80A85A14B9695822BFEC59865D556D337B3FE05487E8661D9B1A20EA990B6E04483082DB1D00AAC41D273378AE929A2688E589E67EAF81299726FD52CFF39CBEAF6294F62BE0FE4D4ECDFFC665577915FDB71E59084239DC3387D16D7A4380A2B50773758191CF250A4C8DF4F032FF1893ECCD2F7CE6EF1AAFDB32F32C2D812E497C228496752B05B9F804ED323BBC6A05355C432AB4F971E42A7F43C12ADAA5D179DEA51F26455154597C0DADAF4E9829A15A64C8C1AFBCF582BC2CBF8182F55A902F04F3D312AD50E1258A5AD3B6ABD20A58A596FE98E28549D542185A61E52566B4B6A42561B56C2D368544DD19D835C4D5245975BBB232BEA4AAAD08AE615B015328B6DDD5115A5275560457377ECB20E455C4A777817D39E65D6DCC6B243EF7AFB9806E365D6C561B6C1CADD7E15A8F2B92716BFBD97C0F8F79DB429EDC96F4D9BCA321EEBD9940643BF0AD5EEC6EB8B50E385BE1EB376E15D5BE89B2EFCF578FD2CF745ED433AFE892405F7E218281CF7C6FCE8D5FEE8463A8B6524A691AB11ACEA39A6D81F3182D1EC0F6FEAB9982DE939C11522EE02C7342BF2300FF70F0E85173BBBF37AC68A63C7531C5D754F68EA73B6817A2DF28822FB014572F5C41A2F4C4A5029317D411CFC3431FF4C7B1DA7390EF6AFF4F39E7111DF13F78F041AEEA2041B7FC9D5A0C354DC371FBB76F47D4477AD5EFCFE29EBBA67DC44E031C7C6BEA0CB5566B8FE6AA2973459D735A459F92DC5EB75A8DAE30425AAE010ABBF4598BB74907708B994DFF8E8E9DBBEA229DF1AAC85A8784F3014DE202AD4BD1758054BFB56C0819F347D2BD06FB0EAB703AB88A67D37E092FE60E2AB81EECB50DE738B5B8DE264B4892529D5736BD5F55A2598DBDE9BA4E2ECB51C5D2EC0EE01B74691F50A96F1CAEA9307DB1D15E5C783616FD3B45FBCE67857CA8CCB0290ED56176FB2A0B8E1A2E87F5547BC03956F8A4A9EED570B6FDAD674D9DC1D2FB9EC5713BC63C6C6EBBBB65FF9BB6963D3A57977DCD87AD5F7EE98AD6D6BFFDCB2A575DE42B75EAD2B171E696E6554B9E0B66ADC2C710E27FC790046904594D9234A75F95753E96A0BC39244CF545F772632961C47E22B5134B3ED3756BEE1370E96D334B3D5546B36F1E6EB7F236F4ED3CC5B5303B98D3A626515A2AAB6BB651D6B2A8B7A4D75C3B591B494A9B7C5AC8D57ECAFA94C7810A5D4BC477347FC7AAA820751C990AED3A30A58BEEE85BDB3F2971861FF8EDD6509C1FE2E23C1766DD72C682EC822C8376F41A29C44C8D05C618A1CD8524F22EA2E904DA199E598D357E069DE8EDD74CCB173416E121A2614868CFDB9574B78B120A0897F5AEA5C97797C13A67FD064882180982ECBCDDF909F13D7730AB9CF1539210D048B2E784697CD256599DDE57381741D908E405C7D45507487FDD003B0F886CCD0235E453630BF4BBC44F6739901D481B44F445DEDE353172D23E4C71CA3EC0F3FC1861DFFE9C7FF00F0438F8C90540000, N'6.1.0-30225')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (0, N'Jedi                ')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (2, N'Food                ')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (3, N'Ships               ')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (4, N'Clothing            ')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (5, N'Droids              ')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (6, N'Weapons             ')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (7, N'Miscellaneous       ')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (8, N'SW - Miscellaneous  ')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (9, N'SW - Clothing       ')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (10, N'SW - Accessories    ')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (11, N'SW - Appliances     ')
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName]) VALUES (0, N'Security            ')
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName]) VALUES (1, N'Development         ')
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName]) VALUES (2, N'Sales               ')
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName]) VALUES (3, N'Scavenging          ')
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName]) VALUES (4, N'Leads               ')
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName]) VALUES (5, N'Human Resources     ')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeFName], [EmployeeLName], [DateOfHire], [ExitDate], [DepartmentID], [DirectReportID]) VALUES (0, N'Monica              ', N'Richowski           ', CAST(N'2012-12-12' AS Date), NULL, 4, NULL)
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeFName], [EmployeeLName], [DateOfHire], [ExitDate], [DepartmentID], [DirectReportID]) VALUES (1, N'Grant               ', N'Plum                ', CAST(N'2001-01-12' AS Date), NULL, 4, 0)
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeFName], [EmployeeLName], [DateOfHire], [ExitDate], [DepartmentID], [DirectReportID]) VALUES (2, N'Stephanie           ', N'Mitchell            ', CAST(N'2001-05-13' AS Date), NULL, 4, 0)
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeFName], [EmployeeLName], [DateOfHire], [ExitDate], [DepartmentID], [DirectReportID]) VALUES (3, N'Juan                ', N'Reed                ', CAST(N'2002-03-13' AS Date), NULL, 2, 1)
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeFName], [EmployeeLName], [DateOfHire], [ExitDate], [DepartmentID], [DirectReportID]) VALUES (4, N'Armaud              ', N'Bloom               ', CAST(N'2004-05-14' AS Date), CAST(N'2005-01-22' AS Date), 2, 3)
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeFName], [EmployeeLName], [DateOfHire], [ExitDate], [DepartmentID], [DirectReportID]) VALUES (5, N'Genevieve           ', N'Robinson            ', CAST(N'2004-05-14' AS Date), CAST(N'2005-01-22' AS Date), 2, 1)
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeFName], [EmployeeLName], [DateOfHire], [ExitDate], [DepartmentID], [DirectReportID]) VALUES (6, N'Claudia             ', N'Tyler               ', CAST(N'2001-05-13' AS Date), NULL, 5, 2)
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeFName], [EmployeeLName], [DateOfHire], [ExitDate], [DepartmentID], [DirectReportID]) VALUES (7, N'Takumo              ', N'Yao                 ', CAST(N'2002-03-13' AS Date), CAST(N'2005-01-22' AS Date), 5, 2)
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeFName], [EmployeeLName], [DateOfHire], [ExitDate], [DepartmentID], [DirectReportID]) VALUES (8, N'Mark                ', N'Schmidt             ', CAST(N'2004-05-14' AS Date), CAST(N'2004-11-20' AS Date), 0, 0)
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (0, N'AT-AT Walker', 8, 40.0000, N'Style your walker with this custom-built AT-AT leg extensions. Fits all sizes of walkers. Yes even that one. ', 3, N'2faedfd6-b346-4d69-a50e-41b24ee361a0.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (1, N'Bantha Hide Jacket', 4, 75.0000, N'This jacket made from the hide of a bantha straight from Tattooine will surely have you looking the very best in the Outer Rim.', 3, N'7c23977a-0bcb-4782-81f5-a2a6407cb576.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (2, N'Bantha Hide Utility Belt', 4, 40.0000, N'This utility belt made out of bantha hide is strong enough to hold the toughest of things.', 4, N'2ceabb17-4ee7-4bbf-ac2b-f54cb768dbc8.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (3, N'Bantha Milk', 2, 7.5000, N'Bantha milk from an in-store bantha. Fresh daily.', 4, N'04e7a4a7-d907-4024-ada6-d6bed9c1593f.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (4, N'Battle Droid', 5, 500.0000, N'This battle droid from the age of the Clone Wars is perfect for your security needs. ', 4, N'd0abbddc-ad54-428a-bae7-aa0117d1dfb6.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (5, N'Beskar Ingot (x5)', 7, 25000.0000, N'5 solid beskar ingots. Great for armor. Deflects 100% of all blaster shots and even can compete with lightsabers.', 3, N'399b28f9-71e3-4bec-9e2e-aa0852aa88f5.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (6, N'Beskar Spear', 6, 750.0000, N'A spear forged from beskar. This spear can also combat lightsabers and deflect blaster bullets.', 4, N'f52dcf02-22df-4434-869e-8619df0f12c4.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (7, N'Binder Cuffs', 7, 12.5000, N'Binder cuffs to make sure your prisoner stays where they need to stay.', 3, N'4c3827e3-cc03-4b57-b1ea-ea1ea0d30e52.png')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (8, N'Blue Kyber Crystal', 0, 111.0000, NULL, 3, N'40a2ec6f-9393-4a92-bd5e-5356d7eaee27.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (9, N'Chewbacca Mask', 10, 20.0000, N'You''ve seen the Chewbacca mask mom video. I''ve seen the Chewbacca mask mom video. That can be you.', 3, N'd42cd632-3723-4009-89d3-7527e8511e1c.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (10, N'Commando Droid', 5, 1100.0000, N'A commando droid from the Clone Wars. High ranking officers among the droid army, these droids are programmed to be the best security.', 3, N'545956f6-994e-4561-a7d4-f23d0753fabe.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (11, N'Commuter Shuttle', 3, 100000.0000, N'Don''t ask how we got this.', 3, N'799d78ea-5da9-4adb-b102-5f4c867e6f7b.png')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (12, N'Darth Vader Mug', 11, 30.0000, N'Do you like your coffee "on the dark side"? *I''ll leave now*', 3, N'909f45c5-b3f1-4771-a1bf-5bc0d1aa9f88.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (13, N'Darth Vader Watch', 0, 35.0000, N'Do you like your time "on the dark side"? *sorry', 3, N'd9d896f5-1289-48f5-9089-d087f967f2d3.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (14, N'Energy Cell', 6, 75.0000, N'Its just an energy cell.', 3, N'c9e9b036-58b3-4a9e-be57-0f2007246fff.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (15, N'Fusion Cutters', 7, 45.0000, N'Fusion cutters are good for cutting metal and good for welding. This is a fantastic gift for ship mechanics.', 3, N'970f1d5b-4c19-45a8-b0d0-f016b495006a.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (16, N'Gonk Droid', 5, 0.0000, N'It doesn''t do anything. You can have it.', 3, N'534ce3d6-f652-430a-ace4-f5ed63d8cac7.png')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (17, N'Green Kyber Crystal', 0, 111.0000, N'Those dumb Jedi got one thing right. These kyber crystals have some strong energy to them.', 3, N'ea32bc05-e9da-4ec7-9b05-43685ce8aa86.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (18, N'Han Solo Mug', 11, 20.0000, N'Now YOU can shoot first after a cup of coffee from this mug!', 3, N'aa1591f7-1d40-4a5f-9edd-bfc3422737ee.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (19, N'Holocron', 0, 5000000.0000, N'I don''t know what a holocron is but I picked it up from a Jedi years ago.', 3, N'6c814e37-2209-49a7-b3d9-3423d484ea65.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (20, N'Hyperdrive Docking Ring', 3, 500000.0000, N'For those inferior ships that need a docking ring to go into hyperspace.                                         ', 3, N'57645b7d-8d59-4c1e-a70f-aa73eae11c9b.png')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (21, N'IG Unit Assassin Droid', 5, 7500.0000, N'Are you planning on joining the senate? Are your political opponents giving you trouble? Smearing your name? Then look no further!', 3, N'fdf5a567-523b-4642-86f0-4c066551c1fa.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (22, N'Jabba The Hutt Blowup Costume', 9, 50.0000, N'Is Halloween fast approaching? Comic-Con? The Jabba The Hutt Blowup Costume is an easy fix!', 3, N'17b6b8c4-53d8-474b-93f4-ae5b03505e7e.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (23, N'Jedi Battle Armor', 0, 750.0000, N'Found it from one of those Jedi. Doesn''t look too good but it must be powerful.', 4, N'1d9bb3cf-b546-4065-b483-c0d185a641bb.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (24, N'Jedi Rey Outfit', 9, 25.0000, N'This Rey outfit is perfect for any cosplaying event.', 3, N'a6cfc2b9-0469-4b2f-a7bd-98e43606d5e4.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (25, N'Jedi Robes', 0, 35.0000, N'Robes commonly worn by Jedi. They look like rags to me.', 3, N'48b56c65-cb06-497f-9b1e-258a7e7594cd.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (26, N'Jedi Starfighter', 3, 450000.0000, N'A ship manned by Jedi during the Clone Wars', 4, N'4c14aec7-c781-469e-89b3-51d97c6ede66.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (27, N'Jewel of Yavin', 7, 10000000.0000, N'I have no idea what this is. Looks expensive, though.', 3, N'92f1d2df-2904-4ad2-8966-ebb765921f01.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (28, N'Jogan Fruit', 2, 12.0000, N'A 4 count pack of delicious jogan fruit. Can''t find it anywhere else for fresher.', 3, N'2a31946c-6d5e-4404-a848-f49941404938.png')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (29, N'Land Speeder', 3, 10000.0000, N'A landspeeder typically used to explore the vast deserts of Tatooine', 3, N'641e220f-bf41-4557-a995-37dde298b02c.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (30, N'Lightsaber', 0, 500.0000, N'A weapon used by the Jedi. Still don''t think it beats a blaster, though.', 3, N'7c825549-6ee3-46f8-b09c-f6775c6f4326.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (31, N'Lightsaber Chopsticks', 11, 10.0000, N'Works great with sushi!', 3, N'4416ed36-d83f-4380-8fbc-a7eee5fe9103.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (32, N'LucasFilm Blue Tee', 9, 15.0000, N'A  blue tee in honor of LucasFilm', 3, N'4a7e777c-97c1-4960-86b2-ca6b9fd5dfbb.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (33, N'Grogu Baby Yoda Tee', 9, 15.0000, N'A t-shirt with Baby Yoda on it.', 3, N'1dba58cc-8d48-40c7-b978-d351e55414a0.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (34, N'Mandalorian Helmet', 10, 40.0000, N'This helmet will really help complete your Mandalorian cosplay', 3, N'fca22dda-c904-4fe9-bdb8-1cb644be1ae5.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (35, N'Meiloorun', 2, 15.0000, N'A stinky, yet tasty fruit.', 3, N'7c8f24ec-6de7-4132-9d8f-1de25f6b57f4.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (36, N'Naboo Starfighter', 3, 25000.0000, N'An old Nabooin star fighter. Incredible ship.', 3, N'472575ef-9376-45aa-8954-b41cb8478db1.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (37, N'Pit Droid', 5, 1000.0000, N'A standard pit droid that can assist in ship repairs.', 3, N'e1f8ec2b-f966-465e-b565-d6781f5e0902.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (38, N'Protocol Droid', 5, 7000.0000, N'A protocol droid perfect for communication.', 3, N'7b546c03-f66f-42ea-9817-91b075e905db.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (39, N'R7 Astromech Droid', 5, 5500.0000, N'An astromech droid perfect for navigating through space.', 4, N'91715b07-64a3-4485-8dcb-05d7f75a4c15.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (40, N'Random Cane', 7, 500.0000, N'Was told this was the cane from the sith lord, Sidious. Looks like a stick to me', 3, N'cbbebc07-0ca8-4c1c-834f-7d4ff26119e3.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (41, N'Red Kyber Crystal', 0, 111.0000, N'A red kyber crystal. Jedi were crazy but they got the crystals right, at least.', 4, N'c87d1f16-ac35-43cf-af8a-6534e8b7c072.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (42, N'Republic Gunship', 3, 150000.0000, N'A gunship from the age of the Clone Wars, used to carry troops of clones.', 4, N'e401f6d2-de4d-42dd-b8cd-7f1cb91e668a.png')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (43, N'Royal Guard Armor', 4, 7500.0000, N'The legendary Royal Guards, guardians of the Emperor. The armor can be yours.', 3, N'9eb7edff-8995-4c08-a7c7-2d8b1dd64037.png')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (44, N'Shadow Trooper Helmet', 4, 75.0000, N'The helmet of a Shock trooper from the times of the Rebellion.', 3, N'dd9f3807-5979-4c53-beb0-83f6f50fa38d.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (45, N'Smugglers Vest', 4, 30.0000, N'Perfect vest for a smuggler', 3, N'0c8c16e9-3fce-4343-967c-78a96b6a876b.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (46, N'Smuggler''s Guide', 7, 25.0000, N'The Smuggler''s Guide', 4, N'54412ba4-541d-4ece-9c92-c5effc2ed6f4.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (47, N'Space Waffle', 2, 10.0000, N'Waffles to eat on your travels through the galaxy.', 3, N'7a577048-469f-49bc-9c91-20f1eb5606f7.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (48, N'Speeder', 3, 45000.0000, N'A VERY fast speeder (I promise)', 3, N'6e2d1d29-88d5-42dc-8e67-836fdbd8688a.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (49, N'Star Wars Christmas Tee', 9, 20.0000, N'Merry Christmas!', 4, N'5ec86a5b-2fc4-40bf-85c3-2ecc2fba58d1.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Price], [Description], [StockStatusID], [ProductImage]) VALUES (50, N'Star Wars Tee', 9, 20.0000, N'A standard Star Wars Tee', 3, N'051bdd37-39b9-43b6-beb2-a22663b4c5e0.jpg')
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[StockStatus] ON 

INSERT [dbo].[StockStatus] ([StockStatusID], [InStock]) VALUES (3, N'In Stock')
INSERT [dbo].[StockStatus] ([StockStatusID], [InStock]) VALUES (4, N'Out of Stock')
SET IDENTITY_INSERT [dbo].[StockStatus] OFF
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Employee_Department]') AND parent_object_id = OBJECT_ID(N'[dbo].[Employee]'))
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Employee_Department]') AND parent_object_id = OBJECT_ID(N'[dbo].[Employee]'))
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Department]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Employee_Employee]') AND parent_object_id = OBJECT_ID(N'[dbo].[Employee]'))
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Employee] FOREIGN KEY([DirectReportID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Employee_Employee]') AND parent_object_id = OBJECT_ID(N'[dbo].[Employee]'))
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Employee]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Products_Category]') AND parent_object_id = OBJECT_ID(N'[dbo].[Products]'))
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Products_Category]') AND parent_object_id = OBJECT_ID(N'[dbo].[Products]'))
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Category]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Products_StockStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[Products]'))
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_StockStatus] FOREIGN KEY([StockStatusID])
REFERENCES [dbo].[StockStatus] ([StockStatusID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Products_StockStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[Products]'))
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_StockStatus]
GO
