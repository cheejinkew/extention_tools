using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

public partial class MasterPage : System.Web.UI.MasterPage
{
    public StringBuilder sb;
    public string cname;
    public string username;
    public string userid;
    public string email;
    public string image;
    public string schlogo;
    public string role;
    Autheraisation auth = new Autheraisation();
    authresponce res = new authresponce();
    public bool paid = false;
    public StringBuilder sbMenu = new StringBuilder();
    protected override void OnInit(EventArgs e)
    {
        res = auth.autheraise();
        if (res.responcecode == "02")
            Response.Redirect("accountexpaired.aspx");
        else if (res.responcecode == "05")
            Response.Redirect("login.aspx");
        else if (res.responcecode == "04")
            Response.Redirect("accessdenied.aspx");
        else if (res.responcecode == "06")
            Response.Redirect("404page.aspx");

        if (res.responcecode == "01")
        {
            paid = true;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
      
        cname = (string)HttpContext.Current.Session["companyname"];
        username = (string)HttpContext.Current.Session["username"];
        userid = (string)HttpContext.Current.Session["userid"]; 
       
        image = "img/users/defaultuser.png";
       
      
    }
}
