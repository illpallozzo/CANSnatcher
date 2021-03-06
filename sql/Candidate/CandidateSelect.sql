USE [CANSnatcher]
GO
/****** Object:  StoredProcedure [dbo].[CandidateSelect]    Script Date: 9/8/2017 9:51:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/8/2017>
-- Description:	<Description,, Select a Candidate entity for database use>
-- =============================================
CREATE PROCEDURE CandidateSelect
	-- Add the parameters for the stored procedure here
	(
	@Type			varchar(60),
	@Value			varchar(60)
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	IF (@Type = '_Id') 
	BEGIN
	SELECT uid._Id, FNAME, MNAME, LNAME, CAN_STATUS, EMAIL, PHONE_NUMBER, STREET, CITY, COUNTY, ZIP
		FROM Candidate AS can
			LEFT JOIN Person AS p
				ON can.Person__Id = p.UniqueID__Id
			LEFT JOIN UniqueID AS uid
				ON can.Person__Id = uid._Id
			LEFT JOIN ContactView AS cv
				ON uid._Id = cv._Id
		WHERE can.Person__Id = @Value;
	END
	ELSE IF (@Type = 'FName')
	BEGIN		
	SELECT uid._Id, FNAME, MNAME, LNAME, CAN_STATUS, EMAIL, PHONE_NUMBER, STREET, CITY, COUNTY, ZIP
		FROM Candidate AS can
			LEFT JOIN Person AS p
				ON can.Person__Id = p.UniqueID__Id
			LEFT JOIN UniqueID AS uid
				ON can.Person__Id = uid._Id
			LEFT JOIN ContactView AS cv
				ON uid._Id = cv._Id
		WHERE p.FNAME LIKE '%' + @Value + '%';
	END
	ELSE IF (@Type = 'MName')
	BEGIN		
	SELECT uid._Id, FNAME, MNAME, LNAME, CAN_STATUS, EMAIL, PHONE_NUMBER, STREET, CITY, COUNTY, ZIP
		FROM Candidate AS can
			LEFT JOIN Person AS p
				ON can.Person__Id = p.UniqueID__Id
			LEFT JOIN UniqueID AS uid
				ON can.Person__Id = uid._Id
			LEFT JOIN ContactView AS cv
				ON uid._Id = cv._Id
		WHERE p.MNAME LIKE '%' + @Value + '%';
	END
	ELSE IF (@Type = 'LName')
	BEGIN		
	SELECT uid._Id, FNAME, MNAME, LNAME, CAN_STATUS, EMAIL, PHONE_NUMBER, STREET, CITY, COUNTY, ZIP
		FROM Candidate AS can
			LEFT JOIN Person AS p
				ON can.Person__Id = p.UniqueID__Id
			LEFT JOIN UniqueID AS uid
				ON can.Person__Id = uid._Id
			LEFT JOIN ContactView AS cv
				ON uid._Id = cv._Id
		WHERE p.LNAME LIKE '%' + @Value + '%';
	END
	ELSE IF (@Type = 'Attribute')
	BEGIN
	
	SELECT uid._Id, FNAME, MNAME, LNAME, CAN_STATUS, EMAIL, PHONE_NUMBER, STREET, CITY, COUNTY, ZIP
		FROM Candidate AS can
			LEFT JOIN Person AS p
				ON can.Person__Id = p.UniqueID__Id
			LEFT JOIN UniqueID AS uid
				ON can.Person__Id = uid._Id
			LEFT JOIN ContactView AS cv
				ON uid._Id = cv._Id
			INNER JOIN Attribute AS a
				ON uid._Id = a.Candidate__Id
		WHERE (a.ATT_TYPE LIKE '%' + @Value + '%') OR (a.SUB_TYPE LIKE '%' + @Value + '%');

	END
	ELSE 
	BEGIN

	-- 		SELECT uid._Id, EMAIL, PHONE_NUMBER, STREET, CITY, COUNTY, ZIP

	DECLARE @Contact TABLE(_Id int, EMAIL varchar(50), PHONE_NUMBER varchar(20), TYPE varchar(15), STREET varchar(40), City varchar(40), County varchar(40), ZIP numeric(10,0))
	INSERT INTO @Contact EXEC ContactSelect @Type, @Value

	SELECT uid._Id, FNAME, MNAME, LNAME, CAN_STATUS, EMAIL, PHONE_NUMBER, STREET, CITY, COUNTY, ZIP
		FROM Candidate AS can
			LEFT JOIN Person AS p
				ON can.Person__Id = p.UniqueID__Id
			LEFT JOIN UniqueID AS uid
				ON can.Person__Id = uid._Id
			INNER JOIN @Contact cv
		     ON uid._Id = cv._Id
		WHERE uid._Id = cv._Id;

	END
END

