-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2017-08-29 21:25:48.635

-- tables
-- Table: AccessLog
CREATE TABLE AccessLog (
    _Id int  NOT NULL IDENTITY,
    timestamp timestamp  NOT NULL,
    User__Id int  NOT NULL,
    TYPE varchar(20)  NOT NULL,
    CONSTRAINT AccessLog_pk PRIMARY KEY  (_Id,timestamp,User__Id)
);

-- Table: Address_holder
CREATE TABLE Address_holder (
    Address__Id int  NOT NULL,
    Owner__Id int  NOT NULL,
    CONSTRAINT Address_holder_pk PRIMARY KEY  (Address__Id,Owner__Id)
);

-- Table: AppUser
CREATE TABLE AppUser (
    Person__Id int  NOT NULL,
    ULEVEL int  NOT NULL,
    CONSTRAINT AppUser_pk PRIMARY KEY  (Person__Id)
);

CREATE INDEX User_idx_1 on AppUser (Person__Id ASC)
;

-- Table: Attribute
CREATE TABLE Attribute (
    _Id int  NOT NULL IDENTITY,
    Candidate__Id int  NOT NULL,
    timestamp timestamp  NOT NULL,
    ATT_TYPE varchar(40)  NOT NULL,
    SUB_TYPE varchar(40)  NULL,
    CONSTRAINT Attribute_pk PRIMARY KEY  (_Id,Candidate__Id)
);

-- Table: Candidate
CREATE TABLE Candidate (
    Person__Id int  NOT NULL,
    timestamp timestamp  NOT NULL,
    CAN_STATUS varchar(20)  NULL,
    CONSTRAINT Candidate_pk PRIMARY KEY  (Person__Id)
);

-- Table: Contact
CREATE TABLE Contact (
    _Id int  NOT NULL IDENTITY,
    Contact__Id int  NOT NULL,
    ContactFor__Id int  NULL,
    timestamp timestamp  NOT NULL,
    CONSTRAINT Contact_holder_ak_1 UNIQUE (ContactFor__Id),
    CONSTRAINT Contact_pk PRIMARY KEY  (_Id)
);

-- Table: Email
CREATE TABLE Email (
    _Id int  NOT NULL IDENTITY,
    Owner__Id int  NOT NULL,
    timestamp timestamp  NOT NULL,
    EMAIL varchar(50)  NOT NULL,
    CONSTRAINT Email_pk PRIMARY KEY  (_Id,Owner__Id)
);

-- Table: Facility
CREATE TABLE Facility (
    UniqueID__Id int  NOT NULL,
    timestamp timestamp  NOT NULL,
    NAME varchar(60)  NOT NULL,
    Parent__Id int  NULL,
    CONSTRAINT Facility_ak_1 UNIQUE (UniqueID__Id),
    CONSTRAINT Facility_pk PRIMARY KEY  (UniqueID__Id)
);

CREATE UNIQUE INDEX Facility_idx_1 on Facility (UniqueID__Id ASC)
;

-- Table: JobOrder
CREATE TABLE JobOrder (
    UniqueID__Id int  NOT NULL,
    timestamp timestamp  NOT NULL,
    TITLE varchar(40)  NOT NULL,
    RATE decimal(10,2)  NULL,
    JO_START_DATE date  NOT NULL,
    JO_STATUS varchar(10)  NOT NULL,
    JO_DESCRIPTION char(400)  NULL,
    Facility__Id int  NOT NULL,
    CONSTRAINT JobOrder_ak_1 UNIQUE (UniqueID__Id),
    CONSTRAINT JobOrder_pk PRIMARY KEY  (UniqueID__Id)
);

CREATE UNIQUE INDEX JobOrder_idx_1 on JobOrder (UniqueID__Id ASC)
;

-- Table: Notes
CREATE TABLE Notes (
    UniqueID__Id int  NOT NULL,
    Taker__Id int  NOT NULL,
    timestamp timestamp  NOT NULL,
    Noted__Id int  NOT NULL,
    NOTE char(400)  NOT NULL,
    SHARED bit  NOT NULL DEFAULT 1,
    CONSTRAINT Notes_ak_1 UNIQUE (UniqueID__Id),
    CONSTRAINT Notes_pk PRIMARY KEY  (UniqueID__Id,Taker__Id,Noted__Id,SHARED)
);

