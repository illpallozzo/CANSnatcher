using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using CANSnatcher;

namespace CANSnatcher.Controllers.EntityControllers
{
    [Authorize(Roles = "Admin, Recruiter")]
    public class FacilityViewsController : Controller
    {
        private CANSnatcherEntities db = new CANSnatcherEntities();

        // GET: FacilityViews
        public ActionResult Index()
        {
            return View(db.FacilityViews.ToList());
        }

        // GET: FacilityViews/Create
        public ActionResult Create()
        {
            return RedirectToAction("Create", "FacilitySelect_Results");
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
