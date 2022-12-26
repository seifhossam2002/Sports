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

        protected void accept_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            string username = Session["user"].ToString();
            SqlCommand acceptRequest = new SqlCommand("acceptRequest", conn);
            acceptRequest.CommandType = CommandType.StoredProcedure;
            acceptRequest.Parameters.Add(new SqlParameter("@stadium_manager_username", username));
            acceptRequest.Parameters.Add(new SqlParameter("@hosting_club", TextBox1.Text));
            acceptRequest.Parameters.Add(new SqlParameter("@competing_club", TextBox2.Text));
            acceptRequest.Parameters.Add(new SqlParameter("@start", TextBox3.Text));
            SqlParameter oput = acceptRequest.Parameters.Add("@noExistingReq", SqlDbType.Int);
            oput.Direction = ParameterDirection.Output;
            conn.Open();
            try
            {
                acceptRequest.ExecuteNonQuery();
                conn.Close();
                if ((int)oput.Value == 1)
                {
                    Response.Write("Wrong input please try again later ");

                }
                else
                {
                    Response.Write("done need refresh ;)");
                }
            }
            catch(Exception ex)
            {
                Response.Write("Wrong input please try again later ");
            }
        }

        protected void reject_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            string username = Session["user"].ToString();
            SqlCommand rejectRequest = new SqlCommand("rejectRequest", conn);
            rejectRequest.CommandType = CommandType.StoredProcedure;
            rejectRequest.Parameters.Add(new SqlParameter("@stadium_manager_username", username));
            rejectRequest.Parameters.Add(new SqlParameter("@hosting_club", TextBox1.Text));
            rejectRequest.Parameters.Add(new SqlParameter("@competing_club", TextBox2.Text));
            rejectRequest.Parameters.Add(new SqlParameter("@start", TextBox3.Text));
            SqlParameter oput = rejectRequest.Parameters.Add("@noExistingReq", SqlDbType.Int);
            oput.Direction = ParameterDirection.Output;

            conn.Open();
            try
            {
                rejectRequest.ExecuteNonQuery();
                conn.Close();
                if ((int)oput.Value == 1)
                {
                    Response.Write("Wrong input please try again later ");

                }
                else
                {
                    Response.Write("done need refresh ;)");
                }
            }
            catch (Exception ex)
            {
                Response.Write("Wrong input please try again later ");
            }
            
        }
    }
}