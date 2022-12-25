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
    public partial class AllRequestsSM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            string username=Session["user"].ToString();
            var allReq= new SqlCommand("SELECT * from allRequestsASP WHERE username=@username", conn);
            allReq.Parameters.AddWithValue("@username", username);
            conn.Open();
            SqlDataReader rdr = allReq.ExecuteReader(CommandBehavior.CloseConnection);
            while(rdr.Read())
            {
                string crname= rdr.GetString(rdr.GetOrdinal("CRname"));
                string hostName = rdr.GetString(rdr.GetOrdinal("hostName"));
                string guestName = rdr.GetString(rdr.GetOrdinal("guestName"));
                string startTime = rdr.GetDateTime(rdr.GetOrdinal("startTime"))+"";
                string endTime = rdr.GetDateTime(rdr.GetOrdinal("endTime")) + "";
                string status = rdr.GetString(rdr.GetOrdinal("status"));
                TableRow row = new TableRow();
                TableCell cell1 = new TableCell();
                TableCell cell2 = new TableCell();
                TableCell cell3 = new TableCell();
                TableCell cell4 = new TableCell();
                TableCell cell5 = new TableCell();
                TableCell cell6 = new TableCell();
                cell1.Text = crname;
                cell2.Text = hostName;
                cell3.Text = guestName;
                cell4.Text = startTime;
                cell5.Text = endTime;
                cell6.Text = status;
                row.Cells.Add(cell1);
                row.Cells.Add(cell2);
                row.Cells.Add(cell3);
                row.Cells.Add(cell4);
                row.Cells.Add(cell5);
                row.Cells.Add(cell6);
                Table1.Rows.Add(row);
            }
        }
    }
}