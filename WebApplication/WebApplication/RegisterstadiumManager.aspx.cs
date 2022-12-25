using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication
{
    public partial class RegisterstadiumManager : System.Web.UI.Page
    {

        protected void Register(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            string name = TextBox1.Text;
            string username = TextBox2.Text;
            string password = TextBox3.Text;
            string stadiumName = TextBox4.Text;

            SqlCommand addStadiumManager = new SqlCommand("addStadiumManager", conn);
            addStadiumManager.CommandType = CommandType.StoredProcedure;

            addStadiumManager.Parameters.Add(new SqlParameter("@name", name));
            addStadiumManager.Parameters.Add(new SqlParameter("@stadiumName", stadiumName));
            addStadiumManager.Parameters.Add(new SqlParameter("@username", username));
            addStadiumManager.Parameters.Add(new SqlParameter("@password", password));
            SqlParameter success = addStadiumManager.Parameters.Add(new SqlParameter("@success", SqlDbType.Int));
            SqlParameter noExistingStadium = addStadiumManager.Parameters.Add(new SqlParameter("@noExistingStadium", SqlDbType.Int));

            success.Direction = ParameterDirection.Output;
            noExistingStadium.Direction = ParameterDirection.Output;
            conn.Open();
            if (name.Equals("") || username.Equals("") || password.Equals("") || stadiumName.Equals(""))
            {
                Response.Write("Please write a valid input");
            }
            else
            {
                addStadiumManager.ExecuteNonQuery();
                conn.Close();
                if ((int)success.Value == 0)
                {
                    Response.Write("This username is taken");
                }
                else
                {
                    if ((int)noExistingStadium.Value == 1)
                    {
                        Response.Write("Please enter a valid stadium name");
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