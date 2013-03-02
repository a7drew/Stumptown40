using System;

namespace Website.Models
{
    public class Match
    {
        public int MatchId { get; set; }
        public int RoundId { get; set; }
        public int RaceNumber { get; set; }
        public int Racer1Id { get; set; }
        public int Racer2Id { get; set; }
        public int WinningRacerId { get; set; }
        public int NextWinningMatchId { get; set; }
        public int NextWinningMatchSlot { get; set; }
        public DateTime? Modified { get; set; }
    }
}