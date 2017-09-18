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
    public class CandidateViewsController : Controller
    {
        private CANSnatcherEntities db = new CANSnatcherEntities();

        // GET: CandidateViews
        public ActionResult Index()
        {
            return View(db.CandidateViews.ToList());
        }

        // GET: CandidateView/Create
        public ActionResult Create()
        {
            return RedirectToAction("Create", "CandidateSelect_Results");

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
