USE [CANSnatcher]
GO
/****** Object:  StoredProcedure [dbo].[CandidateDelete]    Script Date: 9/8/2017 9:48:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, delete a candidate entity for database use>
-- =============================================
CREATE PROCEDURE CandidateDelete
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
		DELETE FROM Submission	WHERE JobOrder__Id = @_Id;
		DELETE FROM JobOrder	WHERE UniqueID__Id = @_Id;

		DELETE FROM Attribute WHERE Candidate__Id = @_Id;
		DELETE FROM Candidate WHERE Person__Id = @_Id;
		DELETE FROM Person WHERE UniqueID__Id = @_Id;
		DELETE FROM Contact  WHERE ContactFor__Id = @_Id;

	END