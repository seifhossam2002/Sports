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
    public partial class ViewMatchesFAN : System.Web.UI.Page
    {

        protected void Submit(object sender, EventArgs e)
        {
            string date = TextBox1.Text;
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand command = new SqlCommand("SELECT * from availableMatchesToAttend(@datetime)", conn);
            command.Parameters.AddWithValue("@datetime", date);
            conn.Open();
            if (date.Equals(""))
            {
                Response.Write("Please write a valid date");
            }
            else
            {
                try
                {
                    SqlDataReader rdr = command.ExecuteReader(CommandBehavior.CloseConnection);
                    while (rdr.Read())
                    {
                        string hostName = rdr.GetString(rdr.GetOrdinal("host club name"));
                        string guestName = rdr.GetString(rdr.GetOrdinal("guest club name"));
                        string stadiumName = rdr.GetString(rdr.GetOrdinal("name"));
                        string location = rdr.GetString(rdr.GetOrdinal("location"));
                        TableRow row = new TableRow();
                        TableCell cell1 = new TableCell();
                        TableCell cell2 = new TableCell();
                        TableCell cell3 = new TableCell();
                        TableCell cell4 = new TableCell();
                        cell1.Text = hostName;
                        cell2.Text = guestName;
                        cell3.Text = stadiumName;
                        cell4.Text = location;
                        row.Cells.Add(cell1);
                        row.Cells.Add(cell2);
                        row.Cells.Add(cell3);
                        row.Cells.Add(cell4);
                        myTable.Rows.Add(row);
                    }
                }
                catch
                {
                    Response.Write("Please write a valid date");
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}