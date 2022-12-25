<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SportsAssociationManager.aspx.cs" Inherits="WebApplication.SportsAssociationManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Add a new match"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server" placeholder="host club name"></asp:TextBox>
            <asp:TextBox ID="TextBox2" runat="server" placeholder="guest club name"></asp:TextBox>
            <asp:TextBox ID="TextBox3" runat="server" placeholder="start time"></asp:TextBox>
            <asp:TextBox ID="TextBox4" runat="server" placeholder="end time"></asp:TextBox>
            <asp:Button ID="B1" runat="server" Text="Add" OnClick="Button1"/>
             <br/><br/><br/>
            <asp:Label ID="Label2" runat="server" Text="Delete a match"></asp:Label>
            <asp:TextBox ID="TextBox5" runat="server" placeholder="host club name"></asp:TextBox>
            <asp:TextBox ID="TextBox6" runat="server" placeholder="guest club name"></asp:TextBox>
            <asp:TextBox ID="TextBox7" runat="server" placeholder="start time"></asp:TextBox>
            <asp:TextBox ID="TextBox8" runat="server" placeholder="end time"></asp:TextBox>
            <asp:Button ID="B2" runat="server" Text="Delete" OnClick="Button2"/>
            <br/><br/><br/>
            <asp:Button ID="B3" runat="server" Text="View all upcoming matches" OnClick="Button3"/>
            <br/><br/><br/>
            <asp:Button ID="B4" runat="server" Text="View all past matches" OnClick="Button4"/>
            <br/><br/><br/>
            <asp:Button ID="B5" runat="server" Text="View clubs never scheduled to play " OnClick="Button5"/>
            


        </div>
    </form>
</body>
</html>
