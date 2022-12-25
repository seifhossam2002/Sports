using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace WebApplication
{
    public partial class SportsAssociationManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            try
            {
                string hostClubName = TextBox1.Text;
                string guestClubName = TextBox2.Text;
                DateTime startTime= Convert.ToDateTime(TextBox3.Text);
                DateTime endTime = Convert.ToDateTime(TextBox4.Text);
                SqlCommand addNewMatch = new SqlCommand("addNewMatch", conn);
                addNewMatch.CommandType = CommandType.StoredProcedure;
                addNewMatch.Parameters.Add(new SqlParameter("@hostclubname", hostClubName));
                addNewMatch.Parameters.Add(new SqlParameter("@guestclubname", guestClubName));
                addNewMatch.Parameters.Add(new SqlParameter("@starttime", startTime));
                addNewMatch.Parameters.Add(new SqlParameter("@endtime", endTime));
                SqlParameter noExistingClubs = addNewMatch.Parameters.Add(new SqlParameter("@noExistingClubs", SqlDbType.Int));
                noExistingClubs.Direction = ParameterDirection.Output;
                conn.Open();
                addNewMatch.ExecuteNonQuery();
                conn.Close();
                if ((int)noExistingClubs.Value == 1)
                    Response.Write("Please enter valid input");
                else
                    Response.Write("Done adding a match");
            }
            catch
            {
                Response.Write("Please enter valid input");
            }
            
        }

        protected void Button2(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            try
            {
                string hostClubName = TextBox5.Text;
                string guestClubName = TextBox6.Text;
                DateTime startTime = Convert.ToDateTime(TextBox7.Text);
                DateTime endTime = Convert.ToDateTime(TextBox8.Text);
                SqlCommand deleteMatch = new SqlCommand("deleteMatch", conn);
                deleteMatch.CommandType = CommandType.StoredProcedure;
                deleteMatch.Parameters.Add(new SqlParameter("@hostclubname", hostClubName));
                deleteMatch.Parameters.Add(new SqlParameter("@guestclubname", guestClubName));
                deleteMatch.Parameters.Add(new SqlParameter("@starttime", startTime));
                deleteMatch.Parameters.Add(new SqlParameter("@endtime", endTime));
                SqlParameter noExistingMatch = deleteMatch.Parameters.Add(new SqlParameter("@noExistingMatch", SqlDbType.Int));
                noExistingMatch.Direction = ParameterDirection.Output;
                conn.Open();
                deleteMatch .ExecuteNonQuery();
                conn.Close();
                if ((int)noExistingMatch.Value == 1)
                    Response.Write("Please enter valid input");
                else
                    Response.Write("Done deleting match");
            }
            catch
            {
                Response.Write("Please enter valid input");
            }
        }

        protected void Button3(object sender, EventArgs e)
        {
            Response.Redirect("ViewUpcomingMatchesSAM.aspx");
        }

        protected void Button4(object sender, EventArgs e)
        {
            Response.Redirect("ViewPastMatches.aspx");
        }

        protected void Button5(object sender, EventArgs e)
        {
            Response.Redirect("ClubsNeverMatched.aspx");
        }
    }
}