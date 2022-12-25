<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemAdmin.aspx.cs" Inherits="WebApplication.SystemAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Add new club"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server" placeholder="name"></asp:TextBox>
            <asp:TextBox ID="TextBox2" runat="server" placeholder="location"></asp:TextBox>
            <asp:Button ID="B1" runat="server" Text="Add" OnClick="Button1"/>
            <br/><br/><br/>
            <asp:Label ID="Label2" runat="server" Text="Delete a club"></asp:Label>
            <asp:TextBox ID="TextBox3" runat="server" placeholder="name"></asp:TextBox>
            <asp:Button ID="B2" runat="server" Text="Delete" OnCLick="Button2"/>
            <br/><br/><br/>
            <asp:Label ID="Label3" runat="server" Text="Add New Stadium"></asp:Label>
            <asp:TextBox ID="TextBox4" runat="server" placeholder="name"></asp:TextBox>
            <asp:TextBox ID="TextBox5" runat="server" placeholder="location"></asp:TextBox>
            <asp:TextBox ID="TextBox6" runat="server" placeholder="capacity"></asp:TextBox>
            <asp:Button ID="B3" runat="server" Text="Add" OnClick="Button3"/>
            <br/><br/><br/>
            <asp:Label ID="Label4" runat="server" Text="Delete a Stadium"></asp:Label>
            <asp:TextBox ID="TextBox7" runat="server" placeholder="name"></asp:TextBox>
            <asp:Button ID="B4" runat="server" Text="Delete" OnClick="Button4"/>
            <br/><br/><br/>
            <asp:Label ID="Label5" runat="server" Text="Block a fan"></asp:Label>
            <asp:TextBox ID="TextBox8" runat="server" placeholder="national id"></asp:TextBox>
            <asp:Button ID="B5" runat="server" Text="Block" OnClick="Button5"/>
        </div>
    </form>
</body>
</html>
