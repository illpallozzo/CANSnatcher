USE [CANSnatcher]
GO
/****** Object:  StoredProcedure [dbo].[MasterCandidate]    Script Date: 9/8/2017 9:07:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, create a Candidate entity for database use>
-- =============================================
CREATE PROCEDURE CandidateUpdate
	-- Add the parameters for the stored procedure here
	(
	@UniqueID__Id   int,
	@Identifier		varchar(40),
	@FName			varchar(30),
	@MName			varchar(30) = '',
	@LName			varchar(30),
	@Status			varchar(20),

	@Email			varchar(50),

	@Phone			varchar(20) = '',
	@PType			varchar(15),

	@Street			varchar(40),
	@City			varchar(40),
	@County			varchar(40),
	@Zip			numeric(10,0)
	)
AS

 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE UniqueID SET IDENTIFIER = @Identifier
			WHERE _Id = @UniqueID__Id;
		UPDATE Person SET 
			FNAME = @FName,
			MNAME = @MName,
			LNAME = @LName
			WHERE UniqueID__Id = @UniqueID__Id;
		UPDATE Candidate SET
			CAN_STATUS = @Status
			WHERE Person__Id = @UniqueID__Id;

			EXEC ContactUpdate @UniqueID__Id, @Email, @Phone, @PType, @Street, @City, @County, @Zip

END
GO
