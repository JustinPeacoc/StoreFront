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
            return View(db.StockStatus.ToList());
        }

        // GET: StockStatus/Details/5
        [Authorize(Roles = "Admin")]
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StockStatu stockStatu = db.StockStatus.Find(id);
            if (stockStatu == null)
            {
                return HttpNotFound();
            }
            return View(stockStatu);
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
        public ActionResult Create([Bind(Include = "StockStatusID,InStock")] StockStatu stockStatu)
        {
            if (ModelState.IsValid)
            {
                db.StockStatus.Add(stockStatu);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(stockStatu);
        }

        // GET: StockStatus/Edit/5
        [Authorize(Roles = "Admin")]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StockStatu stockStatu = db.StockStatus.Find(id);
            if (stockStatu == null)
            {
                return HttpNotFound();
            }
            return View(stockStatu);
        }

        // POST: StockStatus/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [Authorize(Roles = "Admin")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "StockStatusID,InStock")] StockStatu stockStatu)
        {
            if (ModelState.IsValid)
            {
                db.Entry(stockStatu).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(stockStatu);
        }

        // GET: StockStatus/Delete/5
        [Authorize(Roles = "Admin")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StockStatu stockStatu = db.StockStatus.Find(id);
            if (stockStatu == null)
            {
                return HttpNotFound();
            }
            return View(stockStatu);
        }

        // POST: StockStatus/Delete/5
        [Authorize(Roles = "Admin")]
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            StockStatu stockStatu = db.StockStatus.Find(id);
            db.StockStatus.Remove(stockStatu);
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
