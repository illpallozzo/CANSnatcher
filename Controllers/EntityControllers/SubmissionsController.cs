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
    public class SubmissionsController : Controller
    {
        private CANSnatcherEntities db = new CANSnatcherEntities();

        // GET: Submissions
        public ActionResult Index()
        {
            return RedirectToAction("Index", "SubmissionViews");
        }

        //// GET: Submissions/Details/5
        //public ActionResult Details(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    Submission submission = db.Submissions.Find(id);
        //    if (submission == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(submission);
        //}

        // GET: Submissions/Create
        public ActionResult Create(int jo, int can)
        {
            Submission submission = new Submission();
            submission.Candidate__Id = can;
            submission.JobOrder__Id = jo;

            ViewBag.SubmissionBy__Id = new SelectList(db.UserViews , "C_Id", "LNAME");
            ViewBag.Candidate__Id = new SelectList(db.CandidateViews , "C_Id", "LNAME", submission.Candidate__Id);
            ViewBag.JobOrder__Id = new SelectList(db.JobOrderViews , "C_Id", "TITLE", submission.JobOrder__Id);
            return View();
        }

        // POST: Submissions/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "JobOrder__Id,Candidate__Id,SubmissionBy__Id,SUBMISSION_DATE,BILL_RATE")] Submission submission)
        {
            
            if (ModelState.IsValid)
            {
                string identifier = ("Submission" + submission.JobOrder__Id.ToString() + submission.Candidate__Id.ToString() + submission.SubmissionBy__Id.ToString() );
                UniqueID uni = new UniqueID();
                uni.IDENTIFIER = identifier;
                db.UniqueIDs.Add(uni);
                db.SaveChanges();
                submission.UniqueID__Id = uni.C_Id;
                db.Submissions.Add(submission);
                db.SaveChanges();
                return RedirectToAction("Index", "SubmissionViews");
            }

            ViewBag.SubmissionBy__Id = new SelectList(db.UserViews, "C_Id", "LNAME", submission.SubmissionBy__Id);
            ViewBag.Candidate__Id = new SelectList(db.CandidateViews, "C_Id", "LNAME", submission.Candidate__Id);
            ViewBag.JobOrder__Id = new SelectList(db.JobOrderViews, "C_Id", "TITLE", submission.JobOrder__Id);
            return View(submission);
        }

        //// GET: Submissions/Edit/5
        //public ActionResult Edit(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    Submission submission = db.Submissions.Find(id);
        //    if (submission == null)
        //    {
        //        return HttpNotFound();
        //    }

        //    //ViewBag.SubmissionBy__Id = new SelectList(db.UserViews, "C_Id", "LNAME", submission.SubmissionBy__Id);
        //    ViewBag.Candidate__Id = new SelectList(db.CandidateViews, "C_Id", "LNAME", submission.Candidate__Id);
        //    ViewBag.JobOrder__Id = new SelectList(db.JobOrderViews, "C_Id", "TITLE", submission.JobOrder__Id);
        //    return View(submission);
        //}

        //// POST: Submissions/Edit/5
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Edit([Bind(Include = "UniqueID__Id,JobOrder__Id,Candidate__Id,SubmissionBy__Id,timestamp,SUBMISSION_DATE,BILL_RATE")] Submission submission)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.Entry(submission).State = EntityState.Modified;
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }
        //    //ViewBag.SubmissionBy__Id = new SelectList(db.UserViews, "C_Id", "LNAME", submission.SubmissionBy__Id);
        //    ViewBag.Candidate__Id = new SelectList(db.CandidateViews, "C_Id", "LNAME", submission.Candidate__Id);
        //    ViewBag.JobOrder__Id = new SelectList(db.JobOrderViews, "C_Id", "TITLE", submission.JobOrder__Id);
        //    return View(submission);
        //}

        //// GET: Submissions/Delete/5
        //public ActionResult Delete(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    SubmissionView submission = db.SubmissionViews.Find(id);
        //    if (submission == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(submission);
        //}

        //// POST: Submissions/Delete/5
        //[HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        //public ActionResult DeleteConfirmed(int id)
        //{
        //    Submission submission = db.Submissions.Find(id);
        //    db.Submissions.Remove(submission);
        //    db.SaveChanges();
        //    return RedirectToAction("Index");
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
