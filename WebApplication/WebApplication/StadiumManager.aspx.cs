using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication
{
    public partial class StadiumManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void StaduimDetails_click(object sender, EventArgs e)
        {
            Response.Redirect("StadiumDetails.aspx");
        }

        protected void recievedrequest_click(object sender, EventArgs e)
        {
            Response.Redirect("AllRequestsSM.aspx");
        }
    }
}