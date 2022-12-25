<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="WebApplication.Fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" runat="server" Text="View all matches" OnClick="View"/>
            <asp:Button ID="Button2" runat="server" Text="Purchase a ticket for a match" OnClick="Purchase"/>
        </div>
    </form>
</body>
</html>
