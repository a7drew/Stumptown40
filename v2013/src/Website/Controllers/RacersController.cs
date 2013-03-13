using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Dapper;
using Website.Models;

namespace Website.Controllers
{
    public class RacersController : ApiController
    {
        // GET api/racers
        public IEnumerable<Racer> Get()
        {
            return new List<Racer>
                {
                    new Racer{ RacerId = 1, Name="Alice Alamacher", Organization = "Alice's House", CarUrl = "https://stumptown40.blob.core.windows.net/cars/car001.jpg"},
                    new Racer{ RacerId = 2, Name="Bob Beach", Organization = "Bob's House", CarUrl = "https://stumptown40.blob.core.windows.net/cars/car002.jpg"},
                    new Racer{ RacerId = 3, Name="Charlie Caps", Organization = "Charlie's House", CarUrl = "https://stumptown40.blob.core.windows.net/cars/car003.jpg"},
                    new Racer{ RacerId = 4, Name="Delbert Dewars", Organization = "Delbert's House", CarUrl = "https://stumptown40.blob.core.windows.net/cars/car004.jpg"},
                    new Racer{ RacerId = 5, Name="Eddie Eggplant", Organization = "Eddie's House", CarUrl = "https://stumptown40.blob.core.windows.net/cars/car005.jpg"},
                };
        }
    }

    public class Racers2Controller : ApiController
    {
        private const string Cnn = @"Server=.\sqlexpress;Database=Stumptown40;Trusted_Connection=True;";

        public IEnumerable<Racer> Get()
        {
            using (var connection = new SqlConnection(Cnn))
            {
                connection.Open();               
                return connection.Query<Racer>("select * from racer");
            }
        }
    }

    public class RoundController : ApiController
    {
        private const string Cnn = @"Server=.\sqlexpress;Database=Stumptown40;Trusted_Connection=True;";

        public IEnumerable<int> Get()
        {
            using (var connection = new SqlConnection(Cnn))
            {
                connection.Open();
                return connection.Query<int>("select * from round");
            }
        }
    }

    public class MatchController : ApiController
    {
        private const string Cnn = @"Server=.\sqlexpress;Database=Stumptown40;Trusted_Connection=True;";

        public IEnumerable<Match> Get()
        {
            using (var connection = new SqlConnection(Cnn))
            {
                connection.Open();
                return connection.Query<Match>("select * from match");
            }
        }

        public IEnumerable<Match> GetMatchByRound(int roundId)
        {
            using (var connection = new SqlConnection(Cnn))
            {
                connection.Open();
                return connection.Query<Match>("select * from match where roundid=@roundId", new {roundId});
            }
        }

        // http://localhost:31464/api/match?matchId=1&winningracerid=2

        public HttpResponseMessage Put(int matchId, int winningracerid)
        {
            using (var connection = new SqlConnection(Cnn))
            {
                connection.Open();

                if (winningracerid < 1)
                {
                    connection.Execute("update match set winningracerid=null where matchid=@matchId", new { matchId });
                    return new HttpResponseMessage(HttpStatusCode.OK);
                }

                connection.Execute("update match set winningracerid=@winningracerid where matchid=@matchId", new { matchId, winningracerid });

                Match match = connection.Query<Match>("select * from match where matchId=@matchId", new {matchId}).First();

                var sql = match.NextWinningMatchSlot == 1
                    ? "update match set racer1id=@winningracerid where matchid=@NextWinningMatchId"
                    : "update match set racer2id=@winningracerid where matchid=@NextWinningMatchId";

                connection.Execute(sql, new { match.NextWinningMatchId, winningracerid });

                return new HttpResponseMessage(HttpStatusCode.OK);
            }
        }
    }
}