-- Table: Person
CREATE TABLE Person (
    UniqueID__Id int  NOT NULL,
    timestamp timestamp  NOT NULL,
    FNAME varchar(30)  NOT NULL,
    MNAME varchar(30)  NULL,
    LNAME varchar(30)  NOT NULL,
    CONSTRAINT Person_ak_1 UNIQUE (UniqueID__Id),
    CONSTRAINT Person_pk PRIMARY KEY  (UniqueID__Id)
);

CREATE UNIQUE INDEX Person_idx_1 on Person (UniqueID__Id ASC)
;

-- Table: Phone
CREATE TABLE Phone (
    _Id int  NOT NULL IDENTITY,
    timestamp timestamp  NOT NULL,
    PHONE_NUMBER varchar(20)  NOT NULL,
    TYPE varchar(15)  NULL,
    CONSTRAINT Phone_pk PRIMARY KEY  (_Id)
);

-- Table: Phone_holder
CREATE TABLE Phone_holder (
    Phone__Id int  NOT NULL,
    Owner__Id int  NOT NULL,
    CONSTRAINT Phone_holder_pk PRIMARY KEY  (Phone__Id,Owner__Id)
);

-- Table: Settings
CREATE TABLE Settings (
    _Id int  NOT NULL IDENTITY,
    User__Id int  NOT NULL,
    SETTING varchar(30)  NOT NULL,
    SETTING_VALUE int  NOT NULL,
    timestamp timestamp  NOT NULL,
    CONSTRAINT Settings_pk PRIMARY KEY  (_Id,User__Id)
);

-- Table: Street_Address
CREATE TABLE Street_Address (
    _Id int  NOT NULL IDENTITY,
    timestamp timestamp  NOT NULL,
    STREET varchar(40)  NOT NULL,
    CITY varchar(40)  NOT NULL,
    ADDRESS_STATE varchar(40)  NULL,
    ZIP varchar(10)  NOT NULL,
    CONSTRAINT Street_Address_pk PRIMARY KEY  (_Id)
);

-- Table: Submission
CREATE TABLE Submission (
    UniqueID__Id int  NOT NULL,
    JobOrder__Id int  NOT NULL,
    Candidate__Id int  NOT NULL,
    SubmissionBy__Id int  NOT NULL,
    timestamp timestamp  NOT NULL,
    SUBMISSION_DATE date  NOT NULL DEFAULT GETDATE(),
    BILL_RATE decimal(10,2)  NULL,
    CONSTRAINT Submission_ak_1 UNIQUE (UniqueID__Id),
    CONSTRAINT Submission_pk PRIMARY KEY  (UniqueID__Id,JobOrder__Id,Candidate__Id,SubmissionBy__Id)
);

CREATE UNIQUE INDEX Submission_idx_1 on Submission (UniqueID__Id ASC)
;

-- Table: UniqueID
CREATE TABLE UniqueID (
    _Id int  NOT NULL IDENTITY,
    timestamp timestamp  NOT NULL,
    IDENTIFIER nvarchar(128)  NOT NULL DEFAULT 'UNNAMED',
    CONSTRAINT UniqueID_ak_1 UNIQUE (_Id, IDENTIFIER),
    CONSTRAINT UniqueID_pk PRIMARY KEY  (_Id)
);

CREATE UNIQUE INDEX UniqueID_idx_1 on UniqueID (_Id ASC)
;

-- views

-- View: AddressView
GO

CREATE VIEW AddressView
AS
SELECT STREET, CITY, ADDRESS_STATE, ZIP, Owner__Id
FROM Street_Address AS sa LEFT JOIN Address_holder AS ah
ON sa._Id = ah.Address__Id;

-- View: PhoneView
GO

CREATE VIEW PhoneView
AS
SELECT PHONE_NUMBER, TYPE, Owner__Id
FROM Phone LEFT JOIN Phone_holder AS ph
ON Phone._Id = ph.Phone__Id;

-- View: ContactView
GO

