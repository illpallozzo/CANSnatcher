USE [CANSnatcher]
GO
/****** Object:  StoredProcedure [dbo].[CandidateInsert]    Script Date: 9/8/2017 9:47:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, create a candidate entity for database use>
-- =============================================
CREATE PROCEDURE CandidateInsert
	-- Add the parameters for the stored procedure here
	(
	@UniqueID__Id   int,
	@Identifier		varchar(40),
	@FName			varchar(30),
	@MName			varchar(30) = '',
	@LName			varchar(30),

	@Status			varchar(20) = '',

	@Email			varchar(50) = '',

	@Phone			varchar(20) = '',
	@PType			varchar(15),

	@Street			varchar(40) = '',
	@City			varchar(40) = '',
	@County			varchar(40) = '',
	@Zip			numeric(10,0)
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

	INSERT INTO UniqueID (IDENTIFIER) values (@Identifier);
	SET @UniqueID__Id =  @@IDENTITY;

	INSERT INTO Person (UniqueID__Id, FNAME, MNAME, LNAME) values (@UniqueID__Id, @FName, @MName, @LName)
	INSERT INTO Candidate (Person__Id, CAN_STATUS) values (@UniqueID__Id, @Status)

	EXEC ContactInsert @UniqueID__Id, @Email, @Phone, @PType, @Street, @City, @County, @Zip
END