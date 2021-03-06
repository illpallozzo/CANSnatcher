USE [CANSnatcher]
GO
/****** Object:  StoredProcedure [dbo].[ContactSelect]    Script Date: 9/8/2017 9:53:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, search for a contact entity for database use>
-- =============================================
CREATE PROCEDURE ContactSelect
	-- Add the parameters for the stored procedure here
	(
	@Type		    varchar(60),
	@Value			varchar(60)
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF(@type = '_Id')
	BEGIN
		DECLARE @_Id AS INT
		SET @_Id = CONVERT(int, @Value)

		SELECT uid._Id, EMAIL, PHONE_NUMBER, pv.TYPE, STREET, CITY, ADDRESS_STATE, ZIP
		FROM UniqueID AS uid
		  LEFT JOIN AddressView AS av
				ON uid._Id = av.Owner__Id
		  LEFT JOIN PhoneView AS pv
				ON uid._Id = pv.Owner__Id
		  LEFT JOIN Email AS e
				ON uid._Id = e.Owner__Id
		WHERE uid._Id = @_Id;

	END
	ELSE IF(@type = 'Email')
	BEGIN
	
		SELECT uid._Id, e.EMAIL, pv.PHONE_NUMBER, pv.TYPE, av.STREET, av.CITY, av.ADDRESS_STATE, ZIP
		FROM UniqueID AS uid 
		  LEFT JOIN AddressView AS av
				 ON uid._Id = av.Owner__Id
			 LEFT JOIN Email AS e
			  ON uid._Id = e.Owner__Id
				LEFT JOIN PhoneView AS pv
					ON uid._Id = pv.Owner__Id
		WHERE e.EMAIL LIKE '%' + @Value + '%';

	END

	ELSE IF(@type = 'Phone')
	BEGIN
	
		SELECT uid._Id, EMAIL, PHONE_NUMBER, pv.TYPE, STREET, CITY, ADDRESS_STATE, ZIP
		FROM UniqueID AS uid 
		  LEFT JOIN AddressView AS av
				 ON uid._Id = av.Owner__Id
			 LEFT JOIN Email AS e
			  ON uid._Id = e.Owner__Id
				LEFT JOIN PhoneView AS pv
					ON uid._Id = pv.Owner__Id
		WHERE pv.PHONE_NUMBER LIKE @value;

	END

	ELSE IF(@type = 'Street')
	BEGIN
	
		SELECT uid._Id, EMAIL, PHONE_NUMBER, pv.TYPE, STREET, CITY, ADDRESS_STATE, ZIP
		FROM UniqueID AS uid 
		  LEFT JOIN AddressView AS av
				 ON uid._Id = av.Owner__Id
			 LEFT JOIN Email AS e
			  ON uid._Id = e.Owner__Id
				LEFT JOIN PhoneView AS pv
					ON uid._Id = pv.Owner__Id
		WHERE av.STREET LIKE '%' + @Value + '%';

	END

	ELSE IF(@type = 'City')
	BEGIN
	
		SELECT uid._Id, EMAIL, PHONE_NUMBER, pv.TYPE, STREET, CITY, ADDRESS_STATE, ZIP
		FROM UniqueID AS uid 
		  LEFT JOIN AddressView AS av
				 ON uid._Id = av.Owner__Id
			 LEFT JOIN Email AS e
			  ON uid._Id = e.Owner__Id
				LEFT JOIN PhoneView AS pv
					ON uid._Id = pv.Owner__Id
		WHERE av.CITY LIKE '%' + @Value + '%';

	END

	ELSE IF(@type = 'Zip')
	BEGIN
	
		SELECT uid._Id, EMAIL, PHONE_NUMBER, pv.TYPE, STREET, CITY, ADDRESS_STATE, ZIP
		FROM UniqueID AS uid 
		  LEFT JOIN AddressView AS av
				 ON uid._Id = av.Owner__Id
			 LEFT JOIN Email AS e
			  ON uid._Id = e.Owner__Id
				LEFT JOIN PhoneView AS pv
					ON uid._Id = pv.Owner__Id
		WHERE av.ZIP LIKE '%' + @value + '%';

	END

END

