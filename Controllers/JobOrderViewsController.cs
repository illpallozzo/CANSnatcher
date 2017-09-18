using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using CANSnatcher;
using CANSnatcher.Models;

namespace CANSnatcher.Controllers
{
    [Authorize(Roles = "Admin, Recruiter")]
    public class JobOrderViewsController : Controller
    {
        private CANSnatcherEntities db = new CANSnatcherEntities();

        // GET: JobOrderViews
        public ActionResult Index()
        {
            return View(db.JobOrderViews.ToList());
        }

        // GET: JobOrderViews/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            JobOrderView jobOrderView = db.JobOrderViews.Find(id);
            if (jobOrderView == null)
            {
                return HttpNotFound();
            }
            return View(jobOrderView);
        }

        //// GET: JobOrderViews/Create
        //public ActionResult Create()
        //{
        //    return View();
        //}

        //// POST: JobOrderViews/Create
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Create([Bind(Include = "C_Id,TITLE,RATE,JO_START_DATE,JO_STATUS,JO_DESCRIPTION,Facility__Id,Facility_NAME")] JobOrderView jobOrderView)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.JobOrderViews.Add(jobOrderView);
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }

        //    return View(jobOrderView);
        //}

        //// GET: JobOrderViews/Edit/5
        //public ActionResult Edit(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    JobOrderView jobOrderView = db.JobOrderViews.Find(id);
        //    if (jobOrderView == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(jobOrderView);
        //}

        //// POST: JobOrderViews/Edit/5
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Edit([Bind(Include = "C_Id,TITLE,RATE,JO_START_DATE,JO_STATUS,JO_DESCRIPTION,Facility__Id,Facility_NAME")] JobOrderView jobOrderView)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.Entry(jobOrderView).State = EntityState.Modified;
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }
        //    return View(jobOrderView);
        //}
        
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
