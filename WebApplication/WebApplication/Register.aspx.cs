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
    public partial class Register : System.Web.UI.Page
    {
        protected void fanC(object sender, EventArgs e)
        {
            Response.Redirect("RegisterFan.aspx");
        }

        protected void SportsAsssociationManagerC(object sender, EventArgs e)
        {
            Response.Redirect("RegisterSportsAsssociationManager.aspx");
        }

        protected void clubRepresentativeC(object sender, EventArgs e)
        {
            Response.Redirect("RegisterclubRepresentative.aspx");
        }

        protected void stadiumManagerC(object sender, EventArgs e)
        {
            Response.Redirect("RegisterstadiumManager.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}