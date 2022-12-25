<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewPastMatches.aspx.cs" Inherits="WebApplication.ViewPastMatches" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="myTable" runat="server">
        <asp:TableRow>
            <asp:TableCell>Host Name</asp:TableCell>
            <asp:TableCell>Guest Name</asp:TableCell>
            <asp:TableCell>Start Time</asp:TableCell>
            <asp:TableCell>End Time</asp:TableCell>
        </asp:TableRow>
    </asp:Table>
        </div>
    </form>
</body>
</html>
