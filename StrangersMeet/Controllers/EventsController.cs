using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FIT5032_Assignment.Models;

namespace FIT5032_Assignment.Controllers
{
    public class EventsController : Controller
    {
        private AssignmentModelContainer db = new AssignmentModelContainer();

        // GET: Events
        public ActionResult Index()
        {
            var events = db.Events;
            //var events = db.Events.Include(@ => @.Organiser).Include(@ => @.EventType);
            return View(events.ToList());
        }

        // GET: Events/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Event @event = db.Events.Find(id);
            if (@event == null)
            {
                return HttpNotFound();
            }
            return View(@event);
        }

        // GET: Events/Create
        public ActionResult Create()
        {
            ViewBag.organiserEmail = new SelectList(db.Organisers, "organiserEmail", "password");
            ViewBag.eventTypeId = new SelectList(db.EventTypes, "eventTypeId", "eventName");
            return View();
        }

        // POST: Events/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "eventName,eventDate,eventTime,description,street,suburb,postCode,city,latitude,longitude,seatCapacity,organiserEmail,eventTypeId")] Event @event)
        {
            if (ModelState.IsValid)
            {
                db.Events.Add(@event);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.organiserEmail = new SelectList(db.Organisers, "organiserEmail", "password", @event.organiserEmail);
            ViewBag.eventTypeId = new SelectList(db.EventTypes, "eventTypeId", "eventName", @event.eventTypeId);
            return View(@event);
        }

        // GET: Events/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Event @event = db.Events.Find(id);
            if (@event == null)
            {
                return HttpNotFound();
            }
            ViewBag.organiserEmail = new SelectList(db.Organisers, "organiserEmail", "password", @event.organiserEmail);
            ViewBag.eventTypeId = new SelectList(db.EventTypes, "eventTypeId", "eventName", @event.eventTypeId);
            return View(@event);
        }

        // POST: Events/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "eventName,eventDate,eventTime,description,street,suburb,postCode,city,latitude,longitude,seatCapacity,organiserEmail,eventTypeId")] Event @event)
        {
            if (ModelState.IsValid)
            {
                db.Entry(@event).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.organiserEmail = new SelectList(db.Organisers, "organiserEmail", "password", @event.organiserEmail);
            ViewBag.eventTypeId = new SelectList(db.EventTypes, "eventTypeId", "eventName", @event.eventTypeId);
            return View(@event);
        }

        // GET: Events/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Event @event = db.Events.Find(id);
            if (@event == null)
            {
                return HttpNotFound();
            }
            return View(@event);
        }

        // POST: Events/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            Event @event = db.Events.Find(id);
            db.Events.Remove(@event);
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
