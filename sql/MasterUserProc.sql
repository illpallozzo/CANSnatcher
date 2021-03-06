USE [CANSnatcher]
GO
/****** Object:  StoredProcedure [dbo].[MasterUser]    Script Date: 9/8/2017 10:19:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, create a user entity for database use>
-- =============================================
CREATE PROCEDURE MasterUser
	-- Add the parameters for the stored procedure here
	(
	@UniqueID__Id   int,
	@Identifier		varchar(40) = '',
	@FName			varchar(30) = '',
	@MName			varchar(30) = '',
	@LName			varchar(30) = '',
	@ULevel			int,

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

		INSERT INTO AppUser(Person__Id, ULEVEL) values (@UniqueID__Id, @Ulevel);
	END
	IF @StatementType = 'Select'
	BEGIN
		SELECT uid._Id, FNAME AS 'First Name', MNAME AS 'M', LNAME AS 'Last Name', ULEVEL AS 'level'
		FROM AppUser AS au
			LEFT JOIN Person AS p
				ON au.Person__Id = p.UniqueID__Id
			LEFT JOIN UniqueID AS uid
				ON au.Person__Id = uid._Id
		WHERE au.Person__Id = @UniqueID__Id;
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
		UPDATE AppUser SET
			ULEVEL = @ULevel
			WHERE Person__Id = @UniqueID__Id;
	END
	IF ((@StatementType = 'Delete') AND (@Modifier > 3))
	BEGIN
		DELETE FROM Settings	WHERE Settings.User__Id = @UniqueID__Id
		DELETE FROM AccessLog	WHERE AccessLog.User__Id = @UniqueID__Id
		DELETE FROM Submission	WHERE Submission.SubmissionBy__Id = @User
		DELETE FROM AppUser		WHERE AppUser.Person__Id = @UniqueID__Id
		DELETE FROM Person		WHERE Person.UniqueID__Id = @UniqueID__Id
		DELETE FROM UniqueID	WHERE UniqueID._Id = @UniqueID__Id
	END
END
