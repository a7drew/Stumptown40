using System.Collections.Generic;
using System.Data;
using System.Linq;
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

        public EventModel GetNextRaceByDivisionId(int id)
        {
            using (var cnn = Settings.GetConnection())
            {
                cnn.Open();

                var racers = cnn.Query<IEnumerable<int>>(
                    "spGetNextRaceByDivisionId",
                    new {id},
                    commandType: CommandType.StoredProcedure).First().ToList();

                var eventModel = new EventModel();

                if (racers.Count() > 1)
                {
                    eventModel.Racer1CarId = racers[0];
                    eventModel.Racer2CarId = racers[1];
                }

                if (racers.Count() > 3)
                {
                    eventModel.NextRacer1CarId = racers[2];
                    eventModel.NextRacer2CarId = racers[3];
                }

                return eventModel;
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