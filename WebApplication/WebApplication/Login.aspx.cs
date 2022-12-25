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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

        protected void login(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            string username = u1.Text;
            string password = p1.Text;
            SqlCommand loginproc = new SqlCommand("userLogin", conn);

            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@username", username));
            loginproc.Parameters.Add(new SqlParameter("@password", password));
            SqlParameter type = loginproc.Parameters.Add("@type", SqlDbType.VarChar,25);
            SqlParameter id = loginproc.Parameters.Add("@id", SqlDbType.Int);


            type.Direction = ParameterDirection.Output;
            id.Direction = ParameterDirection.Output;
            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();
            string typeTemp=type.Value.ToString();
            Session["user"]= username;
            Session["id"] = id.Value;
            Console.Write(typeTemp);
            switch (typeTemp)
            {
                case "Fan":
                    Response.Redirect("Fan.aspx"); break;
                case "SportsAsssociationManager":
                    Response.Redirect("SportsAssociationManager.aspx"); break;
                case "clubRepresentative":
                    Response.Redirect("clubRepresentative.aspx"); break;
                case "stadiumManager":
                    Response.Redirect("StadiumManager.aspx"); break;
                case "SystemAdmin":
                    Response.Redirect("SystemAdmin.aspx"); break;
                default:
                    Response.Write("User Not found"); break;
            }
            

        }
    }
}