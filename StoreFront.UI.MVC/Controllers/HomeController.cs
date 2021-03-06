using StoreFront.DATA.EF;
using StoreFront.UI.MVC.Models;
using StoreFront.UI.MVC.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;


namespace StoreFront.UI.MVC.Controllers
{
    public class HomeController : Controller
    {
        private StorefrontEntities db = new StorefrontEntities();
        [HttpGet]

        // GET: Products
        public ActionResult Index()
        {
           var products = db.Products.Where(p => p.Price.Value < 100).Include(p => p.Category).Include(p => p.StockStatu);
            return View(products.ToList());
        }

        [HttpGet]
        
        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";

            return View();
        }

        [HttpGet]
        public ActionResult Contact()
        {            
            return View();
        }

        [HttpPost]
        public ActionResult Contact(ContactViewModel cvm)
        {
            if (!ModelState.IsValid)
            {
                return View(cvm);
            }

            string message = $"You have received an email from {cvm.Name}.<br />" +
                $"Subject: {cvm.Subject}<br />" +
                $"Message: {cvm.Message}<br />" +
                $"Please reply to {cvm.Email} with your response at your earliest convenience.";

            //MailMessage - What sends the email
            //Overload for MailMessage - FROM, TO, SUBJECT, BODY
            MailMessage mm = new MailMessage("administrator@projectpeacock.net", "justinpeacock30@outlook.com", cvm.Subject, message);

            //MailMessage Properties
            mm.IsBodyHtml = true;
            mm.Priority = MailPriority.High;
            //Reply to the sender, and not our website/webmail
            mm.ReplyToList.Add(cvm.Email);

            //SmtpClient - Info from the host that allows emails to be sent
            SmtpClient client = new SmtpClient("mail.projectpeacock.net");

            //Client Credentials
            client.Credentials = new NetworkCredential("administrator@projectpeacock.net", "P@ssw0rd");

            //Port options -- SMTP uses two ports 25 and 8889. Test with both to determine
            //if your internet provider blocks/does not use one of these.
            //client.Port = 25;
            //client.Port = 8889;

            //Try to send the email
            try
            {
                //Attempt to send the email
                client.Send(mm);
            }
            catch (System.Exception ex)
            {

                ViewBag.CustomerMessage = $"We're sorry, but your request could not be completed at this time. " +
                    $"Please try again later. If the issue persists, please contact your site administrator and provide " +
                    $"the following info:<br />{ex.StackTrace}";
                return View(cvm);
            }

            return View("EmailConfirmation", cvm);

        }
    }
}
