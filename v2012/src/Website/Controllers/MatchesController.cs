﻿using System;
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

		/// <summary>
		///	Get list of matches by RoundId
		/// </summary>
		/// <param name="id">RoundId</param>
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
						 orderby a.RaceNumber
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

		/// <summary>
		/// Get header info for a given RoundId
		/// </summary>
		/// <param name="id">RoundId</param>
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

		/// <summary>
		/// Get a list of matches by RoundId
		/// </summary>
		/// <param name="id">RoundId</param>
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
		public ActionResult Update(int matchId, int winningRacerId, int losingRacerId, string pin)
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

			var match = this.ctx.Matches.Single(m => m.MatchId == matchId);
			match.WinningRacerId = winningRacerId;
			match.Modified = DateTime.Now;
			this.ctx.SaveChanges();

			SetNextMatch(match.NextWinningMatchId, match.NextWinningMatchSlot, winningRacerId);
			SetNextMatch(match.NextLosingMatchId, match.NextLosingMatchSlot, losingRacerId);

			var model = new { result = "OK" };
			//return Json(model, JsonRequestBehavior.AllowGet);

			return new JsonpResult
			{
				Data = model, 
				JsonRequestBehavior = JsonRequestBehavior.AllowGet
			};
		}

		private void SetNextMatch(int? nextMatchId, int? nextMatchSlot, int racerId)
		{
			if (!nextMatchId.HasValue)
				return;

			var nextMatch = this.ctx.Matches.Single(m => m.MatchId == nextMatchId.Value);

			switch (nextMatchSlot)
			{
				case 1:
					nextMatch.Racer1Id = racerId;
					break;
				case 2:
					nextMatch.Racer2Id = racerId;
					break;
			}

			this.ctx.SaveChanges();
		}
	}
}
