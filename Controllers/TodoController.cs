using Microsoft.AspNetCore.Mvc;
using TodoApp.Models;

namespace TodoApp.Controllers
{
    public class TodoController : Controller
    {
        private readonly AppDbContext _context;

        public TodoController(AppDbContext context)
        {
            _context = context;
        }

        // Show all todos
        public IActionResult Index()
        {
            var items = _context.TodoItems.ToList();
            return View(items);
        }

        // Add new todo
        [HttpPost]
        public IActionResult Add(string title)
        {
            if (!string.IsNullOrEmpty(title))
            {
                _context.TodoItems.Add(new TodoItem { Title = title });
                _context.SaveChanges();
            }
            return RedirectToAction("Index");
        }

        // Delete todo
        public IActionResult Delete(int id)
        {
            var item = _context.TodoItems.Find(id);
            if (item != null)
            {
                _context.TodoItems.Remove(item);
                _context.SaveChanges();
            }
            return RedirectToAction("Index");
        }
    }
}