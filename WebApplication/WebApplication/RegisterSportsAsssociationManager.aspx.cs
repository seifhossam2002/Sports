using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication
{
    public partial class RegisterSportsAsssociationManager : System.Web.UI.Page
    {
        protected void Register(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            string name = TextBox1.Text;
            string username = TextBox2.Text;
            string password = TextBox3.Text;
            SqlCommand addAssociationManager = new SqlCommand("addAssociationManager", conn);
            addAssociationManager.CommandType = CommandType.StoredProcedure;
            addAssociationManager.Parameters.Add(new SqlParameter("@name", name));
            addAssociationManager.Parameters.Add(new SqlParameter("@username", username));
            addAssociationManager.Parameters.Add(new SqlParameter("@password", password));
            SqlParameter success = addAssociationManager.Parameters.Add(new SqlParameter("@success", SqlDbType.Int));
            success.Direction = ParameterDirection.Output;

            conn.Open();
            if (name.Equals("") || username.Equals("") || password.Equals(""))
            {
                Response.Write("Please enter a valid input");
            }
            else
            {
                addAssociationManager.ExecuteNonQuery();
                conn.Close();
                if ((int)success.Value == 0)
                {
                    Response.Write("Already exists this username");
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}