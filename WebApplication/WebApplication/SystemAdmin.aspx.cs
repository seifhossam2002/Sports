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
    public partial class SystemAdmin : System.Web.UI.Page
    {
        protected void Button1(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            string name=TextBox1.Text;
            string location = TextBox2.Text;
            SqlCommand addClub = new SqlCommand("addClub", conn);
            addClub.CommandType = CommandType.StoredProcedure;

            addClub.Parameters.Add(new SqlParameter("@nameclub",name));
            addClub.Parameters.Add(new SqlParameter("@location",location));
            if(name != "" && location != ""){
                conn.Open();
                addClub.ExecuteNonQuery();
                conn.Close();
                Response.Write("Done adding club");
            }
            else
                Response.Write("Cant add club");


        }

        protected void Button2(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            string name=TextBox3.Text;
            SqlCommand deleteClub = new SqlCommand("deleteClub", conn);
            deleteClub.CommandType = CommandType.StoredProcedure;
            deleteClub.Parameters.Add(new SqlParameter("@club", name));
            SqlParameter noExistingClub = deleteClub.Parameters.Add(new SqlParameter("@noExistingClub", SqlDbType.Int));
            noExistingClub.Direction = ParameterDirection.Output;
            conn.Open();
            deleteClub.ExecuteNonQuery();
            conn.Close();
            if ((int)noExistingClub.Value == 1 || name=="")
                Response.Write("Please enter a valid club name");
            else
                Response.Write("Done deleting club");
        }

        protected void Button3(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            string name=TextBox4.Text;
            string location=TextBox5.Text;
            string capacity = TextBox6.Text;
            SqlCommand addStadium = new SqlCommand("addStadium", conn);
            addStadium.CommandType = CommandType.StoredProcedure;

            addStadium.Parameters.Add(new SqlParameter("@stadium_name", name));
            addStadium.Parameters.Add(new SqlParameter("@stadium_location", location));
            addStadium.Parameters.Add(new SqlParameter("@capacity", capacity));
            if(name != "" && location != "" && capacity != "")
            {
                conn.Open();
                addStadium.ExecuteNonQuery();
                conn.Close();
                Response.Write("Done adding stadium");
            }
            else
            {
                Response.Write("Cant add stadium");
            }
            
        }

        protected void Button4(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            string name = TextBox7.Text;
            SqlCommand deleteStadium = new SqlCommand("deleteStadium", conn);
            deleteStadium.CommandType = CommandType.StoredProcedure;

            deleteStadium.Parameters.Add(new SqlParameter("@stadium_name", name));
            SqlParameter noExistingStadium = deleteStadium.Parameters.Add(new SqlParameter("@noExistingStadium", SqlDbType.Int));
            noExistingStadium.Direction = ParameterDirection.Output;
            conn.Open();
            deleteStadium.ExecuteNonQuery();
            conn.Close();
            if ((int)noExistingStadium.Value == 1 || name=="")
                Response.Write("Please a valid stadium name");
            else
                Response.Write("Done deleting stadium");
        }

        protected void Button5(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            string id = TextBox8.Text;
            SqlCommand blockFan = new SqlCommand("blockFan",conn);
            blockFan.CommandType = CommandType.StoredProcedure;
            blockFan.Parameters.Add(new SqlParameter("@national_id", id));
            SqlParameter noExistingFan = blockFan.Parameters.Add(new SqlParameter("@noExistingFan", SqlDbType.Int));
            noExistingFan.Direction = ParameterDirection.Output;
            conn.Open();
            blockFan.ExecuteNonQuery();
            conn.Close();
            if ((int)noExistingFan.Value == 1 || id=="")
                Response.Write("Please a valid fan id");
            else
                Response.Write("Done blocking fan");

        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}