<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterFan.aspx.cs" Inherits="WebApplication.RegisterFan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="name"></asp:Label><br/>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox> <br/>
            <asp:Label ID="Label2" runat="server" Text="username"></asp:Label> <br/>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox> <br/>
            <asp:Label ID="Label3" runat="server" Text="password"></asp:Label> <br/>
            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox> <br/>
            <asp:Label ID="Label4" runat="server" Text="national id"></asp:Label> <br/>
            <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox> <br/>
            <asp:Label ID="Label5" runat="server" Text="phone number"></asp:Label> <br/>
            <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox> <br/>
            <asp:Label ID="Label6" runat="server" Text="birth date"></asp:Label> <br/>
            <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox> <br/>
            <asp:Label ID="Label7" runat="server" Text="address"></asp:Label> <br/>
            <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox> <br/>
            <asp:Button ID="Button1" runat="server" Text="Register" OnClick="Register"/>
        </div>
    </form>
</body>
</html>

