<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PurchaseTicket.aspx.cs" Inherits="WebApplication.PurchaseTicket" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="TextBox1" runat="server" placeholder="Host Name"></asp:TextBox>
            <asp:TextBox ID="TextBox2" runat="server" placeholder="Guest Name"></asp:TextBox>
            <asp:TextBox ID="TextBox3" runat="server" placeholder="Start Time"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Submit"/>
        </div>
    </form>
</body>
</html>
