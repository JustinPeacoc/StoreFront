using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using StoreFront.DATA.EF;

namespace StoreFront.UI.MVC.Models
{
    public class CartItemViewModel
    {
        [Range(1, byte.MaxValue, ErrorMessage = "*Please enter a Quantity between 1 and 255.")]
        public int Qty { get; set; }
         public Product ShopProduct { get; set; }

        public CartItemViewModel(int qty, Product shopProduct)
        {
            Qty = qty;
            ShopProduct = shopProduct;
            
        }
    }
}