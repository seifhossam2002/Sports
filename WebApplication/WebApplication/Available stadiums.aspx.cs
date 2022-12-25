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
    public partial class Available_stadiums : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string date = TextBox1.Text;
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand command = new SqlCommand("SELECT * from viewAvailableStadiumsOn(@datetime)", conn);
            command.Parameters.AddWithValue("@datetime", date);
            conn.Open();
            if (date.Equals(""))
            {
                Response.Write("Please enter a valid date");
            }
            else
            {
                try
                {
                    SqlDataReader rdr = command.ExecuteReader(CommandBehavior.CloseConnection);
                    while (rdr.Read())
                    {
                        string Name = rdr.GetString(rdr.GetOrdinal("name"));
                        string Location = rdr.GetString(rdr.GetOrdinal("location"));
                        int stadiumCapacity = rdr.GetInt32(rdr.GetOrdinal("capacity"));
                        TableRow row = new TableRow();
                        TableCell cell1 = new TableCell();
                        TableCell cell2 = new TableCell();
                        TableCell cell3 = new TableCell();
                        cell1.Text = Name;
                        cell2.Text = Location;
                        cell3.Text = stadiumCapacity + "";
                        row.Cells.Add(cell1);
                        row.Cells.Add(cell2);
                        row.Cells.Add(cell3);
                        myTable.Rows.Add(row);
                    }
                }
                catch
                {
                    Response.Write("Please enter a valid date");
                }
            }
        }
    }
}