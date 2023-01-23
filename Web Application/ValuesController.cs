using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.UI.WebControls;
using System.Text;
using Newtonsoft.Json;
using System.Web.Http.Results;
using FitnessPulse_Web.Models;
using System.Drawing;

namespace FitnessPulse_Web
{
    public class ValuesController : ApiController
    {
        // GET api/<controller>
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<controller>/5
        public Members Get(string email, string password)
        {   
            SqlConnection cnn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Dell Latitude 7480\development\MVC\FitnessPulse_Web\App_Data\FPData.mdf"";Integrated Security=True");
            cnn.Open();
            
            SqlCommand sde = new SqlCommand("Select MemberID, First_Name + ' ' + LastName as Name, Gender, Email, CNIC from Members where Email = '" + email + "' and Password = '" + password + "'", cnn);
            var reader = sde.ExecuteReader();
            Members s = new Members();
            while (reader.Read())
            {
                s.MemberId = (int)reader["MemberID"];
                s.Name = (string)reader["Name"];
                s.Gender = (string)reader["Gender"];
                s.Email = (string)reader["Email"];
                s.CNIC = (string)reader["CNIC"];
            }
            return s;
        }

        public List<Slots> GetSlots(string day)
        {

            SqlConnection cnn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Dell Latitude 7480\development\MVC\FitnessPulse_Web\App_Data\FPData.mdf"";Integrated Security=True");
            cnn.Open();
            //var jsonResult = new StringBuilder();

            SqlCommand sde = new SqlCommand("Select Slotid, StartTime, EndTime, Capacity from Slots where Day ='" + day + "'", cnn);
            var reader = sde.ExecuteReader();
            var sts = new List<Slots>();

            while (reader.Read())
            {
                Slots s = new Slots();
                s.Slotid = (int)reader["Slotid"];
                s.StartTime = (string)time_format((TimeSpan)reader["StartTime"]);
                s.EndTime = (string)time_format((TimeSpan)reader["EndTime"]);
                s.Capacity = (int)reader["Capacity"];
                sts.Add(s);
            }
            return sts;
        }

        private string time_format(TimeSpan t)
        {;
            DateTime time = DateTime.Today.Add(t);
            string displayTime = time.ToString("hh:mm tt");
            return displayTime;
        }

        // POST api/<controller>
        public void Post([FromBody] Appointment appointment)
        {
            var mID = appointment.MemberID;
            var sID = appointment.Slotid;
            var x = (appointment.Date);
            SqlConnection cnn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Dell Latitude 7480\development\MVC\FitnessPulse_Web\App_Data\FPData.mdf"";Integrated Security=True");
            cnn.Open();

            string query = "insert into Appointments(MemberID, Slotid, Date) values('" + mID + "','" + sID + "','" + x.ToString() + "')";
            SqlCommand sde = new SqlCommand(query, cnn);
            sde.ExecuteNonQuery();
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }
    }
}