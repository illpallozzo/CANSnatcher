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
    using System.ComponentModel.DataAnnotations;

    public partial class FacilitySelect_Result
    {
        [Key]
        public int C_Id { get; set; }
        public string NAME { get; set; }
        public Nullable<int> Parent__Id { get; set; }
        public string Parent_NAME { get; set; }
        public string EMAIL { get; set; }
        public string PHONE_NUMBER { get; set; }
        public string STREET { get; set; }
        public string CITY { get; set; }
        public string ADDRESS_STATE { get; set; }
        public string ZIP { get; set; }
    }
}
