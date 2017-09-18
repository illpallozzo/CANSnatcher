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
-- Description:	<Description,,User Id number search>
-- =============================================
CREATE PROCEDURE  UserIdSearch
	-- Add the parameters for the stored procedure here
	(
	@Id		nvarchar(128)
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT _Id FROM UniqueID AS uid
		INNER JOIN AppUser AS au
		ON uid._Id = au.Person__Id
	WHERE IDENTIFIER = @Id;
END
GO
