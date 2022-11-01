using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Cooking.Models;

namespace Cooking.Controllers
{
    public class CategoryController : Controller
    {
        private readonly CookingContext _context;

        public CategoryController(CookingContext context)
        {
            _context = context;
        }

        // GET: Category
        public async Task<IActionResult> Index()
        {
            var cookingContext = _context.Category.Include(c => c.MeasureCodeNavigation).OrderBy(c => c.Name);
            return View(await cookingContext.ToListAsync());
        }

        // GET: Category/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (id == null || _context.Category == null)
            {
                return NotFound();
            }

            var category = await _context.Category
                .Include(c => c.MeasureCodeNavigation)
                .FirstOrDefaultAsync(m => m.CategoryCode == id);
            if (category == null)
            {
                return NotFound();
            }

            return View(category);
        }

        // GET: Category/Create
        public IActionResult Create()
        {
            ViewData["MeasureCode"] = new SelectList(_context.Measure, "MeasureCode", "MeasureCode");
            return View();
        }

        // POST: Category/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("CategoryCode,Name,MeasureCode")] Category category)
        {
            if (ModelState.IsValid)
            {
                _context.Add(category);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["MeasureCode"] = new SelectList(_context.Measure, "MeasureCode", "MeasureCode", category.MeasureCode);
            return View(category);
        }

        // GET: Category/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (id == null || _context.Category == null)
            {
                return NotFound();
            }

            var category = await _context.Category.FindAsync(id);
            if (category == null)
            {
                return NotFound();
            }
            ViewData["MeasureCode"] = new SelectList(_context.Measure, "MeasureCode", "MeasureCode", category.MeasureCode);
            return View(category);
        }

        // POST: Category/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, [Bind("CategoryCode,Name,MeasureCode")] Category category)
        {
            if (id != category.CategoryCode)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(category);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!CategoryExists(category.CategoryCode))
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
            ViewData["MeasureCode"] = new SelectList(_context.Measure, "MeasureCode", "MeasureCode", category.MeasureCode);
            return View(category);
        }

        // GET: Category/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (id == null || _context.Category == null)
            {
                return NotFound();
            }

            var category = await _context.Category
                .Include(c => c.MeasureCodeNavigation)
                .FirstOrDefaultAsync(m => m.CategoryCode == id);
            if (category == null)
            {
                return NotFound();
            }

            return View(category);
        }

        // POST: Category/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            if (_context.Category == null)
            {
                return Problem("Entity set 'CookingContext.Category'  is null.");
            }
            var category = await _context.Category.FindAsync(id);
            if (category != null)
            {
                _context.Category.Remove(category);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool CategoryExists(string id)
        {
          return _context.Category.Any(e => e.CategoryCode == id);
        }
    }
}
