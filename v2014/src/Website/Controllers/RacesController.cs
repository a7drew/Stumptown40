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

                return cnn.Query<Race>(@"SELECT * 
                                         FROM Race 
                                         ORDER BY RaceId");
            }
        }

        public EventModel GetNextRaceByDivisionId(int id)
        {
            using (var cnn = Settings.GetConnection())
            {
                cnn.Open();

                var racers = cnn.Query<int>(
                    "spGetNextRaceByDivisionId",
                    new {id},
                    commandType: CommandType.StoredProcedure).ToList();

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

        public Race Post(Race race)
        {
            using (var cnn = Settings.GetConnection())
            {
                cnn.Open();

                return cnn.Query<Race>(@"DELETE RACE 
                                          WHERE DivisionId=@DivisionId 
                                          AND 
                                            ((CarIdWinner=@CarIdWinner and CarIdLoser=@CarIdLoser) 
                                            OR 
                                            (CarIdWinner=@CarIdLoser and CarIdLoser=@CarIdWinner));
                                          INSERT INTO RACE 
                                            (DivisionId, CarIdWinner, CarIdLoser) 
                                          VALUES 
                                            (@DivisionId, @CarIdWinner, @CarIdLoser);
                                        SELECT TOP 1 * 
                                         FROM Race 
                                         ORDER BY RaceId DESC",
                            new {race.Divisionid, race.CarIdWinner, race.CarIdLoser}).FirstOrDefault();                
            }
        }

//        public HttpResponseMessage Put(Race race)
//        {
//            using (var cnn = Settings.GetConnection())
//            {
//                cnn.Open();

//                cnn.Execute(@"update Race 
//                              set CarIdWinner=@CarIdWinner, 
//                                  CarIdLoser=@CarIdLoser 
//                              where RaceId=@RaceId",
//                            new {race.CarIdWinner, race.CarIdLoser, race.RaceId});
                
//                return new HttpResponseMessage(HttpStatusCode.OK);
//            }
//        }

        public HttpResponseMessage Delete(int id)
        {
            using (var cnn = Settings.GetConnection())
            {
                cnn.Open();

                cnn.Execute(@"DELETE Race 
                              WHERE RaceId=@id",
                            new {id});
                
                return new HttpResponseMessage(HttpStatusCode.OK);
            }
        }
    }
}