﻿using System;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Mvc;
using Dapper;
using Website.Models;

namespace Website.Controllers
{
    public class AdminController : Controller
    {
        private const string Cnn = @"Server=.\sqlexpress;Database=Stumptown40;Trusted_Connection=True;";

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public bool ClearWinningRacers()
        {
            using (var connection = new SqlConnection(Cnn))
            {
                connection.Open();
                connection.Execute("update match set winningracerid=null");
            }

            return true;
        }

        [HttpPost]
        public bool AssignSequentialStartSlots()
        {
            using (var connection = new SqlConnection(Cnn))
            {
                connection.Open();
                connection.Execute("update racer set startslot=racerId");
            }

            return true;
        }

        [HttpPost]
        public bool AssignRandomStartSlots()
        {
            using (var connection = new SqlConnection(Cnn))
            {
                connection.Open();

                connection.Execute("update racer set startslot=-1");

                var numbers = Enumerable.Range(1, 100).ToList();

                var racers = connection.Query<Racer>("select * from racer order by racerid").ToList();

                var rnd = new Random();

                foreach (var racer in racers)
                {
                    var x = rnd.Next(0, numbers.Count);
                    racer.StartSlot = numbers[x];
                    numbers.RemoveAt(x);
                    connection.Execute("update racer set startslot=@StartSlot where racerid=@RacerId", new { racer.StartSlot, racer.RacerId });
                }
            }

            return true;
        }

        [HttpPost]
        public bool AssignBracketsByStartSlot()
        {
            using (var connection = new SqlConnection(Cnn))
            {
                connection.Open();

                var racers = connection.Query<Racer>("select * from racer order by startslot").ToList();

                var matches1 = connection.Query<Match>("select * from match where roundid=1 order by matchid").ToList();

                var racerIndex = 0;

                foreach (var match in matches1)
                {
                    if (!matches1.Any(m => m.NextWinningMatchId == match.MatchId && m.NextWinningMatchSlot == 1))
                    {
                        var racer1Id = racers[racerIndex].RacerId;
                        match.Racer1Id = racer1Id;
                        connection.Execute("update match set racer1id=@racer1Id where matchid=@MatchId", new { racer1Id, match.MatchId });                        
                        racerIndex++;
                    }

                    if (!matches1.Any(m => m.NextWinningMatchId == match.MatchId && m.NextWinningMatchSlot == 2))
                    {
                        var racer2Id = racers[racerIndex].RacerId;
                        match.Racer2Id = racer2Id;
                        connection.Execute("update match set racer2id=@racer2Id where matchid=@MatchId", new { racer2Id, match.MatchId });
                        racerIndex++;
                    }
                }

                var matches2 = connection.Query<Match>("select * from match where roundid=2 order by matchid").ToList();

                foreach (var match in matches2)
                {
                    if (!matches1.Any(m => m.NextWinningMatchId == match.MatchId && m.NextWinningMatchSlot == 1))
                    {
                        var racer1Id = racers[racerIndex].RacerId;
                        match.Racer1Id = racer1Id;
                        connection.Execute("update match set racer1id=@racer1Id where matchid=@MatchId", new { racer1Id, match.MatchId });
                        racerIndex++;
                    }
                }
            }

            return true;
        }
    }
}
