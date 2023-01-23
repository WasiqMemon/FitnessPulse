using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FitnessPulse_Web.Models
{
    public class Appointment
    {
        public int MemberID { get; set; }
        public int Slotid { get; set; }
        public DateTime Date { get; set; }

    }
}