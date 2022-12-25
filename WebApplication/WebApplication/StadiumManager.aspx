<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StadiumManager.aspx.cs" Inherits="WebApplication.StadiumManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form_stad_manager" runat="server">
        <asp:Label ID="Label1" runat="server" Text="Stadium manager"></asp:Label><br />
        
        <asp:Button ID="Button1" runat="server" Text="view Stadium details" OnClick="StaduimDetails_click" /><br />
        <asp:Button ID="Button2" runat="server" Text="View all recieved requests" OnClick="recievedrequest_click"/><br />
        <div>
        </div>
    </form>
</body>
</html>
