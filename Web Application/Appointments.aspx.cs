using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DayPilot.Web.Ui;

namespace FitnessPulse_Web
{
    public partial class Appointments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (IsUserLogin != true)
                Response.Redirect("Login.aspx");

            DataTable ds = new DataTable();
            ds = null;
            GridView5.DataSource = ds;
            GridView5.DataBind();

            using (SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Dell Latitude 7480\development\MVC\FitnessPulse_Web\App_Data\FPData.mdf"";Integrated Security=True"))
            {
                SqlDataAdapter sdq = new SqlDataAdapter("Select Slotid, StartTime, EndTime, (select count(*) from Appointments where Slots.Slotid=Appointments.Slotid) as Bookings, Capacity from Slots where Day ='" + aptday.SelectedItem.Text + "'", con);
                DataSet dt = new DataSet();
                sdq.Fill(dt);
                GridView4.DataSource = dt;
                GridView4.DataBind();
            }

        }

        public bool IsUserLogin
        {
            get
            {

                if (Session["IsUserLogin"] != null)
                    return Convert.ToBoolean(Session["IsUserLogin"]);
                return false;
            }
        }

        protected void GridView4_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Dell Latitude 7480\development\MVC\FitnessPulse_Web\App_Data\FPData.mdf"";Integrated Security=True"))
            {
                
                SqlDataAdapter sdq = new SqlDataAdapter("select distinct Members.First_Name + ' ' + Members.LastName as Member from Members, Appointments where Members.MemberID=Appointments.MemberID and Appointments.Slotid='" + GridView4.SelectedRow.Cells[1].Text.ToString() + "'", con);
                DataSet dt = new DataSet();
                sdq.Fill(dt);
                GridView5.DataSource = dt;
                GridView5.DataBind();
            }
        }
    }
}