CREATE VIEW ContactView
AS
SELECT uid._Id, uid.IDENTIFIER, EMAIL, PHONE_NUMBER, STREET, CITY, ADDRESS_STATE, ZIP
FROM UniqueId AS uid
  LEFT JOIN AddressView AS av
	ON uid._Id = av.Owner__Id
  LEFT JOIN PhoneView AS pv
    ON uid._Id = pv.Owner__Id
  LEFT JOIN Email
    ON uid._Id = Email.Owner__Id;

-- View: CandidateView
GO

CREATE VIEW CandidateView
AS
SELECT uid._Id, p.FNAME, p.MNAME, p.LNAME, conv.EMAIL AS Email, conv.PHONE_NUMBER AS Phone, can.CAN_STATUS
FROM UniqueID AS uid 
 INNER JOIN Candidate AS can
  ON uid._Id = can.Person__Id
    LEFT JOIN Person AS p
     ON can.Person__Id = p.UniqueID__Id
 LEFT JOIN ContactView AS conv
  ON uid._Id = conv._id;

-- View: UserView
GO

CREATE VIEW UserView
AS
SELECT uid._Id, uid.IDENTIFIER, ULEVEL, FNAME, MNAME, LNAME
FROM AppUser AS u
 JOIN Person AS p
     ON u.Person__Id = p.UniqueID__Id
 LEFT JOIN UniqueID AS uid
     ON uid._Id = p.UniqueID__Id;
        

-- View: FacilityView
GO

CREATE VIEW FacilityView
AS
SELECT uid._Id, NAME, EMAIL, PHONE_NUMBER, STREET, CITY, ZIP, Parent__Id AS Parent, (SELECT NAME FROM Facility WHERE UniqueID__Id = fac.Parent__Id) AS Parent_NAME
FROM Facility AS fac
 LEFT JOIN  UniqueID AS uid
     ON fac.UniqueID__Id = uid._Id
 LEFT JOIN ContactView AS conv
     ON uid._Id = conv._Id;

-- View: JobOrderView
GO

CREATE VIEW JobOrderView
AS
SELECT uid._Id, TITLE, RATE, JO_START_DATE, JO_STATUS, JO_DESCRIPTION, Facility__Id, (SELECT NAME FROM Facility WHERE UniqueID__Id = jo.Facility__Id) AS Facility_NAME
FROM JobOrder AS jo
 LEFT JOIN UniqueID AS uid
    ON jo.UniqueID__Id = uid._Id;

GO

-- View: SubmissionView
CREATE VIEW SubmissionView
AS
SELECT sub.UniqueID__Id, cv.LNAME, cv.FNAME, jov.Facility_NAME, jov.JO_START_DATE, SUBMISSION_DATE, jov.RATE, BILL_RATE, jov.JO_STATUS,jov.TITLE, jov.JO_DESCRIPTION
FROM Submission AS sub
 LEFT JOIN JobOrderView AS jov
     ON sub.JobOrder__Id = jov._Id
    LEFT JOIN CandidateView AS cv
     ON sub.Candidate__Id = cv._Id;

GO

-- foreign keys
-- Reference: AccessLog_User (table: AccessLog)
ALTER TABLE AccessLog ADD CONSTRAINT AccessLog_User
    FOREIGN KEY (User__Id)
    REFERENCES AppUser (Person__Id)  ON DELETE CASCADE;

-- Reference: Address_holder_Address (table: Address_holder)
ALTER TABLE Address_holder ADD CONSTRAINT Address_holder_Address
    FOREIGN KEY (Address__Id)
    REFERENCES Street_Address (_Id) ON DELETE CASCADE;

-- Reference: Address_holder_UniqueID (table: Address_holder)
ALTER TABLE Address_holder ADD CONSTRAINT Address_holder_UniqueID
    FOREIGN KEY (Owner__Id)
    REFERENCES UniqueID (_Id) ON DELETE CASCADE;

-- Reference: Attribute_Candidate (table: Attribute)
ALTER TABLE Attribute ADD CONSTRAINT Attribute_Candidate
    FOREIGN KEY (Candidate__Id)
    REFERENCES Candidate (Person__Id) ON DELETE CASCADE;

-- Reference: Candidate_holder_Candidate (table: Submission)
ALTER TABLE Submission ADD CONSTRAINT Candidate_holder_Candidate
    FOREIGN KEY (Candidate__Id)
    REFERENCES Candidate (Person__Id) ON DELETE CASCADE;

