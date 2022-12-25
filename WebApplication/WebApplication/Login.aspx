<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    
    
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Please Login"></asp:Label> <br />
            <asp:Label ID="Label2" runat="server" Text="Username:"></asp:Label> <br />
            <asp:TextBox ID="u1" runat="server"></asp:TextBox> <br/>
            <asp:Label ID="Label3" runat="server" Text="Password:"></asp:Label> <br/>
            <asp:TextBox ID="p1" runat="server"></asp:TextBox> <br/> <br/>
            <asp:Button ID="signin" runat="server" Text="log in" OnClick="login"/>
            <asp:Button ID="Button1" runat="server" Text="Register" OnClick="Register"/>
        </div>
        
    </form>
</body>
</html>
