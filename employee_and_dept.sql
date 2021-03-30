CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NULL,
	[Gender] [varchar](10) NULL,
	[Salary] [int] NULL,
	[DeptId] [int] NULL
) ON [PRIMARY]


CREATE TABLE [dbo].[Department](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NULL
) 
