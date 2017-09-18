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
-- Description:	<Description,, Update a Facility entity for database use>
-- =============================================
CREATE PROCEDURE FacilityUpdate
	-- Add the parameters for the stored procedure here
	(
	@UniqueID__Id   int,
	@Identifier		varchar(40),

	@Name			varchar(60),
	@Parent			varchar(60),

	@Email			varchar(50),

	@Phone			varchar(20) = '',
	@PType			varchar(15),

	@Street			varchar(40),
	@City			varchar(40),
	@County			varchar(40),
	@Zip			varchar(10)
	)
AS

 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Parent__Id AS int
		IF (@Parent IS NOT NULL)
			BEGIN
				SET @Parent__Id = (SELECT TOP 1 UniqueID__Id FROM Facility WHERE NAME LIKE @Parent)
			END

		UPDATE UniqueID SET IDENTIFIER = @Identifier
			WHERE _Id = @UniqueID__Id;


		UPDATE facility SET 
			NAME = @Name,
			Parent__Id = @Parent__Id
			WHERE UniqueID__Id = @UniqueID__Id;

			EXEC ContactUpdate @UniqueID__Id, @Email, @Phone, @PType, @Street, @City, @County, @Zip

END
GO
