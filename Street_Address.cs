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
    
    public partial class Street_Address
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Street_Address()
        {
            this.UniqueIDs = new HashSet<UniqueID>();
        }
    
        public int C_Id { get; set; }
        public byte[] timestamp { get; set; }
        public string STREET { get; set; }
        public string CITY { get; set; }
        public string ADDRESS_STATE { get; set; }
        public string ZIP { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UniqueID> UniqueIDs { get; set; }
    }
}