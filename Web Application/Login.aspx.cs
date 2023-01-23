using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FitnessPulse_Web
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public bool IsUserLogin
        {
            get
            {

                if (Session["IsUserLogin"] != null)
                    return Convert.ToBoolean(Session["IsUserLogin"]);
                return false;
            }
            set
            {
                Session["IsUserLogin"] = value;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            SqlConnection cnn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Dell Latitude 7480\development\MVC\FitnessPulse_Web\App_Data\FPData.mdf"";Integrated Security=True");
            cnn.Open();
            Response.Write("Connection Established");

            string checkuser = "select count(*) from Admin where Email='" + email.Value + "' and Password='" + password.Value + "'";
            SqlCommand cmd = new SqlCommand(checkuser, cnn);
            int temp = Convert.ToInt32(cmd.ExecuteScalar().ToString());

            if (temp == 1)
            {
                IsUserLogin = true;
                Response.Redirect("Dashboard.aspx");
            }
            else
            {
                caution.InnerText = "Email or Password is incorrect";
            }

            cnn.Close();
        }
    }
}