using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication
{
    public partial class Fan : System.Web.UI.Page
    {

        protected void View(object sender, EventArgs e)
        {
            Response.Redirect("ViewMatchesFAN.aspx");
        }

        protected void Purchase(object sender, EventArgs e)
        {
            Response.Redirect("PurchaseTicket.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}