using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data.SqlServerCe;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Dapper;
using Website.Models;

namespace Website.Controllers
{
    public static class Settings
    {
        public static string Cnn
        {
            get
            {
                var cnn = ConfigurationManager.ConnectionStrings["DefaultConnection"];
                return cnn.ConnectionString;
            }
        }
    }

    public class RacersController : ApiController
    {
        // GET api/racers
        public IEnumerable<Racer> Get()
        {
            using (var connection = new SqlCeConnection(Settings.Cnn))
            {
                connection.Open();
                return connection.Query<Racer>("select * from racer order by RacerId");
            }
        }
    }

    public class RoundController : ApiController
    {
        public IEnumerable<int> Get()
        {
            using (var connection = new SqlCeConnection(Settings.Cnn))
            {
                connection.Open();
                return connection.Query<int>("select * from round");
            }
        }
    }

    public class MatchController : ApiController
    {
        public IEnumerable<Match> Get()
        {
            using (var connection = new SqlCeConnection(Settings.Cnn))
            {
                connection.Open();
                return connection.Query<Match>("select * from match");
            }
        }

        public IEnumerable<Match> GetMatchByRound(int roundId)
        {
            using (var connection = new SqlCeConnection(Settings.Cnn))
            {
                connection.Open();
                return connection.Query<Match>("select * from match where roundid=@roundId", new {roundId});
            }
        }

        // http://localhost:31464/api/match?matchId=1&winningracerid=2

        [Authorize(Users = "alice")]
        public HttpResponseMessage Put(int matchId, int winningracerid)
        {
            using (var connection = new SqlCeConnection(Settings.Cnn))
            {
                connection.Open();

                if (winningracerid < 1)
                {
                    connection.Execute("update match set winningracerid=null, modified=null where matchid=@matchId", new { matchId });
                    return new HttpResponseMessage(HttpStatusCode.OK);
                }

                connection.Execute("update match set winningracerid=@winningracerid, modified=GETDATE() where matchid=@matchId", new { matchId, winningracerid });

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
