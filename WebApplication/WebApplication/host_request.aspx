<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="host_request.aspx.cs" Inherits="WebApplication.host_request" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    </head>
<body>
    <form id="form1" runat="server">
        <p>
            * Enter the name of the stadium you want to host the match in:</p>
        <asp:TextBox ID="stadium" runat="server"></asp:TextBox>
        <br />
        * Select the date you want to play the match on :<br />
        <asp:TextBox ID="date" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="submit" runat="server" Text="Submit request" OnClick="submit_Click" />
    </form>
</body>
</html>