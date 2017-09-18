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
    public class SubmissionViewsController : Controller
    {
        private CANSnatcherEntities db = new CANSnatcherEntities();

        // GET: SubmissionViews
        public ActionResult Index()
        {
            return View(db.SubmissionViews.ToList());
        }

        //// GET: SubmissionViews/Details/5
        //public ActionResult Details(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    SubmissionView submissionView = db.SubmissionViews.Find(id);
        //    if (submissionView == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(submissionView);
        //}

        //// GET: SubmissionViews/Create
        //public ActionResult Create()
        //{
        //    return View();
        //}

        //// POST: SubmissionViews/Create
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Create([Bind(Include = "UniqueID__Id,LNAME,FNAME,Facility_NAME,JO_START_DATE,SUBMISSION_DATE,RATE,BILL_RATE,JO_STATUS,JO_DESCRIPTION")] SubmissionView submissionView)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.SubmissionViews.Add(submissionView);
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }

        //    return View(submissionView);
        //}

        //// GET: SubmissionViews/Edit/5
        //public ActionResult Edit(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    SubmissionView submissionView = db.SubmissionViews.Find(id);
        //    if (submissionView == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(submissionView);
        //}

        //// POST: SubmissionViews/Edit/5
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Edit([Bind(Include = "UniqueID__Id,LNAME,FNAME,Facility_NAME,JO_START_DATE,SUBMISSION_DATE,RATE,BILL_RATE,JO_STATUS,JO_DESCRIPTION")] SubmissionView submissionView)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.Entry(submissionView).State = EntityState.Modified;
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }
        //    return View(submissionView);
        //}

        // GET: SubmissionViews/Delete/5
        [Authorize(Roles = "Admin")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SubmissionView submissionView = db.SubmissionViews.SingleOrDefault(m => m.UniqueID__Id == id);
            if (submissionView == null)
            {
                return HttpNotFound();
            }
            return View(submissionView);
        }

        // POST: SubmissionViews/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            SubmissionView submissionView = db.SubmissionViews.SingleOrDefault(m => m.UniqueID__Id == id);
            db.SubmissionViewDelete(id);
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