-- Reference: Contact_Person (table: Contact)
ALTER TABLE Contact ADD CONSTRAINT Contact_Person
    FOREIGN KEY (Contact__Id)
    REFERENCES Person (UniqueID__Id) ON DELETE CASCADE;

-- Reference: Contact_UniqueID (table: Contact)
ALTER TABLE Contact ADD CONSTRAINT Contact_UniqueID
    FOREIGN KEY (ContactFor__Id)
    REFERENCES UniqueID (_Id) ON DELETE CASCADE;

-- Reference: Email_UniqueID (table: Email)
ALTER TABLE Email ADD CONSTRAINT Email_UniqueID
    FOREIGN KEY (Owner__Id)
    REFERENCES UniqueID (_Id) ON DELETE CASCADE;

-- Reference: Facility_Facility (table: Facility)
ALTER TABLE Facility ADD CONSTRAINT Facility_Facility
    FOREIGN KEY (Parent__Id)
    REFERENCES Facility (UniqueID__Id) ON DELETE NO ACTION;

-- Reference: JobOrder_Facility (table: JobOrder)
ALTER TABLE JobOrder ADD CONSTRAINT JobOrder_Facility
    FOREIGN KEY (Facility__Id)
    REFERENCES Facility (UniqueID__Id) ON DELETE CASCADE;

-- Reference: Noted_UniqueID (table: Notes)
ALTER TABLE Notes ADD CONSTRAINT Noted_UniqueID
    FOREIGN KEY (Noted__Id)
    REFERENCES UniqueID (_Id) ON DELETE CASCADE;

-- Reference: Notes_User (table: Notes)
ALTER TABLE Notes ADD CONSTRAINT Notes_User
    FOREIGN KEY (Taker__Id)
    REFERENCES AppUser (Person__Id) ON DELETE NO ACTION;

-- Reference: Person_Profile (table: Candidate)
ALTER TABLE Candidate ADD CONSTRAINT Person_Profile
    FOREIGN KEY (Person__Id)
    REFERENCES Person (UniqueID__Id) ON DELETE CASCADE;

-- Reference: Phone_holder_UniqueID (table: Phone_holder)
ALTER TABLE Phone_holder ADD CONSTRAINT Phone_holder_UniqueID
    FOREIGN KEY (Owner__Id)
    REFERENCES UniqueID (_Id) ON DELETE CASCADE;

-- Reference: Phone_owner_Phone (table: Phone_holder)
ALTER TABLE Phone_holder ADD CONSTRAINT Phone_owner_Phone
    FOREIGN KEY (Phone__Id)
    REFERENCES Phone (_Id) ON DELETE CASCADE;

-- Reference: Settings_User (table: Settings)
ALTER TABLE Settings ADD CONSTRAINT Settings_User
    FOREIGN KEY (User__Id)
    REFERENCES AppUser (Person__Id) ON DELETE CASCADE;

-- Reference: Submission_JobOrder (table: Submission)
ALTER TABLE Submission ADD CONSTRAINT Submission_JobOrder
    FOREIGN KEY (JobOrder__Id)
    REFERENCES JobOrder (UniqueID__Id) ON DELETE CASCADE;

-- Reference: Submission_User (table: Submission)
ALTER TABLE Submission ADD CONSTRAINT Submission_User
    FOREIGN KEY (SubmissionBy__Id)
    REFERENCES AppUser (Person__Id) ON DELETE CASCADE;

-- Reference: UniqueID_Facility (table: Facility)
ALTER TABLE Facility ADD CONSTRAINT UniqueID_Facility
    FOREIGN KEY (UniqueID__Id)
    REFERENCES UniqueID (_Id) ON DELETE CASCADE;

-- Reference: UniqueID_JobOrder (table: JobOrder)
ALTER TABLE JobOrder ADD CONSTRAINT UniqueID_JobOrder
    FOREIGN KEY (UniqueID__Id)
    REFERENCES UniqueID (_Id) ON DELETE NO ACTION;

-- Reference: UniqueID_Notes (table: Notes)
ALTER TABLE Notes ADD CONSTRAINT UniqueID_Notes
    FOREIGN KEY (UniqueID__Id)
    REFERENCES UniqueID (_Id) ON DELETE NO ACTION;

