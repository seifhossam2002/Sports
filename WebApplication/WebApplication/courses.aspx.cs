using Microsoft.SqlServer.Server;
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
    public partial class courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            //string x = Session["user"].ToString();
            string x = "clubrep1";
            var command = new SqlCommand("select club.name,club.id,club.location from club " +
                                                "inner join clubRepresentative on club.id = clubRepresentative.clubid " +
                                                "where clubRepresentative.username=@x", conn);
            command.Parameters.AddWithValue("@x", x);
            conn.Open();
            SqlDataReader rdr = command.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                string username = rdr.GetString(rdr.GetOrdinal("name"));
                int id = rdr.GetInt32(rdr.GetOrdinal("id"));
                string loc = rdr.GetString(rdr.GetOrdinal("location"));
                TableRow row = new TableRow();
                TableCell cell1 = new TableCell();
                TableCell cell2 = new TableCell();
                TableCell cell3 = new TableCell();
                cell1.Text = username;
                cell2.Text = id+"";
                cell3.Text = loc;
                row.Cells.Add(cell1);
                row.Cells.Add(cell2);
                row.Cells.Add(cell3);
                myTable.Rows.Add(row);
            }

        }
    }
}