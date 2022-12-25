<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Available stadiums.aspx.cs" Inherits="WebApplication.Available_stadiums" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
    <body>
        <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" Text="Kindly select the date"></asp:Label>
    </body>
<body>
      :<br />
      <br />
      <asp:TextBox ID="TextBox1" runat="server" placeholder ="YYYY-MM-DD hh:mm:ss"></asp:TextBox>
      <br />
      <br />
      <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />
      <br />
      <br />
      <asp:Table ID="myTable" runat="server" Width="572px">
        <asp:TableRow>
            <asp:TableCell>Stadium Name</asp:TableCell>
            <asp:TableCell>Location</asp:TableCell>
            <asp:TableCell>Capacity</asp:TableCell>
        </asp:TableRow>
    </asp:Table>
        </form>
</body>
</html>