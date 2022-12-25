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
    public partial class PurchaseTicket : System.Web.UI.Page
    {

        protected void Submit(object sender, EventArgs e)
        {
            string nationalID = Session["id"].ToString();
            string hostName = TextBox1.Text;
            string guestName = TextBox2.Text;
            string startTime = TextBox3.Text;
            string connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand purchaseProc = new SqlCommand("purchaseTicket", conn);
            purchaseProc.CommandType = CommandType.StoredProcedure;
            
            purchaseProc.Parameters.Add(new SqlParameter("@nationalID", nationalID));
            purchaseProc.Parameters.Add(new SqlParameter("@hostname", hostName));
            purchaseProc.Parameters.Add(new SqlParameter("@guestname", guestName));
            purchaseProc.Parameters.Add(new SqlParameter("@starttime", startTime));

            SqlParameter success = purchaseProc.Parameters.Add(new SqlParameter("@success", SqlDbType.Int));
            success.Direction = ParameterDirection.Output;
            conn.Open();
            
            purchaseProc.ExecuteNonQuery();
            conn.Close();
            if (success.Value.ToString() == "0")
            {
                Response.Write("Tickets weren't available");
            }
            else
            {
                Response.Write("Done");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}