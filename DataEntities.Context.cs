﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CANSnatcher
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class CANSnatcherEntities : DbContext
    {
        public CANSnatcherEntities()
            : base("name=CANSnatcherEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<AccessLog> AccessLogs { get; set; }
        public virtual DbSet<AppUser> AppUsers { get; set; }
        public virtual DbSet<AspNetRole> AspNetRoles { get; set; }
        public virtual DbSet<AspNetUserClaim> AspNetUserClaims { get; set; }
        public virtual DbSet<AspNetUserLogin> AspNetUserLogins { get; set; }
        public virtual DbSet<AspNetUser> AspNetUsers { get; set; }
        public virtual DbSet<Attribute> Attributes { get; set; }
        public virtual DbSet<Candidate> Candidates { get; set; }
        public virtual DbSet<Contact> Contacts { get; set; }
        public virtual DbSet<Email> Emails { get; set; }
        public virtual DbSet<Facility> Facilities { get; set; }
        public virtual DbSet<JobOrder> JobOrders { get; set; }
        public virtual DbSet<Note> Notes { get; set; }
        public virtual DbSet<Person> People { get; set; }
        public virtual DbSet<Phone> Phones { get; set; }
        public virtual DbSet<Setting> Settings { get; set; }
        public virtual DbSet<Street_Address> Street_Address { get; set; }
        public virtual DbSet<Submission> Submissions { get; set; }
        public virtual DbSet<UniqueID> UniqueIDs { get; set; }
        public virtual DbSet<AddressView> AddressViews { get; set; }
        public virtual DbSet<CandidateView> CandidateViews { get; set; }
        public virtual DbSet<ContactView> ContactViews { get; set; }
        public virtual DbSet<FacilityView> FacilityViews { get; set; }
        public virtual DbSet<JobOrderView> JobOrderViews { get; set; }
        public virtual DbSet<PhoneView> PhoneViews { get; set; }
        public virtual DbSet<SubmissionView> SubmissionViews { get; set; }
        public virtual DbSet<UserView> UserViews { get; set; }
    
        public virtual int CandidateDelete(Nullable<int> p_Id)
        {
            var p_IdParameter = p_Id.HasValue ?
                new ObjectParameter("_Id", p_Id) :
                new ObjectParameter("_Id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("CandidateDelete", p_IdParameter);
        }
    
        public virtual int CandidateInsert(Nullable<int> uniqueID__Id, string identifier, string fName, string mName, string lName, string status, string email, string phone, string pType, string street, string city, string state, string zip)
        {
            var uniqueID__IdParameter = uniqueID__Id.HasValue ?
                new ObjectParameter("UniqueID__Id", uniqueID__Id) :
                new ObjectParameter("UniqueID__Id", typeof(int));
    
            var identifierParameter = identifier != null ?
                new ObjectParameter("Identifier", identifier) :
                new ObjectParameter("Identifier", typeof(string));
    
            var fNameParameter = fName != null ?
                new ObjectParameter("FName", fName) :
                new ObjectParameter("FName", typeof(string));
    
            var mNameParameter = mName != null ?
                new ObjectParameter("MName", mName) :
                new ObjectParameter("MName", typeof(string));
    
            var lNameParameter = lName != null ?
                new ObjectParameter("LName", lName) :
                new ObjectParameter("LName", typeof(string));
    
            var statusParameter = status != null ?
                new ObjectParameter("Status", status) :
                new ObjectParameter("Status", typeof(string));
    
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            var phoneParameter = phone != null ?
                new ObjectParameter("Phone", phone) :
                new ObjectParameter("Phone", typeof(string));
    
            var pTypeParameter = pType != null ?
                new ObjectParameter("PType", pType) :
                new ObjectParameter("PType", typeof(string));
    
            var streetParameter = street != null ?
                new ObjectParameter("Street", street) :
                new ObjectParameter("Street", typeof(string));
    
            var cityParameter = city != null ?
                new ObjectParameter("City", city) :
                new ObjectParameter("City", typeof(string));
    
            var stateParameter = state != null ?
                new ObjectParameter("State", state) :
                new ObjectParameter("State", typeof(string));
    
            var zipParameter = zip != null ?
                new ObjectParameter("Zip", zip) :
                new ObjectParameter("Zip", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("CandidateInsert", uniqueID__IdParameter, identifierParameter, fNameParameter, mNameParameter, lNameParameter, statusParameter, emailParameter, phoneParameter, pTypeParameter, streetParameter, cityParameter, stateParameter, zipParameter);
        }
    
        public virtual ObjectResult<CandidateSelect_Result> CandidateSelect(string type, string value)
        {
            var typeParameter = type != null ?
                new ObjectParameter("Type", type) :
                new ObjectParameter("Type", typeof(string));
    
            var valueParameter = value != null ?
                new ObjectParameter("Value", value) :
                new ObjectParameter("Value", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<CandidateSelect_Result>("CandidateSelect", typeParameter, valueParameter);
        }
    
        public virtual int CandidateUpdate(Nullable<int> uniqueID__Id, string identifier, string fName, string mName, string lName, string status, string email, string phone, string pType, string street, string city, string aDDRESS_STATE, string zip)
        {
            var uniqueID__IdParameter = uniqueID__Id.HasValue ?
                new ObjectParameter("UniqueID__Id", uniqueID__Id) :
                new ObjectParameter("UniqueID__Id", typeof(int));
    
            var identifierParameter = identifier != null ?
                new ObjectParameter("Identifier", identifier) :
                new ObjectParameter("Identifier", typeof(string));
    
            var fNameParameter = fName != null ?
                new ObjectParameter("FName", fName) :
                new ObjectParameter("FName", typeof(string));
    
            var mNameParameter = mName != null ?
                new ObjectParameter("MName", mName) :
                new ObjectParameter("MName", typeof(string));
    
            var lNameParameter = lName != null ?
                new ObjectParameter("LName", lName) :
                new ObjectParameter("LName", typeof(string));
    
            var statusParameter = status != null ?
                new ObjectParameter("Status", status) :
                new ObjectParameter("Status", typeof(string));
    
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            var phoneParameter = phone != null ?
                new ObjectParameter("Phone", phone) :
                new ObjectParameter("Phone", typeof(string));
    
            var pTypeParameter = pType != null ?
                new ObjectParameter("PType", pType) :
                new ObjectParameter("PType", typeof(string));
    
            var streetParameter = street != null ?
                new ObjectParameter("Street", street) :
                new ObjectParameter("Street", typeof(string));
    
            var cityParameter = city != null ?
                new ObjectParameter("City", city) :
                new ObjectParameter("City", typeof(string));
    
            var aDDRESS_STATEParameter = aDDRESS_STATE != null ?
                new ObjectParameter("ADDRESS_STATE", aDDRESS_STATE) :
                new ObjectParameter("ADDRESS_STATE", typeof(string));
    
            var zipParameter = zip != null ?
                new ObjectParameter("Zip", zip) :
                new ObjectParameter("Zip", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("CandidateUpdate", uniqueID__IdParameter, identifierParameter, fNameParameter, mNameParameter, lNameParameter, statusParameter, emailParameter, phoneParameter, pTypeParameter, streetParameter, cityParameter, aDDRESS_STATEParameter, zipParameter);
        }
    
        public virtual int ContactDelete(Nullable<int> p_Id)
        {
            var p_IdParameter = p_Id.HasValue ?
                new ObjectParameter("_Id", p_Id) :
                new ObjectParameter("_Id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("ContactDelete", p_IdParameter);
        }
    
        public virtual int ContactInsert(Nullable<int> p_Id, string email, string phone, string pType, string street, string city, string state, string zip)
        {
            var p_IdParameter = p_Id.HasValue ?
                new ObjectParameter("p_Id", p_Id) :
                new ObjectParameter("p_Id", typeof(int));
    
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            var phoneParameter = phone != null ?
                new ObjectParameter("Phone", phone) :
                new ObjectParameter("Phone", typeof(string));
    
            var pTypeParameter = pType != null ?
                new ObjectParameter("PType", pType) :
                new ObjectParameter("PType", typeof(string));
    
            var streetParameter = street != null ?
                new ObjectParameter("Street", street) :
                new ObjectParameter("Street", typeof(string));
    
            var cityParameter = city != null ?
                new ObjectParameter("City", city) :
                new ObjectParameter("City", typeof(string));
    
            var stateParameter = state != null ?
                new ObjectParameter("State", state) :
                new ObjectParameter("State", typeof(string));
    
            var zipParameter = zip != null ?
                new ObjectParameter("Zip", zip) :
                new ObjectParameter("Zip", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("ContactInsert", p_IdParameter, emailParameter, phoneParameter, pTypeParameter, streetParameter, cityParameter, stateParameter, zipParameter);
        }
    
        public virtual ObjectResult<ContactSelect_Result> ContactSelect(string type, string value)
        {
            var typeParameter = type != null ?
                new ObjectParameter("Type", type) :
                new ObjectParameter("Type", typeof(string));
    
            var valueParameter = value != null ?
                new ObjectParameter("Value", value) :
                new ObjectParameter("Value", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<ContactSelect_Result>("ContactSelect", typeParameter, valueParameter);
        }
    
        public virtual int ContactUpdate(Nullable<int> p_Id, string email, string phone, string pType, string street, string city, string state, string zip)
        {
            var p_IdParameter = p_Id.HasValue ?
                new ObjectParameter("p_Id", p_Id) :
                new ObjectParameter("p_Id", typeof(int));
    
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            var phoneParameter = phone != null ?
                new ObjectParameter("Phone", phone) :
                new ObjectParameter("Phone", typeof(string));
    
            var pTypeParameter = pType != null ?
                new ObjectParameter("PType", pType) :
                new ObjectParameter("PType", typeof(string));
    
            var streetParameter = street != null ?
                new ObjectParameter("Street", street) :
                new ObjectParameter("Street", typeof(string));
    
            var cityParameter = city != null ?
                new ObjectParameter("City", city) :
                new ObjectParameter("City", typeof(string));
    
            var stateParameter = state != null ?
                new ObjectParameter("State", state) :
                new ObjectParameter("State", typeof(string));
    
            var zipParameter = zip != null ?
                new ObjectParameter("Zip", zip) :
                new ObjectParameter("Zip", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("ContactUpdate", p_IdParameter, emailParameter, phoneParameter, pTypeParameter, streetParameter, cityParameter, stateParameter, zipParameter);
        }
    
        public virtual int FacilityDelete(Nullable<int> p_Id)
        {
            var p_IdParameter = p_Id.HasValue ?
                new ObjectParameter("_Id", p_Id) :
                new ObjectParameter("_Id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("FacilityDelete", p_IdParameter);
        }
    
        public virtual int FacilityInsert(Nullable<int> uniqueID__Id, string identifier, string name, string parent, string email, string phone, string pType, string street, string city, string state, string zip)
        {
            var uniqueID__IdParameter = uniqueID__Id.HasValue ?
                new ObjectParameter("UniqueID__Id", uniqueID__Id) :
                new ObjectParameter("UniqueID__Id", typeof(int));
    
            var identifierParameter = identifier != null ?
                new ObjectParameter("Identifier", identifier) :
                new ObjectParameter("Identifier", typeof(string));
    
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            var parentParameter = parent != null ?
                new ObjectParameter("Parent", parent) :
                new ObjectParameter("Parent", typeof(string));
    
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            var phoneParameter = phone != null ?
                new ObjectParameter("Phone", phone) :
                new ObjectParameter("Phone", typeof(string));
    
            var pTypeParameter = pType != null ?
                new ObjectParameter("PType", pType) :
                new ObjectParameter("PType", typeof(string));
    
            var streetParameter = street != null ?
                new ObjectParameter("Street", street) :
                new ObjectParameter("Street", typeof(string));
    
            var cityParameter = city != null ?
                new ObjectParameter("City", city) :
                new ObjectParameter("City", typeof(string));
    
            var stateParameter = state != null ?
                new ObjectParameter("State", state) :
                new ObjectParameter("State", typeof(string));
    
            var zipParameter = zip != null ?
                new ObjectParameter("Zip", zip) :
                new ObjectParameter("Zip", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("FacilityInsert", uniqueID__IdParameter, identifierParameter, nameParameter, parentParameter, emailParameter, phoneParameter, pTypeParameter, streetParameter, cityParameter, stateParameter, zipParameter);
        }
    
        public virtual ObjectResult<FacilitySelect_Result> FacilitySelect(string type, string value)
        {
            var typeParameter = type != null ?
                new ObjectParameter("type", type) :
                new ObjectParameter("type", typeof(string));
    
            var valueParameter = value != null ?
                new ObjectParameter("value", value) :
                new ObjectParameter("value", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<FacilitySelect_Result>("FacilitySelect", typeParameter, valueParameter);
        }
    
        public virtual int FacilityUpdate(Nullable<int> uniqueID__Id, string identifier, string name, string parent, string email, string phone, string pType, string street, string city, string state, string zip)
        {
            var uniqueID__IdParameter = uniqueID__Id.HasValue ?
                new ObjectParameter("UniqueID__Id", uniqueID__Id) :
                new ObjectParameter("UniqueID__Id", typeof(int));
    
            var identifierParameter = identifier != null ?
                new ObjectParameter("Identifier", identifier) :
                new ObjectParameter("Identifier", typeof(string));
    
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            var parentParameter = parent != null ?
                new ObjectParameter("Parent", parent) :
                new ObjectParameter("Parent", typeof(string));
    
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            var phoneParameter = phone != null ?
                new ObjectParameter("Phone", phone) :
                new ObjectParameter("Phone", typeof(string));
    
            var pTypeParameter = pType != null ?
                new ObjectParameter("PType", pType) :
                new ObjectParameter("PType", typeof(string));
    
            var streetParameter = street != null ?
                new ObjectParameter("Street", street) :
                new ObjectParameter("Street", typeof(string));
    
            var cityParameter = city != null ?
                new ObjectParameter("City", city) :
                new ObjectParameter("City", typeof(string));
    
            var stateParameter = state != null ?
                new ObjectParameter("State", state) :
                new ObjectParameter("State", typeof(string));
    
            var zipParameter = zip != null ?
                new ObjectParameter("Zip", zip) :
                new ObjectParameter("Zip", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("FacilityUpdate", uniqueID__IdParameter, identifierParameter, nameParameter, parentParameter, emailParameter, phoneParameter, pTypeParameter, streetParameter, cityParameter, stateParameter, zipParameter);
        }
    
        public virtual ObjectResult<MasterUser_Result> MasterUser(Nullable<int> uniqueID__Id, string identifier, string fName, string mName, string lName, Nullable<int> uLevel, string statementType, Nullable<int> user)
        {
            var uniqueID__IdParameter = uniqueID__Id.HasValue ?
                new ObjectParameter("UniqueID__Id", uniqueID__Id) :
                new ObjectParameter("UniqueID__Id", typeof(int));
    
            var identifierParameter = identifier != null ?
                new ObjectParameter("Identifier", identifier) :
                new ObjectParameter("Identifier", typeof(string));
    
            var fNameParameter = fName != null ?
                new ObjectParameter("FName", fName) :
                new ObjectParameter("FName", typeof(string));
    
            var mNameParameter = mName != null ?
                new ObjectParameter("MName", mName) :
                new ObjectParameter("MName", typeof(string));
    
            var lNameParameter = lName != null ?
                new ObjectParameter("LName", lName) :
                new ObjectParameter("LName", typeof(string));
    
            var uLevelParameter = uLevel.HasValue ?
                new ObjectParameter("ULevel", uLevel) :
                new ObjectParameter("ULevel", typeof(int));
    
            var statementTypeParameter = statementType != null ?
                new ObjectParameter("StatementType", statementType) :
                new ObjectParameter("StatementType", typeof(string));
    
            var userParameter = user.HasValue ?
                new ObjectParameter("User", user) :
                new ObjectParameter("User", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<MasterUser_Result>("MasterUser", uniqueID__IdParameter, identifierParameter, fNameParameter, mNameParameter, lNameParameter, uLevelParameter, statementTypeParameter, userParameter);
        }
    
        public virtual ObjectResult<Nullable<int>> UserIdSearch(string id)
        {
            var idParameter = id != null ?
                new ObjectParameter("Id", id) :
                new ObjectParameter("Id", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<int>>("UserIdSearch", idParameter);
        }
    
        public virtual int SubmissionViewDelete(Nullable<int> p_Id)
        {
            var p_IdParameter = p_Id.HasValue ?
                new ObjectParameter("_Id", p_Id) :
                new ObjectParameter("_Id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("SubmissionViewDelete", p_IdParameter);
        }
    }
}
