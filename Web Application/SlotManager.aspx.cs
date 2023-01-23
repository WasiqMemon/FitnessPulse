using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace FitnessPulse_Web
{
    public partial class SlotManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsUserLogin != true)
                Response.Redirect("Login.aspx");

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
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            SqlConnection cnn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Dell Latitude 7480\development\MVC\FitnessPulse_Web\App_Data\FPData.mdf"";Integrated Security=True");
            cnn.Open();
            Response.Write("Connection Established");

            string checkuser = "select count(*) from Slots where StartTime='" + pst.Value + "' and Day='" + day.Text + "'";
            SqlCommand cnd = new SqlCommand(checkuser, cnn);
            int temp = Convert.ToInt32(cnd.ExecuteScalar().ToString());

            if (temp >= 1)
            {
                caution.InnerText = "Slot in defined time already exists";
                cnn.Close();
            }
            else
            {

                string adduser = "insert into Slots(StartTime, EndTime, Capacity, Day) values('" + pst.Value + "','"
                    + pet.Value + "','"
                    + cpcty.Value + "','"
                    + day.Text + "')";

                SqlCommand cmd = new SqlCommand(adduser, cnn);
                cmd.ExecuteNonQuery();
                cnn.Close();

                caution.InnerText = "Slot added";


            }
        }

        protected void selectday_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Dell Latitude 7480\development\MVC\FitnessPulse_Web\App_Data\FPData.mdf"";Integrated Security=True"))
            {
                SqlDataAdapter sde = new SqlDataAdapter("Select * from Slots where Day ='" + selectday.SelectedItem.Text + "'", con);
                DataSet ds = new DataSet();
                sde.Fill(ds);
                GridView2.DataSource = ds;
                GridView2.DataBind();
            }
            
        }

        protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Dell Latitude 7480\development\MVC\FitnessPulse_Web\App_Data\FPData.mdf"";Integrated Security=True");
            con.Open();
            SqlCommand cmd = new SqlCommand("delete FROM Slots where Slotid='" + Convert.ToInt32(GridView2.DataKeys[e.RowIndex].Value.ToString()) + "'", con);
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Redirect(Request.RawUrl);
        }
    }
}