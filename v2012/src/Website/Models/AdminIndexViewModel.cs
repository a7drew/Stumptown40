using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Website.Models
{
	public class AdminIndexViewModel
	{
		public AdminIndexViewModel()
		{
			this.MatchStats = new List<MatchStat>();
		}

		public DateTime FirstRaceDate { get; set; }
		public DateTime LastRaceDate { get; set; }
		public DateTime EstimatedEndDate { get; set; }
		public int LastMatchId { get; set; }
		public double MatchesPercentComplete { get; set; }
		public double CurrentAverageSecondsPerRace { get; set; }
		public List<MatchStat> MatchStats { get; set; }
	}

	public class MatchStat
	{
		public int MatchId { get; set; }
		public double SecondsAfterLastRace { get; set; }
	}
}