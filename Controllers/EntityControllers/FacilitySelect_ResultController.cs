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
    public class FacilitySelect_ResultController : Controller
    {
        private CANSnatcherEntities db = new CANSnatcherEntities();

        // GET: FacilitySelect_Result
        public ActionResult Index()
        {
            return RedirectToAction("Index", "FacilityViews");
        }

        // GET: FacilitySelect_Result/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FacilitySelect_Result facilitySelect_Result = db.FacilitySelect("_Id", id.ToString()).First();
            if (facilitySelect_Result == null)
            {
                return HttpNotFound();
            }
            return View(facilitySelect_Result);
        }

        // GET: FacilitySelect_Result/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: FacilitySelect_Result/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "C_Id,NAME,Parent__Id,Parent_NAME,EMAIL,PHONE_NUMBER,STREET,CITY,ADDRESS_STATE,ZIP")] FacilitySelect_Result facilitySelect_Result)
        {
            if (ModelState.IsValid)
            {
                string identifier = "facility" + (facilitySelect_Result.C_Id.ToString() + facilitySelect_Result.NAME + facilitySelect_Result.CITY);

                db.FacilityInsert(
                    facilitySelect_Result.C_Id,
                    identifier                ,
                    facilitySelect_Result.NAME,
                    facilitySelect_Result.Parent_NAME,
                    facilitySelect_Result.EMAIL,
                    facilitySelect_Result.PHONE_NUMBER,
                    "default"                  ,
                    facilitySelect_Result.STREET,
                    facilitySelect_Result.CITY,
                    facilitySelect_Result.ADDRESS_STATE,
                    facilitySelect_Result.ZIP
                    );
            }

            return RedirectToAction("Index", "FacilityViews");
        }

        // GET: FacilitySelect_Result/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FacilitySelect_Result facilitySelect_Result = db.FacilitySelect("_Id", id.ToString()).First();
            if (facilitySelect_Result == null)
            {
                return HttpNotFound();
            }
            return View(facilitySelect_Result);
        }

        // POST: FacilitySelect_Result/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "C_Id,NAME,Parent__Id,Parent_NAME,EMAIL,PHONE_NUMBER,STREET,CITY,ADDRESS_STATE,ZIP")] FacilitySelect_Result facilitySelect_Result)
        {
            if (ModelState.IsValid)
            {
                string identifier = "UpdatedFacility" + (facilitySelect_Result.C_Id.ToString() + facilitySelect_Result.NAME + facilitySelect_Result.CITY);

                
                db.FacilityUpdate(
                    facilitySelect_Result.C_Id,
                    identifier,
                    facilitySelect_Result.NAME,
                    facilitySelect_Result.Parent_NAME,
                    facilitySelect_Result.EMAIL,
                    facilitySelect_Result.PHONE_NUMBER,
                    "default",
                    facilitySelect_Result.STREET,
                    facilitySelect_Result.CITY,
                    facilitySelect_Result.ADDRESS_STATE,
                    facilitySelect_Result.ZIP
                    );
                db.SaveChanges();
                return RedirectToAction("Index", "FacilityViews");
            }
            return RedirectToAction("Index", "FacilityViews");
        }

        // GET: FacilitySelect_Result/Delete/5
        [Authorize(Roles = "Admin")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FacilitySelect_Result facilitySelect_Result = db.FacilitySelect("_Id", id.ToString()).First();
            if (facilitySelect_Result == null)
            {
                return HttpNotFound();
            }
            return View(facilitySelect_Result);
        }

        // POST: FacilitySelect_Result/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            db.FacilityDelete(id);
            db.SaveChanges();
            return RedirectToAction("Index", "FacilityViews");
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
