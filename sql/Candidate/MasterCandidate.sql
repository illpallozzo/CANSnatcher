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
-- Description:	<Description,, create a Candidate entity for database use>
-- =============================================
CREATE PROCEDURE MasterCandidate
	-- Add the parameters for the stored procedure here
	(
	@UniqueID__Id   int,
	@Identifier		varchar(40),
	@FName			varchar(30),
	@MName			varchar(30) = '',
	@LName			varchar(30),
	@Status			varchar(20),

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
		INSERT INTO UniqueID (IDENTIFIER) values (@Identifier);
		SET @UniqueID__Id =  @@IDENTITY;

		INSERT INTO Person (UniqueID__Id,FNAME,MNAME,LNAME) values (@UniqueID__Id, @FName, @MName, @LName);

		INSERT INTO Candidate(Person__Id, CAN_STATUS) values (@UniqueID__Id, @Status);
	END
	IF @StatementType = 'Select'
	BEGIN
		SELECT uid._Id, FNAME AS 'First Name', MNAME AS 'M', LNAME AS 'Last Name', CAN_STATUS AS 'Status'
		FROM Candidate AS can
			LEFT JOIN Person AS p
				ON can.Person__Id = p.UniqueID__Id
			LEFT JOIN UniqueID AS uid
				ON can.Person__Id = uid._Id
		WHERE can.Person__Id = @UniqueID__Id;
	END
	IF @StatementType = 'Update'
	BEGIN
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
	END
	IF ((@StatementType = 'Delete') AND (@Modifier > 3))
	BEGIN
		DELETE FROM Attribute	WHERE Candidate__Id = @UniqueID__Id;
		DELETE FROM Candidate	WHERE Person__Id = @UniqueID__Id;
		DELETE FROM Person		WHERE UniqueID__Id = @UniqueID__Id;
		DELETE FROM UniqueID	WHERE _Id = @UniqueID__Id;
	END
END
GO
