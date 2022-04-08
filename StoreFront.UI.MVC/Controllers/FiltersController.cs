using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using PagedList;
using StoreFront.DATA.EF;

namespace StoreFront.UI.MVC.Controllers
{
    public class FiltersController : Controller
    {
        private StorefrontEntities db = new StorefrontEntities();

        // GET: Filters
        public ActionResult Index()
        {
            var products = db.Products.Include(p => p.Category).Include(p => p.StockStatu);
            return View(products.ToList());
        }

        public ActionResult ProductQS(string searchFilter)//Parameter name matches the textbox name
        {
            #region Optional Search Filter

            //Check if the searchFilter string was provided/has content
            if (String.IsNullOrEmpty(searchFilter))
            {
                //If optional search isn't used, return all records
                var products = db.Products;
                return View(products.ToList());
            }
            else
            {
                //If the optional search is used, then filter the results by those
                //criteria (compare to first or last name and ignore casing concerns)

                //v1 LINQ Method/Lambda Syntax
                string searchLowCase = searchFilter.ToLower();

                List<Product> searchResults = db.Products.Where(
                    p => p.ProductName.ToLower().Contains(searchLowCase)).ToList();

                return View(searchResults);

            }

            #endregion

        }

        public ActionResult ProductPaging(string searchFilter, int page = 1)
        {
            int pageSize = 5;

            ViewBag.SearchFilter = new SelectList(db.Products.Select(x => x.Category.CategoryName).Distinct());

            if (String.IsNullOrEmpty(searchFilter))
            {
                var products = db.Products.OrderBy(p => p.ProductName).ToList();
                return View(products.ToPagedList(page, pageSize));
            }
            else
            {
                string searchLowCase = searchFilter.ToLower();

                List<Product> searchResults = db.Products.Where(
                    p => p.ProductName.ToLower().Contains(searchLowCase)).ToList();
                return View(searchResults);
            }
        }
    }
}
