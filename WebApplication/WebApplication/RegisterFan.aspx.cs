using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Security.Authentication.ExtendedProtection;

namespace WebApplication
{
    public partial class RegisterFan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            string name = TextBox1.Text;
            string username = TextBox2.Text;
            string password = TextBox3.Text;
            string nationalId = TextBox4.Text;
            //int phoneNumber = int.Parse(TextBox5.Text);
            string phoneNumber = TextBox5.Text;
            string birthDate = TextBox6.Text;
            //DateTime birthDate = DateTime.Parse(TextBox6.Text);
            string address = TextBox7.Text;

            SqlCommand addFan = new SqlCommand("addFan", conn);

            addFan.CommandType = CommandType.StoredProcedure;
            addFan.Parameters.Add(new SqlParameter("@name", name));
            addFan.Parameters.Add(new SqlParameter("@username", username));
            addFan.Parameters.Add(new SqlParameter("password", password));
            addFan.Parameters.Add(new SqlParameter("@national_id", nationalId));
            addFan.Parameters.Add(new SqlParameter("@phone_number", phoneNumber));
            addFan.Parameters.Add(new SqlParameter("@birth_date", birthDate));
            addFan.Parameters.Add(new SqlParameter("@address", address));
            SqlParameter success = addFan.Parameters.Add(new SqlParameter("@success", SqlDbType.Int));

            success.Direction = ParameterDirection.Output;

            conn.Open();
            if (name.Equals("") || username.Equals("") || password.Equals("") || nationalId.Equals("")
                || phoneNumber.Equals("") || birthDate.Equals("") || address.Equals(""))
            {
                Response.Write("Please write a valid input");
            }
            else
            {
                try
                {
                    addFan.ExecuteNonQuery();
                    if ((int)success.Value == 0)
                        Response.Write("Already exists");
                    else
                        Response.Redirect("Login.aspx");
                }
                catch (Exception ex)
                {
                    Response.Write("Please write a valid input");
                }

            }
            conn.Close();
        }
    }
}