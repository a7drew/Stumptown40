using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Website.Infrastructure;
using Website.Models;

namespace Website.Controllers
{
	public class MatchesController : Controller
	{
		private Stumptown40Entities ctx;

		public MatchesController()
		{
			this.ctx = EntityFactory.GetDataContext();
		}

		public ActionResult Index(int id)
		{
			var model = (from a in this.ctx.Matches
			             join b in this.ctx.Racers on a.Racer1Id equals (int?)b.RacerId into racer1
			             join c in this.ctx.Racers on a.Racer2Id equals (int?)c.RacerId into racer2
			             join d in this.ctx.Racers on a.WinningRacerId equals (int?)d.RacerId into winningRacer
			             where a.RoundId == id
			             from r1 in racer1.DefaultIfEmpty(null)
						 from r2 in racer2.DefaultIfEmpty(null)
						 from w in winningRacer.DefaultIfEmpty(null)
						 orderby a.Cluster, a.RaceNumber
						 select new
			                    	{
			                    		a.MatchId,
			                    		a.RaceNumber,
			                    		Racer1 = new
			                    		         	{
														RacerId = (r1 == null) ? 0 : r1.RacerId,
			                    		         		Name = (r1 == null) ? "" : r1.Name
			                    		         	},
			                    		Racer2 = new
			                    		         	{
			                    		         		RacerId = (r2 == null) ? 0 : r2.RacerId,
			                    		         		Name = (r2 == null) ? "" : r2.Name
			                    		         	},
										Winner = new
			                    		         	{
			                    		         		RacerId = (w == null) ? 0 : w.RacerId,
			                    		         		Name = (w == null) ? "" : w.Name
			                    		         	}
			                    	}).ToList();

			// return Json(model, JsonRequestBehavior.AllowGet);

			return new JsonpResult
			{
				Data = model, 
				JsonRequestBehavior = JsonRequestBehavior.AllowGet
			};
		}

		public ActionResult Header(int id)
		{
			var round = this.ctx.Rounds.Single(r => r.RoundId == id);

			var model = new
			            	{
								round.RoundId,
								round.RoundNumber,
								round.BracketId
			            	};
			
			//return Json(model, JsonRequestBehavior.AllowGet);

			return new JsonpResult
			{
				Data = model, 
				JsonRequestBehavior = JsonRequestBehavior.AllowGet
			};
		}

		public ActionResult Detail(int id)
		{
			var model = (from a in this.ctx.Matches
			             join b in this.ctx.Racers on a.Racer1Id equals (int?)b.RacerId into racer1
			             join c in this.ctx.Racers on a.Racer2Id equals (int?)c.RacerId into racer2
			             join d in this.ctx.Racers on a.WinningRacerId equals (int?)d.RacerId into winningRacer
			             where a.MatchId == id
			             from r1 in racer1.DefaultIfEmpty(null)
						 from r2 in racer2.DefaultIfEmpty(null)
						 from w in winningRacer.DefaultIfEmpty(null)
						 select new
			                    	{
			                    		a.MatchId,
			                    		a.RaceNumber,
                                        a.RoundId,
                                        a.Cluster,
                                        a.Round.RoundNumber,
			                    		Racer1 = new
			                    		         	{
														RacerId = (r1 == null) ? 0 : r1.RacerId,
			                    		         		Name = (r1 == null) ? "" : r1.Name
			                    		         	},
			                    		Racer2 = new
			                    		         	{
			                    		         		RacerId = (r2 == null) ? 0 : r2.RacerId,
			                    		         		Name = (r2 == null) ? "" : r2.Name
			                    		         	},
										Winner = new
			                    		         	{
			                    		         		RacerId = (w == null) ? 0 : w.RacerId,
			                    		         		Name = (w == null) ? "" : w.Name
			                    		         	}
			                    	}).Single();

			//return Json(model, JsonRequestBehavior.AllowGet);

			return new JsonpResult
			{
				Data = model, 
				JsonRequestBehavior = JsonRequestBehavior.AllowGet
			};
		}

		[HttpPost]
		public ActionResult Update(int matchId, int winningRacerId, int losingRacerId)
		{
			var match = this.ctx.Matches.Single(m => m.MatchId == matchId);
			match.WinningRacerId = winningRacerId;

			if (match.NextMatchId != null)
			{
				var nextMatch = this.ctx.Matches.Single(m => m.MatchId == match.NextMatchId);

				if (IsLastMatchPointingToNextMatch(match, nextMatch))
				{
					nextMatch.Racer2Id = winningRacerId;
				}
				else
				{
					nextMatch.Racer1Id = winningRacerId;
				}
			}

			if (match.RoundId == 1)
			{
				// TODO: Add this racer to the losing bracket
			}

			this.ctx.SaveChanges();

			var model = new { result = "OK" };
			//return Json(model, JsonRequestBehavior.AllowGet);

			return new JsonpResult
			{
				Data = model, 
				JsonRequestBehavior = JsonRequestBehavior.AllowGet
			};
		}

