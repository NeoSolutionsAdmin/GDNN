USE [Sistema]
GO

/****** Object:  Table [dbo].[Empleados_Local]    Script Date: 05/11/2018 18:06:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Empleados_Local](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[LocalID] [bigint] NOT NULL,
 CONSTRAINT [PK_Empleados_Local] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


USE [Sistema]
GO

/****** Object:  Table [dbo].[Sucursales]    Script Date: 05/11/2018 18:06:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Sucursales](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[NombreLocal] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Sucursales] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE Treatment
ADD UserId bigint;

GO

USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[Search_Tratamiento]    Script Date: 02/11/2018 16:34:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Search_Tratamiento](@LocalId bigint, @cadenadebusqueda varchar(50))
as
begin
select * from Treatment where Nombre like '%' + @cadenadebusqueda + '%' and UserId = @LocalId
end
GO

USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[Insert_Treatment]    Script Date: 02/11/2018 15:54:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Insert_Treatment] (@UserId bigint, @Nombre varchar(50),@Precio decimal(18,4), @FechaCreacion date, @FechaCaducidad date, @Descripcion varchar(200), @Allowed bit)
as
begin
insert into Treatment(UserId,Nombre,Precio,FechaCreacion,FechaCaducidad,Descripcion,Allowed) values(@UserId,@Nombre,@Precio,@FechaCreacion,@FechaCaducidad,@Descripcion,@Allowed)
end

GO
