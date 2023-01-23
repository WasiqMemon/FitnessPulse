using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Services;

namespace FitnessPulse_Web
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (IsUserLogin != true)
                Response.Redirect("Login.aspx");

            using (SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Dell Latitude 7480\development\MVC\FitnessPulse_Web\App_Data\FPData.mdf"";Integrated Security=True"))
            {
                SqlDataAdapter sde = new SqlDataAdapter("Select top 5 First_Name + ' ' + LastName as Name, Gender, Email, CONVERT(VARCHAR(10), DateJoined, 103) as DateJoined from Members", con);
                DataSet ds = new DataSet();
                sde.Fill(ds);
                GridView1.DataSource = ds;
                GridView1.DataBind();
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

        protected string pb1
        {
            get
            {
                SqlConnection cnn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Dell Latitude 7480\development\MVC\FitnessPulse_Web\App_Data\FPData.mdf"";Integrated Security=True");
                cnn.Open();

                string checkmales = "Select count(*) from Members where Gender='Male'";

                SqlCommand cnd = new SqlCommand(checkmales, cnn);

                var ml = cnd.ExecuteScalar();
                return ml.ToString();
            }
        }

        protected string pb2
        {
            get
            {
                SqlConnection cnn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Dell Latitude 7480\development\MVC\FitnessPulse_Web\App_Data\FPData.mdf"";Integrated Security=True");
                cnn.Open();

                string checkfemales = "Select count(*) from Members where Gender='Female'";

                SqlCommand cnd = new SqlCommand(checkfemales, cnn);

                var fl = cnd.ExecuteScalar();
                return fl.ToString();
            }
        }

    }
}