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
    
    public partial class Note
    {
        public int UniqueID__Id { get; set; }
        public int Taker__Id { get; set; }
        public byte[] timestamp { get; set; }
        public int Noted__Id { get; set; }
        public string NOTE1 { get; set; }
        public bool SHARED { get; set; }
    
        public virtual AppUser AppUser { get; set; }
        public virtual UniqueID UniqueID { get; set; }
        public virtual UniqueID UniqueID1 { get; set; }
    }
}