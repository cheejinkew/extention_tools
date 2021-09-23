using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Login : System.Web.UI.Page
{
    public static string errormessage = "";
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod()]
    public static string CheckLogin(string uname, string pwd)
    {
        string result = "N";
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnection"]);
        int res = 0;
        try
        {
            //SqlCommand command = new SqlCommand();
            //SqlDataReader dr;
            //command.CommandType = CommandType.StoredProcedure;
            //command.Connection = conn;
            //command.CommandText = "sp_LoginChcek";
            //command.Parameters.AddWithValue("@username", uname );
            //command.Parameters.AddWithValue("@pwd",pwd);
            //conn.Open();
            //dr = command.ExecuteReader();
            if (uname=="teo" && pwd=="teo@123")
            {
                HttpContext.Current.Session["companyname"] = "Gussmann Technologies";
                HttpContext.Current.Session["username"] = "Teo";
                HttpContext.Current.Session["userid"] ="1001";
                errormessage = "";
            }
            else
            {
                errormessage = "Invalid Username or Password";
            }
          //  dr.Close(); 
            conn.Close();
        }
        catch (Exception ex)
        {
            errormessage = ex.Message;
        }
        finally
        {
            conn.Close();
        }

        if (errormessage == "")
        {
            result = "Y";
        }
        
        return result;

    }

}