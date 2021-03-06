﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Notebook.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Вход</title>
</head>
<body>
    <form id="loginform" runat="server">
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
                    <th></th>
                    <th align="right">
                        <asp:Button ID="LoginButton" OnClick="LoginButton_Click" Width="100" Text="Вход" runat="server" />
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
                        <asp:HyperLink Text="Регистрация..."  runat="server" NavigateUrl="/registration.aspx" />
                    </th>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
