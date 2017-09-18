-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2017-08-29 21:25:48.635

DROP PROCEDURE CandidateInsert;
DROP PROCEDURE CandidateDelete;
DROP PROCEDURE CandidateUpdate;
DROP PROCEDURE CandidateSelect;
DROP PROCEDURE ContactSelect;
DROP PROCEDURE ContactUpdate;
DROP PROCEDURE ContactInsert;
DROP PROCEDURE ContactDelete;
DROP PROCEDURE FacilityDelete;
DROP PROCEDURE FacilityUpdate;
DROP PROCEDURE FacilitySelect;
DROP PROCEDURE FacilityInsert
DROP PROCEDURE SubmissionDelete;
DROP PROCEDURE MasterUser;
DROP PROCEDURE UserIdSearch;

-- views
DROP VIEW SubmissionView;

DROP VIEW JobOrderView;

DROP VIEW FacilityView;

DROP VIEW UserView;

DROP VIEW CandidateView;

DROP VIEW PhoneView;

DROP VIEW AddressView;

DROP VIEW ContactView;

-- foreign keys
ALTER TABLE AccessLog DROP CONSTRAINT AccessLog_User;

ALTER TABLE Address_holder DROP CONSTRAINT Address_holder_Address;

ALTER TABLE Address_holder DROP CONSTRAINT Address_holder_UniqueID;

ALTER TABLE Attribute DROP CONSTRAINT Attribute_Candidate;

ALTER TABLE Submission DROP CONSTRAINT Candidate_holder_Candidate;

ALTER TABLE Contact DROP CONSTRAINT Contact_Person;

ALTER TABLE Contact DROP CONSTRAINT Contact_UniqueID;

ALTER TABLE Email DROP CONSTRAINT Email_UniqueID;

ALTER TABLE Facility DROP CONSTRAINT Facility_Facility;

ALTER TABLE JobOrder DROP CONSTRAINT JobOrder_Facility;

ALTER TABLE Notes DROP CONSTRAINT Noted_UniqueID;

ALTER TABLE Notes DROP CONSTRAINT Notes_User;

ALTER TABLE Candidate DROP CONSTRAINT Person_Profile;

ALTER TABLE Phone_holder DROP CONSTRAINT Phone_holder_UniqueID;

ALTER TABLE Phone_holder DROP CONSTRAINT Phone_owner_Phone;

ALTER TABLE Settings DROP CONSTRAINT Settings_User;

ALTER TABLE Submission DROP CONSTRAINT Submission_JobOrder;

ALTER TABLE Submission DROP CONSTRAINT Submission_User;

ALTER TABLE Facility DROP CONSTRAINT UniqueID_Facility;

ALTER TABLE JobOrder DROP CONSTRAINT UniqueID_JobOrder;

ALTER TABLE Notes DROP CONSTRAINT UniqueID_Notes;

ALTER TABLE Person DROP CONSTRAINT UniqueID_Person;

 -- ALTER TABLE Submission DROP CONSTRAINT UniqueID_Submission;

ALTER TABLE AppUser DROP CONSTRAINT User_Person;

-- tables
DROP TABLE AccessLog;

DROP TABLE Address_holder;

DROP TABLE AppUser;

DROP TABLE Attribute;

DROP TABLE Candidate;

DROP TABLE Contact;

DROP TABLE Email;

DROP TABLE Facility;

DROP TABLE JobOrder;

DROP TABLE Notes;

DROP TABLE Person;

DROP TABLE Phone;

DROP TABLE Phone_holder;

DROP TABLE Settings;

DROP TABLE Street_Address;

DROP TABLE Submission;

DROP TABLE UniqueID;

-- End of file.