-- Reference: UniqueID_Person (table: Person)
ALTER TABLE Person ADD CONSTRAINT UniqueID_Person
    FOREIGN KEY (UniqueID__Id)
    REFERENCES UniqueID (_Id) ON DELETE NO ACTION;
	
-- removed for MasterSubmission for cyclic delete concern
-- Reference: UniqueID_Submission (table: Submission)
-- ALTER TABLE Submission ADD CONSTRAINT UniqueID_Submission
--     FOREIGN KEY (UniqueID__Id)
--     REFERENCES UniqueID (_Id) ON DELETE NO ACTION;

-- Reference: User_Person (table: AppUser)
ALTER TABLE AppUser ADD CONSTRAINT User_Person
    FOREIGN KEY (Person__Id)
    REFERENCES Person (UniqueID__Id) ON DELETE NO ACTION;



-- Stored Procedures

GO
/****** Object:  StoredProcedure [dbo].[ContactInsert]    Script Date: 9/8/2017 9:37:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, Insert a contact entity for database use>
-- =============================================
CREATE PROCEDURE ContactInsert
	-- Add the parameters for the stored procedure here
	(
	@_Id		    int,

	@Email			varchar(50) = '',

	@Phone			varchar(20) = '',
	@PType			varchar(15) = '',

	@Street			varchar(40) = '',
	@City			varchar(40) = '',
	@State			varchar(40) = '',
	@Zip			varchar(10) = 0
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DECLARE @P__Id AS int
		DECLARE @A__Id AS int

		INSERT INTO Email (Owner__Id, EMAIL) values (@_Id, @Email);

		INSERT INTO Phone (PHONE_NUMBER, TYPE) values (@Phone, @PType)
		SET @P__Id =  @@IDENTITY;

		INSERT INTO Street_Address (STREET, CITY, ADDRESS_STATE, ZIP) values (@Street, @City, @State, @Zip)
		SET @A__Id = @@IDENTITY;

		INSERT INTO Phone_holder (Phone__Id, Owner__Id) values (@P__Id, @_Id);
		INSERT INTO Address_holder (Address__Id, Owner__Id) values (@A__Id, @_Id);
	END


GO
/****** Object:  StoredProcedure [dbo].[ContactDelete]    Script Date: 9/8/2017 9:50:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, delete a contact entity for database use>
-- =============================================
CREATE PROCEDURE ContactDelete
	-- Add the parameters for the stored procedure here
	(
	@_Id		    int
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		DELETE FROM Email WHERE Owner__Id = @_Id;
		DELETE FROM Phone WHERE _Id = (SELECT Phone__Id FROM Phone_holder WHERE Owner__Id = @_Id)
		DELETE FROM Phone_holder WHERE Owner__Id = @_Id;
		DELETE FROM Street_Address WHERE _Id = (SELECT Address__Id FROM Address_holder WHERE Owner__Id = @_Id)
		DELETE FROM Address_holder WHERE Owner__Id = @_Id;
	END


GO
/****** Object:  StoredProcedure [dbo].[ContactSelect]    Script Date: 9/8/2017 9:53:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, search for a contact entity for database use>
-- =============================================
CREATE PROCEDURE ContactSelect
	-- Add the parameters for the stored procedure here
	(
	@Type		    varchar(60),
	@Value			varchar(60)
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF(@type = '_Id')
	BEGIN
		DECLARE @_Id AS INT
		SET @_Id = CONVERT(int, @Value)

		SELECT uid._Id, EMAIL, PHONE_NUMBER, pv.TYPE, STREET, CITY, ADDRESS_STATE, ZIP
		FROM UniqueID AS uid
		  LEFT JOIN AddressView AS av
				ON uid._Id = av.Owner__Id
		  LEFT JOIN PhoneView AS pv
				ON uid._Id = pv.Owner__Id
		  LEFT JOIN Email AS e
				ON uid._Id = e.Owner__Id
		WHERE uid._Id = @_Id;

	END
	ELSE IF(@type = 'Email')
	BEGIN
	
		SELECT uid._Id, e.EMAIL, pv.PHONE_NUMBER, pv.TYPE, av.STREET, av.CITY, av.ADDRESS_STATE, ZIP
		FROM UniqueID AS uid 
		  LEFT JOIN AddressView AS av
				 ON uid._Id = av.Owner__Id
			 LEFT JOIN Email AS e
			  ON uid._Id = e.Owner__Id
				LEFT JOIN PhoneView AS pv
					ON uid._Id = pv.Owner__Id
		WHERE e.EMAIL LIKE '%' + @Value + '%';

	END

	ELSE IF(@type = 'Phone')
	BEGIN
	
		SELECT uid._Id, EMAIL, PHONE_NUMBER, pv.TYPE, STREET, CITY, ADDRESS_STATE, ZIP
		FROM UniqueID AS uid 
		  LEFT JOIN AddressView AS av
				 ON uid._Id = av.Owner__Id
			 LEFT JOIN Email AS e
			  ON uid._Id = e.Owner__Id
				LEFT JOIN PhoneView AS pv
					ON uid._Id = pv.Owner__Id
		WHERE pv.PHONE_NUMBER LIKE @value;

	END

	ELSE IF(@type = 'Street')
	BEGIN
	
		SELECT uid._Id, EMAIL, PHONE_NUMBER, pv.TYPE, STREET, CITY, ADDRESS_STATE, ZIP
		FROM UniqueID AS uid 
		  LEFT JOIN AddressView AS av
				 ON uid._Id = av.Owner__Id
			 LEFT JOIN Email AS e
			  ON uid._Id = e.Owner__Id
				LEFT JOIN PhoneView AS pv
					ON uid._Id = pv.Owner__Id
		WHERE av.STREET LIKE '%' + @Value + '%';

	END

	ELSE IF(@type = 'City')
	BEGIN
	
		SELECT uid._Id, EMAIL, PHONE_NUMBER, pv.TYPE, STREET, CITY, ADDRESS_STATE, ZIP
		FROM UniqueID AS uid 
		  LEFT JOIN AddressView AS av
				 ON uid._Id = av.Owner__Id
			 LEFT JOIN Email AS e
			  ON uid._Id = e.Owner__Id
				LEFT JOIN PhoneView AS pv
					ON uid._Id = pv.Owner__Id
		WHERE av.CITY LIKE '%' + @Value + '%';

	END

	ELSE IF(@type = 'Zip')
	BEGIN
	
		SELECT uid._Id, EMAIL, PHONE_NUMBER, pv.TYPE, STREET, CITY, ADDRESS_STATE, ZIP
		FROM UniqueID AS uid 
		  LEFT JOIN AddressView AS av
				 ON uid._Id = av.Owner__Id
			 LEFT JOIN Email AS e
			  ON uid._Id = e.Owner__Id
				LEFT JOIN PhoneView AS pv
					ON uid._Id = pv.Owner__Id
		WHERE av.ZIP LIKE '%' + @value + '%';

	END

END


GO
/****** Object:  StoredProcedure [dbo].[ContactInsert]    Script Date: 9/8/2017 9:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, Update a contact entity for database use>
-- =============================================
CREATE PROCEDURE ContactUpdate
	-- Add the parameters for the stored procedure here
	(
	@_Id		    int,

	@Email			varchar(50) = '',

	@Phone			varchar(20) = '',
	@PType			varchar(15) = '',

	@Street			varchar(40) = '',
	@City			varchar(40) = '',
	@State			varchar(40) = '',
	@Zip			varchar(10) = 0
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE Email SET
		EMAIL = @Email
		WHERE Email.Owner__Id = @_Id;
	UPDATE Phone SET
		PHONE_NUMBER = @Phone,
		TYPE = @PType
		WHERE (SELECT Phone__Id FROM Phone_holder WHERE Owner__Id = @_Id) = Phone._Id;
		
	UPDATE Street_Address SET
		STREET	= @Street,
		CITY	= @City,
		ADDRESS_STATE	= @State,
		ZIP		= @Zip
		WHERE (SELECT Address__Id FROM Address_holder WHERE Owner__Id = @_Id) = Street_Address._Id;
	END








GO
/****** Object:  StoredProcedure [dbo].[CandidateDelete]    Script Date: 9/8/2017 9:48:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, delete a candidate entity for database use>
-- =============================================
CREATE PROCEDURE CandidateDelete
	-- Add the parameters for the stored procedure here
	(
	@_Id		    int
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		
		EXEC ContactDelete @_Id;
		DELETE FROM Submission	WHERE JobOrder__Id = @_Id;
		DELETE FROM JobOrder	WHERE UniqueID__Id = @_Id;

		DELETE FROM Attribute WHERE Candidate__Id = @_Id;
		DELETE FROM Candidate WHERE Person__Id = @_Id;
		DELETE FROM Person WHERE UniqueID__Id = @_Id;
		DELETE FROM Contact  WHERE ContactFor__Id = @_Id;

	END

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
	@State			varchar(40) = '',
	@Zip			varchar(10)
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

	EXEC ContactInsert @UniqueID__Id, @Email, @Phone, @PType, @Street, @City, @State, @Zip
END



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
	SELECT uid._Id, FNAME, MNAME, LNAME, CAN_STATUS, EMAIL, PHONE_NUMBER, STREET, CITY, ADDRESS_STATE, ZIP
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
	SELECT uid._Id, FNAME, MNAME, LNAME, CAN_STATUS, EMAIL, PHONE_NUMBER, STREET, CITY, ADDRESS_STATE, ZIP
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
	SELECT uid._Id, FNAME, MNAME, LNAME, CAN_STATUS, EMAIL, PHONE_NUMBER, STREET, CITY, ADDRESS_STATE, ZIP
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
	SELECT uid._Id, FNAME, MNAME, LNAME, CAN_STATUS, EMAIL, PHONE_NUMBER, STREET, CITY, ADDRESS_STATE, ZIP
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
	
	SELECT uid._Id, FNAME, MNAME, LNAME, CAN_STATUS, EMAIL, PHONE_NUMBER, STREET, CITY, ADDRESS_STATE, ZIP
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

	-- 		SELECT uid._Id, EMAIL, PHONE_NUMBER, STREET, CITY, ADDRESS_STATE, ZIP

	DECLARE @Contact TABLE(_Id int, EMAIL varchar(50), PHONE_NUMBER varchar(20), TYPE varchar(15), STREET varchar(40), City varchar(40), ADDRESS_STATE varchar(40), ZIP varchar(10))
	INSERT INTO @Contact EXEC ContactSelect @Type, @Value

	SELECT uid._Id, FNAME, MNAME, LNAME, CAN_STATUS, EMAIL, PHONE_NUMBER, STREET, CITY, ADDRESS_STATE, ZIP
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

GO
/****** Object:  StoredProcedure [dbo].[MasterCandidate]    Script Date: 9/8/2017 9:07:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, create a Candidate entity for database use>
-- =============================================
CREATE PROCEDURE CandidateUpdate
	-- Add the parameters for the stored procedure here
	(
	@UniqueID__Id   int,
	@Identifier		varchar(40),
	@FName			varchar(30),
	@MName			varchar(30) = '',
	@LName			varchar(30),
	@Status			varchar(20),

	@Email			varchar(50),

	@Phone			varchar(20) = '',
	@PType			varchar(15),

	@Street			varchar(40),
	@City			varchar(40),
	@State			varchar(40),
	@Zip			varchar(10)
	)
AS

 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

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

			EXEC ContactUpdate @UniqueID__Id, @Email, @Phone, @PType, @Street, @City, @State, @Zip

END
GO


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
CREATE PROCEDURE FacilitySelect
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
	SELECT uid._Id, NAME, Parent__Id, (SELECT NAME FROM Facility WHERE UniqueID__Id = fac.Parent__Id) AS 'Parent NAME', cv.EMAIL, cv.PHONE_NUMBER, cv.STREET, cv.CITY, cv.ADDRESS_STATE, cv.ZIP
		FROM Facility AS fac
		 LEFT JOIN  UniqueID AS uid
			 ON fac.UniqueID__Id = uid._Id
		 LEFT JOIN ContactView cv
		     ON fac.UniqueID__Id = cv._Id
		WHERE uid._Id = CONVERT(INT, @value);
	END
	ELSE IF (@Type = 'Name')
	BEGIN		
	SELECT uid._Id, fac.NAME, Parent__Id, (SELECT NAME FROM Facility WHERE UniqueID__Id = fac.Parent__Id) AS 'Parent NAME', cv.EMAIL, cv.PHONE_NUMBER, cv.STREET, cv.CITY, cv.ADDRESS_STATE, cv.ZIP
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

	SELECT uid._Id, NAME, Parent__Id, (SELECT NAME FROM Facility WHERE UniqueID__Id = fac.Parent__Id) AS 'Parent', cv.EMAIL, cv.PHONE_NUMBER, cv.STREET, cv.CITY, cv.ADDRESS_STATE, cv.ZIP
		FROM Facility AS fac
		 LEFT JOIN  UniqueID AS uid
			 ON fac.UniqueID__Id = uid._Id
		 LEFT JOIN ContactView cv
		     ON fac.UniqueID__Id = cv._Id
		WHERE fac.Parent__Id = @Parent;
	END
	ELSE 
	BEGIN

	-- 		SELECT uid._Id, EMAIL, PHONE_NUMBER, pv.TYPE, STREET, CITY, ADDRESS_STATE, ZIP

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


GO
/****** Object:  StoredProcedure [dbo].[FacilityInsert]    Script Date: 9/8/2017 9:55:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, create a facility entity for database use>
-- =============================================
CREATE PROCEDURE FacilityInsert
	-- Add the parameters for the stored procedure here
	(
	@UniqueID__Id   int,
	@Identifier		varchar(40),
	@Name			varchar(60) = '',
	@Parent			varchar(60) = '',

	@Email			varchar(50) = '',

	@Phone			varchar(20) = '',
	@PType			varchar(15),

	@Street			varchar(40) = '',
	@City			varchar(40) = '',
	@State			varchar(40) = '',
	@Zip			varchar(10) = ''
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @Parent_Id AS int = NULL

	IF (@Parent IS NOT NULL)
	BEGIN
		SET @Parent_Id = (SELECT TOP 1 UniqueID__Id FROM Facility WHERE NAME LIKE '%' + @Parent + '%')
	END

	INSERT INTO UniqueID (IDENTIFIER) values (@Identifier);
	SET @UniqueID__Id =  @@IDENTITY;

	INSERT INTO facility (UniqueID__Id,NAME, Parent__Id) values (@UniqueID__Id, @Name, @Parent_Id);

	EXEC ContactInsert @UniqueID__Id, @Email, @Phone, @PType, @Street, @City, @State, @Zip

END

GO
/****** Object:  StoredProcedure [dbo].[FacilityDelete]    Script Date: 9/8/2017 9:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, delete a facility entity for database use>
-- =============================================
CREATE PROCEDURE FacilityDelete
	-- Add the parameters for the stored procedure here
	(
	@_Id		    int
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		
		IF ((SELECT Parent__Id FROM Facility WHERE Parent__Id = @_Id) > 0)
	BEGIN
		UPDATE Facility SET Parent__Id = null WHERE Parent__Id = @_Id
	END

		EXEC ContactDelete @_Id;

		DELETE FROM JobOrder WHERE Facility__Id = @_Id;
		DELETE FROM Contact  WHERE ContactFor__Id = @_Id;

		DELETE FROM Facility WHERE UniqueID__Id = @_Id;
	END




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
	@State			varchar(40),
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
				SET @Parent__Id = (SELECT TOP 1 UniqueID__Id FROM Facility WHERE NAME LIKE '%' + @Parent + '%')
			END

		UPDATE UniqueID SET IDENTIFIER = @Identifier
			WHERE _Id = @UniqueID__Id;


		UPDATE facility SET 
			NAME = @Name,
			Parent__Id = @Parent__Id
			WHERE UniqueID__Id = @UniqueID__Id;

			EXEC ContactUpdate @UniqueID__Id, @Email, @Phone, @PType, @Street, @City, @State, @Zip

END



	GO
/****** Object:  StoredProcedure [dbo].[MasterCandidate]    Script Date: 9/8/2017 9:07:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Nels Quinlog>
-- Create date: <Create Date,,9/5/2017>
-- Description:	<Description,, Delete a Submission entity for database use>
--				<Simple solution to SubmissionView delete.>
-- =============================================
CREATE PROCEDURE SubmissionViewDelete
	-- Add the parameters for the stored procedure here
	(
	    @_Id			int
	)
AS
 BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		
		DELETE FROM Submission WHERE UniqueID__Id = @_Id;
END




-- End of file.

