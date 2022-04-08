using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using StoreFront.UI.MVC.Models;
using StoreFront.UI.MVC.Controllers;

namespace StoreFront.UI.MVC.Controllers
{
    public class ShoppingCartController : Controller
    {
        // GET: ShoppingCart -- Generate this View with the List template for CartItemViewModel objects (No data context)
        public ActionResult Index()
        {
            //Pull session cart into a local variable, which we can then pass to the View
            var shoppingCart = (Dictionary<int, CartItemViewModel>)Session["cart"];

            if (shoppingCart == null || shoppingCart.Count == 0)
            {
                //User either hasn't put anything in the cart, removed all cart items, or session expired...
                //Set the cart to an empty cart object (we can still send that to the View, UNLIKE a NULL value)
                shoppingCart = new Dictionary<int, CartItemViewModel>();

                //Create a message informing them about the empty cart
                ViewBag.Message = "There are no items in your cart.";
            }
            else
            {
                ViewBag.Message = null;//Explicitly clears out that ViewBag variable
            }

            return View(shoppingCart);
        }


        public ActionResult RemoveFromCart(int id)
        {
            Dictionary<int, CartItemViewModel> shoppingCart = (Dictionary<int, CartItemViewModel>)Session["cart"];
            shoppingCart.Remove(id);
            if (shoppingCart.Count == 0)
            {
                Session["cart"] = null;
            }
            return RedirectToAction("Index");
        }

        public ActionResult UpdateCart(int productID, int qty)
        {
            if (qty == 0)
            {
                RemoveFromCart(productID);
                return RedirectToAction("Index");
            }
            Dictionary<int, CartItemViewModel> shoppingCart = (Dictionary<int, CartItemViewModel>)Session["cart"];
            shoppingCart[productID].Qty = qty;
            Session["cart"] = shoppingCart;
            if (shoppingCart.Count == 0)
            {
                ViewBag.Message = "There are no products in your cart";
            }
            return RedirectToAction("Index");
        }

    }
}