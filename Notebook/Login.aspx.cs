using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Notebook
{
    public partial class Login : System.Web.UI.Page
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
            Unload += Login_Unload;
        }

        private void Login_Unload(object sender, EventArgs e)
        {
            db.Dispose();
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            var user = (from u in db.User where u.Login == LoginField.Text where u.Password == PasswordField.Text select u);

            if (user.Count() != 0)
            {
                Guid guid = Guid.NewGuid();
                db.Token.InsertOnSubmit(new Token() { UserId = user.ToArray()[0].Id, Id = guid });
                db.SubmitChanges();
                Response.Cookies.Add(new HttpCookie("Token", guid.ToString()) { Expires = DateTime.Today.AddDays(7) } );
                Response.Redirect("/contacts.aspx");
            }
            else
            {
                ErrorMessage.Text = "Неверный логин или пароль!";
            }
        }
    }
}