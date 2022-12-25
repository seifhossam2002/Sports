using System;

namespace WebApplication
{
    public partial class clubRepresentative : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void clubDetails_Click(object sender, EventArgs e)
        {
            Response.Redirect("Club details.aspx");
        }

        protected void UpcomingMatches_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewUpcomingMatchesCR.aspx");
        }

        protected void availableStadiums_Click(object sender, EventArgs e)
        {
            Response.Redirect("Available stadiums.aspx");
        }

        protected void host_req_Click(object sender, EventArgs e)
        {
            Response.Redirect("host_request.aspx");
        }
    }
}