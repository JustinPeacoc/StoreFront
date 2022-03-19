using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using StoreFront.DATA.EF;

namespace StoreFront.UI.MVC.Controllers
{
    public class LAProductsController : Controller
    {
        private StorefrontEntities db = new StorefrontEntities();

        // GET: LAProducts
        public ActionResult Index()
        {
            var lAProducts = db.LAProducts.Include(l => l.Category).Include(l => l.StockStatu);
            return View(lAProducts.ToList());
        }

        // GET: LAProducts/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            LAProduct lAProduct = db.LAProducts.Find(id);
            if (lAProduct == null)
            {
                return HttpNotFound();
            }
            return View(lAProduct);
        }

        // GET: LAProducts/Create
        [Authorize(Roles = "Admin")]
        public ActionResult Create()
        {
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName");
            ViewBag.StockStatusID = new SelectList(db.StockStatus1, "StockStatusID", "StockStatusID");
            return View();
        }

        // POST: LAProducts/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize(Roles = "Admin")]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "LAProductID,LAProductName,CategoryID,Price,Description,StockStatusID,ProductImage")] LAProduct lAProduct, HttpPostedFileBase productImage)
        {
            if (ModelState.IsValid)
            {
                #region File Upload
         
                string imageName = "noImage.jpg";

                if (productImage != null)
                {
                    imageName = productImage.FileName;

                    string ext = imageName.Substring(imageName.LastIndexOf("."));

                    //Create a whitelist of valid extensions
                    string[] goodExts = new string[] { ".jpeg", ".jpg", ".png", ".gif" };


                    if (goodExts.Contains(ext.ToLower()))
                    {

                        imageName = Guid.NewGuid() + ext;

                        productImage.SaveAs(Server.MapPath("~/Content/imgs/" + imageName));
                    }
                    else
                    {
                        imageName = "noImage.png";
                    }

                    lAProduct.ProductImage = imageName;
                }

                #endregion

                db.LAProducts.Add(lAProduct);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", lAProduct.CategoryID);
            ViewBag.StockStatusID = new SelectList(db.StockStatus1, "StockStatusID", "StockStatusID", lAProduct.StockStatusID);
            return View(lAProduct);
        }

        // GET: LAProducts/Edit/5
        [Authorize(Roles = "Admin")]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            LAProduct lAProduct = db.LAProducts.Find(id);
            if (lAProduct == null)
            {
                return HttpNotFound();
            }
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", lAProduct.CategoryID);
            ViewBag.StockStatusID = new SelectList(db.StockStatus1, "StockStatusID", "StockStatusID", lAProduct.StockStatusID);
            return View(lAProduct);
        }

        // POST: LAProducts/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize(Roles = "Admin")]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "LAProductID,LAProductName,CategoryID,Price,Description,StockStatusID,ProductImage")] LAProduct lAProduct, HttpPostedFileBase productImage)
        {
            if (ModelState.IsValid)
            {

                #region File Upload

                if (productImage != null)
                {
                    string imageName = productImage.FileName;

                    string ext = imageName.Substring(imageName.LastIndexOf("."));

                    string[] goodExts = new string[] { ".jpeg", ".jpg", ".png", ".gif" };


                    if (goodExts.Contains(ext.ToLower()))
                    {

                        imageName = Guid.NewGuid() + ext;


                        productImage.SaveAs(Server.MapPath("~/Content/assets/images/Books/" + imageName));

                        string currentFile = Request.Params["BookImage"];
                        if (currentFile != "noImage.png" && currentFile != null)
                        {
                            System.IO.File.Delete(Server.MapPath("~/Content/assets/images/Books/" + currentFile));

                        }
                    }
                    lAProduct.ProductImage = imageName;
                }
                #endregion

                db.Entry(lAProduct).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", lAProduct.CategoryID);
            ViewBag.StockStatusID = new SelectList(db.StockStatus1, "StockStatusID", "StockStatusID", lAProduct.StockStatusID);
            return View(lAProduct);
        }

        // GET: LAProducts/Delete/5
        [Authorize(Roles = "Admin")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            LAProduct lAProduct = db.LAProducts.Find(id);
            if (lAProduct == null)
            {
                return HttpNotFound();
            }
            return View(lAProduct);
        }

        // POST: LAProducts/Delete/5
        [Authorize(Roles = "Admin")]
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            LAProduct lAProduct = db.LAProducts.Find(id);
            db.LAProducts.Remove(lAProduct);
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
