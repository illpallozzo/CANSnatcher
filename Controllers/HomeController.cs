using CANSnatcher.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CANSnatcher.Controllers
{
    [RequireHttps]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.MessageLeft = "Check out our job as a Deck Swabber. For more information talk to our recruiters today!";
            ViewBag.MessageRight = "Adding CRITICAL Access Network to your recruiting pool is easy. For more information contact onboarding or register for more information.";
            ViewBag.MessageCenter = "Are you a doctor looking to spend a vacation helping internationally? Try our next international position for your next getaway.";

            return View();
        }

        public ActionResult About()
        {
            var model = new AboutModel();
            model.Name = "CRITICAL Access Network";
            model.Location = "Somewhere in Florida, USA";

            return View(model);
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}