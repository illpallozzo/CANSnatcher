-- ==========================================================
-- Create Stored Procedure Template for Windows Azure SQL Database
-- ==========================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, create a contactView entity for database use>
-- =============================================
CREATE PROCEDURE MasterContactView
	-- Add the parameters for the stored procedure here
	(
	@_Id		    int,

	@Email			varchar(50),

	@Phone			varchar(20),
	@PType			varchar(15),

	@Street			varchar(40) = '',
	@City			varchar(40) = '',
	@County			varchar(40) = '',
	@Zip			numeric(10,0),


	@StatementType	nvarchar(8),
	@User			int
	)
AS
DECLARE @Modifier AS int
	SET @Modifier = (SELECT ULEVEL FROM AppUser WHERE Person__Id = @User)
 IF (@Modifier > 0)
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @StatementType = 'Insert'
	BEGIN
		DECLARE @P__Id AS int
		DECLARE @A__Id AS int

		INSERT INTO Email (Owner__Id, EMAIL) values (@_Id, @Email);

		INSERT INTO Phone (PHONE_NUMBER, TYPE) values (@Phone, @PType);
		SET @P__Id =  @@IDENTITY;

		INSERT INTO Street_Address (STREET, CITY, COUNTY, ZIP) values (@Street, @City, @County, @Zip);
		SET @A__Id = @@IDENTITY;

		INSERT INTO Phone_holder (Phone__Id, Owner__Id) values (@P__Id, @_Id);
		INSERT INTO Address_holder (Address__Id, Owner__Id) values (@A__Id, @_Id);
	END
	IF @StatementType = 'Select'
	BEGIN
		SELECT uid._Id, EMAIL AS 'Email', PHONE_NUMBER AS 'Phone', pv.TYPE AS 'Phone Type', STREET AS 'Street', CITY AS 'City', COUNTY AS 'County', ZIP
		FROM UniqueID AS uid 
		  LEFT JOIN AddressView AS av
				 ON uid._Id = av.Owner__Id
			 LEFT JOIN Email AS e
			  ON uid._Id = e.Owner__Id
				LEFT JOIN PhoneView AS pv
					ON uid._Id = pv.Owner__Id
		WHERE uid._Id = @_Id
	END
	IF @StatementType = 'Delete'
	BEGIN
		DELETE FROM Email WHERE Owner__Id = @_Id;
		DELETE FROM Phone_holder WHERE Owner__Id = @_Id;
		DELETE FROM Address_holder WHERE Owner__Id = @_Id;
	END
END
GO
