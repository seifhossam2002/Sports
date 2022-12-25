<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewMatchesFAN.aspx.cs" Inherits="WebApplication.ViewMatchesFAN" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" Text="Date"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Submit" />
    </form>
    <asp:Table ID="myTable" runat="server">
        <asp:TableRow>
            <asp:TableCell>Host Name</asp:TableCell>
            <asp:TableCell>Guest Name</asp:TableCell>
            <asp:TableCell>Stadium Name</asp:TableCell>
            <asp:TableCell>Stadium Location</asp:TableCell>
        </asp:TableRow>
    </asp:Table>
</body>
</html>
