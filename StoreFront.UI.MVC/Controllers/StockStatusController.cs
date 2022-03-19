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
    public class StockStatusController : Controller
    {
        private StorefrontEntities db = new StorefrontEntities();

        // GET: StockStatus
        [Authorize(Roles = "Admin")]
        public ActionResult Index()
        {
            return View(db.StockStatus1.ToList());
        }

        // GET: StockStatus/Details/5
        [Authorize(Roles = "Admin")]
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StockStatus stockStatus = db.StockStatus1.Find(id);
            if (stockStatus == null)
            {
                return HttpNotFound();
            }
            return View(stockStatus);
        }

        // GET: StockStatus/Create
        [Authorize(Roles = "Admin")]
        public ActionResult Create()
        {
            return View();
        }

        // POST: StockStatus/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize(Roles = "Admin")]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "StockStatusID,InStock")] StockStatus stockStatus)
        {
            if (ModelState.IsValid)
            {
                db.StockStatus1.Add(stockStatus);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(stockStatus);
        }

        // GET: StockStatus/Edit/5
        [Authorize(Roles = "Admin")]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StockStatus stockStatus = db.StockStatus1.Find(id);
            if (stockStatus == null)
            {
                return HttpNotFound();
            }
            return View(stockStatus);
        }

        // POST: StockStatus/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize(Roles = "Admin")]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "StockStatusID,InStock")] StockStatus stockStatus)
        {
            if (ModelState.IsValid)
            {
                db.Entry(stockStatus).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(stockStatus);
        }

        // GET: StockStatus/Delete/5
        [Authorize(Roles = "Admin")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StockStatus stockStatus = db.StockStatus1.Find(id);
            if (stockStatus == null)
            {
                return HttpNotFound();
            }
            return View(stockStatus);
        }

        // POST: StockStatus/Delete/5
        [Authorize(Roles = "Admin")]
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            StockStatus stockStatus = db.StockStatus1.Find(id);
            db.StockStatus1.Remove(stockStatus);
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
