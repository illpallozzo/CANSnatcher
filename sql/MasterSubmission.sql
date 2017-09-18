-- ==========================================================
-- Create Stored Procedure Template for Windows Azure SQL Database
-- ==========================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,, 9/8/2017>
-- Description:	<Description,, Master Job Order Submission Control >
-- =============================================
CREATE PROCEDURE MasterSubmission 
	-- Add the parameters for the stored procedure here
	(
	@_Id		    int,
	@Identifier		varchar(40) = '',

	@JO__Id			int,
	@Candidate__Id	int,
	@Rate			decimal(10,2) = 0,

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

	IF @StatementType = 'Insert'
	BEGIN
		DECLARE @UniqueID__Id AS int
		INSERT INTO UniqueID (IDENTIFIER) values (@Identifier);
		SET @UniqueID__Id =  @@IDENTITY;

		INSERT INTO Submission (UniqueID__Id, JobOrder__Id, Candidate__Id, SubmissionBy__Id, BILL_RATE)
			values (@UniqueID__Id, @JO__Id, @Candidate__Id, @User, @Rate);
	END
	IF @StatementType = 'Select'
	BEGIN
		SELECT * FROM SubmissionView
		WHERE _Id = @_Id;

	END
	IF @StatementType = 'Update'
	BEGIN
		IF (@Identifier IS NOT NULL) 
		BEGIN
		UPDATE UniqueID SET IDENTIFIER = @Identifier
			WHERE _Id = @_Id;
		END
		UPDATE Submission SET 
			JobOrder__Id		=	@JO__Id,
			Candidate__Id		=	@Candidate__Id,
			SubmissionBy__Id	=	@User,
			BILL_RATE			=   @Rate
		WHERE UniqueID__Id = @_Id;
	END
	IF @StatementType = 'Delete'
	BEGIN
		DELETE FROM Submission	WHERE UniqueID__Id = @_Id;
		DELETE FROM UniqueID	WHERE _Id = @_Id;
	END

END
GO
