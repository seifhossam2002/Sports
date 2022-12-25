using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication
{
    public partial class RegisterclubRepresentative : System.Web.UI.Page
    {

        protected void Register(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            string name = TextBox1.Text;
            string username = TextBox2.Text;
            string password = TextBox3.Text;
            string clubName = TextBox4.Text;

            SqlCommand addRepresentative = new SqlCommand("addRepresentative", conn);
            addRepresentative.CommandType = CommandType.StoredProcedure;

            addRepresentative.Parameters.Add(new SqlParameter("@name", name));
            addRepresentative.Parameters.Add(new SqlParameter("@clubName", clubName));
            addRepresentative.Parameters.Add(new SqlParameter("@username", username));
            addRepresentative.Parameters.Add(new SqlParameter("@password", password));
            SqlParameter success = addRepresentative.Parameters.Add(new SqlParameter("@success", SqlDbType.Int));
            SqlParameter noExistingClub = addRepresentative.Parameters.Add(new SqlParameter("@noExistingClub", SqlDbType.Int));

            success.Direction = ParameterDirection.Output;
            noExistingClub.Direction = ParameterDirection.Output;
            conn.Open();
            if (name.Equals("") || username.Equals("") || password.Equals("") || clubName.Equals(""))
            {
                Response.Write("Please write a valid input");
            }
            else
            {
                addRepresentative.ExecuteNonQuery();
                conn.Close();
                if ((int)success.Value == 0)
                {
                    Response.Write("This username is taken");
                }
                else
                {
                    if ((int)noExistingClub.Value == 1)
                    {
                        Response.Write("Please enter a valid club name");
                    }
                    else
                        Response.Redirect("Login.aspx");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}