		[HttpGet]
		public ActionResult Setup()
        {
            ClearMatches();
            MapMatches();
            AssignPlayers();

            var model = new {Result="Races have been setup."};
			//return Json(model, JsonRequestBehavior.AllowGet);

			return new JsonpResult
			{
				Data = model, 
				JsonRequestBehavior = JsonRequestBehavior.AllowGet
			};
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

        private void AssignPlayers()
        {
            var racers = this.ctx.Racers.ToList();

            var round1Matches = this.ctx.Matches.Where(m => m.Round.BracketId == 1 && m.Round.RoundNumber == 1).ToList();
            var x = 0;
            foreach (var match in round1Matches)
            {
                match.Racer1Id = racers[x].RacerId;
                x++;
                match.Racer2Id = racers[x].RacerId;
                x++;
            }

        	for (int cluster = 1; cluster < 5; cluster++)
        	{
        		var round2Matches = this.ctx.Matches.Where(m => m.Round.BracketId == 1 && m.Round.RoundNumber == 2 && m.Cluster == cluster).ToList();

        		foreach (var match in round2Matches)
        		{
					if (match.RaceNumber % 2 == 0)
					{
						match.Racer1Id = racers[x].RacerId;
						x++;
						match.Racer2Id = racers[x].RacerId;
						x++;
					}
					else
					{
						match.Racer1Id = racers[x].RacerId;
						x++;
					}
        		}
        	}

        	this.ctx.SaveChanges();
        }

        private void MapMatches()
        {
            var matches = this.ctx.Matches.ToList();

            for (int c = 1; c < 5; c++)
            {
                MapNextMatch(matches, 1, c, 1, c, 1);
                MapNextMatch(matches, 1, c, 2, c, 3);
                MapNextMatch(matches, 1, c, 3, c, 5);
                MapNextMatch(matches, 1, c, 4, c, 7);
                                               
                MapNextMatch(matches, 2, c, 1, c, 1);
                MapNextMatch(matches, 2, c, 2, c, 1);
                MapNextMatch(matches, 2, c, 3, c, 2);
                MapNextMatch(matches, 2, c, 4, c, 2);
                MapNextMatch(matches, 2, c, 5, c, 3);
                MapNextMatch(matches, 2, c, 6, c, 3);
                MapNextMatch(matches, 2, c, 7, c, 4);
                MapNextMatch(matches, 2, c, 8, c, 4);
                                               
                MapNextMatch(matches, 3, c, 1, c, 1);
                MapNextMatch(matches, 3, c, 2, c, 1);
                MapNextMatch(matches, 3, c, 3, c, 2);
                MapNextMatch(matches, 3, c, 4, c, 2);
                                               
                MapNextMatch(matches, 4, c, 1, c, 1);
                MapNextMatch(matches, 4, c, 2, c, 1);
            }

            MapNextMatch(matches, 5, 1, 1, 1, 1);
            MapNextMatch(matches, 5, 2, 1, 1, 1);
            MapNextMatch(matches, 5, 3, 1, 1, 2);
            MapNextMatch(matches, 5, 4, 1, 1, 2);

            MapNextMatch(matches, 6, 1, 1, 1, 1);
            MapNextMatch(matches, 6, 1, 2, 1, 1);

        	this.ctx.SaveChanges();
        }

        private void MapNextMatch(List<Match> matches, int roundId, int cluster, int raceNumber, int nextCluster, int nextRaceNumber)
        {
            var match = matches.Single(m => m.RoundId == roundId
                && m.RaceNumber == raceNumber
                && m.Cluster == cluster);

            var nextMatch = matches.Single(m => m.RoundId == (roundId + 1)
                                                && m.Cluster == nextCluster
                                                && m.RaceNumber == nextRaceNumber);

            match.NextMatchId = nextMatch.MatchId;
        }

		private bool IsLastMatchPointingToNextMatch(Match match, Match nextMatch)
		{
			var lastMatchPointingToNextMatch =
				this.ctx.Matches
				.Where(m => m.NextMatchId == nextMatch.MatchId)
				.OrderBy(m => m.RaceNumber)
				.ToList()
				.Last();

			return (lastMatchPointingToNextMatch.MatchId == match.MatchId);
		}
	}
}
