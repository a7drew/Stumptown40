using System.Linq;
using System.Web.Mvc;
using Website.Infrastructure;
using Website.Models;

namespace Website.Controllers
{
	public class BracketsController : Controller
	{
		private Stumptown40Entities ctx;

		public BracketsController()
		{
			this.ctx = EntityFactory.GetDataContext();
		}

		public ActionResult Index()
		{
			var model = ctx.Brackets
				.Select(b => new
								 {
									 b.BracketId,
									 b.Name
								 });

			// return Json(model, JsonRequestBehavior.AllowGet);

			return new JsonpResult
			{
				Data = model, 
				JsonRequestBehavior = JsonRequestBehavior.AllowGet
			};
		}

	}
}
