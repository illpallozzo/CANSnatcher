USE [CANSnatcher]
GO
/****** Object:  StoredProcedure [dbo].[MasterJobOrder]    Script Date: 9/8/2017 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, create a JobOrder entity for database use>
-- =============================================
CREATE PROCEDURE MasterJobOrder
	-- Add the parameters for the stored procedure here
	(
	@_Id   int,
	@Identifier		varchar(40),

	@Title			varchar(40),
	@Rate			decimal(10,2),
	@StartDate		date,
	@Status			varchar(10),
	@Description	char(400),

	@Facility		int,

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
		DECLARE @UniqueID__Id AS int
		INSERT INTO UniqueID (IDENTIFIER) values (@Identifier);
		SET @UniqueID__Id =  @@IDENTITY;

		INSERT INTO JobOrder (UniqueID__Id, TITLE, RATE, JO_START_DATE, JO_STATUS, JO_DESCRIPTION, Facility__Id) 
			values (@UniqueID__Id, @Title, @Rate, @StartDate, @Status, @Description, @Facility);
	END
	IF @StatementType = 'Select'
	BEGIN
		SELECT uid._Id, TITLE AS 'Title', RATE AS 'Rate', JO_START_DATE AS 'Start Date', JO_STATUS AS 'Status', JO_DESCRIPTION AS 'Description', Facility__Id, (SELECT NAME FROM Facility WHERE UniqueID__Id = jo.Facility__Id) AS 'Facility'
		FROM JobOrder AS jo
			LEFT JOIN UniqueID AS uid
			ON jo.UniqueID__Id = uid._Id
		WHERE uid._Id = @_Id;
	END
	IF @StatementType = 'Update'
	BEGIN
		IF (@Identifier IS NOT NULL) 
		BEGIN
		UPDATE UniqueID SET IDENTIFIER = @Identifier
			WHERE _Id = @_Id;
		END
		UPDATE JobOrder SET 
			TITLE	=		 @Title,
			RATE	=		 @Rate,
			JO_START_DATE =	 @StartDate,
			JO_STATUS	=	 @Status,
			JO_DESCRIPTION = @Description,
			Facility__Id =	 @Facility
			WHERE UniqueID__Id = @_Id;
	END
	IF ((@StatementType = 'Delete') AND (@Modifier > 3))
	BEGIN
		DELETE FROM Submission	WHERE JobOrder__Id = @_Id;
		DELETE FROM JobOrder	WHERE UniqueID__Id = @_Id;
	END
END
