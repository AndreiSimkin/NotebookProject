using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Notebook
{
    public partial class Registration : System.Web.UI.Page
    {
        NotebookDBDataContext db;
        protected void Page_Load(object sender, EventArgs e)
        {
            db = new NotebookDBDataContext();
            if (!IsPostBack)
            {
                if (Request.Cookies["Token"] != null && Request.Cookies["Token"].Value != null)
                    if ((from t in db.Token where t.Id.ToString() == Request.Cookies["Token"].Value select t).Count() > 0)
                        Response.Redirect("/contacts.aspx");
            }
            Unload += Registration_Unload;
        }

        private void Registration_Unload(object sender, EventArgs e)
        {
            db.Dispose();
        }

        protected void RegisterButton_Click(object sender, EventArgs e)
        {
            if (PasswordField.Text.Length == 0)
            {
                ErrorMessage.Text = "Введите пароль!";
            }
            else if (PasswordField.Text.Length < 8)
            {
                ErrorMessage.Text = "Пороль слишком короткий!";
            }
            else if (PasswordField.Text == ConfirmPassword.Text)
            {
                var user = (from u in db.User where u.Login == LoginField.Text select u);

                if (user.Count() == 0)
                {
                    db.User.InsertOnSubmit(new Notebook.User() { Login = LoginField.Text, Password = PasswordField.Text });
                    db.SubmitChanges();
                    Response.Redirect("/login.aspx");
                }
                else
                {
                    ErrorMessage.Text = "Такой пользователь уже существует!";
                }
            }
            else
            {
                ErrorMessage.Text = "Пароли должны совпадать!";
            }
        }
    }
}