USE [CANSnatcher]
GO
/****** Object:  StoredProcedure [dbo].[FacilityDelete]    Script Date: 9/8/2017 9:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, delete a facility entity for database use>
-- =============================================
ALTER PROCEDURE FacilityDelete
	-- Add the parameters for the stored procedure here
	(
	@_Id		    int
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		
		EXEC ContactDelete @_Id;

		DELETE FROM JobOrder WHERE Facility__Id = @_Id;
		DELETE FROM Contact  WHERE ContactFor__Id = @_Id;

		DELETE FROM Facility WHERE UniqueID__Id = @_Id;
	END
