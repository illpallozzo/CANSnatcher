USE [CANSnatcher]
GO
/****** Object:  StoredProcedure [dbo].[ContactDelete]    Script Date: 9/8/2017 9:50:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, delete a contact entity for database use>
-- =============================================
CREATE PROCEDURE ContactDelete
	-- Add the parameters for the stored procedure here
	(
	@_Id		    int
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		DELETE FROM Email WHERE Owner__Id = @_Id;
		DELETE FROM Phone WHERE _Id = (SELECT Phone__Id FROM Phone_holder WHERE Owner__Id = @_Id)
		DELETE FROM Phone_holder WHERE Owner__Id = @_Id;
		DELETE FROM Street_Address WHERE _Id = (SELECT Address__Id FROM Address_holder WHERE Owner__Id = @_Id)
		DELETE FROM Address_holder WHERE Owner__Id = @_Id;
	END
