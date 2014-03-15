using System.Collections.Generic;
using System.Web.Http;
using Dapper;
using Website.Models;

namespace Website.Controllers
{
    public class CarsController : ApiController
    {
        public IEnumerable<Car> Get()
        {
            using (var cnn = Settings.GetConnection())
            {
                cnn.Open();

                return cnn.Query<Car>(@"select * 
                                      from Car 
                                      order by CarId");
            }
        }
    }
}