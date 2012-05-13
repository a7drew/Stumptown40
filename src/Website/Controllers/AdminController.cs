using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Models;

namespace Website.Controllers
{
    public class AdminController : Controller
    {
		private Stumptown40Entities ctx;

    	public AdminController()
    	{
    		this.ctx = EntityFactory.GetDataContext();
    	}

        public ActionResult Index()
        {
			var model = new AdminIndexViewModel();

        	var matches = this.ctx.Matches.Where(m => m.WinningRacerId != null).OrderBy(m => m.MatchId).ToList();

			if (!matches.Any())
				return View(model);

        	model.FirstRaceDate = matches.First().Modified.Value;

        	var lastMatch = matches.Last();
			
			model.LastRaceDate = lastMatch.Modified.Value;
        	model.LastMatchId = lastMatch.MatchId;
        	model.MatchesPercentComplete = Math.Floor(((double)lastMatch.MatchId/(double)159)* 100);
        	
        	var lastRaceDate = model.FirstRaceDate;
        	foreach (var match in matches)
        	{
        		model.MatchStats.Add(
					new MatchStat
						{
							MatchId = match.MatchId, 
							SecondsAfterLastRace = (match.Modified.Value - lastRaceDate).TotalSeconds
						});

        		lastRaceDate = match.Modified.Value;
        	}

        	model.CurrentAverageSecondsPerRace = model.MatchStats.Average(m => m.SecondsAfterLastRace);

        	model.EstimatedEndDate = model.FirstRaceDate.AddSeconds(model.CurrentAverageSecondsPerRace*158);

        	return View(model);
        }

        public ActionResult Setup()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Setup(FormCollection form)
        {
            var c = this.HttpContext.Request.Cookies["stumptown40UserModePin"];
            var actualPin = System.Configuration.ConfigurationManager.AppSettings["pin"].ToString();

            if ((c == null) || c.Value != actualPin)
            {
                this.ViewBag.Message = "Nope.";
                return View();
            }

            return RedirectToAction("Index", "Home");
        }
    }
}
