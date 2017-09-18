using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using CANSnatcher;

namespace CANSnatcher.Controllers.EntityControllers
{
    [Authorize (Roles = "Admin, Recruiter") ]
    public class CandidateSelect_ResultController : Controller
    {
        private CANSnatcherEntities db = new CANSnatcherEntities();

        // GET: CandidateSelect_Result/
        public ActionResult Index()
        {
            return RedirectToAction("Index", "CandidateViews");
        }

        // GET: CandidateSelect_Result/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            CandidateSelect_Result candidateSelect_Result = db.CandidateSelect("_Id", id.ToString()).First();
            if (candidateSelect_Result == null)
            {
                return HttpNotFound();
            }
            return View(candidateSelect_Result);
        }

        // GET: CandidateSelect_Result/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: CandidateSelect_Result/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "C_Id,FNAME,MNAME,LNAME,CAN_STATUS,EMAIL,PHONE_NUMBER,STREET,CITY,ADDRESS_STATE,ZIP")] CandidateSelect_Result candidateSelect_Result)
        {
            if (ModelState.IsValid)
            {
                string identifier = "" + (candidateSelect_Result.C_Id.ToString() + candidateSelect_Result.FNAME + candidateSelect_Result.LNAME);
                db.CandidateInsert(
                    candidateSelect_Result.C_Id,
                    identifier                  ,
                    candidateSelect_Result.FNAME,
                    candidateSelect_Result.MNAME,
                    candidateSelect_Result.LNAME,
                    candidateSelect_Result.CAN_STATUS,
                    candidateSelect_Result.EMAIL,
                    candidateSelect_Result.PHONE_NUMBER,
                    "default"                   ,
                    candidateSelect_Result.STREET,
                    candidateSelect_Result.CITY,
                    candidateSelect_Result.ADDRESS_STATE,
                    candidateSelect_Result.ZIP
                    );
                db.SaveChanges();
                return RedirectToAction("Index", "CandidateViews");
            }

            return View(candidateSelect_Result);
        }

        // GET: CandidateSelect_Result/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CandidateSelect_Result candidateSelect_Result = db.CandidateSelect("_Id", id.ToString()).First();
            if (candidateSelect_Result == null)
            {
                return HttpNotFound();
            }
            return View(candidateSelect_Result);
        }

        // POST: CandidateSelect_Result/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "C_Id,FNAME,MNAME,LNAME,CAN_STATUS,EMAIL,PHONE_NUMBER,STREET,CITY,COUNTY,ZIP")] CandidateSelect_Result candidateSelect_Result)
        {
            if (ModelState.IsValid)
            {
                string identifier = "Updated" + (candidateSelect_Result.C_Id.ToString() + candidateSelect_Result.FNAME + candidateSelect_Result.LNAME);

                db.CandidateUpdate(
                    candidateSelect_Result.C_Id,
                    identifier                   ,
                    candidateSelect_Result.FNAME,
                    candidateSelect_Result.MNAME,
                    candidateSelect_Result.LNAME,
                    candidateSelect_Result.CAN_STATUS,
                    candidateSelect_Result.EMAIL,
                    candidateSelect_Result.PHONE_NUMBER,
                    "default"                   ,
                    candidateSelect_Result.STREET,
                    candidateSelect_Result.CITY,
                    candidateSelect_Result.ADDRESS_STATE,
                    candidateSelect_Result.ZIP
                    );
                db.SaveChanges();
                return RedirectToAction("Index", "CandidateViews");
            }
            return View(candidateSelect_Result);
        }

        // GET: CandidateSelect_Result/Delete/5
        [Authorize (Roles = "Admin")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CandidateSelect_Result candidateSelect_Result = db.CandidateSelect("_Id",id.ToString()).First();
            if (candidateSelect_Result == null)
            {
                return HttpNotFound();
            }
            return View(candidateSelect_Result);
        }

        // POST: CandidateSelect_Result/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            db.CandidateDelete(id);
            db.SaveChanges();
            return RedirectToAction("Index", "CandidateViews");
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
