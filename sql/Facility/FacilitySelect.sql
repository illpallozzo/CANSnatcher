USE [CANSnatcher]
GO
/****** Object:  StoredProcedure [dbo].[FacilitySelect]    Script Date: 9/8/2017 9:56:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, Select a facility entity for database use>
-- =============================================
CREATE PROCEDURE [dbo].[FacilitySelect]
	-- Add the parameters for the stored procedure here
	(
	@type			varchar(60),
	@value			varchar(60)
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	IF (@Type = '_Id') 
	BEGIN
	SELECT uid._Id, NAME, Parent__Id, (SELECT NAME FROM Facility WHERE UniqueID__Id = fac.Parent__Id) AS 'Parent NAME', cv.EMAIL, cv.PHONE_NUMBER, cv.STREET, cv.CITY, cv.COUNTY, cv.ZIP
		FROM Facility AS fac
		 LEFT JOIN  UniqueID AS uid
			 ON fac.UniqueID__Id = uid._Id
		 LEFT JOIN ContactView cv
		     ON fac.UniqueID__Id = cv._Id
		WHERE uid._Id = CONVERT(INT, @value);
	END
	ELSE IF (@Type = 'Name')
	BEGIN		
	SELECT uid._Id, fac.NAME, Parent__Id, (SELECT NAME FROM Facility WHERE UniqueID__Id = fac.Parent__Id) AS 'Parent NAME', cv.EMAIL, cv.PHONE_NUMBER, cv.STREET, cv.CITY, cv.COUNTY, cv.ZIP
		FROM Facility AS fac
		 LEFT JOIN  UniqueID AS uid
			 ON fac.UniqueID__Id = uid._Id
		 LEFT JOIN ContactView cv
		     ON fac.UniqueID__Id = cv._Id
		WHERE fac.NAME LIKE '%' + @Value + '%';
	END
	ELSE IF (@Type = 'Parent')
	BEGIN

	DECLARE @Parent AS int
	SET @Parent = (SELECT TOP 1 UniqueID__Id FROM Facility WHERE NAME LIKE '%' + @Value + '%')

	SELECT uid._Id, NAME, Parent__Id, (SELECT NAME FROM Facility WHERE UniqueID__Id = fac.Parent__Id) AS 'Parent', cv.EMAIL, cv.PHONE_NUMBER, cv.STREET, cv.CITY, cv.COUNTY, cv.ZIP
		FROM Facility AS fac
		 LEFT JOIN  UniqueID AS uid
			 ON fac.UniqueID__Id = uid._Id
		 LEFT JOIN ContactView cv
		     ON fac.UniqueID__Id = cv._Id
		WHERE fac.Parent__Id = @Parent;
	END
	ELSE 
	BEGIN

	-- 		SELECT uid._Id, EMAIL, PHONE_NUMBER, pv.TYPE, STREET, CITY, COUNTY, ZIP

	DECLARE @Contact TABLE(_Id int, EMAIL varchar(50), PHONE_NUMBER varchar(20), TYPE varchar(15), STREET varchar(40), CITY varchar(40), ADDRESS_STATE varchar(40), ZIP varchar(10))
	INSERT INTO @Contact EXEC ContactSelect @Type, @Value

	SELECT uid._Id, NAME, Parent__Id, (SELECT NAME FROM Facility WHERE UniqueID__Id = fac.Parent__Id) AS 'Parent NAME', cv.EMAIL, cv.PHONE_NUMBER, cv.STREET, cv.CITY, cv.ADDRESS_STATE, cv.ZIP
		FROM Facility AS fac
		 LEFT JOIN  UniqueID AS uid
			 ON fac.UniqueID__Id = uid._Id
		 INNER JOIN @Contact AS cv
		     ON fac.UniqueID__Id = cv._Id
		WHERE uid._Id = cv._Id ; 

	END
END