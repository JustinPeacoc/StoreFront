using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StoreFront.DATA.EF
{
    class StoreFrontMetadata
    {
        public class ProductMetaData
        {

            //public int ProductID { get; set; }
            [Required(ErrorMessage = "*")]
            [StringLength(50, ErrorMessage = "*Cannot exceed 50 characters")]
            [Display(Name = "Product")]
            public string ProductName { get; set; }
            public int CategoryID { get; set; }
            [Range(0, double.MaxValue, ErrorMessage = "*Must be a valid number, 0 or larger")]
            [DisplayFormat(DataFormatString = "{0:c}")]
            public Nullable<decimal> Price { get; set; }
            [UIHint("MultilineText")]
            public string Description { get; set; }
            [Required(ErrorMessage = "*")]
            public int StockStatusID { get; set; }
            [Display(Name = "Image")]
            public string ProductImage { get; set; }
        }

        [MetadataType(typeof(ProductMetaData))]
        public partial class Product { }

        public class CategoryMetadata
        {
            //public int CategoryID { get; set; }
            [Required(ErrorMessage = "*")]
            [Display(Name = "Category")]
            [StringLength(20, ErrorMessage = "*Cannot exceed 20 characters")]
            public string CategoryName { get; set; }
        }

        [MetadataType(typeof(CategoryMetadata))]
        public partial class Category { }

        public class DepartmentMetadata
        {
            //public int DepartmentID { get; set; }
            [Required(ErrorMessage = "*")]
            [Display(Name = "Department")]
            [StringLength(20, ErrorMessage = "Cannot exceed 20 characters")]
            public string DepartmentName { get; set; }
        }

        [MetadataType(typeof(DepartmentMetadata))]
        public partial class Department { }

        public class EmployeeMetadata
        {
            //public int EmployeeID { get; set; }
            [Required(ErrorMessage = "*")]
            [StringLength(20, ErrorMessage = "* Cannot exceed 20 characters.")]
            [Display(Name = "First Name")]
            public string EmployeeFName { get; set; }
            [Required(ErrorMessage = "*")]
            [StringLength(20, ErrorMessage = "* Cannot exceed 20 characters")]
            [Display(Name = "Last Name")]
            public string EmployeeLName { get; set; }
            [Required(ErrorMessage = "*")]
            [DisplayFormat(DataFormatString = "{0:d}", ApplyFormatInEditMode = true)]
            public System.DateTime DateOfHire { get; set; }
            [DisplayFormat(DataFormatString = "{0:d}", ApplyFormatInEditMode = true)]
            public Nullable<System.DateTime> ExitDate { get; set; }
            public int DepartmentID { get; set; }
            public Nullable<int> DirectReportID { get; set; }
        }

        [MetadataType(typeof(EmployeeMetadata))]
        public partial class Employee
        {
            [Display(Name = "Employee")]
            public string FullName
            {
                get { string EmployeeFName = null; return EmployeeFName + " " + EmployeeFName; }
            }
        }

        public class StockStatusMetadata
        {
            //public int StockStatusID { get; set; }
            [Display(Name = "In Stock")]
            [StringLength(20, ErrorMessage = "*Must be 20 characters or less")]
            public string InStock { get; set; }
        }

        [MetadataType(typeof(StockStatusMetadata))]
        public partial class StockStatus { }

    }
}

