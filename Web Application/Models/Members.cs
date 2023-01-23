using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FitnessPulse_Web.Models
{
    public class Members
    {
        public int MemberId { get; set; }
        public string Name { get; set; }
        public string Gender { get; set; }
        public string Email { get; set; }
        public string CNIC { get; set; }

        public Members() { }
    }
}