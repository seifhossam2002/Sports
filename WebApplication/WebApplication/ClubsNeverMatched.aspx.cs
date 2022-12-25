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
    public partial class ClubsNeverPlayed : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            var clubsNeverMatched = new SqlCommand("Select * from clubsNeverMatched", conn);
            conn.Open();
            SqlDataReader rdr = clubsNeverMatched.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String club1Name = rdr.GetString(rdr.GetOrdinal("club1 name"));
                String club2Name = rdr.GetString(rdr.GetOrdinal("club2 name"));
                TableRow row = new TableRow();
                TableCell cell1 = new TableCell();
                TableCell cell2 = new TableCell();
                cell1.Text = club1Name;
                cell2.Text = club2Name;
                row.Cells.Add(cell1);
                row.Cells.Add(cell2);
                myTable.Rows.Add(row);

            }
        }
    }
}