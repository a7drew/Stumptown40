using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Website.Models
{
    public class Racer
    {
        public int RacerId { get; set; }

        public string Name { get; set; }

        public string Organization { get; set; }

        public string CarUrl { get; set; }
    }
}