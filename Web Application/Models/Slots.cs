using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FitnessPulse_Web.Models
{
    public class Slots
    {
        public int Slotid { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public int Capacity { get; set; }
    }
}