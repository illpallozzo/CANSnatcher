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
    using System.ComponentModel.DataAnnotations;

    public partial class JobOrderView
    {
        [Key]
        public int C_Id { get; set; }
        public string TITLE { get; set; }
        public Nullable<decimal> RATE { get; set; }
        public System.DateTime JO_START_DATE { get; set; }
        public string JO_STATUS { get; set; }
        public string JO_DESCRIPTION { get; set; }
        public int Facility__Id { get; set; }
        public string Facility_NAME { get; set; }
    }
}