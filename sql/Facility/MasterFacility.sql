USE [CANSnatcher]
GO
/****** Object:  StoredProcedure [dbo].[MasterFacility]    Script Date: 9/6/2017 1:04:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, create a facility entity for database use>
-- =============================================
CREATE PROCEDURE [dbo].[MasterFacility]
	-- Add the parameters for the stored procedure here
	(
	@UniqueID__Id   int,
	@Identifier		varchar(40),
	@FName			varchar(60),
	@Parent			varchar(60),

	@Email			varchar(50),

	@Phone			varchar(20) = '',
	@PType			varchar(15),

	@Street			varchar(40),
	@City			varchar(40),
	@County			varchar(40),
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
	
	DECLARE @Parent_Id AS int = NULL
    
	-- Insert statements for procedure here
	IF @StatementType = 'Insert'
	BEGIN
		IF (@Parent IS NOT NULL)
		BEGIN
			SET @Parent_Id = (SELECT TOP 1 UniqueID__Id FROM Facility WHERE NAME LIKE @Parent)
		END

		INSERT INTO UniqueID (IDENTIFIER) values (@Identifier);
		SET @UniqueID__Id =  @@IDENTITY;

		INSERT INTO facility (UniqueID__Id,NAME, Parent__Id) values (@UniqueID__Id, @FName, @Parent_Id);

		EXEC MasterContactView @UniqueID__Id, @Email, @Phone, @PType, @Street, @City, @County, @Zip, @StatementType, @User OUTPUT
		
	END
	IF @StatementType = 'Select'
	BEGIN
		SELECT uid._Id, NAME AS 'Name', IDENTIFIER, Parent__Id, (SELECT NAME FROM Facility WHERE UniqueID__Id = fac.Parent__Id) AS 'Parent NAME', cv.EMAIL AS 'Email', cv.PHONE_NUMBER AS 'Phone', cv.STREET AS 'Street', cv.CITY AS 'City', cv.COUNTY AS 'County', cv.ZIP
		FROM Facility AS fac
		 LEFT JOIN  UniqueID AS uid
			 ON fac.UniqueID__Id = uid._Id
		 LEFT JOIN ContactView cv
		     ON fac.UniqueID__Id = cv._Id
		WHERE uid._Id = @UniqueID__Id
	END
	IF @StatementType = 'Update'
	BEGIN
				IF (@Parent IS NOT NULL)
				BEGIN
					SET @Parent_Id = (SELECT TOP 1 UniqueID__Id FROM Facility WHERE NAME LIKE @Parent)
				END

		UPDATE UniqueID SET IDENTIFIER = @Identifier
			WHERE _Id = @UniqueID__Id;


		UPDATE facility SET 
			NAME = @FName,
			Parent__Id = @Parent_Id
			WHERE UniqueID__Id = @UniqueID__Id;


			EXEC MasterContactView @UniqueID__Id, @Email, @Phone, @PType, @Street, @City, @County, @Zip, @StatementType, @User OUTPUT

	END
	IF ((@StatementType = 'Delete') AND (@Modifier > 3))
	BEGIN
		DELETE FROM Facility	WHERE Facility.UniqueID__Id = @UniqueID__Id
	END
END
