//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace StoreFront.DATA.EF
{
    using System;
    using System.Collections.Generic;
    
    public partial class Employee
    {
        public int EmployeeID { get; set; }
        public string EmployeeFName { get; set; }
        public string EmployeeLName { get; set; }
        public System.DateTime DateOfHire { get; set; }
        public Nullable<System.DateTime> ExitDate { get; set; }
        public int DepartmentID { get; set; }
        public Nullable<int> DirectReportID { get; set; }
    
        public virtual Department Department { get; set; }
    }
}
