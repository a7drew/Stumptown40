using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Dapper;
using Website.Models;

namespace Website.Controllers
{
    public class RacesController : ApiController
    {
        public IEnumerable<Race> Get()
        {
            using (var cnn = Settings.GetConnection())
            {
                cnn.Open();

                return cnn.Query<Race>(@"select * 
                                         from Race 
                                         order by RaceId");
            }
        }

        public IEnumerable<Race> GetLastRaceByDivisionId(int id)
        {
            using (var cnn = Settings.GetConnection())
            {
                cnn.Open();

                return cnn.Query<Race>(@"select top 1 * 
                                         from Race 
                                         where DivisionId=@id 
                                         order by RaceId desc;",
                                       new {id});
            }
        }

        public HttpResponseMessage Post(Race race)
        {
            using (var cnn = Settings.GetConnection())
            {
                cnn.Open();

                cnn.Execute(@"insert into Race 
                              (DivisionId, CarIdWinner, CarIdLoser) 
                              values 
                              (0, @CarIdWinner, @CarIdLoser)",
                            new {race.CarIdWinner, race.CarIdLoser});
                
                return new HttpResponseMessage(HttpStatusCode.OK);
            }
        }

        public HttpResponseMessage Put(Race race)
        {
            using (var cnn = Settings.GetConnection())
            {
                cnn.Open();

                cnn.Execute(@"update Race 
                              set CarIdWinner=@CarIdWinner, 
                                  CarIdLoser=@CarIdLoser 
                              where RaceId=@RaceId",
                            new {race.CarIdWinner, race.CarIdLoser, race.RaceId});
                
                return new HttpResponseMessage(HttpStatusCode.OK);
            }
        }

        public HttpResponseMessage Delete(Race race)
        {
            using (var cnn = Settings.GetConnection())
            {
                cnn.Open();

                cnn.Execute(@"delete Race 
                              where RaceId=@RaceId",
                            new {race.RaceId});
                
                return new HttpResponseMessage(HttpStatusCode.OK);
            }
        }
    }
}