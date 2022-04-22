using PagedList;
using StoreFront.DATA.EF;
using StoreFront.UI.MVC.Models;
using StoreFront.UI.MVC.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace StoreFront.UI.MVC.Controllers
{
    public class ProductsController : Controller
    {
        private StorefrontEntities db = new StorefrontEntities();

        // GET: Products
        public ActionResult Index()
        {
            var products = db.Products.Include(p => p.Category).Include(p => p.StockStatu);
            return View(products.ToList());
        }

        //// GET: Products/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        #region AddToCart()
        [HttpPost]
        public ActionResult AddToCart(int qty, int productID)
        {
            Dictionary<int, CartItemViewModel> shoppingCart = null;

            if (Session["cart"] != null)
            {
                shoppingCart = (Dictionary<int, CartItemViewModel>)Session["cart"];
            }
            else
            {
                shoppingCart = new Dictionary<int, CartItemViewModel>();
            }

            Product shopProduct = db.Products.Where(b => b.ProductID == productID).FirstOrDefault();

            if (shopProduct == null)
            {
                return RedirectToAction("Index");
            }
            else
            {
                CartItemViewModel item = new CartItemViewModel(qty, shopProduct);

                if (shoppingCart.ContainsKey(shopProduct.ProductID))
                {
                    shoppingCart[shopProduct.ProductID].Qty += qty;
                }
                else
                {
                    shoppingCart.Add(shopProduct.ProductID, item);
                }
                Session["cart"] = shoppingCart;
            }
            return RedirectToAction("Index", "ShoppingCart");
        }

        #endregion

        // GET: Products/Create
        [Authorize(Roles = "Admin")]
        public ActionResult Create()
        {
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName");
            ViewBag.StockStatusID = new SelectList(db.StockStatus, "StockStatusID", "StockStatusID");
            return View();
        }

        // POST: Products/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ProductID,ProductName,CategoryID,Price,Description,StockStatusID,ProductImage")] Product product, HttpPostedFileBase productImage)
        {
            if (ModelState.IsValid)
            {
                #region File Upload

                string file = "noImage.jpg";

                if (productImage != null)
                {
                    file = productImage.FileName;

                    string ext = file.Substring(file.LastIndexOf('.'));


                    string[] goodExts = { ".jpeg", ".jpg", ".png", ".gif" };

                    //Check that the uploaded file ext is in our list of acceptable extensions
                    //and chekc that the file size <= 4MB, which is the default maximum for ASP.NET

                    if (goodExts.Contains(ext.ToLower()) && productImage.ContentLength <= 4194304)
                    {
                        //Create a new file name (using a GUID)
                        file = Guid.NewGuid() + ext;

                        #region Resize Image

                        string savePath = Server.MapPath("~/Content/imgs/");

                        Image convertedImage = Image.FromStream(productImage.InputStream);

                        int maxImageSize = 1000;

                        int maxThumbSize = 225;

                        ImageUtility.ResizeImage(savePath, file, convertedImage, maxImageSize, maxThumbSize);

                        #endregion
                    }

                    //No matter what, update the PhotoUrl with the value of the file variable
                    product.ProductImage = file;
                }

                #endregion
                db.Products.Add(product);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", product.CategoryID);
            ViewBag.StockStatusID = new SelectList(db.StockStatus, "StockStatusID", "StockStatusID", product.StockStatusID);
            return View(product);
        }

        // GET: Products/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", product.CategoryID);
            ViewBag.StockStatusID = new SelectList(db.StockStatus, "StockStatusID", "StockStatusID", product.StockStatusID);
            return View(product);
        }

        // POST: Products/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ProductID,ProductName,CategoryID,Price,Description,StockStatusID,ProductImage")] Product product, HttpPostedFileBase productImage)
        {
            if (ModelState.IsValid)
            {
                #region File Upload

                //Check to see if a new file has been uploaded. If not, the HiddenFor()
                //in the view will maintain the original value
                string file = "noImage.jpg";

                //If a file has been uploaded
                if (productImage != null)
                {
                    //Get the name
                    file = productImage.FileName;

                    //Capture the extension
                    string ext = file.Substring(file.LastIndexOf('.'));

                    //Create a "whitelist" of accepted extensions
                    string[] goodExts = { ".jpeg", ".jpg", ".png", ".gif" };

                    //Check that the uploaded file ext is in our list of acceptable extensions
                    //and that the file size is <= 4MB

                    if (goodExts.Contains(ext.ToLower()) && productImage.ContentLength <= 4194304)
                    {
                        //Create a new file name (using a GUID)
                        file = Guid.NewGuid() + ext;

                        #region Resize Image

                        string savePath = Server.MapPath("~/Content/imgs/");

                        Image convertedImage = Image.FromStream(productImage.InputStream);

                        int maxImageSize = 1000;

                        int maxThumbSize = 225;

                        ImageUtility.ResizeImage(savePath, file, convertedImage, maxImageSize, maxThumbSize);

                        #endregion

                        if (product.ProductImage != null && product.ProductImage != "noImage.jpg")
                        {
                            string path = Server.MapPath("~/Content/imgs/");
                            ImageUtility.Delete(path, product.ProductImage);
                        }
                        //Update the property of the object
                        product.ProductImage = file;
                    }

                }

                #endregion
                db.Entry(product).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", product.CategoryID);
            ViewBag.StockStatusID = new SelectList(db.StockStatus, "StockStatusID", "StockStatusID", product.StockStatusID);
            return View(product);
        }

        //// GET: Products/Delete/5
        //public ActionResult Delete(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    Product product = db.Products.Find(id);
        //    if (product == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(product);
        //}

        //////// POST: Products/Delete/5
        //[HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        //public ActionResult DeleteConfirmed(int id)
        //{
        //    Product product = db.Products.Find(id);

        //    string path = Server.MapPath("~/Content/imgs/");
        //    ImageUtility.Delete(path, product.ProductImage);
        //    db.Products.Remove(product);
        //    db.SaveChanges();
        //    return RedirectToAction("Index");
        //}

        //protected override void Dispose(bool disposing)
        //{
        //    if (disposing)
        //    {
        //        db.Dispose();
        //    }
        //    base.Dispose(disposing);
        //}



        #region AJAX CRUD 
        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult AjaxDelete(int id)
        {
            Product product = db.Products.Find(id);

            string path = Server.MapPath("~/Content/imgs/");
            ImageUtility.Delete(path, product.ProductImage);
            db.Products.Remove(product);
            db.SaveChanges();

            string confirmMessage = string.Format("Deleted Product '{0}' from the store.", product.ProductName);
            return Json(new { id, message = confirmMessage }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public PartialViewResult ProductDetails(int id)
        {
            Product product = db.Products.Find(id);
            return PartialView(product);

            //Create Partial View (PublisherDetails.cshtml)
            // - Template: Details
            // - Model Class: Publisher
            // - Data Context Class: BookStoreEntities
            // - Check "Create as Partial View" checkbox
            // - Minor tweaks to the View content
        }

        #endregion

       

    }
}
