using System.Linq;
using System.Web.Mvc;
using Website.Infrastructure;
using Website.Models;

namespace Website.Controllers
{
	public class RacersController : Controller
	{
		private Stumptown40Entities ctx;

		public RacersController()
		{
			this.ctx = EntityFactory.GetDataContext();
		}

		public ActionResult Index()
		{
			var model = this.ctx.Racers.ToList().Select(r => new
			                                                 	{
			                                                 		r.RacerId,
			                                                 		r.Name,
			                                                 		r.Organization
			                                                 	});
			//return Json(model, JsonRequestBehavior.AllowGet);

			return new JsonpResult
			{
				Data = model, 
				JsonRequestBehavior = JsonRequestBehavior.AllowGet
			};
		}

		public FileResult CarPhoto(int id)
		{
			var racerId = (id < 10) ? "0" + id.ToString() : id.ToString();
			var fileName = string.Format("/Content/Images/c{0}.jpg", racerId);

			var filePath = Server.MapPath(fileName);

			if (System.IO.File.Exists(filePath))
				return File(filePath, "image/jpg");

			return File(Server.MapPath("/content/images/c00.jpg"), "image/jpg");
		}
	}
}
