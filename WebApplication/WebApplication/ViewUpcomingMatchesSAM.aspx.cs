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
    public partial class ViewUpcomingMatchesSAM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            var upcoming = new SqlCommand("SELECT * FROM upcomingMatchesSAM()",conn);
            conn.Open();
            SqlDataReader rdr = upcoming.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String host = rdr.GetString(rdr.GetOrdinal("host name"));
                String guest = rdr.GetString(rdr.GetOrdinal("guest name"));
                String start = rdr.GetDateTime(rdr.GetOrdinal("startTime")) + "";
                String end = rdr.GetDateTime(rdr.GetOrdinal("endTime")) + "";
                TableRow row = new TableRow();
                TableCell cell1 = new TableCell();
                TableCell cell2 = new TableCell();
                TableCell cell3 = new TableCell();
                TableCell cell4 = new TableCell();
                cell1.Text = host;
                cell2.Text = guest;
                cell3.Text = start;
                cell4.Text = end;
                row.Cells.Add(cell1);
                row.Cells.Add(cell2);
                row.Cells.Add(cell3);
                row.Cells.Add(cell4);
                myTable.Rows.Add(row);

            }
        }
    }
}