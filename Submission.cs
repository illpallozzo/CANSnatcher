//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Submission
    {
        public int UniqueID__Id { get; set; }
        public int JobOrder__Id { get; set; }
        public int Candidate__Id { get; set; }
        public int SubmissionBy__Id { get; set; }
        public byte[] timestamp { get; set; }
        public System.DateTime SUBMISSION_DATE { get; set; }
        public Nullable<decimal> BILL_RATE { get; set; }
    
        public virtual AppUser AppUser { get; set; }
        public virtual Candidate Candidate { get; set; }
        public virtual JobOrder JobOrder { get; set; }
    }
}
