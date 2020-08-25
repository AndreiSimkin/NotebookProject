<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Notebook.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Регистрация</title>
</head>
<body>
    <form id="registrationform" runat="server">
        <div>
                <table>
                <tr>
                    <th align="right">Логин:</th>
                    <th><asp:TextBox ID="LoginField" runat="server" /></th>
                </tr>
                <tr>
                    <th align="right">Пароль:</th>
                    <th><asp:TextBox ID="PasswordField" TextMode="Password" runat="server" /></th>
                </tr>
                <tr>
                    <th align="right">Повторите пароль:</th>
                    <th><asp:TextBox ID="ConfirmPassword" TextMode="Password" runat="server" /></th>
                </tr>
                <tr>
                    <th></th>
                    <th align="right">
                        <asp:Button ID="RegisterButton" OnClick="RegisterButton_Click" Width="100" Text="Регистрация" runat="server" />
                    </th>
                    <th></th>
                </tr>
            </table>
            <table>
                <tr>
                    <th align="left">
                        <asp:Label style="color:Red;" runat="server" ID="ErrorMessage"/>
                    </th>
                </tr>
                <tr>
                    <th align="left">
                        <asp:HyperLink Text="Вход..."  runat="server" NavigateUrl="/login.aspx" />
                    </th>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
