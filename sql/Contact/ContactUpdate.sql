USE [CANSnatcher]
GO
/****** Object:  StoredProcedure [dbo].[ContactInsert]    Script Date: 9/8/2017 9:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, Update a contact entity for database use>
-- =============================================
CREATE PROCEDURE ContactUpdate
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

	UPDATE Email SET
		EMAIL = @Email
		WHERE Email.Owner__Id = @_Id;
	UPDATE Phone SET
		PHONE_NUMBER = @Phone,
		TYPE = @PType
		WHERE (SELECT Phone__Id FROM Phone_holder WHERE Owner__Id = @_Id) = Phone._Id;
		
	UPDATE Street_Address SET
		STREET	= @Street,
		CITY	= @City,
		ADDRESS_STATE	= @State,
		ZIP		= @Zip
		WHERE (SELECT Address__Id FROM Address_holder WHERE Owner__Id = @_Id) = Street_Address._Id;
	END