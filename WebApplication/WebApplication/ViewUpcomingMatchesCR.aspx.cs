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
    public partial class ViewUpcomingMatchesCR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            int clubrepID = (int)Session["id"];
            //int clubrepID = 1;
            SqlCommand getClubName = new SqlCommand("getClubName",conn);
   
            getClubName.CommandType = CommandType.StoredProcedure;
            getClubName.Parameters.Add(new SqlParameter("@clubrepID", clubrepID));
            SqlParameter clubName=getClubName.Parameters.Add("@clubName", SqlDbType.VarChar,20);

            clubName.Direction = ParameterDirection.Output;
            conn.Open();
            getClubName.ExecuteNonQuery();
            conn.Close();

            var upcoming = new SqlCommand("Select * from upcomingMatchesOfClub(@clubname)", conn);
            upcoming.Parameters.AddWithValue("@clubname", clubName.Value.ToString());
            conn.Open();
            SqlDataReader rdr = upcoming.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String host = rdr.GetString(rdr.GetOrdinal("host name"));
                String guest = rdr.GetString(rdr.GetOrdinal("guest name"));
                String start = rdr.GetDateTime(rdr.GetOrdinal("startTime")) +"";
                String end = rdr.GetDateTime(rdr.GetOrdinal("endTime"))+"";
                String stadium;
                try
                {
                    stadium = rdr.GetString(rdr.GetOrdinal("name"));
                }
                catch
                {
                    stadium = "null";
                }
                TableRow row = new TableRow();
                TableCell cell1 = new TableCell();
                TableCell cell2 = new TableCell();
                TableCell cell3 = new TableCell();
                TableCell cell4 = new TableCell();
                TableCell cell5 = new TableCell();
                cell1.Text = host;
                cell2.Text = guest;
                cell3.Text = start;
                cell4.Text = end;
                cell5.Text = stadium;
                row.Cells.Add(cell1);
                row.Cells.Add(cell2);
                row.Cells.Add(cell3);
                row.Cells.Add(cell4);
                row.Cells.Add(cell5);
                myTable.Rows.Add(row);

            }
        }
    }
}