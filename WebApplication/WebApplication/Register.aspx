<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebApplication.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="fan" runat="server" Text="Fan" OnClick="fanC"/>
            <asp:Button ID="SportsAsssociationManager" runat="server" Text="Sports Asssociation Manager" OnClick="SportsAsssociationManagerC"/>
            <asp:Button ID="clubRepresentative" runat="server" Text="club Representative" OnClick="clubRepresentativeC"/>
            <asp:Button ID="stadiumManager" runat="server" Text="stadium Manager" OnClick="stadiumManagerC"/>
        </div>
    </form>
</body>
</html>
