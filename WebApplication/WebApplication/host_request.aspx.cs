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
    public partial class host_request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void submit_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sports league"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            try
            {
                int clubrepID = (int)Session["id"];

            SqlCommand getClubName = new SqlCommand("getClubName", conn);
            getClubName.CommandType = CommandType.StoredProcedure;
            getClubName.Parameters.Add(new SqlParameter("@clubrepID", clubrepID));

            SqlParameter clubName = getClubName.Parameters.Add("@clubName", SqlDbType.VarChar, 20);
            clubName.Direction = ParameterDirection.Output;
            conn.Open();
            getClubName.ExecuteNonQuery();
            conn.Close();

            String Sname = stadium.Text;
            String Mdate = date.Text;
            SqlCommand hostReqProc = new SqlCommand("addHostRequest", conn);
            hostReqProc.CommandType = CommandType.StoredProcedure;
            hostReqProc.Parameters.Add(new SqlParameter("@clubname", clubName.Value.ToString()));
            hostReqProc.Parameters.Add(new SqlParameter("@stadiumname", Sname));
            hostReqProc.Parameters.Add(new SqlParameter("@datetime", Mdate));
            SqlParameter success = hostReqProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction= ParameterDirection.Output;

            conn.Open();
            
                hostReqProc.ExecuteNonQuery();
                conn.Close();
                if (success.Value.ToString().Equals("1"))
                {
                    Response.Write("host request is successfully submitted");
                }
                else
                {
                    Response.Write("host request has failed successfully");
                }
            }
            catch(Exception ex)
            {
                Response.Write("Please enter a date");
            }
        }
    }
}