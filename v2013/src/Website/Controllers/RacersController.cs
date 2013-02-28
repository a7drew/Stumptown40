using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Website.Models;

namespace Website.Controllers
{
    public class RacersController : ApiController
    {
        // GET api/values
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
}
