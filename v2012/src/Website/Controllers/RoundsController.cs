using System.Linq;
using System.Web.Mvc;
using Website.Infrastructure;
using Website.Models;

namespace Website.Controllers
{
    public class RoundsController : Controller
    {
        private Stumptown40Entities ctx;

    	public RoundsController()
    	{
    		this.ctx = EntityFactory.GetDataContext();
    	}

        public ActionResult Index(int id)
        {
            var model = this.ctx.Rounds
                .Where(r => r.BracketId == id)
                .OrderBy(r => r.RoundNumber)
                .Select(r => new
                                 {
                                     r.RoundId,
                                     r.RoundNumber,
									 IsDone = r.Matches.All(m => m.WinningRacerId.HasValue)
                                 });

			//return Json(model, JsonRequestBehavior.AllowGet);

			return new JsonpResult
			{
				Data = model, 
				JsonRequestBehavior = JsonRequestBehavior.AllowGet
			};
        }
    }
}
