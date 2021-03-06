USE [CANSnatcher]
GO
/****** Object:  StoredProcedure [dbo].[ContactInsert]    Script Date: 9/8/2017 9:37:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, Insert a contact entity for database use>
-- =============================================
CREATE PROCEDURE ContactInsert
	-- Add the parameters for the stored procedure here
	(
	@_Id		    int,

	@Email			varchar(50) = '',

	@Phone			varchar(20) = '',
	@PType			varchar(15) = '',

	@Street			varchar(40) = '',
	@City			varchar(40) = '',
	@State			varchar(40) = '',
	@Zip			varchar(10) = 0
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DECLARE @P__Id AS int
		DECLARE @A__Id AS int

		INSERT INTO Email (Owner__Id, EMAIL) values (@_Id, @Email);

		INSERT INTO Phone (PHONE_NUMBER, TYPE) values (@Phone, @PType)
		SET @P__Id =  @@IDENTITY;

		INSERT INTO Street_Address (STREET, CITY, COUNTY, ZIP) values (@Street, @City, @State, @Zip)
		SET @A__Id = @@IDENTITY;

		INSERT INTO Phone_holder (Phone__Id, Owner__Id) values (@P__Id, @_Id);
		INSERT INTO Address_holder (Address__Id, Owner__Id) values (@A__Id, @_Id);
	END