using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Cooking.Models;
using Microsoft.AspNetCore.Http;

namespace Cooking.Controllers
{
    public class MeasureController : Controller
    {
        private readonly CookingContext _context;

        public MeasureController(CookingContext context)
        {
            _context = context;
        }

        // GET: Measure
        public async Task<IActionResult> Index(string categoryCode)
        {
            if(categoryCode != null)
            {
                // store in cookie
                Response.Cookies.Append("CategoryCode", categoryCode);
            }
            else if (Request.Query["CategoryCode"].Any())
            {
                // store in a cookie
                categoryCode = Request.Query["CategoryCode"];
                Response.Cookies.Append("CategoryCode", categoryCode);
            }
            else if (Request.Cookies["CategoryCode"] != null)
            {
                categoryCode = Request.Cookies["CategoryCode"];
            }
            else if(HttpContext.Session.GetString("CategoryCode") != null)
            {
                categoryCode = HttpContext.Session.GetString("CategoryCode");
            }
            else
            {
                TempData["message"] = "Please select one category first!!";
                return RedirectToAction("Index", "Category");
            }

            var categoryData = _context.Category.Include(o=>o.MeasureCodeNavigation).Where(c => c.CategoryCode == categoryCode).FirstOrDefault();
            var baseMeasure = categoryData.MeasureCode;
            ViewData["SName"] = categoryData.Name;
            if (baseMeasure != null)
            {
                ViewData["MName"] = categoryData.MeasureCodeNavigation.Name;
            }
            else
            {
                ViewData["MName"] = "N/A";
            }


              return View(await _context.Measure.Where(c => c.CategoryCode == categoryCode).OrderBy(c => c.Name).ToListAsync());
        }

        // GET: Measure/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (id == null || _context.Measure == null)
            {
                return NotFound();
            }

            var measure = await _context.Measure
                .FirstOrDefaultAsync(m => m.MeasureCode == id);
            if (measure == null)
            {
                return NotFound();
            }

            return View(measure);
        }

        // GET: Measure/Create
        public IActionResult Create()
        {
            string id = string.Empty;
            if (Request.Cookies["CategoryCode"] != null)
            {
                id = Request.Cookies["CategoryCode"];
            }
            else if (HttpContext.Session.GetString("CategoryCode") != null)
            {
                id = HttpContext.Session.GetString("CategoryCode");
            }
            var categoryData = _context.Category.Include(o => o.MeasureCodeNavigation).Where(c => c.CategoryCode == id).FirstOrDefault();
            ViewData["SName"] = categoryData.Name;
            
            return View();
        }

        // POST: Measure/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("MeasureCode,Name,CategoryCode,RatioToBase")] Measure measure)
        {
            string id = string.Empty;
            if (Request.Cookies["CategoryCode"] != null)
            {
                id = Request.Cookies["CategoryCode"];
            }
            else if (HttpContext.Session.GetString("CategoryCode") != null)
            {
                id = HttpContext.Session.GetString("CategoryCode");
            }
            var categoryData = _context.Category.Include(o => o.MeasureCodeNavigation).Where(c => c.CategoryCode == id).FirstOrDefault();
            ViewData["SName"] = categoryData.Name;
            measure.CategoryCode = id;
            //var codeCategory = _context.Category.Include(o => o.MeasureCode).Where(o => o.CategoryCode == id).FirstOrDefault();
            //var codeCategory = categoryData.MeasureCodeNavigation.CategoryCode;
            if (categoryData.MeasureCode == null)
            {
                if (measure.RatioToBase != 1)
                {
                    return RedirectToAction("Create", "Measure");
                }
                else
                {
                    categoryData.MeasureCode = measure.MeasureCode;
                }
            }
            if (ModelState.IsValid)
            {
                _context.Add(measure);
                await _context.SaveChangesAsync();
                TempData["message"] = "Saved successfully";
                return RedirectToAction(nameof(Index));
            }
            return View(measure);
        }

        // GET: Measure/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (id == null || _context.Measure == null)
            {
                return NotFound();
            }

            var measure = await _context.Measure.FindAsync(id);
            if (measure == null)
            {
                return NotFound();
            }
            return View(measure);
        }

        // POST: Measure/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, [Bind("MeasureCode,Name,CategoryCode,RatioToBase")] Measure measure)
        {
            if (id != measure.MeasureCode)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(measure);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!MeasureExists(measure.MeasureCode))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(measure);
        }

        // GET: Measure/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (id == null || _context.Measure == null)
            {
                return NotFound();
            }

            var measure = await _context.Measure
                .FirstOrDefaultAsync(m => m.MeasureCode == id);
            if (measure == null)
            {
                return NotFound();
            }

            return View(measure);
        }

        // POST: Measure/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            if (_context.Measure == null)
            {
                return Problem("Entity set 'CookingContext.Measure'  is null.");
            }
            var measure = await _context.Measure.FindAsync(id);
            if (measure != null)
            {
                _context.Measure.Remove(measure);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool MeasureExists(string id)
        {
          return _context.Measure.Any(e => e.MeasureCode == id);
        }
    }
}
