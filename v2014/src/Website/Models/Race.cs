namespace Website.Models
{
    public class Race
    {
        public int RaceId { get; set; }
        public int Divisionid { get; set; }
        public int CarIdWinner { get; set; }
        public int CarIdLoser { get; set; }
    }
}