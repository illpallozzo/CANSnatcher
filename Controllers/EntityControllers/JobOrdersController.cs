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
    public class JobOrdersController : Controller
    {
        private CANSnatcherEntities db = new CANSnatcherEntities();

        // GET: JobOrders
        public ActionResult Index()
        {
            return RedirectToAction("Index", "JobOrderViews");
        }

        //// GET: JobOrders/Details/5
        //public ActionResult Details(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    JobOrder jobOrder = db.JobOrders.Find(id);
        //    if (jobOrder == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(jobOrder);
        //}

        // GET: JobOrders/Create
        public ActionResult Create(int id)
        {
            var model = new JobOrder();
            model.Facility__Id = id;

            return View(model);
        }

        // POST: JobOrders/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "TITLE,RATE,JO_START_DATE,JO_STATUS,JO_DESCRIPTION,Facility__Id")] JobOrder jobOrder)
        {
            
            if (ModelState.IsValid)
            {
                string identifier = "JobOrder" + jobOrder.Facility__Id.ToString() + jobOrder.TITLE;
                UniqueID uni = new UniqueID { IDENTIFIER = identifier };

                db.UniqueIDs.Add(uni);
                db.SaveChanges();
                jobOrder.UniqueID__Id = uni.C_Id;
                db.JobOrders.Add(jobOrder);
                db.SaveChanges();
                return RedirectToAction("Index", "JobOrderViews");
            }

            return RedirectToAction("Index", "JobOrderViews");
        }

        // GET: JobOrders/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            JobOrder jobOrder = db.JobOrders.Find(id);
            if (jobOrder == null)
            {
                return HttpNotFound();
            }
            //ViewBag.Facility__Id = new SelectList(db.Facilities, "UniqueID__Id", "NAME", jobOrder.Facility__Id);
            //ViewBag.UniqueID__Id = new SelectList(db.UniqueIDs, "C_Id", "IDENTIFIER", jobOrder.UniqueID__Id);
            return View(jobOrder);
        }

        // POST: JobOrders/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "UniqueID__Id,TITLE,RATE,JO_START_DATE,JO_STATUS,JO_DESCRIPTION,Facility__Id")] JobOrder jobOrder)
        {
            if (ModelState.IsValid)
            {
                string identifier = "updatedJobOrder" + jobOrder.Facility__Id.ToString() + jobOrder.TITLE;
                UniqueID uni = db.UniqueIDs.Find(jobOrder.UniqueID__Id);
                uni.IDENTIFIER = identifier;
                db.Entry(uni).State = EntityState.Modified;
                db.SaveChanges();

                jobOrder.JO_DESCRIPTION = jobOrder.JO_DESCRIPTION + " ";

                db.Entry(jobOrder).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(jobOrder);
        }

        // GET: JobOrders/Delete/5
        [Authorize(Roles = "Admin")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            JobOrder jobOrder = db.JobOrders.Find(id);
            if (jobOrder == null)
            {
                return HttpNotFound();
            }
            return View(jobOrder);
        }

        // POST: JobOrders/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            JobOrder jobOrder = db.JobOrders.Find(id);
            db.JobOrders.Remove(jobOrder);
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
