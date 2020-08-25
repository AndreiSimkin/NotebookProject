using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Notebook
{
    public partial class Contacts : System.Web.UI.Page
    {
        NotebookDBDataContext db;
        int userid;
        protected void Page_Load(object sender, EventArgs e)
        {
            db = new NotebookDBDataContext();

            if (Request.Cookies["Token"] == null || Request.Cookies["Token"].Value == null || (from t in db.Token where t.Id.ToString() == Request.Cookies["Token"].Value select t).Count() == 0)
                Response.Redirect("/login.aspx");
            else
            {
                userid = (from t in db.Token where t.Id.ToString() == Request.Cookies["Token"].Value select t).ToArray()[0].UserId;

                int id;

                if (Request.Params["method"] == "delete" && Request.Params["id"] != null && int.TryParse(Request.Params["id"], out id))
                {
                    Contact[] contact = (from c in db.Contact where c.Id == id where c.UserId == userid select c).ToArray();
                    if (contact.Length != 0)
                        db.Contact.DeleteOnSubmit(contact[0]);
                    db.SubmitChanges();
                }

                ContactsTable.DataSource = (from c in db.Contact where c.UserId == userid select c).ToArray();
                ContactsTable.DataBind();
            }

            Unload += Contacts_Unload;
        }

        private void Contacts_Unload(object sender, EventArgs e)
        {
            db.Dispose();
        }

        protected void AddContactButton_Click(object sender, EventArgs e)
        {
            long phone;
            if (PhoneField.Text == "")
                ErrorMessage.Text = "Необходимо указать номер телефона!";
            else if (NameField.Text == "")
                ErrorMessage.Text = "Необходимо указать имя!";
            else if (!long.TryParse(PhoneField.Text, out phone) || PhoneField.Text.Length < 11 || PhoneField.Text.Length > 13)
            {
                ErrorMessage.Text = "Неверный формат номера телефона";
            }
            else if ((from c in db.Contact where c.Phone == phone select c).Count() != 0)
            {
                ErrorMessage.Text = "Этот номер уже добавлен!";
            }
            else
            {
                db.Contact.InsertOnSubmit(new Contact() { UserId = userid, Phone = phone, Name = NameField.Text, Surname = SurnameField.Text, Patronymic = PatronymicField.Text, Note = NoteField.Text });
                db.SubmitChanges();
                Response.Redirect("/contacts.aspx");
            }
        }

        protected void logout_Click(object sender, EventArgs e)
        {
            db.Token.DeleteOnSubmit((from t in db.Token where t.Id.ToString() == Request.Cookies["token"].Value select t).ToArray()[0]);
            db.SubmitChanges();
            Response.Cookies["Token"].Value = null;
            Response.Redirect("/login.aspx");
        }
    }
}