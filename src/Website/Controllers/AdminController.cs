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

            ClearMatches();

            // RandomizePlayers();

            AssignPlayers();

            return RedirectToAction("Index", "Home");
        }

        private void ClearMatches()
		{
			var list = this.ctx.Matches.ToList();

			foreach (var match in list)
			{
				match.Racer1Id = null;
				match.Racer2Id = null;
				match.WinningRacerId = null;
			}

			this.ctx.SaveChanges();
		}

        private void RandomizePlayers()
        {
            var racers = this.ctx.Racers.OrderBy(r => r.RacerId).ToList();

            var rnd = new Random();
            int carsAssigned = 0;
            foreach (var racer in racers)
            {
                int randomStartSlot = rnd.Next(1, 80);

                while (racers.Any(r => r.StartSlot == randomStartSlot))
                {
                    randomStartSlot = rnd.Next(1, 81);
                }

                racer.StartSlot = randomStartSlot;
                carsAssigned = racers.Count(r => r.StartSlot > 0);
            }

            this.ctx.SaveChanges();
        }

        private void AssignPlayers()
        {
            var racers = this.ctx.Racers.OrderBy(r => r.StartSlot).ToList();

			var matches = this.ctx.Matches.Where(m => m.MatchId < 49).OrderBy(m => m.MatchId).ToList();

        	int racerIndex = 0;

        	foreach (var match in matches)
        	{
        		if (!this.ctx.Matches.Any(m => m.NextWinningMatchId == match.MatchId && m.NextWinningMatchSlot == 1))
        		{
        			match.Racer1Id = racers[racerIndex].RacerId;
        			racerIndex++;
        		}

				if (!this.ctx.Matches.Any(m => m.NextWinningMatchId == match.MatchId && m.NextWinningMatchSlot == 2))
        		{
        			match.Racer2Id = racers[racerIndex].RacerId;
        			racerIndex++;
        		}
        	}

        	this.ctx.SaveChanges();
        }
    }
}
