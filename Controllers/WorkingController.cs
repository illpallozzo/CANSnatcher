using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CANSnatcher.Controllers
{
    public class WorkingController : Controller
    {
        // GET: Working
        [Authorize]
        public ActionResult Index()
        {
            // place user information start page here

            return View();
        }
    }
}