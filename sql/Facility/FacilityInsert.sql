USE [CANSnatcher]
GO
/****** Object:  StoredProcedure [dbo].[FacilityInsert]    Script Date: 9/8/2017 9:55:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, create a facility entity for database use>
-- =============================================
CREATE PROCEDURE FacilityInsert
	-- Add the parameters for the stored procedure here
	(
	@UniqueID__Id   int,
	@Identifier		varchar(40),
	@Name			varchar(60),
	@Parent			varchar(60),

	@Email			varchar(50),

	@Phone			varchar(20) = '',
	@PType			varchar(15),

	@Street			varchar(40) = '',
	@City			varchar(40) = '',
	@State			varchar(40) = '',
	@Zip			varchar(10) = ''
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @Parent_Id AS int = NULL

	IF (@Parent IS NOT NULL)
	BEGIN
		SET @Parent_Id = (SELECT TOP 1 UniqueID__Id FROM Facility WHERE NAME LIKE @Parent)
	END

	INSERT INTO UniqueID (IDENTIFIER) values (@Identifier);
	SET @UniqueID__Id =  @@IDENTITY;

	INSERT INTO facility (UniqueID__Id,NAME, Parent__Id) values (@UniqueID__Id, @Name, @Parent_Id);

	EXEC ContactInsert @UniqueID__Id, @Email, @Phone, @PType, @Street, @City, @State, @Zip

END