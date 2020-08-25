<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contacts.aspx.cs" Inherits="Notebook.Contacts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Контакты</title>
</head>
<body>
    <form id="contactsform" runat="server">
        <footer align="right">
            <asp:Button Text="Выйти" ID="logout" OnClick="logout_Click" runat="server" />
        </footer>
        <div>
            <h2>Добавление контакта</h2>
            <table>
                <tr>
                    <th align="left">Имя:*</th>
                    <th align="left">Фамилия:</th>
                    <th align="left">Отчество:</th>
                    <th align="left">Номер телефона:*</th>
                    <th align="left">Заметка:</th>
                </tr>
                <tr>
                    <th><asp:TextBox ID="NameField" runat="server" /></th>
                    <th><asp:TextBox ID="SurnameField" runat="server" /></th>
                    <th><asp:TextBox ID="PatronymicField" runat="server" /></th>
                    <th><asp:TextBox ID="PhoneField" TextMode="Phone" runat="server" /></th>
                    <th><asp:TextBox ID="NoteField" runat="server" /></th>
                    <th><asp:Button ID="AddContactButton" OnClick="AddContactButton_Click" Text="Добавить" runat="server" /></th>
                </tr>
            </table>
            <asp:Label ID="ErrorMessage" style="color:red;" runat="server"/>
            <h2>Контакты</h2>
            <asp:Repeater ID="ContactsTable" runat="server">
                <HeaderTemplate>
                    <table border="1">
                    <tr>
                        <th>ФИО</th>
                        <th>Номер телефона</th>
                        <th>Заметка</th>
                    </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <th align="left"><%# DataBinder.Eval(Container.DataItem, "Name") %> <%# DataBinder.Eval(Container.DataItem, "Surname") %> <%# DataBinder.Eval(Container.DataItem, "Patronymic") %></th>
                        <th align><%# DataBinder.Eval(Container.DataItem, "Phone").ToString().Substring(0, DataBinder.Eval(Container.DataItem, "Phone").ToString().Length - 10) %> <%# String.Format("{0:### ###-##-##}", long.Parse(DataBinder.Eval(Container.DataItem, "Phone").ToString().Remove(0, DataBinder.Eval(Container.DataItem, "Phone").ToString().Length - 10))) %></th>
                        <th><%# DataBinder.Eval(Container.DataItem, "Note") %> </th>
                        <th><a href="/contacts.aspx?method=delete&id=<%# DataBinder.Eval(Container.DataItem, "Id")%>">Удалить</a></a></th>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
