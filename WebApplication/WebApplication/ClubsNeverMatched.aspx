<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubsNeverMatched.aspx.cs" Inherits="WebApplication.ClubsNeverPlayed" %>

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
            <asp:TableCell>First Club Name</asp:TableCell>
            <asp:TableCell>Second Club Name</asp:TableCell>
        </asp:TableRow>
    </asp:Table>
        </div>
    </form>
</body>
</html>
