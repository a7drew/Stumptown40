using System.Web.Mvc;

namespace Website.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
			this.HttpContext.Response.Redirect("/index.htm");
        	return null;
        }
    }
}
