USE [Sistema]
GO

/****** Object:  Table [dbo].[ArqueosDeCaja]    Script Date: 12/12/2018 12:31:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ArqueosDeCaja](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdLocal] [bigint] NOT NULL,
	[Total] [decimal](18, 2) NULL,
	[Fecha] [datetime] NULL,
	[Anotaciones] [varchar](255) NOT NULL,
 CONSTRAINT [PK_ArqueosDeCaja] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


CREATE PROCEDURE InsertArqueo(@IdLocal bigint, @Total decimal(18,2), @Fecha Varchar(50), @Anotaciones varchar(255))
as
begin
	Insert into ArqueosDeCaja(IdLocal,Total,Fecha,Anotaciones) values (@IdLocal,@Total,Convert(Datetime,@Fecha,120),@Anotaciones)
end

GO
Create PROCEDURE GetLastArqueo(@IdLocal bigint)
as
begin
	Select TOP 1 * from ArqueosDeCaja where IdLocal=@IdLocal Order By Id Desc
end
GO
Create Procedure GetArqueosBetweenDates(@IdLocal bigint, @DateStart Varchar(50), @DateEnd varchar(50))
as
begin
	Select * from ArqueosDeCaja where IdLocal=@IdLocal and Fecha between Convert(datetime,@DateStart,120) and Convert(datetime,@DateEnd,120)
end
GO