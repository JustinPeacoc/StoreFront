using StoreFront.DATA.EF;
using System;
using System.Data.Entity;
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

        // GET: Products/Details/5
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

        // GET: Products/Create
        [Authorize(Roles = "Admin")]
        public ActionResult Create()
        {
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName");
            ViewBag.StockStatusID = new SelectList(db.StockStatus1, "StockStatusID", "StockStatusID");
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

                //Default value for the image to noImage.png
                string imageName = "noImage.jpg";

                //Check the input for the file upload and see iuf it is not null
                if (productImage != null)
                {
                    //Get the file name and save it to a variable
                    imageName = productImage.FileName;

                    //Use the file name and retrieve ONLY the extension and save it to a variable
                    string ext = imageName.Substring(imageName.LastIndexOf("."));

                    //Create a whitelist of valid extensions
                    string[] goodExts = new string[] { ".jpeg", ".jpg", ".png", ".gif" };


                    //Compare ours to the list
                    if (goodExts.Contains(ext.ToLower()))
                    {
                        imageName = Guid.NewGuid() + ext;

                        //Send this file to the web server
                        productImage.SaveAs(Server.MapPath("~/Content/imgs" + imageName));
                    }
                    else
                    {
                        //Image was Not valid
                        imageName = "noImage.jpg";
                    }

                    //No matter whether or noit the file upload actually contained a file,
                    //update the database with the current value of the filename
                    product.ProductImage = imageName;
                }

                #endregion

                db.Products.Add(product);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName");
            ViewBag.StockStatusID = new SelectList(db.StockStatus1, "StockStatusID", "StockStatusID");
            return View();
        }

        // GET: Products/Edit/5
        [Authorize(Roles = "Admin")]
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
            ViewBag.StockStatusID = new SelectList(db.StockStatus1, "StockStatusID", "StockStatusID", product.StockStatusID);
            return View(product);
        }

        // POST: Products/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [Authorize(Roles = "Admin")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ProductID,ProductName,CategoryID,Price,Description,StockStatusID,ProductImage")] Product product, HttpPostedFile productImage)
        {
            if (ModelState.IsValid)
            {
                //db.Entry(product).State = EntityState.Modified;
                //db.SaveChanges();
                //return RedirectToAction("Index");

                if (productImage != null)
                {
                    string imageName = productImage.FileName;

                    string ext = imageName.Substring(imageName.LastIndexOf("."));

                    string[] goodExts = new string[] { ".jpg", ".jpeg", ".png", ".gif" };

                    if (goodExts.Contains(ext.ToLower()))
                    {
                        imageName = Guid.NewGuid() + ext;

                        productImage.SaveAs(Server.MapPath("~/Content/imgs/" + imageName));

                        string currentFile = Request.Params["ProductImage"];
                        if (currentFile != "noImage.jpg" && currentFile != null)
                        {
                            System.IO.File.Delete(Server.MapPath("~/Content/imgs/" + currentFile));
                        }
                    }

                    product.ProductImage = imageName;
                }
                    db.Entry(product).State = EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Index");
            }
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", product.CategoryID);
            ViewBag.StockStatusID = new SelectList(db.StockStatus1, "StockStatusID", "StockStatusID", product.StockStatusID);
            return View(product);
        }

        // GET: Products/Delete/5
        [Authorize(Roles = "Admin")]
        public ActionResult Delete(int? id)
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

        // POST: Products/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Product product = db.Products.Find(id);
            db.Products.Remove(product);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
