<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AllRequestsSM.aspx.cs" Inherits="WebApplication.AllRequestsSM" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form runat="server">
        <asp:TextBox ID="TextBox1" runat="server" placeholder="Host Club Name"></asp:TextBox>
        <asp:TextBox ID="TextBox2" runat="server" placeholder="Guest Club Name"></asp:TextBox>
        <asp:TextBox ID="TextBox3" runat="server" placeholder="Start Time"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="accept" OnClick="accept_Click" />
        <asp:Button ID="Button2" runat="server" Text="reject" OnClick="reject_Click" />
    </form>
    <asp:Table ID="Table1" runat="server" Width="1311px">
        <asp:TableRow>
            <asp:TableCell>Club Representative Name</asp:TableCell>
            <asp:TableCell>Host Club</asp:TableCell>
            <asp:TableCell>Guest CLub</asp:TableCell>
            <asp:TableCell>Start Time</asp:TableCell>
            <asp:TableCell>End Time</asp:TableCell>
            <asp:TableCell>Status</asp:TableCell>
        </asp:TableRow>
    </asp:Table>

</body>
</html>
