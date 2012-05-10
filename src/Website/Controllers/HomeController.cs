using System.Web.Mvc;
using Website.Infrastructure;

namespace Website.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
			this.HttpContext.Response.Redirect("/index.html");
        	return null;
        }

        public ActionResult GetUrl()
        {
            var url = "#brackets";

            return new JsonpResult
            {
                Data = new { url = AppItems.FollowerUrl },
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        [HttpPost]
        public ActionResult SetUrl(string url, string pin)
        {
            var actualPin = System.Configuration.ConfigurationManager.AppSettings["pin"].ToString();

            if (pin != actualPin)
            {
                return new JsonpResult
                {
                    Data = new { result = "NOPE" },
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet
                };
            }

            if (!url.StartsWith("#"))
            {
                return new JsonpResult
                {
                    Data = new { result = "NOPE" },
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet
                };
            }

            AppItems.FollowerUrl = url;

            return new JsonpResult
            {
                Data = new { result = "OK" },
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }
    }
}
