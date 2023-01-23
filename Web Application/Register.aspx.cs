using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FitnessPulse_Web
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void register(object sender, EventArgs e)
        {
            if (Fname.Value != "" && Lname.Value != "")
                if (password.Value == cpassword.Value) 
                {

                    SqlConnection cnn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Dell Latitude 7480\development\MVC\FitnessPulse_Web\App_Data\FPData.mdf"";Integrated Security=True");
                    cnn.Open();
                    Response.Write("Connection Established");


                    string checkuser = "select count(*) from Members where Email='" + email.Value + "' or CNIC='" + cnic.Value + "'";
                    SqlCommand cnd = new SqlCommand(checkuser, cnn);
                    int temp = Convert.ToInt32(cnd.ExecuteScalar().ToString());

                    if (temp >= 1)
                    {
                        caution.InnerText = "Email/CNIC already exists";
                        cnn.Close();
                    }
                    else
                    {

                        string adduser = "insert into Members(First_Name, LastName, Email, CNIC, Gender, Password) values('" + Fname.Value + "','"
                            + Lname.Value + "','"
                            + email.Value + "','"
                            + cnic.Value + "','"
                             + gender.Text + "','"
                            + password.Value + "')";

                        SqlCommand cmd = new SqlCommand(adduser, cnn);
                        cmd.ExecuteNonQuery();
                        cnn.Close();

                        Response.Redirect("RegisterSuccess.aspx");

                    }
                }
                else
                {
                    caution.InnerText = "Passwords don't match!";

                }
            else
            {
                caution.InnerText = "Important Fields are empty!";
            }

        }
    }

}